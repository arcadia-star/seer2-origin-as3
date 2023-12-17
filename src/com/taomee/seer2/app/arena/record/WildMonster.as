package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class WildMonster implements IFightRequest
   {
       
      
      private var _recordData:FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function WildMonster(param1:Function, param2:Function)
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
         var positionIndex:uint = 0;
         var onStartFightBoss:Function = null;
         var onStartFightVerify:Function = null;
         var onSuccess:Function = null;
         var onFail:Function = null;
         var params:Object = param1;
         var btnPanelData:ButtonPanelData = param2;
         var uid:Number = param3;
         onStartFightBoss = function(param1:MessageEvent):void
         {
            reomveCommandListener();
            if(_onStart != null)
            {
               _onStart();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗成功  fightID=" + positionIndex);
         };
         onStartFightVerify = function(param1:MessageEvent):void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            FightVerifyManager.onStartFightVerify(param1,onSuccess,onFail);
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_351);
         };
         onSuccess = function():void
         {
            Connection.send(CommandSet.FIGHT_START_WILD_1500,LittleEndianByteArray.writeIntergerAsUnsignedInt(positionIndex));
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_350);
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：确认成功  fightID=" + positionIndex);
         };
         onFail = function():void
         {
            reomveCommandListener();
            FightVerifyManager.startForbiddenTimer();
            if(_onError != null)
            {
               _onError();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：确认失败  fightID=" + positionIndex);
         };
         var reomveCommandListener:Function = function():void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            Connection.removeCommandListener(CommandSet.FIGHT_START_WILD_1500,onStartFightBoss);
         };
         if(uid == -1)
         {
            uid = UUID.getUnique();
         }
         this._recordData = new FightRecordData(uid,params,btnPanelData);
         positionIndex = uint(params.positionIndex);
         if(FightVerifyManager.checkVerifyStatus() == false)
         {
            if(this._onError != null)
            {
               this._onError();
            }
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：战斗冷却中  fightID=" + positionIndex);
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            return;
         }
         if(FightVerifyManager.validateFightStart())
         {
            Connection.addCommandListener(CommandSet.FIGHT_START_WILD_1500,onStartFightBoss);
            Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            Connection.send(CommandSet.FIGHT_START_WILD_1500,LittleEndianByteArray.writeIntergerAsUnsignedInt(positionIndex));
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.FIGHT_START_WILD_1500.toString() + "  fightID=" + positionIndex);
         }
         else
         {
            if(this._onError != null)
            {
               this._onError();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗失败  fightID=" + positionIndex);
         }
      }
   }
}
