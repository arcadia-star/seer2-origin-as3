package com.taomee.seer2.app.gameRule.cavingNotice
{
   public class ActivityRecord
   {
       
      
      public var pageId:uint;
      
      public var timeInfo:CavingTimeInfo;
      
      public function ActivityRecord(param1:uint, param2:CavingTimeInfo)
      {
         this.pageId = param1;
         this.timeInfo = param2;
         super();
      }
   }
}
