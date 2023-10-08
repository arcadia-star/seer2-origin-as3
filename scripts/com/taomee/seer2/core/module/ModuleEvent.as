package com.taomee.seer2.core.module
{
   import com.taomee.seer2.core.utils.StringConstants;
   import flash.events.Event;
   
   public class ModuleEvent extends Event
   {
      
      public static const OPEN:String = "open";
      
      public static const SET_UP:String = "setup";
      
      public static const INIT:String = "init";
      
      public static const SHOW:String = "show";
      
      public static const HIDE:String = "hide";
      
      public static const DISPOSE:String = "dispose";
       
      
      private var _name:String;
      
      private var _content;
      
      public function ModuleEvent(param1:String, param2:String, param3:* = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1 + StringConstants.SIGN + param2,param4,param5);
         this._name = param1;
         this._content = param3;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get content() : *
      {
         return this._content;
      }
   }
}
