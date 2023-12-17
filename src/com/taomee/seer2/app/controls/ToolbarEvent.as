package com.taomee.seer2.app.controls
{
   import flash.events.Event;
   
   public class ToolbarEvent extends Event
   {
      
      public static const PAGE_CHANGE:String = "pageChange";
      
      public static const RETRACT:String = "retract";
      
      public static const TOOLBAR_HIDE:String = "toolbarHide";
       
      
      public var status:Boolean;
      
      public var typeStr:String;
      
      public function ToolbarEvent(param1:String, param2:Boolean = true, param3:String = "")
      {
         this.status = param2;
         this.typeStr = param3;
         super(param1,false,false);
      }
   }
}
