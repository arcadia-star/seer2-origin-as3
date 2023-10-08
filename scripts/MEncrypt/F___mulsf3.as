package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___mulsf3() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc14_:* = 0;
      var _loc9_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc2_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 32;
      _loc4_ = li32(_loc5_);
      var _loc13_:*;
      _loc12_ = (_loc13_ = (_loc14_ = li32(_loc5_ + 4)) ^ _loc4_) & -2147483648;
      _loc11_ = _loc14_ & 8388607;
      _loc10_ = _loc4_ & 8388607;
      _loc9_ = (_loc13_ = _loc14_ >>> 23) & 255;
      if((uint(_loc13_ = (_loc8_ = (_loc13_ = _loc4_ >>> 23) & 255) + -1)) <= 253)
      {
         _loc7_ = 0;
         if(uint(_loc9_ + -1) >= 254)
         {
            §§goto(addr97);
         }
         §§goto(addr466);
      }
      addr97:
      _loc2_ = _loc4_ & 2147483647;
      if(uint(_loc2_) >= 2139095041)
      {
         si32(_loc13_ = _loc4_ | 4194304,_loc5_ - 32);
         _loc1_ = lf32(_loc5_ - 32);
      }
      else if((uint(_loc4_ = _loc14_ & 2147483647)) >= 2139095041)
      {
         si32(_loc13_ = _loc14_ | 4194304,_loc5_ - 28);
         _loc1_ = lf32(_loc5_ - 28);
      }
      else if(_loc2_ == 2139095040)
      {
         _loc1_ = nan;
         if(_loc4_ != 0)
         {
            si32(_loc13_ = _loc12_ | _loc2_,_loc5_ - 24);
            _loc1_ = lf32(_loc5_ - 24);
         }
      }
      else if(_loc4_ == 2139095040)
      {
         _loc1_ = nan;
         if(_loc2_ != 0)
         {
            si32(_loc13_ = _loc12_ | _loc4_,_loc5_ - 20);
            _loc1_ = lf32(_loc5_ - 20);
         }
      }
      else if(_loc2_ == 0)
      {
         si32(_loc12_,_loc5_ - 16);
         _loc1_ = lf32(_loc5_ - 16);
      }
      else if(_loc4_ == 0)
      {
         si32(_loc12_,_loc5_ - 12);
         _loc1_ = lf32(_loc5_ - 12);
      }
      else
      {
         _loc7_ = 0;
         if(uint(_loc2_) <= 8388607)
         {
            var _loc6_:*;
            _loc10_ <<= (_loc6_ = (_loc13_ = (_loc13_ = (_loc13_ += (_loc13_ = ((_loc6_ = _loc13_ - ((_loc6_ = (_loc13_ = (_loc13_ |= (_loc13_ |= (_loc13_ |= (_loc13_ |= (_loc13_ = _loc10_ | _loc10_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc6_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + -8;
            _loc7_ = 9 - _loc6_;
         }
         if(uint(_loc4_) <= 8388607)
         {
            _loc13_ = (_loc13_ = (_loc13_ = (_loc13_ += (_loc13_ = ((_loc6_ = _loc13_ - ((_loc6_ = (_loc13_ = (_loc13_ = _loc6_ | (_loc6_ |= (_loc6_ |= (_loc6_ = _loc13_ | (_loc13_ = _loc11_ | _loc11_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc6_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
            _loc7_ = (_loc6_ = _loc7_ + 9) - _loc13_;
            _loc11_ <<= _loc13_ + -8;
            addr466:
            _loc3_ -= 16;
            si32(0,_loc3_ + 12);
            si32(0,_loc3_ + 4);
            si32(_loc13_ = _loc10_ | 8388608,_loc3_ + 8);
            si32(_loc13_ = (_loc13_ = _loc11_ << 8) | -2147483648,_loc3_);
            _loc14_ = (_loc13_ = _loc9_ + _loc8_) + _loc7_;
            ESP = _loc3_;
            F___muldi3();
            _loc3_ += 16;
            _loc2_ = eax;
            if((_loc13_ = (_loc8_ = edx) & 8388608) != 0)
            {
               _loc14_ += -126;
            }
            else
            {
               _loc8_ = (_loc13_ = _loc8_ << 1) | _loc2_ >>> 31;
               _loc2_ <<= 1;
               _loc14_ += -127;
            }
            if(_loc14_ >= 255)
            {
               si32(_loc13_ = _loc12_ | 2139095040,_loc5_ - 8);
               _loc1_ = lf32(_loc5_ - 8);
            }
            else
            {
               if(_loc14_ <= 0)
               {
                  if((uint(_loc14_ = 1 - _loc14_)) <= 31)
                  {
                     _loc9_ = 32 - _loc14_;
                     _loc10_ = 1;
                     if(_loc2_ << _loc9_ == 0)
                     {
                        _loc10_ = 0;
                     }
                     _loc13_ = _loc2_ >>> _loc14_;
                     _loc13_ = (_loc6_ = _loc8_ << _loc9_) | _loc13_;
                     _loc6_ = _loc10_ & 1;
                     _loc2_ = _loc13_ | _loc6_;
                     _loc9_ = _loc8_ >>> _loc14_;
                     addr699:
                     _loc8_ = 1;
                     if(uint(_loc2_) <= 2147483648)
                     {
                        _loc8_ = 0;
                     }
                     _loc13_ = _loc8_ & 1;
                     _loc12_ = (_loc6_ = _loc9_ | _loc12_) + _loc13_;
                     if(_loc2_ == -2147483648)
                     {
                        _loc12_ = (_loc13_ = _loc12_ & 1) + _loc12_;
                     }
                  }
                  else if(uint(_loc14_) <= 63)
                  {
                     _loc2_ = 1;
                     if(((_loc13_ = _loc8_ << 64 - _loc14_) | _loc2_) == (_loc9_ = 0))
                     {
                        _loc2_ = _loc9_;
                     }
                     _loc13_ = _loc14_ + -32;
                     _loc13_ = _loc8_ >>> _loc13_;
                     _loc2_ = (_loc6_ = _loc2_ & 1) | _loc13_;
                     §§goto(addr699);
                  }
                  si32(_loc12_,_loc5_ - 4);
                  _loc1_ = lf32(_loc5_ - 4);
                  §§goto(addr746);
               }
               else
               {
                  _loc9_ = (_loc6_ = _loc14_ << 23) | _loc8_ & 8388607;
               }
               §§goto(addr699);
            }
         }
         §§goto(addr466);
      }
      addr746:
      st0 = _loc1_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
