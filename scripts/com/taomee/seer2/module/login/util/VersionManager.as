package com.taomee.seer2.module.login.util
{
   public class VersionManager
   {
      
      private static var _o:Object;
       
      
      public function VersionManager()
      {
         super();
      }
      
      public static function setup(param1:Object) : void
      {
         _o = param1;
      }
      
      public static function get versionTime() : Number
      {
         return (_o.getInstance().lastModifiedDate as Date).time * 0.001;
      }
      
      public static function get version() : String
      {
         var _loc1_:Date = _o.getInstance().lastModifiedDate as Date;
         return _loc1_.fullYear + "." + (_loc1_.getMonth() + 1) + "." + _loc1_.getDate() + " " + _loc1_.toLocaleTimeString();
      }
      
      public static function getURL(param1:String) : String
      {
         return _o.getInstance().getVerURLByNameSpace(param1) as String;
      }
   }
}
