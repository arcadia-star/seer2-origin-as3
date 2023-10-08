package com.taomee.seer2.module.login.data
{
   import flash.utils.IDataInput;
   
   public class ServerInfo
   {
       
      
      public var serverId:uint;
      
      public var serverIp:String;
      
      public var serverPort:uint;
      
      public var userCount:uint;
      
      public var friendCount:uint;
      
      public var _isNewSvr:uint;
      
      public var isRecommendSvr:uint;
      
      public function ServerInfo(param1:IDataInput = null)
      {
         super();
         if(param1)
         {
            this.serverId = param1.readUnsignedShort();
            this.serverIp = param1.readUTFBytes(16);
            this.serverPort = param1.readUnsignedShort();
            this.userCount = param1.readUnsignedInt();
            this.friendCount = param1.readUnsignedByte();
            this._isNewSvr = param1.readUnsignedByte();
         }
      }
      
      public function get isNewSvr() : uint
      {
         return this._isNewSvr;
      }
   }
}
