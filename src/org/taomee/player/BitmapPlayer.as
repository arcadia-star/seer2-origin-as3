package org.taomee.player
{
   import flash.display.Bitmap;
   
   public class BitmapPlayer extends TimePlayer
   {
       
      
      private var _frameList:Vector.<FrameInfo>;
      
      private var _bitmap:Bitmap;
      
      private var _frameInfo:FrameInfo;
      
      public function BitmapPlayer(param1:Bitmap = null, param2:uint = 40)
      {
         super(param2);
         this._bitmap = param1;
      }
      
      public function get bitmap() : Bitmap
      {
         if(this._bitmap == null)
         {
            this._bitmap = new Bitmap();
         }
         return this._bitmap;
      }
      
      public function set bitmap(param1:Bitmap) : void
      {
         this._bitmap = param1;
      }
      
      public function set frameList(param1:Vector.<FrameInfo>) : void
      {
         reset();
         if(param1 == null)
         {
            if(this._bitmap)
            {
               this._bitmap.bitmapData = null;
            }
            this._frameList = null;
            return;
         }
         this._frameList = param1;
         _totalFrames = this._frameList.length;
         setTotalTime();
         this.update();
      }
      
      public function destroy() : void
      {
         this._bitmap = null;
         this._frameList = null;
      }
      
      override protected function update() : void
      {
         if(this._bitmap)
         {
            if(this._frameList)
            {
               this._frameInfo = this._frameList[_currentFrame];
               if(this._frameInfo)
               {
                  if(this._bitmap.bitmapData != this._frameInfo.data)
                  {
                     this._bitmap.bitmapData = this._frameInfo.data;
                  }
                  this._bitmap.x = this._frameInfo.offsetX;
                  this._bitmap.y = this._frameInfo.offsetY;
               }
            }
         }
      }
   }
}
