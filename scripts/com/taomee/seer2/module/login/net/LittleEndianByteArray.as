package com.taomee.seer2.module.login.net
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class LittleEndianByteArray extends ByteArray
   {
       
      
      public function LittleEndianByteArray()
      {
         super();
         endian = Endian.LITTLE_ENDIAN;
      }
      
      public static function writeIntergerAsUnsignedByte(param1:int) : LittleEndianByteArray
      {
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeByte(param1);
         return _loc2_;
      }
      
      public static function writeIntergerAsUnsignedShort(param1:int) : LittleEndianByteArray
      {
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeShort(param1);
         return _loc2_;
      }
      
      public static function writeIntergerAsUnsignedInt(param1:int) : LittleEndianByteArray
      {
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUnsignedInt(param1);
         return _loc2_;
      }
   }
}
