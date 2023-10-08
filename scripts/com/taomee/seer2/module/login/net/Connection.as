package com.taomee.seer2.module.login.net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Connection extends EventDispatcher
   {
      
      private static const MSG_FIRST_TOKEN_LEN:int = 4;
      
      public static const TEL:uint = 0;
      
      public static const CNC:uint = 1;
      
      public static var netType:uint;
      
      private static var _socket:Socket;
      
      private static var _uid:uint;
      
      private static var _tempBuffer:ByteArray;
      
      private static var _chunkBuffer:ByteArray;
      
      private static var _messageQueue:Vector.<com.taomee.seer2.module.login.net.Message>;
      
      private static var _messageDispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _errorDispatcher:EventDispatcher = new EventDispatcher();
      
      {
         initialize();
      }
      
      public function Connection()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _socket = new Socket();
         _socket.endian = Endian.LITTLE_ENDIAN;
         _socket.addEventListener(Event.CLOSE,onSocketClose);
         _socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
         _tempBuffer = new ByteArray();
         _tempBuffer.endian = Endian.LITTLE_ENDIAN;
         _chunkBuffer = new ByteArray();
         _chunkBuffer.endian = Endian.LITTLE_ENDIAN;
         _messageQueue = new Vector.<com.taomee.seer2.module.login.net.Message>();
      }
      
      public static function get uid() : uint
      {
         return _uid;
      }
      
      private static function onSocketClose(param1:Event) : void
      {
      }
      
      private static function onSocketData(param1:ProgressEvent) : void
      {
         var _loc2_:com.taomee.seer2.module.login.net.Message = null;
         getMessageQueue();
         while(_messageQueue.length > 0)
         {
            _loc2_ = _messageQueue.shift();
            if(_loc2_.statusCode != 0)
            {
               if(_errorDispatcher.hasEventListener(_loc2_.cmdId.toString()))
               {
                  _errorDispatcher.dispatchEvent(new MessageEvent(_loc2_.cmdId.toString(),_loc2_));
               }
            }
            else
            {
               _messageDispatcher.dispatchEvent(new MessageEvent(_loc2_.cmdId.toString(),_loc2_));
            }
         }
      }
      
      private static function getMessageQueue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:com.taomee.seer2.module.login.net.Message = null;
         _chunkBuffer.clear();
         if(_tempBuffer.length > 0)
         {
            _tempBuffer.position = 0;
            _tempBuffer.readBytes(_chunkBuffer,0,_tempBuffer.length);
            _tempBuffer.clear();
         }
         _socket.readBytes(_chunkBuffer,_chunkBuffer.length,_socket.bytesAvailable);
         _chunkBuffer.position = 0;
         while(_chunkBuffer.bytesAvailable > 0)
         {
            if(_chunkBuffer.bytesAvailable > MSG_FIRST_TOKEN_LEN)
            {
               _loc1_ = _chunkBuffer.readUnsignedInt() - MSG_FIRST_TOKEN_LEN;
               if(_loc1_ > _chunkBuffer.bytesAvailable)
               {
                  _chunkBuffer.position -= MSG_FIRST_TOKEN_LEN;
                  _chunkBuffer.readBytes(_tempBuffer,0,_chunkBuffer.bytesAvailable);
               }
               else
               {
                  _chunkBuffer.position -= MSG_FIRST_TOKEN_LEN;
                  _loc2_ = new com.taomee.seer2.module.login.net.Message(_chunkBuffer);
                  _messageQueue.push(_loc2_);
               }
            }
            else
            {
               _chunkBuffer.readBytes(_tempBuffer,0,_chunkBuffer.bytesAvailable);
            }
         }
      }
      
      public static function setUserId(param1:uint) : void
      {
         _uid = param1;
      }
      
      public static function connect(param1:String, param2:int) : void
      {
         _socket.connect(param1,param2);
      }
      
      public static function send(param1:int, ... rest) : void
      {
         var _loc3_:ByteArray = packBody(rest);
         var _loc4_:ByteArray = packHead(param1,_loc3_,_loc3_.length);
         var _loc5_:ByteArray;
         (_loc5_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
         _loc5_.writeBytes(_loc4_);
         _loc5_.writeBytes(_loc3_);
         if(_socket.connected == true)
         {
            _socket.writeBytes(_loc5_);
            _socket.flush();
         }
      }
      
      public static function close() : void
      {
         _socket.close();
      }
      
      private static function packHead(param1:uint, param2:ByteArray, param3:int) : ByteArray
      {
         var _loc4_:ByteArray;
         (_loc4_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
         _loc4_.writeUnsignedInt(com.taomee.seer2.module.login.net.Message.HEAD_LENGTH + param3);
         _loc4_.writeShort(param1);
         _loc4_.writeUnsignedInt(_uid);
         _loc4_.writeInt(0);
         var _loc5_:uint = 0;
         param2.position = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param3)
         {
            _loc5_ += param2.readUnsignedByte();
            _loc6_++;
         }
         _loc5_ %= 100000;
         _loc4_.writeInt(_loc5_);
         return _loc4_;
      }
      
      private static function packBody(param1:Array) : ByteArray
      {
         var _loc3_:* = undefined;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         for each(_loc3_ in param1)
         {
            if(_loc3_ is String)
            {
               _loc2_.writeUTFBytes(_loc3_);
            }
            else if(_loc3_ is ByteArray)
            {
               _loc2_.writeBytes(_loc3_);
            }
            else
            {
               _loc2_.writeUnsignedInt(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _socket.addEventListener(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _socket.removeEventListener(param1,param2);
      }
      
      public static function addCommandListener(param1:int, param2:Function) : void
      {
         _messageDispatcher.addEventListener(param1.toString(),param2);
      }
      
      public static function removeCommandListener(param1:int, param2:Function) : void
      {
         _messageDispatcher.removeEventListener(param1.toString(),param2);
      }
      
      public static function addErrorHandler(param1:int, param2:Function) : void
      {
         _errorDispatcher.addEventListener(param1.toString(),param2);
      }
      
      public static function removeErrorHandler(param1:int, param2:Function) : void
      {
         _errorDispatcher.removeEventListener(param1.toString(),param2);
      }
   }
}
