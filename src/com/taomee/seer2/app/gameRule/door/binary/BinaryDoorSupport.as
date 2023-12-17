package com.taomee.seer2.app.gameRule.door.binary
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
   import com.taomee.seer2.app.gameRule.door.BinaryDoor;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.IDoorServerPetable;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1017;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class BinaryDoorSupport implements IUpDoorSupport, IMultiSelectable, IDoorServerPetable
   {
      
      private static var _instance:BinaryDoorSupport;
       
      
      private var _supportInfo:DoorSupportInfo;
      
      private var _map:MapModel;
      
      private var _doorLevel_MC:MovieClip;
      
      private var _guard:MovieClip;
      
      private var _guardInstance:MovieClip;
      
      private var _levelTip2:MovieClip;
      
      private var _doorLevel:uint = 1;
      
      private var _isGetServerGiveFlag:Boolean = false;
      
      private var _canLevelNow:Boolean = true;
      
      private var _animationPlayer:ProgressiveAnimationPlayer;
      
      private var _rewardId:uint;
      
      private var _rewardIDList:Vector.<ServerReward>;
      
      private var _petId:uint = 0;
      
      private var _resourceId:uint = 0;
      
      private var _serverGivePetInfo:PetInfo;
      
      public function BinaryDoorSupport()
      {
         super();
         this._supportInfo = new DoorSupportInfo(DoorRule.BINARY_DOOR,DoorType.Door_NORMAL,BinaryDoor.BINARY_SCENE_MAPID_1,"BinaryDoorStartPanel");
      }
      
      public static function getInstance() : BinaryDoorSupport
      {
         if(_instance == null)
         {
            _instance = new BinaryDoorSupport();
         }
         return _instance;
      }
      
      public function get doorLevel() : uint
      {
         return this._doorLevel;
      }
      
      public function get supportInfo() : DoorSupportInfo
      {
         return this._supportInfo;
      }
      
      public function init(param1:MapModel) : void
      {
         this._canLevelNow = true;
         this._map = param1;
         this.initUI();
      }
      
      private function playAnimation(param1:Function) : void
      {
         var onAnimationEnd:Function = null;
         var onComplete:Function = param1;
         onAnimationEnd = function(param1:Event):void
         {
            SoundManager.backgroundSoundEnabled = true;
            _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END,onAnimationEnd);
            DisplayObjectUtil.removeFromParent(_animationPlayer);
            _animationPlayer = null;
            if(onComplete != null)
            {
               onComplete();
            }
         };
         var animationName:String = "";
         if(this._doorLevel == 21)
         {
            animationName = "door_binary_1";
         }
         else if(this._doorLevel == 41)
         {
            animationName = "door_binary_2";
         }
         if(animationName != "")
         {
            SoundManager.backgroundSoundEnabled = false;
            this._animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/" + animationName));
            this._animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END,onAnimationEnd);
            LayerManager.uiLayer.addChild(this._animationPlayer);
         }
         else if(onComplete != null)
         {
            onComplete();
         }
      }
      
      private function initUI() : void
      {
         this._doorLevel_MC = this._map.content["levelTip"];
         this._doorLevel_MC.gotoAndStop(this._doorLevel);
         this._levelTip2 = this._map.front["levelTip2"];
         this._guard = this._map.content["guard"];
         this._guard.buttonMode = true;
         this._guard.useHandCursor = true;
         this._guard.addEventListener(MouseEvent.CLICK,this.onGuardClick);
         this.updateGuardStatus(this.initResult);
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
         var _loc2_:Vector.<PetInfo> = null;
         var _loc3_:DoorInitData = null;
         if(this._canLevelNow)
         {
            if(FightVerifyManager.checkVerifyStatus() == false)
            {
               return;
            }
            _loc2_ = PetInfoManager.getAllBagPetInfo();
            if(_loc2_.length < 2)
            {
               AlertManager.showAlert("双精灵模式至少需要携带2只精灵!");
            }
            else
            {
               _loc3_ = new DoorInitData();
               _loc3_.npcName = Door21LevelUtil.getBinaryGuardName(this._doorLevel);
               _loc3_.npcPets = Door21LevelUtil.getGuardPets(this._doorLevel,this._supportInfo.doorType,this._supportInfo.doorRule);
               _loc3_.playerName = ActorManager.actorInfo.nick;
               _loc3_.playerPets = _loc2_;
               _loc3_.supportInstance = this;
               _loc3_.doorLevel = this._doorLevel;
               ModuleManager.toggleModule(URLUtil.getAppModule(this._supportInfo.doorStartPanel),"正在打开选择面板...",_loc3_);
            }
         }
      }
      
      private function setTrialLevel(param1:uint) : void
      {
         this._doorLevel = param1;
         this._supportInfo.currentDoorLevel = this._doorLevel;
         this.updateGuardStatus(null);
         this._doorLevel_MC.gotoAndStop(this._doorLevel);
         this._levelTip2.gotoAndStop(this._doorLevel);
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
               this.reward_type1();
            }
            else if(this._doorLevel == 14 || this._doorLevel == 28 || this._doorLevel == 35)
            {
               this.reward_type2();
            }
            else if(this._doorLevel == 21 || this._doorLevel == 42)
            {
               this.reward_type3();
            }
            else
            {
               this.playAnimation(this.afterReward);
            }
         }
      }
      
      private function afterReward(param1:Function = null) : void
      {
         var onTimeOut:Function = null;
         var updateComplete:Function = param1;
         onTimeOut = function():void
         {
            if(updateComplete != null)
            {
               updateComplete();
            }
            onUpdateNextTrail();
         };
         this.canLevelNow = false;
         this._guardInstance.gotoAndPlay("escape");
         setTimeout(onTimeOut,2000);
      }
      
      private function onUpdateNextTrail() : void
      {
         this.canLevelNow = true;
         this.setTrialLevel(this._doorLevel + 1);
      }
      
      private function rewardComplete() : void
      {
         this.afterReward(this.clearServerGive);
      }
      
      private function reward_type1() : void
      {
         if(this._rewardId != 0)
         {
            this._rewardIDList = Vector.<ServerReward>([new ServerReward(200213,ServerReward.ITEM_REWARD),new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200002,ServerReward.ITEM_REWARD)]);
            AlertManager.showDoorReward(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._rewardId,this._rewardIDList,this.rewardComplete);
         }
         else
         {
            this.rewardComplete();
         }
      }
      
      private function reward_type2() : void
      {
         if(this._rewardId != 0)
         {
            this._rewardIDList = Vector.<ServerReward>([new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200221,ServerReward.ITEM_REWARD),new ServerReward(200003,ServerReward.ITEM_REWARD)]);
            AlertManager.showDoorReward(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._rewardId,this._rewardIDList,this.rewardComplete);
         }
         else
         {
            this.rewardComplete();
         }
      }
      
      private function reward_type3() : void
      {
         if(this._petId != 0)
         {
            if(this._isGetServerGiveFlag)
            {
               AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._serverGivePetInfo,0,this.rewardComplete);
            }
            else
            {
               this._isGetServerGiveFlag = true;
            }
         }
         else if(this._rewardId != 0)
         {
            this._rewardIDList = Vector.<ServerReward>([new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200221,ServerReward.ITEM_REWARD),new ServerReward(200003,ServerReward.ITEM_REWARD)]);
            AlertManager.showDoorReward(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._rewardId,this._rewardIDList,this.rewardComplete);
         }
         else
         {
            this.rewardComplete();
         }
      }
      
      private function clearServerGive() : void
      {
         var animationEnd:Function = null;
         animationEnd = function():void
         {
            _supportInfo.targetMapId = BinaryDoor.BINARY_SCENE_MAPID_2;
            SceneManager.changeScene(SceneType.LOBBY,BinaryDoor.BINARY_SCENE_MAPID_2,440,480);
         };
         this._petId = 0;
         this._resourceId = 0;
         this._isGetServerGiveFlag = false;
         this._serverGivePetInfo = null;
         this._rewardId = 0;
         this.rewardIDList = null;
         if(this._doorLevel >= 21)
         {
            if(this._doorLevel >= 42)
            {
               Connection.send(CommandSet.DOOR_OUT_1049);
               SceneManager.changeScene(SceneType.LOBBY,86);
            }
            else
            {
               this.playAnimation(animationEnd);
            }
         }
         else
         {
            this._supportInfo.targetMapId = BinaryDoor.BINARY_SCENE_MAPID_1;
         }
      }
      
      public function reset() : void
      {
         this._doorLevel = 1;
      }
      
      public function get canLevelNow() : Boolean
      {
         return this._canLevelNow;
      }
      
      public function set canLevelNow(param1:Boolean) : void
      {
         this._canLevelNow = param1;
      }
      
      public function get rewardId() : uint
      {
         return this._rewardId;
      }
      
      public function set rewardId(param1:uint) : void
      {
         this._rewardId = param1;
      }
      
      public function get rewardIDList() : Vector.<ServerReward>
      {
         return this._rewardIDList;
      }
      
      public function set rewardIDList(param1:Vector.<ServerReward>) : void
      {
         this._rewardIDList = param1;
      }
      
      public function getPetSimpleInfo(param1:uint, param2:uint) : void
      {
         this._petId = param1;
         this._resourceId = param2;
         var _loc3_:PetInfo = new PetInfo();
         _loc3_.catchTime = this._petId;
         _loc3_.resourceId = this._resourceId;
         Connection.addCommandListener(CommandSet.PET_SIMPLE_INFO_1017,this.onGetPetSimpleInfo);
         Connection.send(CommandSet.PET_SIMPLE_INFO_1017,param1);
      }
      
      private function onGetPetSimpleInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.PET_SIMPLE_INFO_1017,this.onGetPetSimpleInfo);
         this._serverGivePetInfo = new Parser_1017(param1.message.getRawData()).petInfo;
         if(this._isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._serverGivePetInfo,0,this.rewardComplete);
         }
         else
         {
            this._isGetServerGiveFlag = true;
         }
      }
      
      public function get petId() : uint
      {
         var _loc1_:uint = this._petId;
         this._petId = 0;
         return _loc1_;
      }
      
      public function get resourceId() : uint
      {
         var _loc1_:uint = this._resourceId;
         this._resourceId = 0;
         return _loc1_;
      }
   }
}
