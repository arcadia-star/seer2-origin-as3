package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class TrainMonster implements IFightRequest
   {
       
      
      private var _recordData:FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function TrainMonster(param1:Function, param2:Function)
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
         var _loc4_:uint = uint(param1.id);
         if(FightVerifyManager.validateFightStart())
         {
            Connection.addCommandListener(CommandSet.PET_TRAINING_FIGHT_1042,this.onFightStart);
            Connection.addErrorHandler(CommandSet.PET_TRAINING_FIGHT_1042,this.onFightError);
            Connection.send(CommandSet.PET_TRAINING_FIGHT_1042,_loc4_);
         }
         else
         {
            if(this._onError != null)
            {
               this._onError();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
         }
      }
      
      private function onFightError(param1:MessageEvent) : void
      {
         this.reomveCommandListener();
         if(this._onError != null)
         {
            this._onError();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
         AlertManager.showAlert("每个好友只能挑战两次哦，明天再来吧");
      }
      
      private function onFightStart(param1:MessageEvent) : void
      {
         this.reomveCommandListener();
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
      
      private function reomveCommandListener() : void
      {
         Connection.removeErrorHandler(CommandSet.PET_TRAINING_FIGHT_1042,this.onFightError);
         Connection.removeCommandListener(CommandSet.PET_TRAINING_FIGHT_1042,this.onFightStart);
      }
   }
}
