package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80410 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [1647];
      
      private static const FOR_LIST:Array = [205680,205685];
      
      private static const FIGHT_INDEX:int = 1524;
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605537]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1,2]);
      
      private static const TIP_POS:Point = new Point(560,155);
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
       
      
      private var _fightNum:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _npc:Mobile;
      
      private var _canFightNum:int;
      
      public function MapProcessor_80410(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            this.getDataHandleFromBattle();
         }
         else
         {
            this.getDataHandleNormal();
         }
      }
      
      private function getDataHandleNormal() : void
      {
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               _par = param1;
               _info = info;
               _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               initSet();
            });
         });
      }
      
      private function getDataHandleFromBattle() : void
      {
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               _par = par;
               _info = info;
               _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               if(BitUtil.getBit(_par.infoVec[1],1))
               {
                  ServerMessager.addMessage("恭喜通关喽!");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(2,function():void
                  {
                     ModuleManager.showAppModule("WorldKingTwoPanel");
                  });
               }
               else if(_canFightNum > 0)
               {
                  initSet();
               }
               else
               {
                  ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(2,function():void
                  {
                     ModuleManager.showAppModule("WorldKingTwoPanel");
                  });
               }
            });
         });
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this._fightNum = _map.front["fightNum"];
         this._fightNum.text = this._canFightNum.toString();
         this._miPass = _map.front["miPass"];
         if(_par)
         {
            if(BitUtil.getBit(_par.infoVec[1],1))
            {
               this._miPass.visible = false;
            }
            else
            {
               this._miPass.visible = true;
            }
         }
         this._miPass.addEventListener(MouseEvent.CLICK,this.onMiPass);
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(550,350));
            this._npc.resourceUrl = URLUtil.getNpcSwf(874);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "风暴组合";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS,_map.id);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(874,"风暴组合",[[0,"  风暴卷尘埃！看来这次的较量已经没有悬念！"]],["请赐教！","我还没有准备好"],[function():void
         {
            ModuleManager.showAppModule("PetSelectFightPanel",{
               "min":1,
               "max":5,
               "posIndex":FIGHT_INDEX,
               "mode":7
            });
         }]);
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
            SeatTipsManager.removeSeat(TIP_POS,_map.id);
         }
      }
      
      private function onMiPass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(MI_ID_LIST[0],function():void
         {
            _miPass.visible = false;
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(2,function():void
            {
               ModuleManager.showAppModule("WorldKingTwoPanel");
            });
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function onActDispose() : void
      {
         this.clearNpc();
         if(this._miPass)
         {
            this._miPass.removeEventListener(MouseEvent.CLICK,this.onMiPass);
            this._miPass = null;
         }
         this._fightNum = null;
         this._npc = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
