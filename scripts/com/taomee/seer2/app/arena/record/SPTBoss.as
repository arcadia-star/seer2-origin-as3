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
   
   public class SPTBoss implements IFightRequest
   {
       
      
      private var _recordData:com.taomee.seer2.app.arena.record.FightRecordData;
      
      private var _onStart:Function;
      
      private var _onError:Function;
      
      public function SPTBoss(param1:Function, param2:Function)
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
         var bossId:uint = 0;
         var params:Array = null;
         var onStartFightBoss:Function = null;
         var onStartFightVerify:Function = null;
         var onSuccess:Function = null;
         var onFail:Function = null;
         var initData:Object = param1;
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
         };
         onStartFightVerify = function(param1:MessageEvent):void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            FightVerifyManager.onStartFightVerify(param1,onSuccess,onFail);
         };
         onSuccess = function():void
         {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:Vector.<uint> = null;
            var _loc5_:uint = 0;
            var _loc6_:uint = 0;
            var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
            _loc1_.writeUnsignedInt(bossId);
            if(params == null || params.length == 0)
            {
               _loc1_.writeUnsignedInt(0);
            }
            else
            {
               _loc2_ = int(params.length);
               _loc1_.writeUnsignedInt(_loc2_);
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc1_.writeUnsignedInt(params[_loc3_]);
                  _loc3_++;
               }
            }
            if(initData.singlePetFight)
            {
               _loc1_.writeByte(1);
               _loc1_.writeUnsignedInt(0);
            }
            else
            {
               _loc1_.writeByte(2);
               _loc5_ = (_loc4_ = initData.petIds).length;
               _loc1_.writeUnsignedInt(_loc5_);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc1_.writeUnsignedInt(_loc4_[_loc6_]);
                  _loc6_++;
               }
            }
            Connection.send(CommandSet.BOSS_START_FIGHT_1046,_loc1_);
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗成功 boosID=" + bossId);
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：" + CommandSet.BOSS_START_FIGHT_1046.toString() + "boosID=" + bossId);
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
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.FIGHT_ID,"\n战斗协议：发起战斗失败 boosID=" + bossId);
         };
         var reomveCommandListener:Function = function():void
         {
            Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            Connection.removeCommandListener(CommandSet.BOSS_START_FIGHT_1046,onStartFightBoss);
         };
         if(uid == -1)
         {
            uid = UUID.getUnique();
         }
         this._recordData = new com.taomee.seer2.app.arena.record.FightRecordData(uid,initData,btnPanelData);
         bossId = uint(initData.bossId);
         params = initData.params;
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
            Connection.addCommandListener(CommandSet.BOSS_START_FIGHT_1046,onStartFightBoss);
            Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111,onStartFightVerify);
            onSuccess();
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
   }
}
