package com.greensock.easing
{
   public class SteppedEase
   {
       
      
      private var _steps:int;
      
      private var _stepAmount:Number;
      
      public function SteppedEase(param1:int)
      {
         super();
         _stepAmount = 1 / param1;
         _steps = param1 + 1;
      }
      
      public static function create(param1:int) : Function
      {
         var _loc2_:SteppedEase = new SteppedEase(param1);
         return _loc2_.ease;
      }
      
      public function get steps() : int
      {
         return _steps - 1;
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number;
         if((_loc5_ = param1 / param4) < 0)
         {
            _loc5_ = 0;
         }
         else if(_loc5_ >= 1)
         {
            _loc5_ = 0.999999999;
         }
         return (_steps * _loc5_ >> 0) * _stepAmount;
      }
   }
}
