package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.actor.ActorManager;
   import flash.utils.IDataInput;
   
   public class Parser_1135
   {
       
      
      public var statusArr:Array;
      
      public var coins:uint;
      
      public var teamExpLevel:uint;
      
      public function Parser_1135(param1:IDataInput)
      {
         super();
         this.statusArr = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < 100)
         {
            this.statusArr.push(param1.readUnsignedByte());
            _loc2_++;
         }
         this.coins = param1.readUnsignedInt();
         this.teamExpLevel = param1.readUnsignedByte();
         ActorManager.actorInfo.teamInfo.teamExpLevel = this.teamExpLevel;
      }
   }
}
