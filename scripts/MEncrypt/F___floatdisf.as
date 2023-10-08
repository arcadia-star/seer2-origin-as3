package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___floatdisf() : void
   {
      var _loc4_:* = 0;
      var _loc12_:* = 0;
      var _loc2_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = li32(_loc4_ + 4);
      _loc11_ = (_loc12_ = li32(_loc4_)) | _loc2_;
      _loc1_ = 0;
      if(_loc11_ != 0)
      {
         _loc9_ = (_loc10_ = _loc2_ >> 31) ^ _loc12_;
         _loc12_ = 1;
         if(uint(_loc9_) >= uint(_loc10_))
         {
            _loc12_ = 0;
         }
         _loc11_ = (_loc8_ = (_loc11_ = (_loc11_ = _loc10_ ^ _loc2_) - _loc10_) - _loc12_) >>> 1;
         var _loc7_:* = (_loc11_ = _loc8_ | _loc11_) >>> 2;
         _loc7_ = (_loc11_ |= _loc7_) >>> 4;
         _loc7_ = (_loc11_ |= _loc7_) >>> 8;
         _loc7_ = (_loc11_ |= _loc7_) >>> 16;
         _loc7_ = (_loc7_ = (_loc11_ = (_loc11_ |= _loc7_) ^ -1) >>> 1) & 1431655765;
         _loc11_ = (_loc7_ = _loc11_ - _loc7_) & 858993459;
         _loc7_ = (_loc7_ >>>= 2) & 858993459;
         _loc7_ = (_loc11_ += _loc7_) >>> 4;
         _loc12_ = (_loc11_ = (_loc11_ = (_loc11_ += _loc7_) & 252645135) * 16843009) >>> 24;
         _loc6_ = _loc9_ - _loc10_;
         if(_loc8_ == 0)
         {
            _loc7_ = ((_loc7_ = _loc11_ - ((_loc7_ = (_loc11_ = (_loc11_ |= (_loc11_ |= (_loc11_ |= (_loc11_ |= (_loc11_ = _loc6_ | _loc6_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc7_ >>>= 2) & 858993459);
            _loc12_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = _loc7_ + (_loc7_ >>> 4)) & 252645135) * 16843009) >>> 24) + 32;
         }
         _loc2_ = 63 - _loc12_;
         if((_loc12_ = 64 - _loc12_) >= 25)
         {
            if(_loc12_ != 26)
            {
               if(_loc12_ == 25)
               {
                  _loc8_ = (_loc7_ = _loc8_ << 1) | _loc6_ >>> 31;
                  _loc6_ <<= 1;
               }
               else
               {
                  _loc3_ -= 16;
                  si32(_loc11_ = _loc12_ + -26,_loc3_ + 8);
                  si32(_loc6_,_loc3_);
                  si32(_loc8_,_loc3_ + 4);
                  ESP = _loc3_;
                  F___lshrdi3();
                  _loc3_ += 16;
                  _loc9_ = eax;
                  _loc5_ = edx;
                  _loc3_ -= 16;
                  si32(_loc11_ = 90 - _loc12_,_loc3_ + 8);
                  si32(-1,_loc3_ + 4);
                  si32(-1,_loc3_);
                  ESP = _loc3_;
                  F___lshrdi3();
                  _loc3_ += 16;
                  _loc11_ = (_loc11_ = edx) & _loc8_;
                  _loc8_ = 1;
                  if(((_loc7_ = eax & _loc6_) | _loc11_) == 0)
                  {
                     _loc8_ = 0;
                  }
                  _loc6_ = (_loc11_ = _loc8_ & 1) | _loc9_;
                  _loc8_ = _loc5_;
               }
            }
            _loc9_ = (_loc11_ = (_loc11_ = (_loc11_ = _loc6_ >>> 2) & 1) | _loc6_) + 1;
            _loc6_ = _loc5_ = 1;
            if(uint(_loc9_) >= uint(_loc11_))
            {
               _loc6_ = 0;
            }
            if(_loc9_ != 0)
            {
               _loc5_ = _loc6_;
            }
            _loc11_ = (_loc8_ += _loc5_) << 30;
            if((_loc11_ = (_loc9_ = (_loc7_ = _loc9_ >>> 2) | _loc11_) & 16777216) != 0)
            {
               _loc11_ = _loc9_ >>> 1;
               _loc9_ = _loc11_ | _loc8_ >> 2 << 31;
               _loc2_ = _loc12_;
            }
         }
         else
         {
            _loc3_ -= 16;
            si32(_loc6_,_loc3_);
            si32(_loc11_ = 24 - _loc12_,_loc3_ + 8);
            si32(_loc8_,_loc3_ + 4);
            ESP = _loc3_;
            F___ashldi3();
            _loc3_ += 16;
            _loc9_ = eax;
         }
         _loc7_ = _loc10_ & -2147483648;
         _loc11_ = (_loc11_ = _loc9_ & 8388607) | _loc7_;
         _loc7_ = (_loc7_ = _loc2_ << 23) + 1065353216;
         si32(_loc11_ |= _loc7_,_loc4_ - 4);
         _loc1_ = lf32(_loc4_ - 4);
      }
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
