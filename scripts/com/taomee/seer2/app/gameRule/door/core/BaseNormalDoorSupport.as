package com.taomee.seer2.app.gameRule.door.core
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1017;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BaseNormalDoorSupport extends Base21LevelDoorSupport implements IDoorServerPetable
   {
       
      
      protected var _petId:uint = 0;
      
      protected var _resourceId:uint = 0;
      
      protected var _serverGivePetInfo:PetInfo;
      
      protected var _rewardId:uint;
      
      protected var _rewardIDList:Vector.<com.taomee.seer2.app.gameRule.door.core.ServerReward>;
      
      public function BaseNormalDoorSupport()
      {
         super();
      }
      
      protected function showUnlockPanel() : void
      {
         var _loc1_:uint = 0;
         if(_supportInfo.doorType == DoorType.Door_NORMAL && _supportInfo.neverToMaxLevel)
         {
            _loc1_ = uint(_supportInfo.doorRule + 1);
            if(_loc1_ <= DoorRule.BINARY_DOOR)
            {
               ModuleManager.showModule(URLUtil.getAppModule("UnlockDoorPanel"),"正在打开解锁面板...",{"doorRule":_loc1_});
            }
         }
      }
      
      override protected function onGuardClick(param1:MouseEvent) : void
      {
         var _loc2_:DoorInitData = null;
         if(canLevelNow)
         {
            if(FightVerifyManager.checkVerifyStatus() == false)
            {
               return;
            }
            _loc2_ = new DoorInitData();
            _loc2_.npcName = Door21LevelUtil.getGuardName(_doorLevel);
            _loc2_.npcPets = Door21LevelUtil.getGuardPets(_doorLevel,_supportInfo.doorType,_supportInfo.doorRule);
            _loc2_.playerName = ActorManager.actorInfo.nick;
            _loc2_.playerPets = PetInfoManager.getAllBagPetInfo();
            _loc2_.supportInstance = this;
            _loc2_.doorLevel = _doorLevel;
            _loc2_.doorRule = _supportInfo.doorRule;
            _loc2_.doorType = _supportInfo.doorType;
            ModuleManager.toggleModule(URLUtil.getAppModule(_supportInfo.doorStartPanel),"正在打开选择面板...",_loc2_);
         }
      }
      
      protected function onUpdateNextTrail(param1:Event) : void
      {
         _guard_mc.removeEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT,this.onUpdateNextTrail);
         canLevelNow = true;
         setTrialLevel(_doorLevel + 1);
      }
      
      override protected function clearServerGive() : void
      {
         _isGetServerGiveFlag = false;
         this._serverGivePetInfo = null;
         this._rewardId = 0;
         this._rewardIDList = null;
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
         if(_isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,_supportInfo.doorType,_supportInfo.doorRule,this._serverGivePetInfo,0,this.clearServerGive);
         }
         else
         {
            _isGetServerGiveFlag = true;
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
      
      public function get rewardIDList() : Vector.<com.taomee.seer2.app.gameRule.door.core.ServerReward>
      {
         return this._rewardIDList;
      }
      
      public function set rewardIDList(param1:Vector.<com.taomee.seer2.app.gameRule.door.core.ServerReward>) : void
      {
         this._rewardIDList = param1;
      }
      
      public function set rewardId(param1:uint) : void
      {
         this._rewardId = param1;
      }
   }
}
