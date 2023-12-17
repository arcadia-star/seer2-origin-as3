package com.taomee.seer2.app.config
{
   import org.taomee.ds.HashMap;
   
   public class TitleConfig
   {
      
      private static var _xmlClass:Class = TitleConfig__xmlClass;
      
      private static var _configXML:XML;
      
      private static var _map:HashMap;
      
      {
         initialize();
      }
      
      public function TitleConfig()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _map = new HashMap();
         setup();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         _configXML = XML(new _xmlClass());
         var _loc1_:XMLList = _configXML.descendants("type");
         for each(_loc2_ in _loc1_)
         {
            _map.add(int(_loc2_.@id),_loc2_);
         }
      }
      
      public static function getList(param1:int) : Array
      {
         var _loc5_:XML = null;
         var _loc2_:XML = _map.getValue(param1);
         var _loc3_:XMLList = _loc2_.descendants("title");
         var _loc4_:Array = new Array();
         for each(_loc5_ in _loc3_)
         {
            _loc4_.push([_loc5_.@titleId,_loc5_.@titleName,_loc5_.@des]);
         }
         return _loc4_;
      }
   }
}
