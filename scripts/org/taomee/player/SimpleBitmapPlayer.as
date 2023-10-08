package org.taomee.player
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class SimpleBitmapPlayer extends Bitmap
   {
       
      
      private var _frameList:Vector.<BitmapData>;
      
      private var _totalFrames:uint;
      
      private var _currentFrame:uint;
      
      private var _currentCount:uint;
      
      private var _repeatCount:uint;
      
      private var _isPlaying:Boolean;
      
      private var _frameData:BitmapData;
      
      public function SimpleBitmapPlayer()
      {
         super();
      }
      
      public function get totalFrames() : uint
      {
         return this._totalFrames;
      }
      
      public function get currentFrame() : uint
      {
         return this._currentFrame;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function set frameList(param1:Vector.<BitmapData>) : void
      {
         if(param1 == null)
         {
            this.clear();
            return;
         }
         this.stop();
         this._frameList = param1;
         this._totalFrames = this._frameList.length;
         this._currentFrame = 0;
         this._currentCount = 0;
         this.update();
      }
      
      public function get repeatCount() : uint
      {
         return this._repeatCount;
      }
      
      public function set repeatCount(param1:uint) : void
      {
         this._repeatCount = param1;
      }
      
      public function play() : void
      {
         this._isPlaying = true;
         if(this._totalFrames > 1)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         else
         {
            this.onEnterFrame(null);
         }
      }
      
      public function stop() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._isPlaying = false;
      }
      
      public function gotoAndPlay(param1:uint) : void
      {
         if(param1 > this._totalFrames - 1)
         {
            param1 = this._totalFrames - 1;
         }
         if(param1 < 0)
         {
            return;
         }
         if(this._currentFrame == param1)
         {
            return;
         }
         this._currentFrame = param1;
         if(!this._isPlaying)
         {
            this.play();
         }
      }
      
      public function gotoAndStop(param1:uint) : void
      {
         if(param1 > this._totalFrames - 1)
         {
            param1 = this._totalFrames - 1;
         }
         if(param1 < 0)
         {
            return;
         }
         this.stop();
         this._currentFrame = param1;
         this.update();
      }
      
      public function clear() : void
      {
         this.stop();
         bitmapData = null;
         this._totalFrames = 0;
         this._currentFrame = 0;
         this._frameList = null;
         this._currentCount = 0;
      }
      
      public function destroy() : void
      {
         this.stop();
         this._totalFrames = 0;
         this._currentFrame = 0;
         this._currentCount = 0;
         bitmapData = null;
         this._frameList = null;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         ++this._currentFrame;
         if(this._currentFrame == this._totalFrames)
         {
            this._currentFrame = 0;
            if(this._repeatCount != 0)
            {
               ++this._currentCount;
               if(this._currentCount >= this._repeatCount)
               {
                  this.stop();
                  return;
               }
            }
         }
         this.update();
      }
      
      protected function update() : void
      {
         if(this._frameList)
         {
            this._frameData = this._frameList[this._currentFrame];
            if(this._frameData)
            {
               bitmapData = this._frameData;
            }
         }
      }
   }
}
