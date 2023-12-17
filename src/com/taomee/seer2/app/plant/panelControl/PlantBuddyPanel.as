package com.taomee.seer2.app.plant.panelControl
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
   import com.taomee.seer2.app.plant.buddy.PlantBuddyIntroItem;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.filter.ColorFilter;
   
   public class PlantBuddyPanel extends Sprite
   {
       
      
      private var _info:HomeInfo;
      
      private var _container:MovieClip;
      
      private var _selfItem:PlantBuddyIntroItem;
      
      private var _buddyList:PlantBuddyList;
      
      private var _btnRetract:MovieClip;
      
      private var _isRetract:Boolean = true;
      
      private var _showXPos:Number;
      
      private var _hideXPos:Number;
      
      public function PlantBuddyPanel()
      {
         super();
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.adjustPosition();
         this.createContainer();
         this.createBuddyList();
         this.createItemSelf();
      }
      
      private function createItemSelf() : void
      {
         this._selfItem = new PlantBuddyIntroItem();
         addChild(this._selfItem);
      }
      
      public function setUnitData(param1:HomeBuddyDataUnit) : void
      {
         this._selfItem.setData(param1);
      }
      
      public function adjustPosition() : void
      {
         var _loc1_:Number = LayerManager.stage.stageWidth / 1200;
         this._showXPos = 230 * _loc1_;
         this._hideXPos = LayerManager.stage.stageWidth - 15;
         if(this._isRetract)
         {
            this.x = this._showXPos;
         }
         else
         {
            this.x = this._hideXPos;
         }
         this.y = LayerManager.stage.stageHeight - 149;
      }
      
      private function createContainer() : void
      {
         this._container = UIManager.getMovieClip("UI_PlantBuddyBar");
         this._btnRetract = this._container["btnRetract"];
         this._btnRetract.gotoAndStop(2);
         this._btnRetract.addEventListener(MouseEvent.CLICK,this.onRetract);
         ColorFilter.setGrayscale(this._btnRetract);
         addChild(this._container);
      }
      
      private function onRetract(param1:MouseEvent) : void
      {
         if(this._isRetract)
         {
            this._btnRetract.gotoAndStop(1);
            this._isRetract = false;
            TweenLite.to(this,0.6,{
               "x":this._hideXPos,
               "ease":Expo.easeOut
            });
         }
         else
         {
            this._btnRetract.gotoAndStop(2);
            this._isRetract = true;
            TweenLite.to(this,0.6,{
               "x":this._showXPos,
               "ease":Expo.easeOut
            });
         }
      }
      
      private function createBuddyList() : void
      {
         this._buddyList = new PlantBuddyList();
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
         this._selfItem.setLevel(this._info);
      }
      
      public function buddySetData() : void
      {
         this._buddyList.setData();
      }
      
      public function dispose() : void
      {
         this._selfItem.dispose();
         this._buddyList.dispose();
      }
   }
}
