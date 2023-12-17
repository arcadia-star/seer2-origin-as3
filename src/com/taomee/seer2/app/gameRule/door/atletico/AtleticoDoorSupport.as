package com.taomee.seer2.app.gameRule.door.atletico
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.BaseNormalDoorSupport;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class AtleticoDoorSupport extends BaseNormalDoorSupport implements IMultiSelectable
   {
      
      private static var _instance:AtleticoDoorSupport;
      
      private static const DELAY_TIME:uint = 500;
       
      
      private var _winCounter:uint = 0;
      
      private var _totalCounter:uint = 0;
      
      public function AtleticoDoorSupport()
      {
         super();
         _supportInfo = new DoorSupportInfo(DoorRule.ATLETICO_DOOR,DoorType.Door_NORMAL,408,"AtleticoDoorStartPanel");
      }
      
      public static function getInstance() : AtleticoDoorSupport
      {
         if(_instance == null)
         {
            _instance = new AtleticoDoorSupport();
         }
         return _instance;
      }
      
      override protected function dealWithFightResult(param1:uint) : void
      {
         ++this._totalCounter;
         if(param1 == FightSide.RIGHT)
         {
            updateGuardStatus(Base21LevelDoorSupport.STAND_STATUS);
            if(this._totalCounter == 2 && this._winCounter < 1 || this._totalCounter == 3 && this._winCounter < 2)
            {
               AlertManager.showDoorResult(false,_supportInfo.doorType,_supportInfo.doorRule);
            }
            else
            {
               canLevelNow = false;
               setTimeout(this.startFightWithGateMonster,DELAY_TIME);
            }
         }
         else if(param1 == FightSide.LEFT)
         {
            ++this._winCounter;
            if(this._winCounter >= 2)
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
            else
            {
               canLevelNow = false;
               updateGuardStatus(Base21LevelDoorSupport.STAND_STATUS);
               setTimeout(this.startFightWithGateMonster,DELAY_TIME);
            }
         }
      }
      
      private function onFightNext(param1:Event) : void
      {
         _guard_mc.removeEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT,this.onFightNext);
         this.startFightWithGateMonster();
      }
      
      private function startFightWithGateMonster() : void
      {
         var onFightError:Function = null;
         onFightError = function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,83);
         };
         FightManager.startFightWithGateMonster(null,onFightError);
      }
      
      override protected function setTrialLevel(param1:uint) : void
      {
         super.setTrialLevel(param1);
         this.resetCounter();
      }
      
      private function resetCounter() : void
      {
         this._winCounter = 0;
         this._totalCounter = 0;
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
