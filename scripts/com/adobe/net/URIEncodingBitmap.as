package com.adobe.net
{
   import flash.utils.ByteArray;
   
   public class URIEncodingBitmap extends ByteArray
   {
       
      
      public function URIEncodingBitmap(param1:String)
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         super();
         var _loc3_:ByteArray = new ByteArray();
         _loc2_ = 0;
         while(_loc2_ < 16)
         {
            this.writeByte(0);
            _loc2_++;
         }
         _loc3_.writeUTFBytes(param1);
         _loc3_.position = 0;
         while(_loc3_.bytesAvailable)
         {
            if((_loc4_ = _loc3_.readByte()) <= 127)
            {
               this.position = _loc4_ >> 3;
               _loc5_ = (_loc5_ = this.readByte()) | 1 << (_loc4_ & 7);
               this.position = _loc4_ >> 3;
               this.writeByte(_loc5_);
            }
         }
      }
      
      public function ShouldEscape(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.position = 0;
         _loc3_ = _loc2_.readByte();
         if(_loc3_ & 128)
         {
            return 0;
         }
         if(_loc3_ < 31 || _loc3_ == 127)
         {
            return _loc3_;
         }
         this.position = _loc3_ >> 3;
         if((_loc4_ = this.readByte()) & 1 << (_loc3_ & 7))
         {
            return _loc3_;
         }
         return 0;
      }
   }
}
