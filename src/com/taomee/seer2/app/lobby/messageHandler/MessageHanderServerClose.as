package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   
   public class MessageHanderServerClose implements IMessageHandler
   {
       
      
      public function MessageHanderServerClose()
      {
         super();
      }
      
      public function setup() : void
      {
         Connection.addErrorHandler(CommandSet.SERVER_CLOSE_NOTIFY_1012,this.onServerCloseNotify);
         Connection.addCommandListener(CommandSet.SERVER_CLOSE_NOTIFY_1012,this.onMessage);
      }
      
      private function onServerCloseNotify(param1:MessageEvent) : void
      {
         var _loc2_:uint = uint(param1.message.statusCode);
         if(_loc2_ == 91)
         {
            AlertManager.showAlert("服务器将在60秒后关闭");
         }
         if(_loc2_ == 1)
         {
            AlertManager.showAlert("用户重复登录");
         }
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
      }
      
      public function dispose() : void
      {
         Connection.removeErrorHandler(CommandSet.SERVER_CLOSE_NOTIFY_1012,this.onServerCloseNotify);
         Connection.removeCommandListener(CommandSet.SERVER_CLOSE_NOTIFY_1012,this.onMessage);
      }
   }
}
