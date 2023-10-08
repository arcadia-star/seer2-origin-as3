package com.taomee.seer2.core.net.message
{
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import flash.utils.ByteArray;
   
   public class Message
   {
      
      public static const HEAD_LENGTH:int = 18;
       
      
      private var _length:uint;
      
      public var commandId:uint;
      
      public var userId:uint;
      
      public var sequenceIndex:uint;
      
      public var statusCode:uint;
      
      private var _data:ByteArray;
      
      private var _rawData:LittleEndianByteArray;
      
      public function Message(param1:ByteArray)
      {
         super();
         this._data = MessageEncrypt.decrypt(param1);
         if(this._data != null)
         {
            this.parseHead(this._data);
            this.parseBody(this._data);
         }
      }
      
      private function parseHead(param1:ByteArray) : void
      {
         this._length = param1.readUnsignedInt();
         this.commandId = param1.readUnsignedShort();
         this.userId = param1.readUnsignedInt();
         this.sequenceIndex = param1.readUnsignedInt();
         this.statusCode = param1.readUnsignedInt();
      }
      
      private function parseBody(param1:ByteArray) : void
      {
         this._rawData = new LittleEndianByteArray();
         var _loc2_:int = this._length - HEAD_LENGTH;
         if(_loc2_ > 0)
         {
            param1.readBytes(this._rawData,0,_loc2_);
         }
      }
      
      public function getRawData() : LittleEndianByteArray
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
      
      public function getInfo() : Object
      {
         return ResponseParser.parser(this.commandId,this._rawData);
      }
   }
}
