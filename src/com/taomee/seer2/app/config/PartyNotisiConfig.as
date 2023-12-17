package com.taomee.seer2.app.config
{
   import org.taomee.ds.HashMap;
   
   public class PartyNotisiConfig
   {
      
      private static var _xmlClass:Class = PartyNotisiConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _hashMap:HashMap;
      
      {
         initlize();
      }
      
      public function PartyNotisiConfig()
      {
         super();
      }
      
      private static function initlize() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc1_:XML = XML(new _xmlClass());
         var _loc2_:XMLList = _loc1_.descendants("con");
         _hashMap = new HashMap();
         for each(_loc5_ in _loc2_)
         {
            _loc3_ = uint(_loc5_.attribute("id"));
            _loc4_ = String(_loc5_.attribute("content"));
            _hashMap.add(_loc3_,_loc4_);
         }
      }
      
      public static function getStr(param1:uint) : String
      {
         return _hashMap.getValue(param1);
      }
   }
}
