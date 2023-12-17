package com.taomee.seer2.app.net.parser.baseData
{
   import flash.utils.IDataInput;
   
   public class RankServerInfo
   {
       
      
      public var userId:Number;
      
      public var currRank:Number;
      
      public var score:Number;
      
      public var scoreTime:Number;
      
      public var nick:String = "";
      
      public function RankServerInfo(param1:IDataInput = null)
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super();
         if(param1)
         {
            this.userId = param1.readUnsignedInt();
            _loc2_ = uint(param1.readUnsignedInt());
            this.currRank = param1.readUnsignedInt();
            _loc3_ = uint(param1.readUnsignedInt());
            this.scoreTime = param1.readUnsignedInt();
            this.score = param1.readUnsignedInt();
            if((_loc4_ = uint(param1.readUnsignedInt())) != 0)
            {
               this.nick = param1.readUTFBytes(_loc4_);
            }
         }
      }
   }
}
