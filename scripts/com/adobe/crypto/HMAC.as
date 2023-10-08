package com.adobe.crypto
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.describeType;
   
   public class HMAC
   {
       
      
      public function HMAC()
      {
         super();
      }
      
      public static function hash(param1:String, param2:String, param3:Object = null) : String
      {
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(param2);
         _loc5_.writeUTFBytes(param1);
         return hashBytes(_loc5_,_loc4_,param3);
      }
      
      public static function hashBytes(param1:ByteArray, param2:ByteArray, param3:Object = null) : String
      {
         var _loc9_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:String = Endian.BIG_ENDIAN;
         if(param3 == null)
         {
            param3 = MD5;
         }
         if(describeType(param3).@name.toString() == "com.adobe.crypto::MD5")
         {
            _loc6_ = Endian.LITTLE_ENDIAN;
         }
         if(param1.length > 64)
         {
            param3.hashBytes(param1);
            param1 = new ByteArray();
            param1.endian = _loc6_;
            while(param3.digest.bytesAvailable != 0)
            {
               param1.writeInt(param3.digest.readInt());
            }
         }
         param1.length = 64;
         param1.position = 0;
         var _loc7_:int = 0;
         while(_loc7_ < 64)
         {
            _loc9_ = param1.readByte();
            _loc4_.writeByte(54 ^ _loc9_);
            _loc5_.writeByte(92 ^ _loc9_);
            _loc7_++;
         }
         _loc4_.writeBytes(param2);
         param3.hashBytes(_loc4_);
         var _loc8_:ByteArray;
         (_loc8_ = new ByteArray()).endian = _loc6_;
         while(param3.digest.bytesAvailable != 0)
         {
            _loc8_.writeInt(param3.digest.readInt());
         }
         _loc8_.position = 0;
         while(_loc8_.bytesAvailable != 0)
         {
            _loc5_.writeByte(_loc8_.readUnsignedByte());
         }
         return param3.hashBytes(_loc5_);
      }
   }
}
