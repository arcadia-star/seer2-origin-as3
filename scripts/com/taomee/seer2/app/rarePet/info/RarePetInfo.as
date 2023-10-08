package com.taomee.seer2.app.rarePet.info
{
   import org.taomee.ds.HashMap;
   
   public class RarePetInfo
   {
       
      
      public var id:int;
      
      public var index:int;
      
      public var name:String;
      
      public var level:int;
      
      public var mapId:int;
      
      public var intervalTime:int;
      
      public var timeInfoMap:HashMap;
      
      public var DayLimitType:int;
      
      public var DayMaxNum:int;
      
      public function RarePetInfo()
      {
         super();
         this.timeInfoMap = new HashMap();
      }
   }
}
