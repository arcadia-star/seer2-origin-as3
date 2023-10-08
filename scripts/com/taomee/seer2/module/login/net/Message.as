package com.taomee.seer2.module.login.net
{
   import flash.utils.ByteArray;
   
   public class Message
   {
      
      public static const HEAD_LENGTH:int = 18;
       
      
      private var _length:uint;
      
      public var cmdId:uint;
      
      public var uid:uint;
      
      public var sequenceIndex:uint;
      
      public var statusCode:uint;
      
      private var _rawData:com.taomee.seer2.module.login.net.LittleEndianByteArray;
      
      public function Message(param1:ByteArray)
      {
         super();
         this.parseHead(param1);
         this.parseBody(param1);
      }
      
      private function parseHead(param1:ByteArray) : void
      {
         this._length = param1.readUnsignedInt();
         this.cmdId = param1.readUnsignedShort();
         this.uid = param1.readUnsignedInt();
         this.sequenceIndex = param1.readUnsignedInt();
         this.statusCode = param1.readUnsignedInt();
      }
      
      private function parseBody(param1:ByteArray) : void
      {
         this._rawData = new com.taomee.seer2.module.login.net.LittleEndianByteArray();
         var _loc2_:int = this._length - HEAD_LENGTH;
         if(_loc2_ > 0)
         {
            param1.readBytes(this._rawData,0,_loc2_);
         }
      }
      
      public function getRawData() : com.taomee.seer2.module.login.net.LittleEndianByteArray
      {
         return this._rawData;
      }
      
      public function getRawDataCopy() : ByteArray
      {
         this._rawData.position = 0;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = this._rawData.endian;
         this._rawData.readBytes(_loc1_);
         _loc1_.position = 0;
         this._rawData.position = 0;
         return _loc1_;
      }
   }
}
