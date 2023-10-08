package com.taomee.seer2.module.login.util
{
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   
   public class ColorFilter
   {
      
      private static const RED:Number = 0.3086;
      
      private static const GREEN:Number = 0.6094;
      
      private static const BLUE:Number = 0.082;
       
      
      public function ColorFilter()
      {
         super();
      }
      
      public static function setBrightness(param1:DisplayObject, param2:Number) : void
      {
         param2 = ColorFilter.cleanValue(param2,100);
         if(param2 == 0 || isNaN(param2))
         {
            return;
         }
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,param2,0,1,0,0,param2,0,0,1,0,param2,0,0,0,1,0,0,0,0,0,1]);
         setDisplayObject(param1,_loc3_);
      }
      
      public static function setGrayscale(param1:DisplayObject) : void
      {
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter([ColorFilter.RED,ColorFilter.GREEN,ColorFilter.BLUE,0,0,ColorFilter.RED,ColorFilter.GREEN,ColorFilter.BLUE,0,0,ColorFilter.RED,ColorFilter.GREEN,ColorFilter.BLUE,0,0,0,0,0,1,0]);
         setDisplayObject(param1,_loc2_);
      }
      
      private static function cleanValue(param1:Number, param2:Number) : Number
      {
         return Math.min(param2,Math.max(-param2,param1));
      }
      
      private static function setDisplayObject(param1:DisplayObject, param2:BitmapFilter) : void
      {
         var _loc3_:Array = param1.filters;
         _loc3_.push(param2);
         param1.filters = _loc3_;
      }
   }
}
