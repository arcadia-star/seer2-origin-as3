package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.app.home.panel.events.HomePanelEvent;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HomeBuddyEmptyItem extends Sprite
   {
       
      
      private var _container:MovieClip;
      
      private var _type:uint;
      
      public function HomeBuddyEmptyItem(param1:uint = 3)
      {
         super();
         buttonMode = true;
         mouseChildren = false;
         if(param1 == SceneType.HOME)
         {
            this._container = UIManager.getMovieClip("UI_HomeBuddyEmptyItem");
         }
         else if(param1 == SceneType.PLANT)
         {
            this._container = UIManager.getMovieClip("UI_PlantBuddyEmptyItem");
         }
         this._container.gotoAndStop(1);
         addChild(this._container);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         this._container.gotoAndStop(2);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this._container.gotoAndStop(1);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         dispatchEvent(new HomePanelEvent(HomePanelEvent.REQUEST_ADD_BUDDY,true));
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
   }
}
