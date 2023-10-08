package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class HomeBuddyPanel extends Sprite
   {
       
      
      private var _info:HomeInfo;
      
      private var _container:MovieClip;
      
      private var _buddyList:com.taomee.seer2.app.home.panel.buddy.HomeBuddyList;
      
      public function HomeBuddyPanel()
      {
         super();
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.adjustPosition();
         this.createContainer();
         this.createBuddyList();
      }
      
      public function adjustPosition() : void
      {
         this.x = 23;
         this.y = LayerManager.stage.stageHeight - 147;
      }
      
      private function createContainer() : void
      {
         this._container = UIManager.getMovieClip("UI_HomeBuddyBar");
         addChild(this._container);
      }
      
      private function createBuddyList() : void
      {
         this._buddyList = new com.taomee.seer2.app.home.panel.buddy.HomeBuddyList();
         addChild(this._buddyList);
      }
      
      public function setData(param1:HomeInfo) : void
      {
         this._info = param1;
         this.updateDisplay();
      }
      
      private function updateDisplay() : void
      {
         this._buddyList.setData();
      }
      
      public function dispose() : void
      {
         this._buddyList.dispose();
      }
   }
}
