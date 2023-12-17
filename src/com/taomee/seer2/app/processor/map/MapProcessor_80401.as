package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.PayManager;
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
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80401 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [205600,205603,205601];
      
      private static const DAY_LIST:Array = [1629];
      
      private static const FIGHT_INDEX:int = 1506;
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605497,605507]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([3,5]);
      
      private static const TIP_POS:Point = new Point(530,180);
      
      private static const BLOOD_MAX:uint = 100000;
       
      
      private var _fightNum:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _hurtNum:TextField;
      
      private var _bar:MovieClip;
      
      private var _npc:Mobile;
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      private var _canFightNum:int;
      
      public function MapProcessor_80401(param1:MapModel)
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
               _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
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
               var info:DayLimitListInfo = param1;
               _info = info;
               _par = par;
               if(BitUtil.getBit(_par.infoVec[1],2))
               {
                  ServerMessager.addMessage("恭喜通关喽!");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(3,function():void
                  {
                     ModuleManager.showAppModule("DickProcessActMainPanel");
                  });
               }
               _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               if(_canFightNum > 0)
               {
                  initSet();
               }
               else
               {
                  _fightNum = _map.front["fightNum"];
                  _fightNum.text = _canFightNum.toString();
                  _hurtNum = _map.front["hurtNum"];
                  _bar = _map.front["bar"];
                  _hurtNum.text = par.infoVec[2].toString() + "/" + BLOOD_MAX.toString();
                  _bar.scaleX = par.infoVec[2] / BLOOD_MAX > 1 ? 1 : par.infoVec[2] / BLOOD_MAX;
                  initSet();
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
         this._bar = _map.front["bar"];
         this._hurtNum = _map.front["hurtNum"];
         if(this._info)
         {
            this._hurtNum.text = this._par.infoVec[2].toString() + "/" + BLOOD_MAX.toString();
            this._bar.scaleX = this._par.infoVec[2] / BLOOD_MAX > 1 ? 1 : this._par.infoVec[2] / BLOOD_MAX;
         }
         if(this._par)
         {
            if(BitUtil.getBit(this._par.infoVec[1],2))
            {
               this._miPass.visible = false;
            }
            else
            {
               this._miPass.visible = true;
            }
         }
         this.createNpc();
         this._miPass.addEventListener(MouseEvent.CLICK,this.onMiPass);
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 110;
            this._npc.height = 180;
            this._npc.setPostion(new Point(530,384));
            this._npc.resourceUrl = URLUtil.getNpcSwf(679);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "库贝萨";
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
         if(this.isCanFight())
         {
            if(this._canFightNum > 0)
            {
               FightManager.startFightWithWild(FIGHT_INDEX);
            }
            else
            {
               ShopManager.buyItemForId(MI_ID_LIST[1],function():void
               {
                  ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
                  {
                     var par:Parser_1142 = param1;
                     DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
                     {
                        _par = par;
                        _info = param1;
                        _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                        _fightNum.text = _canFightNum.toString();
                        FightManager.startFightWithWild(FIGHT_INDEX);
                     });
                  });
               });
            }
         }
      }
      
      private function isCanFight() : Boolean
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            if(PetInfoManager.getPowerByPetInfo(_loc2_) >= 4500)
            {
               _loc1_ = true;
               break;
            }
         }
         if(!_loc1_)
         {
            ModuleManager.showAppModule("DickProcessPowerTipPanel");
         }
         return _loc1_;
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
         AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻一键通关吗?",function():void
         {
            PayManager.buyItem(MI_ID_LIST[0],function():void
            {
               _miPass.visible = false;
               ServerMessager.addMessage("恭喜通关喽!");
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("DickProcessActMainPanel");
               });
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
         this._hurtNum = null;
         this._bar = null;
         this._npc = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
