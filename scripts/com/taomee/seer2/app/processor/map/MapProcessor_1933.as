package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_1933 extends QinBeastChapter1Map
   {
       
      
      private var _passCartoon:MovieClip;
      
      public function MapProcessor_1933(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.initPassCartoon();
      }
      
      private function initPassCartoon() : void
      {
         this._passCartoon = _map.content["cartoons"] as MovieClip;
         this._passCartoon.addEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
      }
      
      private function onPassEnterFrame(param1:Event) : void
      {
         if(this._passCartoon.currentFrame == this._passCartoon.totalFrames)
         {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
            DisplayObjectUtil.removeFromParent(_map.path["pathMask"]);
            _map.recalculatePathData();
         }
      }
      
      override public function dispose() : void
      {
         if(this._passCartoon.hasEventListener(Event.ENTER_FRAME))
         {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
         }
         this._passCartoon = null;
         super.dispose();
      }
   }
}
