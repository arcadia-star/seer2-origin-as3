package com.taomee.seer2.app.gameRule.cavingNotice
{
   public class ActivityRecord
   {
       
      
      public var pageId:uint;
      
      public var timeInfo:com.taomee.seer2.app.gameRule.cavingNotice.CavingTimeInfo;
      
      public function ActivityRecord(param1:uint, param2:com.taomee.seer2.app.gameRule.cavingNotice.CavingTimeInfo)
      {
         this.pageId = param1;
         this.timeInfo = param2;
         super();
      }
   }
}
