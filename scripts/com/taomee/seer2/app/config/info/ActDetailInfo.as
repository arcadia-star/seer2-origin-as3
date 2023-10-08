package com.taomee.seer2.app.config.info
{
   public class ActDetailInfo
   {
       
      
      public var seat:uint;
      
      public var name:String;
      
      public var detailDes:String;
      
      public var go:String;
      
      public var timeDes:String;
      
      public var startTime:uint;
      
      public var endTime:uint;
      
      public var iconId:uint;
      
      public var isPet:Boolean;
      
      public var willOver:Boolean;
      
      public var itemReward:Array;
      
      public var petReward:Array;
      
      public function ActDetailInfo()
      {
         this.itemReward = [];
         this.petReward = [];
         super();
      }
   }
}
