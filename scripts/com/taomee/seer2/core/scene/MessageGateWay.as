package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class MessageGateWay
   {
       
      
      protected var _scene:com.taomee.seer2.core.scene.BaseScene;
      
      protected var _msgHandlerVec:Vector.<IMessageHandler>;
      
      public function MessageGateWay(param1:com.taomee.seer2.core.scene.BaseScene)
      {
         super();
         this._scene = param1;
         this._msgHandlerVec = new Vector.<IMessageHandler>();
         this.initMessageHandler();
         this.blockCommands();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         this.realseCommands();
      }
      
      protected function initMessageHandler() : void
      {
      }
      
      protected function blockCommands() : void
      {
      }
      
      protected function realseCommands() : void
      {
      }
      
      public function addMessageHandler(param1:IMessageHandler) : void
      {
         param1.setup();
         this._msgHandlerVec.push(param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:IMessageHandler = null;
         for each(_loc1_ in this._msgHandlerVec)
         {
            _loc1_.dispose();
         }
         this._msgHandlerVec = null;
      }
   }
}
