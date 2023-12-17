package com.taomee.seer2.app.processor.quest.handler.branch.quest10194
{
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class TorchRelayTime
   {
      
      public static var date:Date;
       
      
      public function TorchRelayTime()
      {
         super();
      }
      
      public static function isAppearTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.month == 11 && (_loc1_.date >= 20 || _loc1_.date <= 26))
         {
            if(_loc1_.hours == 13)
            {
               return true;
            }
            return false;
         }
         return false;
      }
   }
}
