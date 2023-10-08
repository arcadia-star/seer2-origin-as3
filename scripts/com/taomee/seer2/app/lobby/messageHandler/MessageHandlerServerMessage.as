package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import flash.utils.ByteArray;
   
   public class MessageHandlerServerMessage implements IMessageHandler
   {
       
      
      public function MessageHandlerServerMessage()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.SERVER_MESSAGE_8000,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         var _loc2_:ByteArray = param1.message.getRawData();
         var _loc3_:String = _loc2_.readUTFBytes(_loc2_.length);
         ServerMessager.addMessage(_loc3_);
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.SERVER_MESSAGE_8000,this.onMessage);
      }
   }
}
