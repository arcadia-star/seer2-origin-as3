package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class ActivityBoss implements IFightRequest
   {
       
      
      private var _recordData:com.taomee.seer2.app.arena.record.FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function ActivityBoss(param1:Function, param2:Function)
      {
         super();
         this._onStart = param1;
         this._onError = param2;
      }
      
      public function get fightRecordData() : com.taomee.seer2.app.arena.record.FightRecordData
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
         this._recordData = new com.taomee.seer2.app.arena.record.FightRecordData(param3,param1,param2);
         var _loc4_:uint = uint(param1.bossId);
         if(FightVerifyManager.validateFightStart())
         {
            Connection.addCommandListener(CommandSet.ACTIVITY_FIGHT_MONSTER_1066,this.onStartFightBoss);
            Connection.send(CommandSet.ACTIVITY_FIGHT_MONSTER_1066,_loc4_);
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
      
      private function onStartFightBoss(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVITY_FIGHT_MONSTER_1066,this.onStartFightBoss);
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
   }
}
