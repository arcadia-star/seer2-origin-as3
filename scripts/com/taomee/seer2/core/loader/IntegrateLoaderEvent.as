package com.taomee.seer2.core.loader
{
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   
   internal class IntegrateLoaderEvent extends Event
   {
      
      public static const COMPLETE:String = "complete";
       
      
      private var _content;
      
      private var _domain:ApplicationDomain;
      
      public function IntegrateLoaderEvent(param1:String, param2:*, param3:ApplicationDomain = null)
      {
         super(param1);
         this._content = param2;
         this._domain = param3;
      }
      
      public function get content() : *
      {
         return this._content;
      }
      
      public function get domain() : ApplicationDomain
      {
         return this._domain;
      }
   }
}
