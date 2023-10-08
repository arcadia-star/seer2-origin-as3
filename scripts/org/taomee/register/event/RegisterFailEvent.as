package org.taomee.register.event
{
   import flash.events.Event;
   
   public class RegisterFailEvent extends Event
   {
      
      public static const REGISTER_FAIL:String = "register_fail";
       
      
      public var errorCode:int;
      
      public function RegisterFailEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.errorCode = param2;
      }
   }
}
