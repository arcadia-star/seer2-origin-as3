package com.taomee.seer2.app.component
{
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class MouseClickHintSprite extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      public function MouseClickHintSprite()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         DisplayObjectUtil.disableSprite(this);
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this._mc = UIManager.getMovieClip("UI_MouseHint");
         addChild(this._mc);
      }
   }
}
