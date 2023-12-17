package com.taomee.seer2.app.gameRule.door.warrior
{
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.BaseNormalDoorSupport;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   
   public class WarriorDoorSuport extends BaseNormalDoorSupport implements IMultiSelectable
   {
      
      private static var _instance:WarriorDoorSuport;
       
      
      public function WarriorDoorSuport(param1:Block)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Singleton Instance!");
         }
         _supportInfo = new DoorSupportInfo(DoorRule.WARRIOR_DOOR,DoorType.Door_NORMAL,404,"WarriorDoorStartPanel");
      }
      
      public static function getInstance() : WarriorDoorSuport
      {
         if(_instance == null)
         {
            _instance = new WarriorDoorSuport(new Block());
         }
         return _instance;
      }
      
      override protected function dealWithFightResult(param1:uint) : void
      {
         if(param1 == FightSide.RIGHT)
         {
            updateGuardStatus(Base21LevelDoorSupport.STAND_STATUS);
            AlertManager.showDoorResult(false,_supportInfo.doorType,_supportInfo.doorRule);
         }
         else if(param1 == FightSide.LEFT)
         {
            if(_doorLevel >= 21)
            {
               _guard_mc.visible = false;
               if(_isGetServerGiveFlag)
               {
                  AlertManager.showDoorResult(true,_supportInfo.doorType,_supportInfo.doorRule,_serverGivePetInfo,0,clearServerGive);
               }
               else
               {
                  _isGetServerGiveFlag = true;
               }
            }
            else
            {
               canLevelNow = false;
               _guard_mc.addEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT,onUpdateNextTrail);
               updateGuardStatus(Base21LevelDoorSupport.ESCAPE_STATUS);
            }
         }
      }
      
      override public function set rewardId(param1:uint) : void
      {
         _rewardId = param1;
         if(_doorLevel == 7)
         {
            this.reward7();
         }
         else if(_doorLevel == 14)
         {
            this.reward14();
         }
      }
      
      private function reward7() : void
      {
         _rewardIDList = Vector.<ServerReward>([new ServerReward(200213,ServerReward.ITEM_REWARD),new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200002,ServerReward.ITEM_REWARD)]);
         AlertManager.showDoorReward(true,_supportInfo.doorType,_supportInfo.doorRule,_rewardId,_rewardIDList);
      }
      
      private function reward14() : void
      {
         _rewardIDList = Vector.<ServerReward>([new ServerReward(200214,ServerReward.ITEM_REWARD),new ServerReward(200221,ServerReward.ITEM_REWARD),new ServerReward(200003,ServerReward.ITEM_REWARD)]);
         AlertManager.showDoorReward(true,_supportInfo.doorType,_supportInfo.doorRule,_rewardId,_rewardIDList);
      }
   }
}

class Block
{
    
   
   public function Block()
   {
      super();
   }
}
