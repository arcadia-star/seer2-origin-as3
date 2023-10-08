package com.taomee.seer2.app.processor.activity.mascot
{
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class MascotTimeControl
   {
      
      public static var currTime:int = 1;
       
      
      public function MascotTimeControl()
      {
         super();
      }
      
      public static function timeRight() : Boolean
      {
         var _loc1_:uint = new Date(2014,7,28,21,1).getTime() / 1000;
         if(TimeManager.getServerTime() > _loc1_)
         {
            return true;
         }
         return false;
      }
      
      public static function timeLeft() : Boolean
      {
         var _loc1_:uint = new Date(2014,7,17,11,59).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc1_)
         {
            return true;
         }
         return false;
      }
      
      public static function timeContent() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.date == 25 || _loc1_.date == 26 || _loc1_.date == 27)
         {
            if(DateUtil.inInDateScope(_loc1_.day,12,0,15,1))
            {
               currTime = 1;
               return true;
            }
            if(DateUtil.inInDateScope(_loc1_.day,18,0,21,1))
            {
               currTime = 2;
               return true;
            }
         }
         return false;
      }
      
      public static function timeContent2() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(Boolean(DateUtil.inInDateScope(_loc1_.day,11,59,15,1)) || Boolean(DateUtil.inInDateScope(_loc1_.day,17,59,21,1)))
         {
            return true;
         }
         return false;
      }
   }
}
