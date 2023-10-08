package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.MatchingInfo;
   import org.taomee.ds.HashMap;
   
   public class MatchingConfig
   {
      
      private static var _xmlClass:Class = MatchingConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _matchingInfoList:HashMap;
      
      private static var _newMap:HashMap;
      
      private static var _entry:HashMap;
      
      {
         initlize();
      }
      
      public function MatchingConfig()
      {
         super();
      }
      
      private static function initlize() : void
      {
         var _loc3_:MatchingInfo = null;
         var _loc4_:XML = null;
         var _loc1_:XML = XML(new _xmlClass());
         var _loc2_:XMLList = _loc1_.child("matching");
         _matchingInfoList = new HashMap();
         _newMap = new HashMap();
         _entry = new HashMap();
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = new MatchingInfo();
            _loc3_.newId = uint(_loc4_.@oldId);
            _loc3_.oldId = uint(_loc4_.@newId);
            _loc3_.entry = String(_loc4_.@entry);
            _newMap.add(_loc3_.newId,_loc3_.oldId);
            _matchingInfoList.add(_loc3_.oldId,_loc3_.newId);
            _entry.add(_loc3_.newId,_loc3_.entry);
         }
      }
      
      public static function getNewId(param1:uint) : uint
      {
         return uint(_matchingInfoList.getValue(param1));
      }
      
      public static function getOldId(param1:uint) : uint
      {
         return uint(_newMap.getValue(param1));
      }
      
      public static function getEntry(param1:uint) : String
      {
         return String(_entry.getValue(param1));
      }
   }
}
