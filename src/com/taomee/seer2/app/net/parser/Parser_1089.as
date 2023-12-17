package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.team.TeamManager;
   import flash.utils.IDataInput;
   
   public class Parser_1089
   {
       
      
      public var teamCapacity:uint;
      
      public var teamMemberlist:Vector.<uint>;
      
      public function Parser_1089(param1:IDataInput)
      {
         super();
         this.teamCapacity = param1.readUnsignedInt();
         TeamManager.teamCapacity = this.teamCapacity;
         this.teamMemberlist = new Vector.<uint>();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.teamMemberlist.push(param1.readUnsignedInt());
            _loc3_++;
         }
      }
   }
}
