package com.taomee.seer2.app.home
{
   import com.taomee.seer2.app.home.messageHandler.MessageHandlerPetTraining;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHanderServerClose;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerBuddy;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerServerMessage;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSetPetFollow;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerStartLoadArenaMap;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSyncServerTime;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   
   public class HomeMessageHandleDelegate
   {
       
      
      private var _scene:HomeScene;
      
      public function HomeMessageHandleDelegate(param1:HomeScene)
      {
         super();
         this._scene = param1;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.blockCommand();
         this.addMessageHandler();
         this.releaseCommand();
      }
      
      private function blockCommand() : void
      {
      }
      
      private function releaseCommand() : void
      {
         Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
         Connection.releaseCommand(CommandSet.GET_CONIS_1547);
      }
      
      private function addMessageHandler() : void
      {
         this._scene.addMessageHandler(new MessageHandlerSyncServerTime());
         this._scene.addMessageHandler(new MessageHandlerSetPetFollow());
         this._scene.addMessageHandler(new MessageHandlerPetTraining());
         this._scene.addMessageHandler(new MessageHandlerBuddy());
         this._scene.addMessageHandler(new MessageHandlerServerMessage());
         this._scene.addMessageHandler(new MessageHandlerStartLoadArenaMap());
         this._scene.addMessageHandler(new MessageHanderServerClose());
      }
      
      public function dispose() : void
      {
      }
   }
}
