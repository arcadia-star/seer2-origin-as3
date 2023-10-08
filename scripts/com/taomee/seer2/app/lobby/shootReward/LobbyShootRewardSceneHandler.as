package com.taomee.seer2.app.lobby.shootReward
{
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.ISceneHandler;
   
   public class LobbyShootRewardSceneHandler implements ISceneHandler
   {
       
      
      private var _scene:LobbyScene;
      
      private var _shootSwapProcessor:com.taomee.seer2.app.lobby.shootReward.MapShootSwapProcessor;
      
      public function LobbyShootRewardSceneHandler()
      {
         super();
      }
      
      public function init(param1:BaseScene) : void
      {
         this._scene = param1 as LobbyScene;
      }
      
      public function onMapStart() : void
      {
         if(MapShootSwapConfig.hasShootReward(this._scene.mapID))
         {
            this.initShootSwap();
         }
      }
      
      private function initShootSwap() : void
      {
         this._shootSwapProcessor = new com.taomee.seer2.app.lobby.shootReward.MapShootSwapProcessor(this._scene.mapModel);
      }
      
      private function clearShootSwap() : void
      {
         if(this._shootSwapProcessor)
         {
            this._shootSwapProcessor.dispose();
            this._shootSwapProcessor = null;
         }
      }
      
      public function onTick(param1:int) : void
      {
      }
      
      public function onMapEnd() : void
      {
         this.clearShootSwap();
      }
      
      public function disopse() : void
      {
         this.clearShootSwap();
      }
   }
}
