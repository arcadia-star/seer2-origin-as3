package com.taomee.seer2.app.plantSystem.bubble
{
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class PlantBubble extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _txt:TextField;
      
      private var _setTimeout:uint;
      
      public function PlantBubble()
      {
         super();
         this._mc = UIManager.getMovieClip("PlantBubble");
         this._txt = this._mc["txt"];
      }
      
      public function set content(param1:String) : void
      {
         this.remove();
         this._txt.text = param1;
         addChild(this._mc);
         this.start();
      }
      
      private function remove() : void
      {
         DisplayUtil.removeForParent(this._mc);
         if(this._setTimeout != 0)
         {
            clearTimeout(this._setTimeout);
            this._setTimeout = 0;
         }
      }
      
      private function start() : void
      {
         this._setTimeout = setTimeout(function():void
         {
            remove();
         },2000);
      }
      
      public function dispose() : void
      {
         this.remove();
         this._mc = null;
         this._txt = null;
      }
   }
}
