package com.taomee.seer2.module.login.config
{
   public class LoginConfig
   {
      
      private static const PRODUCT_NAME:String = "seer2";
      
      private static const PRODUCT_ID:uint = 10;
      
      private static var _isDebug:Boolean = false;
      
      private static var _configXml:XML;
       
      
      public function LoginConfig()
      {
         super();
      }
      
      public static function setXML(param1:XML) : void
      {
         _configXml = param1;
      }
      
      public static function setDebug(param1:Boolean) : void
      {
         _isDebug = param1;
      }
      
      public static function dispose() : void
      {
         _configXml = null;
      }
      
      public static function get productName() : String
      {
         if(_configXml.@name != null && _configXml.@name != "" && _configXml.@name != undefined)
         {
            return _configXml.@name;
         }
         return PRODUCT_NAME;
      }
      
      public static function get productID() : uint
      {
         if(_configXml.@gid != null && _configXml.@gid != "" && _configXml.@gid != undefined)
         {
            return uint(_configXml.@gid);
         }
         return PRODUCT_ID;
      }
      
      public static function get isDebug() : Boolean
      {
         return _isDebug;
      }
      
      public static function get comURL() : String
      {
         return _configXml.elements("com")[0].attribute("url").toString();
      }
      
      public static function get telURL() : String
      {
         return _configXml.elements("tel")[0].attribute("url").toString();
      }
      
      public static function get cncURL() : String
      {
         return _configXml.elements("cnc")[0].attribute("url").toString();
      }
   }
}
