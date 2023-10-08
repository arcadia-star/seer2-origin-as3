package com.taomee.seer2.core.utils
{
   import flash.utils.getQualifiedClassName;
   
   public class ObjectUtil
   {
       
      
      public function ObjectUtil()
      {
         super();
      }
      
      public static function getClassName(param1:Object) : String
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:int = _loc2_.indexOf("::");
         if(_loc3_ != -1)
         {
            _loc2_ = _loc2_.substr(_loc3_ + 2);
         }
         return _loc2_;
      }
      
      public static function isSimple(param1:Object) : Boolean
      {
         var _loc2_:* = typeof param1;
         switch(_loc2_)
         {
            case "number":
            case "string":
            case "boolean":
               return true;
            case "object":
               return param1 is Date || param1 is Array;
            default:
               return false;
         }
      }
   }
}
