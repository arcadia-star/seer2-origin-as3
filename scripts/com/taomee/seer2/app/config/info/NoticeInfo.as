package com.taomee.seer2.app.config.info
{
   import org.taomee.ds.HashMap;
   
   public class NoticeInfo
   {
       
      
      public var resId:String;
      
      public var difficulty:int;
      
      public var trainerLev:int;
      
      public var go:Array;
      
      public var des:String;
      
      public var detailDes:String;
      
      public var time:String;
      
      public var isAll:Boolean;
      
      public var startTime:String;
      
      public var endTime:String;
      
      public var strategyId:uint;
      
      public var isMapID:int;
      
      public var types:Vector.<String>;
      
      public var petReward:Array;
      
      public var itemReward:Vector.<com.taomee.seer2.app.config.info.ItemInfo>;
      
      public var timeLimit:HashMap;
      
      public function NoticeInfo()
      {
         super();
      }
   }
}
