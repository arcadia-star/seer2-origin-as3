package com.taomee.seer2.app.gameRule.door.trails
{
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.BaseNormalDoorSupport;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   
   public class TrailDoorSupport extends BaseNormalDoorSupport
   {
      
      private static var _instance:com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;
       
      
      public function TrailDoorSupport(param1:Block)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Singleton Instance!");
         }
         _supportInfo = new DoorSupportInfo(DoorRule.TRAIL_DOOR,DoorType.Door_NORMAL,400,"TrailDoorStartPanel");
      }
      
      public static function getInstance() : com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport(new Block());
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
                  AlertManager.showDoorResult(true,_supportInfo.doorType,_supportInfo.doorRule,_serverGivePetInfo,0,this.closePanelFun);
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
      
      private function closePanelFun() : void
      {
         showUnlockPanel();
         clearServerGive();
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
