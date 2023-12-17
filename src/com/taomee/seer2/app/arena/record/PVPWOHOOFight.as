package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class PVPWOHOOFight implements IFightRequest
   {
       
      
      private var _recordData:FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      private var _isConnection:Boolean = false;
      
      private var _data:LittleEndianByteArray;
      
      public function PVPWOHOOFight(param1:Function, param2:Function)
      {
         super();
         this._onStart = param1;
         this._onError = param2;
      }
      
      public function get uid() : Number
      {
         return this._recordData.fightUniqueID;
      }
      
      public function get fightRecordData() : FightRecordData
      {
         return this._recordData;
      }
      
      public function startFight(param1:Object, param2:ButtonPanelData, param3:Number = -1) : void
      {
         if(param3 == -1)
         {
            param3 = UUID.getUnique();
         }
         this._recordData = new FightRecordData(param3,param1,param2);
         this._data = param1.data as LittleEndianByteArray;
         Connection.addCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         Connection.addErrorHandler(CommandSet.SYSTEM_PET_FIGHT_1218,this.onSystemError);
         Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,this._data);
      }
      
      private function onSystemError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 200015)
         {
            Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
            Connection.removeErrorHandler(CommandSet.SYSTEM_PET_FIGHT_1218,this.onSystemError);
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
            AlertManager.showAlert("请选择至少1只伊特来对战");
            ModuleManager.closeForName("PVPWOHOOFightPanel");
         }
         if(param1.message.statusCode == 117)
         {
            Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
            Connection.removeErrorHandler(CommandSet.SYSTEM_PET_FIGHT_1218,this.onSystemError);
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
            AlertManager.showAlert("时间不对");
            ModuleManager.closeForName("PVPWOHOOFightPanel");
         }
      }
      
      private function onStartFightVerify(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         FightVerifyManager.onStartFightVerify(param1,this.onSuccess,this.onFail);
      }
      
      private function onSuccess() : void
      {
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,this._data);
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
         Connection.removeErrorHandler(CommandSet.SYSTEM_PET_FIGHT_1218,this.onSystemError);
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
      }
      
      private function onStartFight(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.removeErrorHandler(CommandSet.SYSTEM_PET_FIGHT_1218,this.onSystemError);
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
   }
}
