package org.taomee.utils
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataUtil
   {
       
      
      public function BitmapDataUtil()
      {
         super();
      }
      
      public static function makeList(param1:BitmapData, param2:int, param3:int, param4:uint, param5:Array = null) : Array
      {
         var _loc14_:int = 0;
         var _loc6_:int = int(Math.min(param1.width,2880) / param2);
         var _loc7_:int = int(Math.min(param1.height,2880) / param3);
         var _loc8_:int = 0;
         var _loc9_:BitmapData = null;
         var _loc10_:Array = new Array(param4);
         var _loc11_:Rectangle = new Rectangle(0,0,param2,param3);
         var _loc12_:Point = new Point();
         var _loc13_:int = 0;
         while(_loc13_ < _loc7_)
         {
            _loc14_ = 0;
            while(_loc14_ < _loc6_)
            {
               if(_loc8_ >= param4)
               {
                  return _loc10_;
               }
               _loc11_.x = _loc14_ * param2;
               _loc11_.y = _loc13_ * param3;
               if(param5)
               {
                  if(param5.indexOf(_loc8_) != -1)
                  {
                     (_loc9_ = new BitmapData(param2,param3)).copyPixels(param1,_loc11_,_loc12_);
                     _loc10_[_loc8_] = _loc9_;
                  }
                  else
                  {
                     _loc10_[_loc8_] = null;
                  }
               }
               else
               {
                  (_loc9_ = new BitmapData(param2,param3)).copyPixels(param1,_loc11_,_loc12_);
                  _loc10_[_loc8_] = _loc9_;
               }
               _loc8_++;
               _loc14_++;
            }
            _loc13_++;
         }
         return _loc10_;
      }
   }
}
