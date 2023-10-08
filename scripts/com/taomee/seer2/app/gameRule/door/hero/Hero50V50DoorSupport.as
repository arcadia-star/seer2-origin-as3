package com.taomee.seer2.app.gameRule.door.hero
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.IDoorServerEquipable;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class Hero50V50DoorSupport implements IUpDoorSupport, IMultiSelectable, IDoorServerEquipable
   {
      
      private static var _instance:com.taomee.seer2.app.gameRule.door.hero.Hero50V50DoorSupport;
       
      
      private var _supportInfo:DoorSupportInfo;
      
      private var _map:MapModel;
      
      private var _guard:MovieClip;
      
      private var _guardInstance:MovieClip;
      
      private var _doorLevel_MC:MovieClip;
      
      private var _levelTip2:MovieClip;
      
      private var _doorLevel:uint = 1;
      
      private var _isGetServerGiveFlag:Boolean = false;
      
      private var _canLevelNow:Boolean = true;
      
      private var _rewardIDList:Vector.<ServerReward>;
      
      private var _rewardId:uint;
      
      private var _ITEMS:Array;
      
      protected var _equipId:uint = 0;
      
      public function Hero50V50DoorSupport()
      {
         super();
         this._supportInfo = new DoorSupportInfo(DoorRule.HERO_DOOR,DoorType.Door_50V50,417,"HeroDoorStartPanel");
         this._ITEMS = [100177,100178,100179,100180,100181];
      }
      
      public static function getInstance() : com.taomee.seer2.app.gameRule.door.hero.Hero50V50DoorSupport
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.gameRule.door.hero.Hero50V50DoorSupport();
         }
         return _instance;
      }
      
      public function init(param1:MapModel) : void
      {
         this._canLevelNow = true;
         this._map = param1;
         this.initUI();
      }
      
      private function initUI() : void
      {
         this._doorLevel_MC = this._map.front["levelTip"];
         this._doorLevel_MC.gotoAndStop(this._doorLevel);
         this._levelTip2 = this._map.front["levelTip2"];
         this._guard = this._map.content["guard"];
         this._guard.buttonMode = true;
         this._guard.useHandCursor = true;
         this._guard.addEventListener(MouseEvent.CLICK,this.onGuardClick);
         this.updateGuardStatus(this.initResult);
      }
      
      private function initResult() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this.dealWithFightResult(FightManager.fightWinnerSide);
         }
         else
         {
            this.setTrialLevel(this._supportInfo.currentDoorLevel);
         }
      }
      
      public function dispose() : void
      {
         this._doorLevel_MC = null;
         this._levelTip2 = null;
         this._guard.removeEventListener(MouseEvent.CLICK,this.onGuardClick);
         this._guard = null;
      }
      
      private function onGuardClick(param1:MouseEvent) : void
      {
         var _loc2_:DoorInitData = null;
         if(this._canLevelNow)
         {
            if(FightVerifyManager.checkVerifyStatus() == false)
            {
               return;
            }
            _loc2_ = new DoorInitData();
            _loc2_.npcName = Door21LevelUtil.getGuardName(this._doorLevel);
            _loc2_.npcPets = Door21LevelUtil.getGuardPets(this._doorLevel,this._supportInfo.doorType,this._supportInfo.doorRule);
            _loc2_.playerName = ActorManager.actorInfo.nick;
            _loc2_.playerPets = PetInfoManager.getAllBagPetInfo();
            _loc2_.supportInstance = this;
            _loc2_.doorLevel = this._doorLevel;
            ModuleManager.toggleModule(URLUtil.getAppModule(this._supportInfo.doorStartPanel),"正在打开选择面板...",_loc2_);
         }
      }
      
      private function setTrialLevel(param1:uint) : void
      {
         this._doorLevel = param1;
         this.updateGuardStatus(null);
         this._doorLevel_MC.gotoAndStop(this._doorLevel);
         this._levelTip2.gotoAndStop(this._doorLevel);
      }
      
      private function updateGuardStatus(param1:Function) : void
      {
         var onEnterFrame:Function = null;
         var onComplete:Function = param1;
         onEnterFrame = function(param1:Event):void
         {
            _guard.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            _guardInstance = _guard["guardInstance"];
            _guardInstance.gotoAndPlay("waiting");
            if(onComplete != null)
            {
               onComplete();
            }
         };
         this._guard.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         this._guard.gotoAndStop(Door21LevelUtil.getGuardIndex(this._doorLevel) + 1);
      }
      
      private function dealWithFightResult(param1:uint) : void
      {
         if(param1 == FightSide.RIGHT)
         {
            AlertManager.showDoorResult(false,this._supportInfo.doorType,this._supportInfo.doorRule,null,0);
         }
         else if(param1 == FightSide.LEFT)
         {
            if(this._doorLevel == 7)
            {
               this.reward7();
            }
            else if(this._doorLevel == 14)
            {
               this.reward14();
            }
            else if(this._doorLevel == 21)
            {
               this.reward21();
            }
            if(this._doorLevel < 21)
            {
               this.canLevelNow = false;
               this._guardInstance.gotoAndPlay("escape");
               setTimeout(this.onUpdateNextTrail,2000);
            }
         }
      }
      
      private function reward7() : void
      {
         this._rewardIDList = Vector.<ServerReward>([new ServerReward(200213,ServerReward.ITEM_REWARD),new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200002,ServerReward.ITEM_REWARD)]);
         AlertManager.showDoorReward(true,this._supportInfo.doorType,this._supportInfo.doorRule,this.rewardId,this._rewardIDList);
      }
      
      private function reward14() : void
      {
         this._rewardIDList = Vector.<ServerReward>([new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200221,ServerReward.ITEM_REWARD),new ServerReward(200003,ServerReward.ITEM_REWARD)]);
         AlertManager.showDoorReward(true,this._supportInfo.doorType,this._supportInfo.doorRule,this.rewardId,this._rewardIDList);
      }
      
      private function reward21() : void
      {
         if(this._isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,null,this._equipId,this.clearServerGive);
         }
         else
         {
            this._isGetServerGiveFlag = true;
         }
      }
      
      private function onUpdateNextTrail() : void
      {
         this.canLevelNow = true;
         this.setTrialLevel(this._doorLevel + 1);
      }
      
      private function clearServerGive() : void
      {
         this._isGetServerGiveFlag = false;
         this._equipId = 0;
         this.rewardId = 0;
         this.rewardIDList = null;
      }
      
      public function reset() : void
      {
         this._doorLevel = 1;
      }
      
      public function get supportInfo() : DoorSupportInfo
      {
         return this._supportInfo;
      }
      
      public function get canLevelNow() : Boolean
      {
         return this._canLevelNow;
      }
      
      public function set canLevelNow(param1:Boolean) : void
      {
         this._canLevelNow = param1;
      }
      
      public function get rewardIDList() : Vector.<ServerReward>
      {
         return this._rewardIDList;
      }
      
      public function set rewardIDList(param1:Vector.<ServerReward>) : void
      {
         this._rewardIDList = param1;
      }
      
      public function set rewardId(param1:uint) : void
      {
         this._rewardId = param1;
      }
      
      public function get rewardId() : uint
      {
         return this._rewardId;
      }
      
      public function getEquipSimpleInfo(param1:uint) : void
      {
         if(this._ITEMS.indexOf(param1) != -1 || param1 == 1)
         {
            this._equipId = param1;
            this.showEquip();
         }
      }
      
      private function showEquip() : void
      {
         if(this._isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,null,this._equipId,this.clearServerGive);
         }
         else
         {
            this._isGetServerGiveFlag = true;
         }
      }
      
      public function get doorLevel() : uint
      {
         return this._doorLevel;
      }
   }
}
