package com.taomee.seer2.app.team
{
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.scene.LobbyPanel;
   
   public class TeamScene extends LobbyScene
   {
       
      
      public function TeamScene(param1:int)
      {
         super(param1);
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
         mapModel.name = TeamManager.teamInfo.name;
         LobbyPanel.instance.update(mapModel);
      }
   }
}
