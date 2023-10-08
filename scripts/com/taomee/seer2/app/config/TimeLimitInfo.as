package com.taomee.seer2.app.config
{
   public class TimeLimitInfo
   {
       
      
      public var ID:uint;
      
      public var NAME:String;
      
      public var ToDate:String;
      
      public var FromDate:String;
      
      public var dayArr:Vector.<com.taomee.seer2.app.config.TimeLimitDay>;
      
      public function TimeLimitInfo()
      {
         super();
      }
   }
}
