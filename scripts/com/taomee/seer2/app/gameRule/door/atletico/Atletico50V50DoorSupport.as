package com.taomee.seer2.app.gameRule.door.atletico
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.Base50V50DoorSupport;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class Atletico50V50DoorSupport extends Base50V50DoorSupport
   {
      
      private static var _instance:com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport;
       
      
      private var _winCounter:uint = 0;
      
      private var _totalCounter:uint = 0;
      
      public function Atletico50V50DoorSupport()
      {
         super();
         _supportInfo = new DoorSupportInfo(DoorRule.ATLETICO_DOOR,DoorType.Door_50V50,409,"AtleticoDoorStartPanel");
         _ITEMS = [100111,100110,100109,100108];
      }
      
      public static function getInstance() : com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport();
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
               setTimeout(this.startFightWithGateMonster,1000);
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
                  showEquip();
               }
               else
               {
                  canLevelNow = false;
                  _guard_mc.addEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT,onUpdateNextTrailHandler);
                  updateGuardStatus(Base21LevelDoorSupport.ESCAPE_STATUS);
               }
            }
            else
            {
               canLevelNow = false;
               updateGuardStatus(Base21LevelDoorSupport.STAND_STATUS);
               setTimeout(this.startFightWithGateMonster,1000);
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
   }
}
