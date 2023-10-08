package com.taomee.seer2.app.lobby
{
   import com.taomee.seer2.app.lobby.shootReward.LobbyShootRewardSceneHandler;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.SceneHandlerGateWay;
   
   public class LobbySceneHandlerGateWay extends SceneHandlerGateWay
   {
       
      
      public function LobbySceneHandlerGateWay(param1:BaseScene)
      {
         super(param1);
      }
      
      override protected function initSceneHandler() : void
      {
         super.initSceneHandler();
         addSceneHandler(new LobbyShootRewardSceneHandler());
      }
   }
}
