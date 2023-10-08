package com.taomee.seer2.app.config.info
{
   public class PaintGuessInfo
   {
       
      
      public var type:String;
      
      public var sort:uint;
      
      public var groupList:Vector.<com.taomee.seer2.app.config.info.PaintGuessGroupInfo>;
      
      public function PaintGuessInfo(param1:String, param2:uint, param3:Vector.<com.taomee.seer2.app.config.info.PaintGuessGroupInfo>)
      {
         super();
         this.type = param1;
         this.sort = param2;
         this.groupList = param3;
      }
   }
}
