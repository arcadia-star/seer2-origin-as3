package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
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
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80441 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [250047,250062];
      
      private static const DAY_LIST:Array = [5029];
      
      private static const FIGHT_INDEX:int = 1560;
      
      private static const FIGHT_INDEX1:int = 1668;
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([500628,605623]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1,1]);
      
      private static const ITEM_ID_LIST:Vector.<uint> = Vector.<uint>([401199]);
      
      private static const TIP_POS:Point = new Point(590,290);
      
      private static var _par:Parser_1142;
       
      
      private var _fightNum:TextField;
      
      private var _hurtBuy:SimpleButton;
      
      private var _itemNum:TextField;
      
      private var _leave:SimpleButton;
      
      private var _vipTip:MovieClip;
      
      private var _npc:Mobile;
      
      private var _info:DayLimitListInfo;
      
      private var _canFightNum:int;
      
      public function MapProcessor_80441(param1:MapModel)
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
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               _canFightNum = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               initSet();
            });
         });
      }
      
      private function getDataHandleFromBattle() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _info = param1;
               _par = par;
               _canFightNum = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               initSet();
               ModuleManager.showAppModule("PetElingFightResultPanel");
            });
         });
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this._fightNum = _map.front["fightNum"];
         this._fightNum.text = this._canFightNum.toString();
         this._hurtBuy = _map.front["hurtBuy"];
         TooltipManager.addCommonTip(this._hurtBuy,"购买恶灵荣耀可在下一场战斗中提升300%伤害");
         this._itemNum = _map.front["itemNum"];
         this._leave = _map.front["leave"];
         this._vipTip = _map.front["vipTip"];
         if(VipManager.vipInfo.isVip())
         {
            this._vipTip.gotoAndStop(2);
         }
         else
         {
            this._vipTip.gotoAndStop(1);
            (this._vipTip["openVip"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onOpenVip);
         }
         this.updateItem();
         this._hurtBuy.addEventListener(MouseEvent.CLICK,this.onHurtBuy);
         this._leave.addEventListener(MouseEvent.CLICK,this.onLeave);
         this.createNpc();
      }
      
      private function updateItem() : void
      {
         ItemManager.requestItemList(function():void
         {
            _itemNum.text = ItemManager.getItemQuantityByReferenceId(ITEM_ID_LIST[0]).toString();
         });
      }
      
      private function onOpenVip(param1:MouseEvent) : void
      {
         VipManager.openVip();
      }
      
      private function onLeave(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(2,function():void
         {
            ModuleManager.showAppModule("PetElingModePanel");
         });
      }
      
      private function onHurtBuy(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._hurtBuy.mouseEnabled = false;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            _par = par;
            _hurtBuy.mouseEnabled = true;
            if(_par.infoVec[1] > 0)
            {
               AlertManager.showAlert("恶灵荣耀使用完再来购买吧!");
            }
            else
            {
               AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻购买恶灵荣耀吗?",function():void
               {
                  PayManager.buyItem(MI_ID_LIST[0],function():void
                  {
                     ServerMessager.addMessage("快去下一场对战中使用吧！");
                  });
               });
            }
         });
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 110;
            this._npc.setPostion(new Point(600,436));
            this._npc.resourceUrl = URLUtil.getNpcSwf(887);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "恶灵兽";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS,_map.id);
         }
      }
      
      private function isCanFight() : Boolean
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            if([3,13].indexOf(_loc2_.type) != -1)
            {
               _loc1_ = false;
               AlertManager.showAlert("不能携带水、暗影系别的精灵挑战哦!");
               break;
            }
         }
         return _loc1_;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._canFightNum > 0)
         {
            if(this.isCanFight())
            {
               if(DateUtil.isInTime(new Date(2015,9,7),new Date(2015,9,7,23,59,59)))
               {
                  FightManager.startFightWithWild(FIGHT_INDEX1);
               }
               else
               {
                  FightManager.startFightWithWild(FIGHT_INDEX);
               }
            }
         }
         else
         {
            AlertManager.showConfirm("当前战斗次数已用完，你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[1]) + "星钻进入挑战吗?",function():void
            {
               PayManager.buyItem(MI_ID_LIST[1],function():void
               {
                  ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
                  {
                     var par:Parser_1142 = param1;
                     DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
                     {
                        _par = par;
                        _info = param1;
                        _canFightNum = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                        _fightNum.text = _canFightNum.toString();
                        if(isCanFight())
                        {
                           if(DateUtil.isInTime(new Date(2015,9,7),new Date(2015,9,7,23,59,59)))
                           {
                              FightManager.startFightWithWild(FIGHT_INDEX1);
                           }
                           else
                           {
                              FightManager.startFightWithWild(FIGHT_INDEX);
                           }
                        }
                     });
                  });
               });
            });
         }
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
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function onActDispose() : void
      {
         this.clearNpc();
         if(this._hurtBuy)
         {
            TooltipManager.remove(this._hurtBuy);
            this._hurtBuy.removeEventListener(MouseEvent.CLICK,this.onHurtBuy);
            this._hurtBuy = null;
         }
         if(this._leave)
         {
            this._leave.removeEventListener(MouseEvent.CLICK,this.onLeave);
            this._leave = null;
         }
         if(Boolean(this._vipTip) && this._vipTip.currentFrame == 1)
         {
            (this._vipTip["openVip"] as SimpleButton).removeEventListener(MouseEvent.CLICK,this.onOpenVip);
         }
         this._vipTip = null;
         this._fightNum = null;
         this._itemNum = null;
         this._npc = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
