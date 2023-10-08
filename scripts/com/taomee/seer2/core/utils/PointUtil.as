package com.taomee.seer2.core.utils
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class PointUtil
   {
       
      
      public function PointUtil()
      {
         super();
      }
      
      public static function switchPointToParent(param1:MovieClip) : void
      {
         var _loc2_:Point = new Point(param1.x,param1.y);
         var _loc3_:Point = param1.parent.localToGlobal(_loc2_);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
      }
   }
}
