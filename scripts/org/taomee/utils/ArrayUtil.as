package org.taomee.utils
{
   public class ArrayUtil
   {
       
      
      public function ArrayUtil()
      {
         super();
      }
      
      public static function removeValueFromArray(param1:Array, param2:Object) : void
      {
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ != -1)
         {
            param1.splice(_loc3_,1);
         }
      }
      
      public static function copyArray(param1:Array) : Array
      {
         return param1.slice();
      }
      
      public static function arrayContainsValue(param1:Array, param2:Object) : Boolean
      {
         return param1.indexOf(param2) != -1;
      }
      
      public static function arraysAreEqual(param1:Array, param2:Array) : Boolean
      {
         var isd:Boolean = false;
         var arr1:Array = param1;
         var arr2:Array = param2;
         if(arr1.length != arr2.length)
         {
            return false;
         }
         isd = arr1.every(function(param1:Object, param2:int, param3:Array):Boolean
         {
            if(arr2.indexOf(param1) == -1)
            {
               return false;
            }
            return true;
         });
         if(!isd)
         {
            return false;
         }
         isd = arr2.every(function(param1:Object, param2:int, param3:Array):Boolean
         {
            if(arr1.indexOf(param1) == -1)
            {
               return false;
            }
            return true;
         });
         return isd;
      }
      
      public static function embody(param1:Array, param2:Array) : Boolean
      {
         var arr1:Array = param1;
         var arr2:Array = param2;
         var isd:Boolean = arr2.every(function(param1:Object, param2:int, param3:Array):Boolean
         {
            if(arr1.indexOf(param1) == -1)
            {
               return false;
            }
            return true;
         });
         return isd;
      }
      
      public static function createUniqueCopy(param1:Array) : Array
      {
         var uniqueArr:Array = null;
         var a:Array = param1;
         uniqueArr = [];
         a.forEach(function(param1:Object, param2:int, param3:Array):void
         {
            if(uniqueArr.indexOf(param1) == -1)
            {
               uniqueArr.push(param1);
            }
         });
         return uniqueArr;
      }
   }
}
