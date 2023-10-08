package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80212 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [204290,204289,204275];
      
      private static const FIGHT_INDEX:int = 1025;
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([603888,500606]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([2,3]);
       
      
      private var _fightNum:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _hurtBuy:SimpleButton;
      
      private var _npc:Mobile;
      
      private var _par:Parser_1142;
      
      private var _canFightNum:int;
      
      public function MapProcessor_80212(param1:MapModel)
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
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            _par = param1;
            _canFightNum = ActsHelperUtil.getCanNum(_par.infoVec[0],_par.infoVec[1],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
            initSet();
         });
      }
      
      private function getDataHandleFromBattle() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            if(_par == null)
            {
               _par = par;
            }
            else if(par.infoVec[0] != _par.infoVec[0])
            {
               ServerMessager.addMessage("恭喜通关喽!");
               _par = par;
            }
            _par = par;
            _canFightNum = ActsHelperUtil.getCanNum(_par.infoVec[0],_par.infoVec[1],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
            if(_canFightNum > 0)
            {
               initSet();
            }
            else
            {
               TweenNano.delayedCall(3,function():void
               {
                  ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            }
         });
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this._fightNum = _map.front["fightNum"];
         this._fightNum.text = this._canFightNum.toString();
         this._miPass = _map.front["miPass"];
         this._hurtBuy = _map.front["hurtBuy"];
         if(BitUtil.getBit(this._par.infoVec[2],2))
         {
            this._miPass.visible = false;
         }
         else
         {
            this._miPass.visible = true;
         }
         this.createNpc();
         this._miPass.addEventListener(MouseEvent.CLICK,this.onMiPass);
         this._hurtBuy.addEventListener(MouseEvent.CLICK,this.onHurtBuy);
      }
      
      private function onHurtBuy(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._hurtBuy.mouseEnabled = false;
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,function getItem(param1:ItemEvent):void
         {
            var num:int;
            var evt:ItemEvent = param1;
            _hurtBuy.mouseEnabled = true;
            ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,getItem);
            num = ItemManager.getSpecialItem(MI_ID_LIST[1]) != null ? int(ItemManager.getSpecialItem(MI_ID_LIST[1]).quantity) : 0;
            if(num > 0)
            {
               AlertManager.showAlert("炎帝荣耀使用完再来购买吧!");
            }
            else
            {
               AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[1]) + "星钻购买炎帝荣耀吗?",function():void
               {
                  PayManager.buyItem(MI_ID_LIST[1],function():void
                  {
                  });
               });
            }
         });
         ItemManager.requestSpecialItemList();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(530,384));
            this._npc.resourceUrl = URLUtil.getNpcSwf(760);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "炎帝";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(FIGHT_INDEX);
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onMiPass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻一键通关吗?",function():void
         {
            PayManager.buyItem(MI_ID_LIST[0],function():void
            {
               _miPass.visible = false;
               ServerMessager.addMessage("恭喜通关喽!");
               SceneManager.changeScene(SceneType.LOBBY,70);
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
         if(this._hurtBuy)
         {
            this._hurtBuy.removeEventListener(MouseEvent.CLICK,this.onHurtBuy);
            this._hurtBuy = null;
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
