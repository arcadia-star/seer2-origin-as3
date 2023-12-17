package com.taomee.seer2.app.home.panel.events
{
   import flash.events.Event;
   
   public class HomePanelEvent extends Event
   {
      
      public static const REQUEST_ADD_BUDDY:String = "requestAddBuddy";
       
      
      public function HomePanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
