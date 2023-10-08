package com.taomee.seer2.app.activity.onlineControl
{
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class OnlineControl
   {
      
      private static const ONLINE_TIME_ARR:Array = [300,600,900,1200,2400,3600,5400];
      
      private static const GIFT_MAX:int = 7;
       
      
      public function OnlineControl()
      {
         super();
      }
      
      public static function getOnlineLevel() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < ONLINE_TIME_ARR.length)
         {
            if(TimeManager.getOnlineTime() >= ONLINE_TIME_ARR[_loc2_])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function currGiftTime() : uint
      {
         if(getOnlineLevel() < GIFT_MAX)
         {
            return ONLINE_TIME_ARR[getOnlineLevel()] - TimeManager.getOnlineTime();
         }
         return 0;
      }
   }
}
