package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class GateMonster implements IFightRequest
   {
       
      
      private var _recordData:FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function GateMonster(param1:Function, param2:Function)
      {
         super();
         this._onStart = param1;
         this._onError = param2;
      }
      
      public function get fightRecordData() : FightRecordData
      {
         return this._recordData;
      }
      
      public function get uid() : Number
      {
         return this._recordData.fightUniqueID;
      }
      
      public function startFight(param1:Object, param2:ButtonPanelData, param3:Number = -1) : void
      {
         if(param3 == -1)
         {
            param3 = UUID.getUnique();
         }
         this._recordData = new FightRecordData(param3,param1,param2);
         if(FightVerifyManager.checkVerifyStatus() == false)
         {
            if(this._onError != null)
            {
               this._onError();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            return;
         }
         Connection.addCommandListener(CommandSet.FIGHT_IN_TRAILSDOOR_1047,this.onStartFightBoss);
         Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.send(CommandSet.FIGHT_IN_TRAILSDOOR_1047);
      }
      
      private function onStartFightBoss(param1:MessageEvent) : void
      {
         this.reomveCommandListener();
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
      
      private function onStartFightVerify(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         FightVerifyManager.onStartFightVerify(param1,this.onSuccess,this.onFail);
      }
      
      private function onSuccess() : void
      {
         Connection.send(CommandSet.FIGHT_IN_TRAILSDOOR_1047);
      }
      
      private function onFail() : void
      {
         this.reomveCommandListener();
         if(this._onError != null)
         {
            this._onError();
         }
         FightVerifyManager.startForbiddenTimer();
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
      }
      
      private function reomveCommandListener() : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.removeCommandListener(CommandSet.FIGHT_IN_TRAILSDOOR_1047,this.onStartFightBoss);
      }
   }
}
