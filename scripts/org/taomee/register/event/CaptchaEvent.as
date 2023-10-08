package org.taomee.register.event
{
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class CaptchaEvent extends Event
   {
      
      public static const REGISTER_CAPTCHA_RECEIVED:String = "register_captcha_received";
      
      public static const REGISTER_CAPTCHA_LOAD_ERROR:String = "register_captcha_load_error";
       
      
      public var captchaBitmap:Bitmap;
      
      public function CaptchaEvent(param1:String, param2:Bitmap, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.captchaBitmap = param2;
      }
   }
}
