package com.taomee.seer2.module.login.util
{
   public class InputCheckUtil
   {
       
      
      public function InputCheckUtil()
      {
         super();
      }
      
      public static function isDigital(param1:String) : Boolean
      {
         var _loc2_:RegExp = /\D/g;
         if(param1.length > 10)
         {
            return false;
         }
         return !_loc2_.test(param1);
      }
      
      public static function hasNullString(... rest) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in rest)
         {
            if(StringUtil.trim(_loc2_) == "")
            {
               return true;
            }
         }
         return false;
      }
   }
}
