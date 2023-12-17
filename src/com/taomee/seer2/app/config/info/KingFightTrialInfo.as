package com.taomee.seer2.app.config.info
{
   public class KingFightTrialInfo
   {
       
      
      public var level:int;
      
      public var fightResList:Vector.<int>;
      
      public var layerNum:int;
      
      public var state:int = -1;
      
      public var dayFighted:int = 0;
      
      public var awradList:Array;
      
      public function KingFightTrialInfo()
      {
         this.awradList = [];
         super();
      }
   }
}
