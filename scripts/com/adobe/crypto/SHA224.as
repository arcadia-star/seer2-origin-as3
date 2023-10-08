package com.adobe.crypto
{
   import com.adobe.utils.IntUtil;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   
   public class SHA224
   {
      
      public static var digest:ByteArray;
       
      
      public function SHA224()
      {
         super();
      }
      
      public static function hash(param1:String) : String
      {
         var _loc2_:Array = createBlocksFromString(param1);
         var _loc3_:ByteArray = hashBlocks(_loc2_);
         return IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true);
      }
      
      public static function hashBytes(param1:ByteArray) : String
      {
         var _loc2_:Array = createBlocksFromByteArray(param1);
         var _loc3_:ByteArray = hashBlocks(_loc2_);
         return IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true) + IntUtil.toHex(_loc3_.readInt(),true);
      }
      
      public static function hashToBase64(param1:String) : String
      {
         var _loc7_:uint = 0;
         var _loc2_:Array = createBlocksFromString(param1);
         var _loc3_:ByteArray = hashBlocks(_loc2_);
         var _loc4_:String = "";
         _loc3_.position = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = _loc3_.readUnsignedByte();
            _loc4_ += String.fromCharCode(_loc7_);
            _loc5_++;
         }
         var _loc6_:Base64Encoder;
         (_loc6_ = new Base64Encoder()).encode(_loc4_);
         return _loc6_.flush();
      }
      
      private static function hashBlocks(param1:Array) : ByteArray
      {
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:int = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:int = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc2_:int = 3238371032;
         var _loc3_:int = 914150663;
         var _loc4_:int = 812702999;
         var _loc5_:int = 4144912697;
         var _loc6_:int = 4290775857;
         var _loc7_:int = 1750603025;
         var _loc8_:int = 1694076839;
         var _loc9_:int = 3204075428;
         var _loc10_:Array = new Array(1116352408,1899447441,3049323471,3921009573,961987163,1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388,2162078206,2614888103,3248222580,3835390401,4022224774,264347078,604807628,770255983,1249150122,1555081692,1996064986,2554220882,2821834349,2952996808,3210313671,3336571891,3584528711,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,2177026350,2456956037,2730485921,2820302411,3259730800,3345764771,3516065817,3600352804,4094571909,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,2227730452,2361852424,2428436474,2756734187,3204031479,3329325298);
         var _loc11_:int = int(param1.length);
         var _loc12_:Array = new Array();
         var _loc13_:int = 0;
         while(_loc13_ < _loc11_)
         {
            _loc15_ = _loc2_;
            _loc16_ = _loc3_;
            _loc17_ = _loc4_;
            _loc18_ = _loc5_;
            _loc19_ = _loc6_;
            _loc20_ = _loc7_;
            _loc21_ = _loc8_;
            _loc22_ = _loc9_;
            _loc23_ = 0;
            while(_loc23_ < 64)
            {
               if(_loc23_ < 16)
               {
                  _loc12_[_loc23_] = param1[_loc13_ + _loc23_];
                  if(isNaN(_loc12_[_loc23_]))
                  {
                     _loc12_[_loc23_] = 0;
                  }
               }
               else
               {
                  _loc30_ = IntUtil.ror(_loc12_[_loc23_ - 15],7) ^ IntUtil.ror(_loc12_[_loc23_ - 15],18) ^ _loc12_[_loc23_ - 15] >>> 3;
                  _loc31_ = IntUtil.ror(_loc12_[_loc23_ - 2],17) ^ IntUtil.ror(_loc12_[_loc23_ - 2],19) ^ _loc12_[_loc23_ - 2] >>> 10;
                  _loc12_[_loc23_] = _loc12_[_loc23_ - 16] + _loc30_ + _loc12_[_loc23_ - 7] + _loc31_;
               }
               _loc24_ = IntUtil.ror(_loc15_,2) ^ IntUtil.ror(_loc15_,13) ^ IntUtil.ror(_loc15_,22);
               _loc25_ = _loc15_ & _loc16_ ^ _loc15_ & _loc17_ ^ _loc16_ & _loc17_;
               _loc26_ = _loc24_ + _loc25_;
               _loc27_ = IntUtil.ror(_loc19_,6) ^ IntUtil.ror(_loc19_,11) ^ IntUtil.ror(_loc19_,25);
               _loc28_ = _loc19_ & _loc20_ ^ ~_loc19_ & _loc21_;
               _loc29_ = _loc22_ + _loc27_ + _loc28_ + _loc10_[_loc23_] + _loc12_[_loc23_];
               _loc22_ = _loc21_;
               _loc21_ = _loc20_;
               _loc20_ = _loc19_;
               _loc19_ = _loc18_ + _loc29_;
               _loc18_ = _loc17_;
               _loc17_ = _loc16_;
               _loc16_ = _loc15_;
               _loc15_ = _loc29_ + _loc26_;
               _loc23_++;
            }
            _loc2_ += _loc15_;
            _loc3_ += _loc16_;
            _loc4_ += _loc17_;
            _loc5_ += _loc18_;
            _loc6_ += _loc19_;
            _loc7_ += _loc20_;
            _loc8_ += _loc21_;
            _loc9_ += _loc22_;
            _loc13_ += 16;
         }
         var _loc14_:ByteArray;
         (_loc14_ = new ByteArray()).writeInt(_loc2_);
         _loc14_.writeInt(_loc3_);
         _loc14_.writeInt(_loc4_);
         _loc14_.writeInt(_loc5_);
         _loc14_.writeInt(_loc6_);
         _loc14_.writeInt(_loc7_);
         _loc14_.writeInt(_loc8_);
         _loc14_.position = 0;
         digest = new ByteArray();
         digest.writeBytes(_loc14_);
         digest.position = 0;
         return _loc14_;
      }
      
      private static function createBlocksFromByteArray(param1:ByteArray) : Array
      {
         var _loc2_:int = int(param1.position);
         param1.position = 0;
         var _loc3_:Array = new Array();
         var _loc4_:int = param1.length * 8;
         var _loc5_:int = 255;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_[_loc6_ >> 5] |= (param1.readByte() & _loc5_) << 24 - _loc6_ % 32;
            _loc6_ += 8;
         }
         _loc3_[_loc4_ >> 5] |= 128 << 24 - _loc4_ % 32;
         _loc3_[(_loc4_ + 64 >> 9 << 4) + 15] = _loc4_;
         param1.position = _loc2_;
         return _loc3_;
      }
      
      private static function createBlocksFromString(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = param1.length * 8;
         var _loc4_:int = 255;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_[_loc5_ >> 5] |= (param1.charCodeAt(_loc5_ / 8) & _loc4_) << 24 - _loc5_ % 32;
            _loc5_ += 8;
         }
         _loc2_[_loc3_ >> 5] |= 128 << 24 - _loc3_ % 32;
         _loc2_[(_loc3_ + 64 >> 9 << 4) + 15] = _loc3_;
         return _loc2_;
      }
   }
}
