package com.taomee.seer2.core.net
{
   import com.taomee.seer2.core.log.Logger;
   import com.taomee.seer2.core.net.message.Message;
   import flash.events.DataEvent;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   
   public class TcpSocket extends Socket
   {
       
      
      private const MSG_FIRST_TOKEN_LEN:int = 4;
      
      private var _tempBuffer:ByteArray;
      
      private var _chunkBuffer:ByteArray;
      
      private var _messageQueue:Vector.<Message>;
      
      private var _host:String = "";
      
      private var _port:int;
      
      private var _logger:Logger;
      
      public function TcpSocket()
      {
         super();
         this._tempBuffer = new ByteArray();
         this._chunkBuffer = new ByteArray();
         this._messageQueue = new Vector.<Message>();
         addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         this._logger = Logger.getLogger("TcpSocket");
      }
      
      public function get host() : String
      {
         return this._host;
      }
      
      public function get port() : int
      {
         return this._port;
      }
      
      override public function set endian(param1:String) : void
      {
         super.endian = param1;
         this._tempBuffer.endian = param1;
         this._chunkBuffer.endian = param1;
      }
      
      override public function connect(param1:String, param2:int) : void
      {
         this._host = param1;
         this._port = param2;
         super.connect(param1,param2);
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Message = null;
         this._chunkBuffer.clear();
         if(this._tempBuffer.length > 0)
         {
            this._tempBuffer.position = 0;
            this._tempBuffer.readBytes(this._chunkBuffer,0,this._tempBuffer.length);
            this._tempBuffer.clear();
         }
         readBytes(this._chunkBuffer,this._chunkBuffer.length,bytesAvailable);
         this._chunkBuffer.position = 0;
         while(this._chunkBuffer.bytesAvailable > 0)
         {
            if(this._chunkBuffer.bytesAvailable > this.MSG_FIRST_TOKEN_LEN)
            {
               _loc2_ = this._chunkBuffer.readUnsignedInt() - this.MSG_FIRST_TOKEN_LEN;
               if(_loc2_ > this._chunkBuffer.bytesAvailable)
               {
                  this._chunkBuffer.position -= this.MSG_FIRST_TOKEN_LEN;
                  this._chunkBuffer.readBytes(this._tempBuffer,0,this._chunkBuffer.bytesAvailable);
               }
               else
               {
                  this._chunkBuffer.position -= this.MSG_FIRST_TOKEN_LEN;
                  _loc3_ = new Message(this._chunkBuffer);
                  this._messageQueue.push(_loc3_);
                  dispatchEvent(new DataEvent(DataEvent.DATA));
               }
            }
            else
            {
               this._chunkBuffer.readBytes(this._tempBuffer,0,this._chunkBuffer.bytesAvailable);
            }
         }
      }
      
      public function getMessageQueue() : Vector.<Message>
      {
         var _loc1_:Vector.<Message> = new Vector.<Message>();
         while(this._messageQueue.length > 0)
         {
            _loc1_.push(this._messageQueue.shift());
         }
         return _loc1_;
      }
      
      public function send(param1:ByteArray) : void
      {
         if(connected == true)
         {
            writeBytes(param1);
            flush();
         }
         else
         {
            this._logger.error("连接已断开");
         }
      }
      
      override public function close() : void
      {
         if(connected == true)
         {
            super.close();
         }
      }
   }
}
