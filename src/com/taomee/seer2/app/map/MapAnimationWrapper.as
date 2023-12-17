package com.taomee.seer2.app.map
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapAnimationWrapper
   {
      
      private static const START_SUFFIX:String = "_start";
      
      private static const END_SUFFIX:String = "_end";
       
      
      private var _source:MovieClip;
      
      private var _startLabel:String;
      
      private var _endLabel:String;
      
      private var _loopTotal:int;
      
      private var _loopedCount:int;
      
      private var _callBack:Function;
      
      public function MapAnimationWrapper(param1:MovieClip)
      {
         super();
         this._source = param1;
         this._source.mouseEnabled = false;
         this._source.mouseChildren = false;
         this._source.gotoAndStop(1);
      }
      
      public function stopAtLabel(param1:String) : void
      {
         this._source.gotoAndStop(param1);
      }
      
      public function playLabel(param1:String, param2:Function = null) : void
      {
         this._startLabel = param1 + START_SUFFIX;
         this._endLabel = param1 + END_SUFFIX;
         this._loopTotal = 1;
         this._loopedCount = 0;
         this._callBack = param2;
         this.playAnnimation();
      }
      
      public function loopLabel(param1:String, param2:int = 0, param3:Function = null) : void
      {
         this._startLabel = param1 + START_SUFFIX;
         this._endLabel = param1 + END_SUFFIX;
         this._loopTotal = param2 > 0 ? param2 : int.MAX_VALUE;
         this._loopedCount = 0;
         this._callBack = param3;
         this.playAnnimation();
      }
      
      private function playAnnimation() : void
      {
         if(!this._source.hasEventListener(Event.ENTER_FRAME))
         {
            this._source.addEventListener(Event.ENTER_FRAME,this.onSourceUpdate);
         }
         this._source.gotoAndPlay(this._startLabel);
      }
      
      private function onSourceUpdate(param1:Event) : void
      {
         if(this._source.currentFrameLabel == this._endLabel)
         {
            ++this._loopedCount;
            if(this._loopedCount >= this._loopTotal)
            {
               this._source.removeEventListener(Event.ENTER_FRAME,this.onSourceUpdate);
               this._source.stop();
               if(this._callBack != null)
               {
                  this._callBack();
               }
            }
            else
            {
               this.playAnnimation();
            }
         }
      }
      
      public function dispose() : void
      {
         this._source.removeEventListener(Event.ENTER_FRAME,this.onSourceUpdate);
         this._source.stop();
         this._source = null;
         this._callBack = null;
      }
   }
}
