package com.taomee.seer2.app.config
{
   import org.taomee.ds.HashMap;
   
   public class PetStarConfig
   {
      
      private static var _xmlClass:Class = PetStarConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _map:HashMap = new HashMap();
      
      {
         setup();
      }
      
      public function PetStarConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:int = 0;
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("pet");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = int(_loc2_.attribute("level"));
            _loc4_ = _loc2_.attribute("idList").split(",");
            _loc5_ = Vector.<uint>([]);
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc5_.push(uint(_loc4_[_loc6_]));
               _loc6_++;
            }
            _map.add(_loc3_,_loc5_);
         }
      }
      
      public static function getStars(param1:int) : Vector.<uint>
      {
         return _map.getValue(param1);
      }
   }
}
