package com.adobe.utils
{
   public class NumberFormatter
   {
       
      
      public function NumberFormatter()
      {
         super();
      }
      
      public static function addLeadingZero(param1:Number) : String
      {
         var _loc2_:String = String(param1);
         if(param1 < 10 && param1 > -1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
   }
}
