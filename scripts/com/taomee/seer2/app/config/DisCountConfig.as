package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.inventory.ItemManager;
   
   public class DisCountConfig
   {
      
      private static var _xmlClass:Class = DisCountConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _list:Array;
      
      {
         initlize();
      }
      
      public function DisCountConfig()
      {
         super();
      }
      
      private static function initlize() : void
      {
         var _loc3_:Array = null;
         var _loc4_:XML = null;
         _list = [];
         var _loc1_:XML = XML(new _xmlClass());
         var _loc2_:XMLList = _loc1_.child("item");
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = String(_loc4_.@list).split("|");
            _list.push(_loc3_);
         }
      }
      
      public static function getList() : Array
      {
         return _list;
      }
      
      public static function getArr(param1:uint) : Array
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _list.length)
         {
            _loc2_ = _list[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(param1 == uint(_loc2_[_loc4_]))
               {
                  return _loc2_;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return new Array();
      }
      
      public static function isContent(param1:uint) : Boolean
      {
         var _loc2_:Array = getArr(param1);
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(ItemManager.getItemByReferenceId(_loc2_[_loc4_]) != null)
            {
               _loc3_ = true;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
