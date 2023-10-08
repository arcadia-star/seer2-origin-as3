package com.taomee.seer2.app.config
{
   public class CompensationConfig
   {
      
      private static var _xmlClass:Class = CompensationConfig__xmlClass;
      
      private static var _configXML:XML;
      
      private static var _txt:String;
      
      private static var _idVec:Vector.<uint>;
      
      {
         initialize();
      }
      
      public function CompensationConfig()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _idVec = new Vector.<uint>();
         setup();
      }
      
      private static function setup() : void
      {
         _configXML = XML(new _xmlClass());
         _txt = _configXML.attribute("txt");
         initList(_configXML.attribute("itemList"));
      }
      
      private static function initList(param1:String) : void
      {
         var _loc2_:Array = param1.split("|");
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _idVec.push(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function getList() : Vector.<uint>
      {
         return _idVec;
      }
      
      public static function getTxt() : String
      {
         return _txt;
      }
   }
}
