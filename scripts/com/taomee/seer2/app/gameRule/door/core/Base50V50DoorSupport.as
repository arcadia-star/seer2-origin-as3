package com.taomee.seer2.app.gameRule.door.core
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Base50V50DoorSupport extends Base21LevelDoorSupport implements IDoorServerEquipable
   {
       
      
      protected var _ITEMS:Array;
      
      protected var _equipId:uint = 0;
      
      protected var _rewardId:uint;
      
      protected var _rewardIDList:Vector.<com.taomee.seer2.app.gameRule.door.core.ServerReward>;
      
      public function Base50V50DoorSupport()
      {
         super();
      }
      
      override protected function clearServerGive() : void
      {
         _isGetServerGiveFlag = false;
         this._equipId = 0;
         this._rewardId = 0;
         this._rewardIDList = null;
      }
      
      protected function onUpdateNextTrailHandler(param1:Event) : void
      {
         _guard_mc.removeEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT,this.onUpdateNextTrailHandler);
         canLevelNow = true;
         setTrialLevel(_doorLevel + 1);
      }
      
      override protected function updateGuardStatus(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(_doorLevel != 21)
         {
            super.updateGuardStatus(param1);
         }
         else
         {
            _loc2_ = this.getLastEquipId();
            if(_loc2_ == -1)
            {
               _guard.gotoAndStop(Door21LevelUtil.getGuardIndex(21) + 1);
               _guard_mc.gotoAndPlay(Door21LevelUtil.getGuardLabel(21,param1));
            }
            else
            {
               _loc3_ = uint(Door21LevelUtil.getGuardIndex(21) + 1 + this.getAddFrameIndex(_loc2_));
               _guard.gotoAndStop(_loc3_);
               _guard_mc.gotoAndPlay(Door21LevelUtil.getGuardLabel(21,param1) + "_" + _loc2_);
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
      
      public function getEquipSimpleInfo(param1:uint) : void
      {
         if(this._ITEMS.indexOf(param1) != -1 || param1 == 1)
         {
            this._equipId = param1;
            this.showEquip();
         }
      }
      
      protected function showEquip() : void
      {
         if(_isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,_supportInfo.doorType,_supportInfo.doorRule,null,this._equipId,this.clearServerGive);
         }
         else
         {
            _isGetServerGiveFlag = true;
         }
      }
      
      private function getAddFrameIndex(param1:uint) : uint
      {
         var _loc2_:int = this._ITEMS.indexOf(param1);
         if(_loc2_ != -1)
         {
            return _loc2_ + 1;
         }
         return 0;
      }
      
      private function getLastEquipId() : int
      {
         var _loc1_:int = -1;
         var _loc2_:int = 0;
         while(this.hasEquipId(this._ITEMS[_loc2_]))
         {
            _loc1_ = int(this._ITEMS[_loc2_]);
            _loc2_++;
            if(_loc2_ > 4)
            {
               break;
            }
         }
         return _loc1_;
      }
      
      private function hasEquipId(param1:uint) : Boolean
      {
         var _loc2_:Vector.<EquipItem> = ItemManager.getEquipVec();
         var _loc3_:uint = _loc2_.length;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc2_[_loc5_].referenceId == param1)
            {
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc4_;
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
