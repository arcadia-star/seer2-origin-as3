package org.taomee.utils
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtil
   {
       
      
      public function DictionaryUtil()
      {
         super();
      }
      
      public static function getValues(param1:Dictionary) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function getKeys(param1:Dictionary) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}
