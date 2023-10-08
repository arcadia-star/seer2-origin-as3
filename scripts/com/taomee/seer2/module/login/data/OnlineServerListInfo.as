package com.taomee.seer2.module.login.data
{
   import flash.utils.IDataInput;
   
   public class OnlineServerListInfo
   {
       
      
      public var serverInfoVector:Vector.<com.taomee.seer2.module.login.data.ServerInfo>;
      
      public var friendData:IDataInput;
      
      public var isNewPlayer:uint;
      
      public function OnlineServerListInfo(param1:IDataInput)
      {
         var _loc4_:com.taomee.seer2.module.login.data.ServerInfo = null;
         this.serverInfoVector = new Vector.<com.taomee.seer2.module.login.data.ServerInfo>();
         super();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new com.taomee.seer2.module.login.data.ServerInfo(param1);
            this.serverInfoVector.push(_loc4_);
            _loc3_++;
         }
         this.isNewPlayer = param1.readUnsignedByte();
         this.friendData = param1;
      }
   }
}
