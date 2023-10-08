package com.taomee.seer2.app.activity.data
{
   public class ActivityCircle
   {
       
      
      public var circleType:int;
      
      public var circleDate:Array;
      
      public var repeatCount:uint;
      
      public function ActivityCircle(param1:int, param2:Array = null, param3:uint = 1)
      {
         super();
         this.circleType = param1;
         this.circleDate = param2;
         this.repeatCount = param3;
      }
   }
}
