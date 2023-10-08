package com.taomee.seer2.core.loader
{
   import flash.system.ApplicationDomain;
   
   public class ContentInfo
   {
       
      
      public var content;
      
      public var domain:ApplicationDomain;
      
      public var data;
      
      private var _url:String;
      
      private var _type:String;
      
      public function ContentInfo(param1:String, param2:String, param3:*, param4:ApplicationDomain = null, param5:* = null)
      {
         super();
         this._url = param1;
         this._type = param2;
         this.content = param3;
         this.domain = param4;
         this.data = param5;
      }
      
      public function dispose() : void
      {
         this.content = null;
         this.domain = null;
         this.data = null;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get type() : String
      {
         return this._type;
      }
   }
}
