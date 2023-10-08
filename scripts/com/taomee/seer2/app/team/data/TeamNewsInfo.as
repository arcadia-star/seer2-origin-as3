package com.taomee.seer2.app.team.data
{
   import flash.utils.IDataInput;
   
   public class TeamNewsInfo
   {
       
      
      public var type:uint;
      
      public var time:uint;
      
      public var userId:uint;
      
      public var userName:String;
      
      public var data_1:uint;
      
      public var data_2:uint;
      
      public function TeamNewsInfo(param1:IDataInput = null)
      {
         super();
         if(param1 != null)
         {
            this.type = param1.readUnsignedByte();
            this.time = param1.readUnsignedInt();
            this.userId = param1.readUnsignedInt();
            this.userName = param1.readUTFBytes(16);
            this.data_1 = param1.readUnsignedInt();
            this.data_2 = param1.readUnsignedInt();
         }
      }
   }
}
