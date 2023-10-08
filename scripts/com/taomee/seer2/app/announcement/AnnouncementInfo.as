package com.taomee.seer2.app.announcement
{
   public class AnnouncementInfo
   {
       
      
      public var serverId:int;
      
      public var day:int;
      
      public var content:String;
      
      public var frequency:String;
      
      public var name:String = "";
      
      public function AnnouncementInfo()
      {
         super();
      }
      
      public function getFrequencyArray() : Array
      {
         return this.frequency.split("_");
      }
   }
}
