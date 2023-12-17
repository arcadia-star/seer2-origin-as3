package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.team.data.TeamRankSimpleInfo;
   import flash.utils.IDataInput;
   
   public class Parser_1149
   {
       
      
      public var infoVec:Vector.<TeamRankSimpleInfo>;
      
      public function Parser_1149(param1:IDataInput)
      {
         super();
         this.infoVec = new Vector.<TeamRankSimpleInfo>();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.infoVec.push(new TeamRankSimpleInfo(param1));
            _loc3_++;
         }
      }
   }
}
