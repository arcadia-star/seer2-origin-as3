package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class PVPTrainerMatchFight implements IFightRequest
   {
       
      
      private var _recordData:FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      private var _isConnection:Boolean = false;
      
      private var _data:LittleEndianByteArray;
      
      public function PVPTrainerMatchFight(param1:Function, param2:Function)
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
         this._data.position = 0;
         this._recordData.initData.positionIndex = this._data.readUnsignedInt();
         this._data.position = 0;
         Connection.addCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,this._data);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.SYSTEM_PET_FIGHT_1218.toString());
      }
      
      private function onStartFightVerify(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         FightVerifyManager.onStartFightVerify(param1,this.onSuccess,this.onFail);
      }
      
      private function onSuccess() : void
      {
         Connection.send(CommandSet.SYSTEM_PET_FIGHT_1218,this._data);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗成功");
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
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗失败");
      }
      
      private function reomveCommandListener() : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
      }
      
      private function onStartFight(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,this.onStartFightVerify);
         Connection.removeCommandListener(CommandSet.SYSTEM_PET_FIGHT_1218,this.onStartFight);
         if(this._onStart != null)
         {
            this._onStart();
         }
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
      }
   }
}
