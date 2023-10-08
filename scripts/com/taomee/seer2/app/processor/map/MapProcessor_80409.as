package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
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
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
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
   
   public class MapProcessor_80409 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [1646];
      
      private static const FOR_LIST:Array = [205679,205685,205688];
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1521,1522,1523]);
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605535]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([2,3]);
      
      private static const NPC_NAME_LIST:Vector.<String> = Vector.<String>(["沙皇鸟","阿兹尔","爪灵兽"]);
      
      private static const NPC_RES_LIST:Vector.<int> = Vector.<int>([871,872,873]);
      
      private static const NPC_WH_LIST:Array = [[100,160],[100,160],[100,160]];
      
      private static const NPC_POS_LIST:Vector.<Point> = Vector.<Point>([new Point(225,425),new Point(700,200),new Point(1020,520)]);
      
      private static const NEED_POWER:Vector.<int> = Vector.<int>([5000,10000,15000]);
      
      private static const TIP_POS:Vector.<Point> = Vector.<Point>([new Point(235,255),new Point(700,30),new Point(1020,350)]);
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
       
      
      private var _fightNum:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _npcList:Vector.<Mobile>;
      
      private var _killedEffectList:Vector.<MovieClip>;
      
      private var _canFightNum:int;
      
      private var _curIndex:int;
      
      public function MapProcessor_80409(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         this.initKilledEffect();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this._curIndex = FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if(this._curIndex != -1)
            {
               this.getDataHandleFromBattle();
            }
         }
         else
         {
            this.getDataHandleNormal();
         }
      }
      
      private function initKilledEffect() : void
      {
         this._killedEffectList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._killedEffectList.push(_map.content["killedEffect" + _loc1_]);
            this._killedEffectList[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function playKilledEffect() : void
      {
         this._killedEffectList[this._curIndex].visible = true;
         MovieClipUtil.playMc(this._killedEffectList[this._curIndex],2,this._killedEffectList[this._curIndex].totalFrames,function():void
         {
            if(_killedEffectList)
            {
               _killedEffectList[_curIndex].gotoAndStop(1);
               _killedEffectList[_curIndex].visible = false;
            }
         });
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
         if(FightManager.fightWinnerSide == FightSide.LEFT)
         {
            this.playKilledEffect();
         }
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               _par = par;
               _info = info;
               _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
               if(BitUtil.getBit(_par.infoVec[1],0))
               {
                  ServerMessager.addMessage("恭喜通关喽!");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(3,function():void
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
                  TweenNano.delayedCall(3,function():void
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
         this.updateBossState();
      }
      
      private function updateBossState() : void
      {
         var _loc1_:Mobile = null;
         this._npcList = Vector.<Mobile>([null,null,null]);
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(!BitUtil.getBit(_par.infoVec[2],_loc2_))
            {
               _loc1_ = this.createNpc(NPC_RES_LIST[_loc2_],NPC_POS_LIST[_loc2_],NPC_NAME_LIST[_loc2_],NPC_WH_LIST[_loc2_]);
               this._npcList[_loc2_] = _loc1_;
               _loc1_.addEventListener(MouseEvent.CLICK,this.onNpcClick);
               SeatTipsManager.registerSeat(TIP_POS[_loc2_],_map.id);
            }
            _loc2_++;
         }
      }
      
      private function createNpc(param1:int, param2:Point, param3:String, param4:Array) : Mobile
      {
         var _loc5_:Mobile;
         (_loc5_ = new Mobile()).width = param4[0];
         _loc5_.height = param4[1];
         _loc5_.setPostion(param2);
         _loc5_.resourceUrl = URLUtil.getNpcSwf(param1);
         _loc5_.labelPosition = MobileLabelPosition.OVER_HEAD;
         _loc5_.label = param3;
         _loc5_.labelImage.y = -_loc5_.height - 10;
         _loc5_.buttonMode = true;
         MobileManager.addMobile(_loc5_,MobileType.NPC);
         return _loc5_;
      }
      
      private function isCanFight(param1:int) : Boolean
      {
         var _loc4_:PetInfo = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         for each(_loc4_ in PetInfoManager.getAllBagPetInfo())
         {
            _loc2_ += PetInfoManager.getPowerByPetInfo(_loc4_);
         }
         if(_loc2_ >= param1)
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = false;
            AlertManager.showAlert("出战精灵总战斗力达到" + param1 + "以上才可以参加挑战哦!");
         }
         return _loc3_;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this._npcList.indexOf(param1.currentTarget);
         if(this.isCanFight(NEED_POWER[_loc2_]))
         {
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[_loc2_]);
         }
      }
      
      private function clearNpc() : void
      {
         var _loc1_:int = 0;
         if(this._npcList)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(this._npcList[_loc1_])
               {
                  this._npcList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
                  DisplayUtil.removeForParent(this._npcList[_loc1_]);
                  SeatTipsManager.removeSeat(TIP_POS[_loc1_],_map.id);
               }
               _loc1_++;
            }
            this._npcList = null;
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
         this._killedEffectList = null;
         this._fightNum = null;
         this._npcList = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
