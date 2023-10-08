package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.info.RankInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1521;
   import com.taomee.seer2.app.net.parser.baseData.RankServerInfo;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class RankManager
   {
      
      private static var _waitVec:Vector.<RankInfo> = new Vector.<RankInfo>();
      
      private static var _isBusy:Boolean = false;
      
      private static var _callBack:Function;
      
      private static var _currentInfo:RankInfo;
      
      private static var _actorCallBack:Function;
       
      
      public function RankManager()
      {
         super();
      }
      
      public static function getRankList(param1:int, param2:Function, param3:int = 0, param4:int = 100) : void
      {
         var _loc5_:RankInfo;
         (_loc5_ = new RankInfo()).rankId = param1;
         _loc5_.callBack = param2;
         _loc5_.min = param3;
         _loc5_.max = param4;
         _waitVec.push(_loc5_);
         if(_isBusy == false)
         {
            connectServer();
         }
      }
      
      public static function getBeforeRank(param1:int, param2:Function, param3:int, param4:int, param5:uint, param6:uint) : void
      {
         var _loc7_:RankInfo;
         (_loc7_ = new RankInfo()).rankId = param1;
         _loc7_.callBack = param2;
         _loc7_.min = param3;
         _loc7_.max = param4;
         _loc7_.startTime = param5;
         _loc7_.endTime = param6;
         _waitVec.push(_loc7_);
         if(_isBusy == false)
         {
            connectServer();
         }
      }
      
      private static function connectServer() : void
      {
         if(_waitVec.length >= 1)
         {
            _currentInfo = _waitVec.shift();
            _callBack = _currentInfo.callBack;
            if(_currentInfo.startTime != 0)
            {
               Connection.addCommandListener(CommandSet.CLI_GET_RANK_BEFORE_1545,onGetRank);
               Connection.addErrorHandler(CommandSet.CLI_GET_RANK_BEFORE_1545,onGetDoCountError);
               Connection.send(CommandSet.CLI_GET_RANK_BEFORE_1545,_currentInfo.rankId,_currentInfo.min,_currentInfo.max,_currentInfo.startTime,_currentInfo.endTime);
            }
            else
            {
               Connection.addCommandListener(CommandSet.GET_RANK_LIST_1521,onGetRank);
               Connection.addErrorHandler(CommandSet.GET_RANK_LIST_1521,onGetDoCountError);
               Connection.send(CommandSet.GET_RANK_LIST_1521,_currentInfo.rankId,_currentInfo.min,_currentInfo.max);
            }
            _isBusy = true;
         }
      }
      
      private static function onGetRank(param1:MessageEvent) : void
      {
         if(param1.message.commandId == 1521)
         {
            Connection.removeCommandListener(CommandSet.GET_RANK_LIST_1521,onGetRank);
            Connection.removeErrorHandler(CommandSet.GET_RANK_LIST_1521,onGetDoCountError);
         }
         else
         {
            Connection.removeCommandListener(CommandSet.CLI_GET_RANK_BEFORE_1545,onGetRank);
            Connection.removeCommandListener(CommandSet.CLI_GET_RANK_BEFORE_1545,onGetDoCountError);
         }
         var _loc2_:Parser_1521 = new Parser_1521(param1.message.getRawDataCopy());
         _callBack(_loc2_);
         _callBack = null;
         _isBusy = false;
         connectServer();
      }
      
      private static function onGetDoCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_RANK_LIST_1521,onGetRank);
         Connection.removeErrorHandler(CommandSet.GET_RANK_LIST_1521,onGetDoCountError);
         _isBusy = false;
         connectServer();
      }
      
      public static function getActorRank(param1:uint, param2:Function, param3:int = 0) : void
      {
         _actorCallBack = param2;
         Connection.addCommandListener(CommandSet.GET_ACTOR_RANK_1522,onGetActorRank);
         Connection.addErrorHandler(CommandSet.GET_ACTOR_RANK_1522,onGetActorError);
         if(param3 != 0)
         {
            Connection.send(CommandSet.GET_ACTOR_RANK_1522,param1,uint(param3));
         }
         else
         {
            Connection.send(CommandSet.GET_ACTOR_RANK_1522,param1,uint(ActorManager.actorInfo.id));
         }
      }
      
      private static function onGetActorRank(param1:MessageEvent) : void
      {
         var _loc10_:Function = null;
         Connection.removeCommandListener(CommandSet.GET_ACTOR_RANK_1522,onGetActorRank);
         Connection.removeErrorHandler(CommandSet.GET_ACTOR_RANK_1522,onGetActorError);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:RankServerInfo;
         (_loc6_ = new RankServerInfo()).userId = _loc2_.readUnsignedInt();
         var _loc7_:uint = uint(_loc2_.readUnsignedInt());
         _loc6_.currRank = _loc2_.readUnsignedInt();
         var _loc8_:uint = uint(_loc2_.readUnsignedInt());
         _loc6_.scoreTime = _loc2_.readUnsignedInt();
         _loc6_.score = _loc2_.readUnsignedInt();
         var _loc9_:uint;
         if((_loc9_ = uint(_loc2_.readUnsignedInt())) != 0)
         {
            _loc6_.nick = _loc2_.readUTFBytes(_loc9_);
         }
         if(_actorCallBack != null)
         {
            _loc10_ = _actorCallBack;
            _actorCallBack = null;
            _loc10_(_loc6_);
         }
      }
      
      private static function onGetActorError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_ACTOR_RANK_1522,onGetActorRank);
         Connection.removeErrorHandler(CommandSet.GET_ACTOR_RANK_1522,onGetActorError);
      }
   }
}
