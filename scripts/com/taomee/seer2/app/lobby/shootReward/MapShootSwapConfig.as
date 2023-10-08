package com.taomee.seer2.app.lobby.shootReward
{
   import org.taomee.ds.HashMap;
   
   public class MapShootSwapConfig
   {
      
      private static var _xmlClass:Class = MapShootSwapConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _labelMap:HashMap;
      
      private static var _swapMap:HashMap;
      
      {
         setup();
      }
      
      public function MapShootSwapConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         _labelMap = new HashMap();
         _swapMap = new HashMap();
         _xml = XML(new _xmlClass());
         initLabelMap();
         initRewardMap();
      }
      
      private static function initLabelMap() : void
      {
         var _loc2_:XML = null;
         var _loc1_:XMLList = _xml.descendants("label");
         for each(_loc2_ in _loc1_)
         {
            _labelMap.add(uint(_loc2_.@shootType),String(_loc2_.@name));
         }
      }
      
      private static function initRewardMap() : void
      {
         var _loc2_:XML = null;
         var _loc3_:HashMap = null;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
         var _loc1_:XMLList = _xml.descendants("map");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new HashMap();
            _loc4_ = _loc2_.descendants("swap");
            for each(_loc5_ in _loc4_)
            {
               _loc3_.add(uint(_loc5_.@shootType),uint(_loc5_.@index));
            }
            _swapMap.add(uint(_loc2_.@id),_loc3_);
         }
      }
      
      public static function hasShootReward(param1:uint) : Boolean
      {
         if(_swapMap.containsKey(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function getLabel(param1:uint) : String
      {
         if(_labelMap.containsKey(param1))
         {
            return _labelMap.getValue(param1);
         }
         return null;
      }
      
      public static function getSwapId(param1:uint, param2:uint) : uint
      {
         var _loc3_:HashMap = null;
         if(_swapMap.containsKey(param1))
         {
            _loc3_ = _swapMap.getValue(param1);
            if(_loc3_.containsKey(param2))
            {
               return _loc3_.getValue(param2);
            }
            return 0;
         }
         return 0;
      }
   }
}
