package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.net.message.Message;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MessageHandlerUserBroadcast implements IMessageHandler
   {
      
      public static const GO_TO_ARENA:uint = 1;
      
      public static const LEAVE:uint = 0;
       
      
      public function MessageHandlerUserBroadcast()
      {
         super();
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.SYNC_POSITION_1101,this.onMessage);
         Connection.addCommandListener(CommandSet.USER_CHANGE_NICK_1099,this.onMessage);
         Connection.addCommandListener(CommandSet.USER_CHANGE_MEDAL_1008,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         switch(param1.message.commandId)
         {
            case CommandSet.SYNC_POSITION_1101.id:
               this.parseSyncPosition(param1.message);
               break;
            case CommandSet.USER_CHANGE_NICK_1099.id:
               this.parseUserChangeNick(param1.message);
               break;
            case CommandSet.USER_CHANGE_MEDAL_1008.id:
               this.parseUserChangeMedal(param1.message);
         }
      }
      
      private function parseSyncPosition(param1:Message) : void
      {
         var _loc7_:Actor = null;
         var _loc2_:IDataInput = param1.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = int(_loc2_.readUnsignedInt());
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         var _loc6_:int = int(ActorManager.actorInfo.id);
         if(_loc3_ != ActorManager.actorInfo.id)
         {
            if(_loc7_ = ActorManager.getActorById(_loc3_))
            {
               _loc7_.walk(_loc4_,_loc5_);
            }
         }
      }
      
      private function parseUserChangeNick(param1:Message) : void
      {
         var _loc2_:ByteArray = param1.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:String = _loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN);
         var _loc5_:Actor;
         if(_loc5_ = ActorManager.getActorById(_loc3_))
         {
            _loc5_.updateNick(_loc4_);
         }
      }
      
      private function parseUserChangeMedal(param1:Message) : void
      {
         var _loc2_:LittleEndianByteArray = param1.getRawData();
         _loc2_.position = 0;
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:Actor;
         if(_loc5_ = ActorManager.getActorById(_loc3_))
         {
            _loc5_.updateMedal(_loc4_);
         }
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.SYNC_POSITION_1101,this.onMessage);
         Connection.removeCommandListener(CommandSet.USER_CHANGE_NICK_1099,this.onMessage);
         Connection.removeCommandListener(CommandSet.USER_CHANGE_MEDAL_1008,this.onMessage);
      }
   }
}
