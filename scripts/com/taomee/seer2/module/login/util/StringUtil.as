package com.taomee.seer2.module.login.util
{
   public class StringUtil
   {
      
      private static const HEX_Head:String = "0x";
      
      private static const DOT:String = ".";
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return rightTrim(leftTrim(param1));
      }
      
      public static function leftTrim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:RegExp = /^\s*/;
         return param1.replace(_loc2_,"");
      }
      
      public static function rightTrim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:RegExp = /\s*$/;
         return param1.replace(_loc2_,"");
      }
      
      public static function beginsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(0,param2.length);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(param1.length - param2.length);
      }
      
      public static function uintToIp(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         var _loc3_:String = uint(HEX_Head + _loc2_.slice(0,2)).toString();
         var _loc4_:String = uint(HEX_Head + _loc2_.slice(2,4)).toString();
         var _loc5_:String = uint(HEX_Head + _loc2_.slice(4,6)).toString();
         var _loc6_:String = uint(HEX_Head + _loc2_.slice(6)).toString();
         return _loc3_ + DOT + _loc4_ + DOT + _loc5_ + DOT + _loc6_;
      }
   }
}
