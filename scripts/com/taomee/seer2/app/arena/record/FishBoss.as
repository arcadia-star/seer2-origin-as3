package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class FishBoss implements IFightRequest
   {
       
      
      private var _recordData:com.taomee.seer2.app.arena.record.FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function FishBoss(param1:Function, param2:Function)
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
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.FIGHT_START_WILD_1500.toString() + "发起战斗成功");
         };
         onStartFightVerify = function(param1:MessageEvent):void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            FightVerifyManager.onStartFightVerify(param1,onSuccess,onFail);
         };
         onSuccess = function():void
         {
            Connection.send(CommandSet.FISH_FIGHT_1165);
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
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.FIGHT_START_WILD_1500.toString() + "发起战斗失败");
         };
         var reomveCommandListener:Function = function():void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            Connection.removeCommandListener(CommandSet.FISH_FIGHT_1165,onStartFightBoss);
         };
         if(uid == -1)
         {
            uid = UUID.getUnique();
         }
         this._recordData = new com.taomee.seer2.app.arena.record.FightRecordData(uid,params,btnPanelData);
         if(FightVerifyManager.checkVerifyStatus() == false)
         {
            if(this._onError != null)
            {
               this._onError();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            return;
         }
         if(FightVerifyManager.validateFightStart())
         {
            Connection.addCommandListener(CommandSet.FISH_FIGHT_1165,onStartFightBoss);
            Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            Connection.send(CommandSet.FISH_FIGHT_1165);
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.FISH_FIGHT_1165.toString());
         }
      }
   }
}
