package com.taomee.seer2.app.controls.mapTitleInfo
{
   public class MapTitleInfo
   {
       
      
      public var day:uint;
      
      public var bitTime:uint;
      
      public var expIngTime:uint;
      
      public var expRate:uint;
      
      public var evRate:uint;
      
      public var expStartEndTimeVec:Vector.<com.taomee.seer2.app.controls.mapTitleInfo.ExpStartEndTime>;
      
      public function MapTitleInfo()
      {
         this.expStartEndTimeVec = Vector.<com.taomee.seer2.app.controls.mapTitleInfo.ExpStartEndTime>([]);
         super();
      }
   }
}
