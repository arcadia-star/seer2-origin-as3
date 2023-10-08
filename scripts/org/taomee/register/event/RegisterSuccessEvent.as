package org.taomee.register.event
{
   import flash.events.Event;
   
   public class RegisterSuccessEvent extends Event
   {
      
      public static const REGISTER_SUCCESS:String = "register_success";
       
      
      public var mimiNum:int;
      
      public function RegisterSuccessEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.mimiNum = param2;
      }
   }
}
