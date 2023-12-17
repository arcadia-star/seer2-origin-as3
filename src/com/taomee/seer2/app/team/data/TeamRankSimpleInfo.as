package com.taomee.seer2.app.team.data
{
   import flash.utils.IDataInput;
   
   public class TeamRankSimpleInfo
   {
       
      
      public var basicInfo:TeamLogoInfo;
      
      public var level:uint;
      
      public var memberCount:uint;
      
      public var memberLimit:uint;
      
      public function TeamRankSimpleInfo(param1:IDataInput)
      {
         super();
         this.basicInfo = new TeamLogoInfo(param1);
         this.level = param1.readUnsignedInt();
         this.memberCount = param1.readUnsignedInt();
         this.memberLimit = param1.readUnsignedInt();
      }
   }
}
