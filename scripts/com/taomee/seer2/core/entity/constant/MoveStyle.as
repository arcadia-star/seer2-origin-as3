package com.taomee.seer2.core.entity.constant
{
   public class MoveStyle
   {
      
      public static const WALK:String = "walk";
      
      public static const RUN:String = "run";
      
      public static const STAND:String = "stand";
      
      private static const DIR_UP:String = "Up";
      
      private static const DIR_DOWN:String = "Down";
       
      
      public function MoveStyle(param1:Blocker)
      {
         super();
      }
      
      public static function getStyleByDirection(param1:String, param2:uint) : String
      {
         var _loc3_:String = null;
         if(param2 & MobileDirectionMask.DIR_VERTICAL_MASK)
         {
            _loc3_ = DIR_UP;
         }
         else
         {
            _loc3_ = DIR_DOWN;
         }
         return param1 + _loc3_;
      }
   }
}

class Blocker
{
    
   
   public function Blocker()
   {
      super();
   }
}
