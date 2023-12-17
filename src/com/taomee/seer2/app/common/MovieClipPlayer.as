package com.taomee.seer2.app.common
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MovieClipPlayer
   {
       
      
      private var _mc:MovieClip;
      
      private var _startFrame:*;
      
      private var _endFrame:*;
      
      private var _isFocus:Boolean;
      
      private var _callBack:Function;
      
      public function MovieClipPlayer()
      {
         super();
      }
      
      public function playMc(param1:MovieClip, param2:*, param3:* = null, param4:Boolean = false, param5:Function = null) : void
      {
         this._mc = param1;
         this._startFrame = param2;
         this._endFrame = param3 == null ? param1.totalFrames : param3;
         this._isFocus = param4;
         this._callBack = param5;
         if(this._isFocus)
         {
            LayerManager.focusOnTopLayer();
         }
         this._mc.gotoAndPlay(param2);
         this._mc.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:* = false;
         if(this._endFrame is int)
         {
            _loc2_ = int(this._endFrame) == this._mc.currentFrame;
         }
         else if(this._endFrame is String)
         {
            _loc2_ = String(this._endFrame) == this._mc.currentLabel;
         }
         if(_loc2_)
         {
            this._mc.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._mc.gotoAndStop(this._endFrame);
            if(this._isFocus)
            {
               LayerManager.resetOperation();
            }
            if(this._callBack != null)
            {
               this._callBack();
            }
         }
      }
      
      public function cancel() : void
      {
         if(this._mc)
         {
            this._mc.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._mc = null;
         }
         this._callBack = null;
      }
   }
}
