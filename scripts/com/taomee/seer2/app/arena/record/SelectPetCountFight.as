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
   import org.taomee.utils.Tick;
   
   public class SelectPetCountFight implements IFightRequest
   {
       
      
      private var _recordData:com.taomee.seer2.app.arena.record.FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      private var _isConnection:Boolean = false;
      
      public function SelectPetCountFight(param1:Function, param2:Function)
      {
         super();
         this._onStart = param1;
         this._onError = param2;
      }
      
      public function get uid() : Number
      {
         return this._recordData.fightUniqueID;
      }
      
      public function get fightRecordData() : com.taomee.seer2.app.arena.record.FightRecordData
      {
         return this._recordData;
      }
      
      public function startFight(param1:Object, param2:ButtonPanelData, param3:Number = -1) : void
      {
         if(param3 == -1)
         {
            param3 = UUID.getUnique();
         }
         this._recordData = new com.taomee.seer2.app.arena.record.FightRecordData(param3,param1,param2);
         var _loc4_:uint = uint(param1.type);
         Connection.addCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         Connection.addCommandListener(CommandSet.FIGHT_LOAD_RES_1,this.onGetResourceInfo);
         Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,_loc4_,0);
      }
      
      private function onStartFightVerify(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         FightVerifyManager.onStartFightVerify(param1,this.onSuccess,this.onFail);
      }
      
      private function onSuccess() : void
      {
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,this._recordData.initData.type,0);
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
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         Connection.removeCommandListener(CommandSet.FIGHT_LOAD_RES_1,this.onGetResourceInfo);
      }
      
      private function onStartFight(param1:MessageEvent) : void
      {
         this._isConnection = false;
         Tick.instance.addTimeout(5000,this.leaveFight);
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
      
      private function leaveFight() : void
      {
         if(this._isConnection == false)
         {
            Connection.send(CommandSet.FIGHE_PLAYER_CANCEL_1505);
            AlertManager.showAlert("对方已经离开战斗！",function():void
            {
            });
         }
      }
      
      private function onGetResourceInfo(param1:MessageEvent) : void
      {
         this._isConnection = true;
         Tick.instance.removeTimeout(this.leaveFight);
         Connection.removeCommandListener(CommandSet.FIGHT_LOAD_RES_1,this.onGetResourceInfo);
      }
   }
}
