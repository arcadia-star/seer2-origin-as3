package com.taomee.seer2.app.config
{
   import org.taomee.ds.HashMap;
   
   public class ServerNameConfig
   {
      
      private static var _xmlClass:Class = ServerNameConfig__xmlClass;
      
      private static var _serverXML:XML;
      
      private static var _serverMap:HashMap;
      
      {
         setup();
      }
      
      public function ServerNameConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _serverMap = new HashMap();
         _serverXML = XML(new _xmlClass());
         var _loc1_:XMLList = _serverXML.descendants("node");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = int(_loc2_.attribute("id"));
            _loc4_ = _loc2_.attribute("name");
            _serverMap.add(_loc3_,_loc4_);
         }
      }
      
      public static function getServerName(param1:int) : String
      {
         if(_serverMap.containsKey(param1))
         {
            return _serverMap.getValue(param1);
         }
         return "未知号";
      }
   }
}
