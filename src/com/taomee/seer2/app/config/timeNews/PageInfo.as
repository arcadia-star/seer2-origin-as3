package com.taomee.seer2.app.config.timeNews
{
   public class PageInfo
   {
       
      
      public var id:uint = 0;
      
      public var type:String;
      
      public var url:String;
      
      public var title:String = "";
      
      public var btnInfos:Array;
      
      public var isNew:Boolean;
      
      public var isPet:Boolean;
      
      public var petInfo:String;
      
      public var awardList:Vector.<int>;
      
      public var name:String = "";
      
      public var getWay:String = "";
      
      public var txtColor:String = "";
      
      public function PageInfo()
      {
         this.btnInfos = [];
         super();
      }
   }
}
