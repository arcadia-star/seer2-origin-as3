package com.taomee.seer2.core.cache.sheet
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SheetImageData
   {
       
      
      public var count:int;
      
      public var anchorPoint:Point;
      
      public var offsetPoint:Point;
      
      public var width:int;
      
      public var height:int;
      
      public var bitmapData:BitmapData;
      
      public function SheetImageData()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.anchorPoint = null;
         this.offsetPoint = null;
         this.bitmapData.dispose();
         this.bitmapData = null;
      }
   }
}
