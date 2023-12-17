package com.taomee.seer2.app.lobby
{
   import com.taomee.seer2.app.controls.GiftRemind;
   import com.taomee.seer2.app.controls.LeftMinorToolBar;
   import com.taomee.seer2.app.controls.LeftTopToolBar;
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.UpContentToolbar;
   import com.taomee.seer2.app.questTiny.QuestTinyPanel;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.scene.LobbyPanel;
   import com.taomee.seer2.app.scene.PathScene;
   
   public class LobbyScene extends PathScene
   {
       
      
      private var _mainSceneIdVec:Vector.<int>;
      
      public function LobbyScene(param1:int)
      {
         this._mainSceneIdVec = new <int>[10,20,30,40,50,60,70,80];
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         LobbyPanel.instance.isShow = true;
      }
      
      override protected function onTick(param1:int) : void
      {
         super.onTick(param1);
         LobbyPanel.instance.onUpdate();
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
         LobbyPanel.instance.update(mapModel);
      }
      
      override public function dispose() : void
      {
         LobbyPanel.instance.isShow = false;
         super.dispose();
      }
      
      public function showToolbar() : void
      {
         ToolBar.show();
         PetAvatarPanel.show();
         MinorToolBar.show();
         RightToolbarConter.instance.show();
         LeftTopToolBar.show();
         LeftMinorToolBar.show();
         UpContentToolbar.show();
         GiftRemind.instance.setVisible(true);
         GiftRemind.instance.showRecharge();
         QuestTinyPanel.instance.show();
      }
      
      public function hideToolbar() : void
      {
         ToolBar.hide();
         PetAvatarPanel.hide();
         MinorToolBar.hide();
         RightToolbarConter.instance.hide();
         LeftTopToolBar.hide();
         LeftMinorToolBar.hide();
         UpContentToolbar.hide();
         GiftRemind.instance.setVisible(false);
         GiftRemind.instance.hideRecharge();
         QuestTinyPanel.instance.hide();
      }
      
      public function hideTrailsToolBar() : void
      {
         ToolBar.hide();
         MinorToolBar.hide();
         LeftTopToolBar.hide();
         RightToolbarConter.instance.hide();
         QuestTinyPanel.instance.hide();
      }
   }
}
