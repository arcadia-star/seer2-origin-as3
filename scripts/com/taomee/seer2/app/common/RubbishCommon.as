package com.taomee.seer2.app.common
{
   import com.taomee.seer2.app.net.Command;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class RubbishCommon
   {
       
      
      public function RubbishCommon()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:Command = new Command(0,"rubbsh");
         Connection.addCommandListener(_loc1_,err);
         Connection.addErrorHandler(_loc1_,err);
      }
      
      private static function err(param1:MessageEvent) : void
      {
      }
   }
}
