package com.taomee.seer2.app.common
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MovieClipExtractor
   {
       
      
      private var _mc:MovieClip;
      
      private var _frame;
      
      private var _childrenArr:Array;
      
      private var _callBack:Function;
      
      public function MovieClipExtractor()
      {
         super();
      }
      
      public function extract(param1:MovieClip, param2:*, param3:Array, param4:Function) : void
      {
         this._mc = param1;
         this._frame = param2;
         this._childrenArr = param3;
         this._callBack = param4;
         this._mc.gotoAndStop(param2);
         this._mc.addEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
      }
      
      private function onFrameConstructed(param1:Event) : void
      {
         var _loc3_:Vector.<DisplayObject> = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc2_:* = false;
         if(this._frame is int)
         {
            _loc2_ = int(this._frame) == this._mc.currentFrame;
         }
         else if(this._frame is String)
         {
            _loc2_ = String(this._frame) == this._mc.currentLabel;
         }
         if(_loc2_)
         {
            this._mc.removeEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
            _loc3_ = new Vector.<DisplayObject>();
            _loc4_ = 0;
            while(_loc4_ < this._childrenArr.length)
            {
               if(this._childrenArr[_loc4_] is int)
               {
                  _loc3_.push(this._mc.getChildAt(int(this._childrenArr[_loc4_])));
               }
               else if(this._childrenArr[_loc4_] is String)
               {
                  _loc3_.push(this._mc.getChildByName(String(this._childrenArr[_loc4_])));
               }
               _loc4_++;
            }
            this._callBack(_loc3_);
         }
      }
      
      public function cancel() : void
      {
         if(this._mc)
         {
            this._mc.removeEventListener(Event.FRAME_CONSTRUCTED,this.onFrameConstructed);
            this._mc = null;
         }
         this._callBack = null;
      }
   }
}
