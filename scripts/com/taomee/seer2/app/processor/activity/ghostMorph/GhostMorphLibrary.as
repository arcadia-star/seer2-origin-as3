package com.taomee.seer2.app.processor.activity.ghostMorph
{
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class GhostMorphLibrary
   {
       
      
      public function GhostMorphLibrary()
      {
         super();
      }
      
      public static function checkTime() : Boolean
      {
         if(Boolean(DateUtil.inInDateScope(6,13,0,15,1)) || Boolean(DateUtil.inInDateScope(5,13,0,15,1)) || Boolean(DateUtil.inInDateScope(0,13,0,15,1)))
         {
            return true;
         }
         return false;
      }
      
      public static function timePar() : Boolean
      {
         var _loc1_:uint = new Date(2012,9,27,13).getTime();
         if(TimeManager.getServerTime() < _loc1_)
         {
            return true;
         }
         return false;
      }
   }
}
