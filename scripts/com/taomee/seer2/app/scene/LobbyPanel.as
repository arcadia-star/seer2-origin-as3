package com.taomee.seer2.app.scene
{
   import com.taomee.seer2.app.component.BlockableView;
   import com.taomee.seer2.app.controls.GiftRemind;
   import com.taomee.seer2.app.controls.LeftMinorToolBar;
   import com.taomee.seer2.app.controls.LeftTopToolBar;
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.controls.RightMinorToolBar;
   import com.taomee.seer2.app.controls.TestAssistPanel;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.UpContentToolbar;
   import com.taomee.seer2.app.questTiny.QuestTinyPanel;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.map.MapModel;
   
   public class LobbyPanel extends BlockableView
   {
      
      private static var _panel:com.taomee.seer2.app.scene.LobbyPanel;
       
      
      public function LobbyPanel()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.scene.LobbyPanel
      {
         if(_panel == null)
         {
            _panel = new com.taomee.seer2.app.scene.LobbyPanel();
         }
         return _panel;
      }
      
      override public function update(param1:*) : void
      {
         var _loc2_:MapModel = param1 as MapModel;
         MapTitlePanel.update(_loc2_);
      }
      
      public function onUpdate() : void
      {
         TestAssistPanel.updateTestAssist();
      }
      
      override public function show() : void
      {
         ToolBar.show();
         PetAvatarPanel.show();
         MinorToolBar.show();
         MapTitlePanel.show();
         TestAssistPanel.show();
         RightMinorToolBar.show();
         LeftMinorToolBar.show();
         LeftTopToolBar.show();
         RightToolbarConter.instance.show();
         UpContentToolbar.show();
         GiftRemind.instance.setVisible(true);
         GiftRemind.instance.showRecharge();
         QuestTinyPanel.instance.show();
      }
      
      override public function hide() : void
      {
         ToolBar.hide();
         PetAvatarPanel.hide();
         MinorToolBar.hide();
         MapTitlePanel.hide();
         TestAssistPanel.hide();
         LeftMinorToolBar.hide();
         RightMinorToolBar.hide();
         LeftTopToolBar.hide();
         RightToolbarConter.instance.hide();
         UpContentToolbar.hide();
         GiftRemind.instance.setVisible(false);
         GiftRemind.instance.hideRecharge();
         QuestTinyPanel.instance.hide();
      }
      
      public function blockMainView() : void
      {
         ToolBar.hide();
         PetAvatarPanel.hide();
         MinorToolBar.hide();
         LeftTopToolBar.hide();
         UpContentToolbar.hide();
         GiftRemind.instance.setVisible(false);
         GiftRemind.instance.hideRecharge();
         QuestTinyPanel.instance.hide();
      }
      
      public function unblockMainView() : void
      {
         ToolBar.show();
         PetAvatarPanel.show();
         UpContentToolbar.show();
         GiftRemind.instance.setVisible(true);
         GiftRemind.instance.showRecharge();
         MinorToolBar.show();
         LeftTopToolBar.show();
         QuestTinyPanel.instance.show();
      }
   }
}
