package com.taomee.seer2.module.login.config
{
   public class ActivityCountDownConfig
   {
      
      private static var _xmlClass:Class = ActivityCountDownConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _startDate:Array;
      
      private static var _activityName:String;
      
      private static var _isOpen:Boolean;
      
      {
         setup();
      }
      
      public function ActivityCountDownConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("info");
         for each(_loc2_ in _loc1_)
         {
            _startDate = String(_loc2_.attribute("startDate")).split("|");
            _activityName = String(_loc2_.attribute("activityName"));
            if(String(_loc2_.attribute("isOpen")) == "true")
            {
               _isOpen = true;
            }
            else
            {
               _isOpen = false;
            }
         }
      }
      
      public static function getActivityName() : String
      {
         return _activityName;
      }
      
      public static function getActivityDate() : Array
      {
         return _startDate;
      }
      
      public static function getIsOpen() : Boolean
      {
         return _isOpen;
      }
   }
}
