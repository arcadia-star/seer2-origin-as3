package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PlanetInfo;
   
   public class PlanetConfig
   {
      
      private static var _xmlClass:Class = PlanetConfig__xmlClass;
      
      private static var _configXML:XML;
      
      private static var _list:Vector.<PlanetInfo>;
      
      {
         setup();
      }
      
      public function PlanetConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:uint = 0;
         var _loc6_:PlanetInfo = null;
         var _loc7_:XML = null;
         _configXML = XML(new _xmlClass());
         var _loc1_:XMLList = _configXML.descendants("planet");
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         _list = Vector.<PlanetInfo>([]);
         for each(_loc7_ in _loc1_)
         {
            _loc2_ = uint(_loc7_.@mapId);
            _loc3_ = String(_loc7_.@idList).split("|");
            _loc4_ = String(_loc7_.@swapList).split("|");
            _loc5_ = String(_loc7_.@tipList).split("|");
            (_loc6_ = new PlanetInfo()).mapId = _loc2_;
            _loc6_.idList = _loc3_;
            _loc6_.swapList = _loc4_;
            _loc6_.tipList = _loc5_;
            _list.push(_loc6_);
         }
      }
      
      public static function getInfo(param1:uint) : PlanetInfo
      {
         var _loc2_:PlanetInfo = null;
         var _loc3_:PlanetInfo = null;
         for each(_loc3_ in _list)
         {
            if(_loc3_.mapId == param1)
            {
               return _loc3_;
            }
         }
         return _loc2_;
      }
      
      public static function getTip(param1:uint) : String
      {
         var _loc2_:PlanetInfo = null;
         var _loc3_:int = 0;
         for each(_loc2_ in _list)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.idList.length)
            {
               if(param1 == _loc2_.idList[_loc3_])
               {
                  return _loc2_.tipList[_loc3_];
               }
               _loc3_++;
            }
         }
         return "";
      }
   }
}
