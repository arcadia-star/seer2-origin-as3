package com.taomee.seer2.core.map.grids
{
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class HeptaFishBitMapMC extends BaseDisplayObject
   {
       
      
      protected var _speed:Number;
      
      protected var _bitmapArr:Array;
      
      private var _bitmapIndex:int = 0;
      
      private var _nowIndex:int;
      
      private var _count:Number = 0;
      
      private var _beginIndex:int;
      
      private var _endIndex:int;
      
      protected var _bitMap:Bitmap;
      
      private var _playDirection:int;
      
      public var end:Function;
      
      private var _isPlaying:Boolean;
      
      protected var _isMirror:Boolean;
      
      protected var _cx:Number;
      
      protected var _cy:Number;
      
      public function HeptaFishBitMapMC(param1:Bitmap = null, param2:int = 1, param3:int = 1, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:Number = 0.27777, param10:* = null, param11:Number = -1, param12:Number = -1)
      {
         super();
         if(param1 != null)
         {
            this._bitmapArr = HeptaFishCovert.divide(param1,param2,param3,param10);
            this._speed = param9;
            this._beginIndex = param4;
            this._endIndex = param5;
            this._playDirection = param6;
            this._bitMap = new Bitmap();
            this._bitMap.bitmapData = this._bitmapArr[param8][param7];
            this._cx = param11 < 0 ? this._bitMap.width / 2 : param11;
            this._cy = param12 < 0 ? this._bitMap.height : param12;
            this._bitMap.x = -this._cx;
            this._bitMap.y = -this._cy;
            addChild(this._bitMap);
            this._bitMap.cacheAsBitmap = true;
         }
      }
      
      public function startMove(param1:uint = 0) : void
      {
         this._nowIndex = param1;
         this._bitmapIndex = this._beginIndex;
         this._isPlaying = true;
         if(this._playDirection == HeptaFishConstant.KEY_BITMAPMC_PLAY_DIRECTION_TR)
         {
            this._bitMap.addEventListener(Event.ENTER_FRAME,this.moveFrameTR);
         }
         else
         {
            if(this._playDirection != HeptaFishConstant.KEY_BITMAPMC_PLAY_DIRECTION_LR)
            {
               throw new Error("unknow playDirection!");
            }
            this._bitMap.addEventListener(Event.ENTER_FRAME,this.moveFrameLR);
         }
      }
      
      public function stopMove() : void
      {
         this._isPlaying = false;
         if(this._playDirection == HeptaFishConstant.KEY_BITMAPMC_PLAY_DIRECTION_TR)
         {
            this._bitMap.removeEventListener(Event.ENTER_FRAME,this.moveFrameTR);
            this._bitMap.bitmapData = this._bitmapArr[this._nowIndex][this._endIndex];
         }
         else
         {
            if(this._playDirection != HeptaFishConstant.KEY_BITMAPMC_PLAY_DIRECTION_TR)
            {
               throw new Error("unknow playDirection!");
            }
            this._bitMap.removeEventListener(Event.ENTER_FRAME,this.moveFrameLR);
            this._bitMap.bitmapData = this._bitmapArr[this._endIndex][this._nowIndex];
         }
         HeptaFishGC.gc();
      }
      
      public function restarMove() : void
      {
         this.startMove(this._nowIndex);
      }
      
      protected function moveFrameTR(param1:Event) : void
      {
         if(this._bitmapIndex >= this._bitmapArr[this._nowIndex].length)
         {
            this._count = 0;
            this._bitmapIndex = this._beginIndex;
         }
         this._count += this._speed;
         this._bitmapIndex += int(this._count) + 1;
         this._count %= 1;
         this._bitMap.bitmapData = this._bitmapArr[this._nowIndex][this._bitmapIndex < this._bitmapArr[this._nowIndex].length ? this._bitmapIndex : this._bitmapArr[this._nowIndex].length - 1];
      }
      
      protected function moveFrameLR(param1:Event) : void
      {
         if(this._bitmapIndex >= this._bitmapArr.length)
         {
            this._count = 0;
            this._bitmapIndex = this._beginIndex;
         }
         this._count += this._speed;
         this._bitmapIndex += int(this._count) + 1;
         this._count %= 1;
         this._bitMap.bitmapData = this._bitmapArr[this._bitmapIndex < this._bitmapArr.length ? this._bitmapIndex : this._bitmapArr.length - 1][this._nowIndex];
      }
      
      public function mirror(param1:int) : void
      {
         scaleX = param1;
      }
      
      public function get nowIndex() : int
      {
         return this._nowIndex;
      }
      
      public function set nowIndex(param1:int) : void
      {
         this._nowIndex = param1;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function get bitmap() : Bitmap
      {
         return this._bitMap;
      }
   }
}
