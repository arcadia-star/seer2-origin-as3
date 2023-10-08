package com.taomee.seer2.app.gameRule.cavingNotice
{
   public class CavingPageInfo
   {
       
      
      public var btn:com.taomee.seer2.app.gameRule.cavingNotice.TagButton;
      
      public var pageId:uint;
      
      public var mapId:uint;
      
      public var times:Vector.<com.taomee.seer2.app.gameRule.cavingNotice.CavingTimeInfo>;
      
      public function CavingPageInfo(param1:uint, param2:uint, param3:String, param4:Vector.<com.taomee.seer2.app.gameRule.cavingNotice.CavingTimeInfo>)
      {
         this.pageId = param1;
         this.mapId = param2;
         this.times = param4;
         super();
      }
      
      public function isInTime() : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:Boolean = false;
         if(this.times != null)
         {
            _loc2_ = this.times.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = this.times[_loc3_].isInTimeScope();
               if(_loc1_)
               {
                  break;
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
   }
}
