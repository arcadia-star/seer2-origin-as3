package com.taomee.seer2.app.arena
{
   import com.taomee.seer2.app.lobby.messageHandler.MessageHanderServerClose;
   import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSyncServerTime;
   import com.taomee.seer2.app.manager.PetExperenceHelper;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.MessageGateWay;
   
   public class ArenaMessageGateWay extends MessageGateWay
   {
       
      
      public function ArenaMessageGateWay(param1:BaseScene)
      {
         super(param1);
      }
      
      override protected function initMessageHandler() : void
      {
         addMessageHandler(new MessageHandlerSyncServerTime());
         addMessageHandler(new MessageHanderServerClose());
         PetExperenceHelper.stopListen();
      }
      
      override protected function blockCommands() : void
      {
         NoticeManager.block();
         Connection.blockCommand(CommandSet.ITEM_SERVER_GIVE_1051);
         Connection.blockCommand(CommandSet.GET_CONIS_1547);
         Connection.blockCommand(CommandSet.RANDOM_EVENT_1140);
      }
   }
}
