package com.taomee.seer2.app.processor.quest.handler.branch.quest10121
{
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class TorchRelayTime
   {
      
      public static const DATE:Date = new Date(2013,5,1,14);
      
      public static const SECONDS_HALF_HOUR:Number = 60 * 30;
      
      public static const MILI_SECONDS:Number = 1000;
       
      
      public function TorchRelayTime()
      {
         super();
      }
      
      public static function isAppearTime() : Boolean
      {
         var _loc1_:Number = Number(TimeManager.getServerTime());
         var _loc2_:Number = DATE.getTime() / MILI_SECONDS;
         var _loc3_:Number = _loc2_ + SECONDS_HALF_HOUR;
         if(_loc1_ >= _loc2_ && _loc1_ < _loc3_)
         {
            return true;
         }
         return false;
      }
   }
}
