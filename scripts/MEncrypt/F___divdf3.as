package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___divdf3() : void
   {
      var _loc10_:int = 0;
      var _loc1_:* = 0;
      var _loc22_:* = 0;
      var _loc6_:* = 0;
      var _loc15_:* = 0;
      var _loc21_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:* = 0;
      var _loc23_:* = 0;
      var _loc3_:* = 0;
      var _loc24_:* = 0;
      var _loc20_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = 0;
      var _loc16_:* = 0;
      var _loc7_:* = 0;
      var _loc18_:* = 0;
      var _loc17_:* = 0;
      var _loc19_:* = NaN;
      var _loc5_:* = (_loc10_ = ESP) - 80;
      _loc24_ = li32(_loc6_ = (_loc6_ = _loc10_) | 4);
      _loc22_ = (_loc6_ = (_loc23_ = li32(_loc6_ = (_loc6_ = _loc10_ + 8) | 4)) ^ _loc24_) & -2147483648;
      _loc21_ = _loc23_ & 1048575;
      _loc20_ = _loc24_ & 1048575;
      _loc18_ = (_loc6_ = _loc23_ >>> 20) & 2047;
      _loc6_ = (_loc17_ = (_loc6_ = _loc24_ >>> 20) & 2047) + -1;
      _loc15_ = li32(_loc10_ + 8);
      _loc1_ = li32(_loc10_);
      if(uint(_loc6_) <= 2045)
      {
         _loc11_ = 0;
         if(uint(_loc18_ + -1) >= 2046)
         {
            §§goto(addr138);
         }
         §§goto(addr923);
      }
      addr138:
      _loc12_ = _loc24_ & 2147483647;
      _loc13_ = _loc11_ = 1;
      if(uint(_loc12_) >= 2146435072)
      {
         _loc13_ = 0;
      }
      if(_loc1_ != 0)
      {
         _loc11_ = 0;
      }
      if(_loc12_ != 2146435072)
      {
         _loc11_ = _loc13_;
      }
      if(_loc11_ == 0)
      {
         si32(_loc6_ = _loc24_ | 524288,(_loc6_ = _loc10_ - 72) | 4);
         si32(_loc1_,_loc10_ - 72);
         _loc19_ = lf64(_loc10_ - 72);
      }
      else
      {
         _loc24_ = _loc23_ & 2147483647;
         _loc13_ = _loc11_ = 1;
         if(uint(_loc24_) >= 2146435072)
         {
            _loc13_ = 0;
         }
         if(_loc15_ != 0)
         {
            _loc11_ = 0;
         }
         if(_loc24_ != 2146435072)
         {
            _loc11_ = _loc13_;
         }
         if(_loc11_ == 0)
         {
            si32(_loc6_ = _loc23_ | 524288,(_loc6_ = _loc10_ - 64) | 4);
            si32(_loc15_,_loc10_ - 64);
            _loc19_ = lf64(_loc10_ - 64);
         }
         else if((_loc6_ = _loc1_ | _loc12_ ^ 2146435072) == 0)
         {
            _loc19_ = nan;
            if((_loc15_ | _loc24_ ^ 2146435072) != 0)
            {
               var _loc14_:*;
               si32(_loc22_ | _loc12_,(_loc14_ = _loc10_ - 56) | 4);
               si32(_loc6_ = 0 | _loc1_,_loc10_ - 56);
               _loc19_ = lf64(_loc10_ - 56);
            }
         }
         else if((_loc6_ = _loc15_ | _loc24_ ^ 2146435072) == 0)
         {
            si32(_loc22_,(_loc6_ = _loc10_ - 48) | 4);
            si32(0,_loc10_ - 48);
            _loc19_ = lf64(_loc10_ - 48);
         }
         else if((_loc6_ = _loc1_ | _loc12_) == 0)
         {
            _loc19_ = nan;
            if((_loc15_ | _loc24_) != 0)
            {
               si32(_loc22_,(_loc6_ = _loc10_ - 40) | 4);
               si32(0,_loc10_ - 40);
               _loc19_ = lf64(_loc10_ - 40);
            }
         }
         else if((_loc6_ = _loc15_ | _loc24_) == 0)
         {
            si32(_loc6_ = _loc22_ | 2146435072,(_loc6_ = _loc10_ - 32) | 4);
            si32(0,_loc10_ - 32);
            _loc19_ = lf64(_loc10_ - 32);
         }
         else
         {
            _loc11_ = 0;
            if(uint(_loc12_) <= 1048575)
            {
               if(_loc20_ != 0)
               {
                  _loc14_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc20_ | _loc20_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459);
                  _loc11_ = (_loc6_ = (_loc6_ = (_loc6_ = _loc14_ + (_loc14_ >>> 4)) & 252645135) * 16843009) >>> 24;
               }
               else
               {
                  _loc14_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ = _loc6_ | (_loc6_ = _loc14_ | (_loc14_ = _loc1_ | _loc1_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459);
                  _loc11_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = _loc14_ + (_loc14_ >>> 4)) & 252645135) * 16843009) >>> 24) + 32;
               }
               _loc5_ -= 16;
               si32(_loc1_,_loc5_);
               si32(_loc6_ = _loc11_ + -11,_loc5_ + 8);
               si32(_loc20_,_loc5_ + 4);
               ESP = _loc5_;
               F___ashldi3();
               _loc11_ = 12 - _loc11_;
               _loc5_ += 16;
               _loc1_ = eax;
               _loc20_ = edx;
            }
            if(uint(_loc24_) <= 1048575)
            {
               if(_loc21_ != 0)
               {
                  _loc12_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc21_ | _loc21_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
               }
               else
               {
                  _loc12_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc15_ | _loc15_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 32;
               }
               _loc5_ -= 16;
               si32(_loc15_,_loc5_);
               si32(_loc6_ = _loc12_ + -11,_loc5_ + 8);
               si32(_loc21_,_loc5_ + 4);
               _loc11_ = (_loc6_ = _loc11_ + _loc12_) + -12;
               ESP = _loc5_;
               F___ashldi3();
               _loc5_ += 16;
               _loc15_ = eax;
               _loc21_ = edx;
               addr923:
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(0,_loc5_ + 4);
               _loc6_ = _loc15_ >>> 21;
               _loc14_ = (_loc21_ |= 1048576) << 11;
               si32(_loc6_ |= _loc14_,_loc5_ + 8);
               var _loc4_:*;
               si32(_loc4_ = 1963258675 - _loc6_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc4_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc14_ = 0 - _loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc4_ = eax;
               _loc14_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               _loc14_ <<= 1;
               si32(_loc4_ = (_loc4_ >>>= 31) | _loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc4_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc14_ = 0 - _loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = eax;
               _loc4_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               _loc4_ <<= 1;
               si32(_loc4_ = (_loc14_ >>>= 31) | _loc4_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc4_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc14_ = 0 - _loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = eax;
               _loc4_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               _loc6_ = _loc4_ << 1;
               si32(_loc7_ = (_loc6_ = (_loc14_ >>>= 31) | _loc6_) + -1,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = eax;
               _loc24_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_ = _loc15_ << 11,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc7_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc8_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc7_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               _loc13_ = _loc14_ + _loc8_;
               _loc9_ = _loc12_ = 1;
               if(uint(_loc13_) >= uint(_loc14_))
               {
                  _loc9_ = 0;
               }
               _loc23_ = _loc12_;
               if(uint(_loc13_) >= uint(_loc8_))
               {
                  _loc23_ = _loc9_;
               }
               _loc9_ = _loc12_;
               if(_loc13_ == 0)
               {
                  _loc9_ = 0;
               }
               _loc6_ = _loc24_ + _loc23_;
               si32(_loc6_ = (_loc6_ = 0 - _loc6_) - _loc9_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc24_ = eax;
               _loc23_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc7_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc6_ = 0 - _loc13_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc7_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               _loc6_ = _loc1_ >>> 30;
               _loc14_ = _loc20_ << 2;
               si32(_loc13_ = (_loc6_ |= _loc14_) | 4194304,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               _loc20_ = (_loc8_ = _loc24_ + _loc7_) + -2;
               _loc3_ = _loc12_;
               if(uint(_loc20_) >= uint(_loc8_))
               {
                  _loc3_ = 0;
               }
               _loc9_ = _loc12_;
               if(uint(_loc20_) >= 4294967294)
               {
                  _loc9_ = _loc3_;
               }
               _loc3_ = _loc12_;
               if(uint(_loc8_) >= uint(_loc24_))
               {
                  _loc3_ = 0;
               }
               _loc24_ = _loc12_;
               if(uint(_loc8_) >= uint(_loc7_))
               {
                  _loc24_ = _loc3_;
               }
               si32(_loc14_ = (_loc6_ = (_loc6_ = _loc23_ + _loc24_) + _loc9_) + -1,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc23_ = eax;
               _loc24_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc13_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc20_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc8_ = eax;
               _loc13_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_ = _loc1_ << 2,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc14_ = eax;
               _loc7_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc6_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc20_,_loc5_);
               _loc9_ = (_loc6_ = _loc14_ & -4) + _loc8_;
               _loc3_ = _loc12_;
               if(uint(_loc9_) >= uint(_loc6_))
               {
                  _loc3_ = 0;
               }
               _loc20_ = _loc12_;
               if(uint(_loc9_) >= uint(_loc8_))
               {
                  _loc20_ = _loc3_;
               }
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc3_ = edx;
               _loc2_ = _loc9_ + _loc3_;
               _loc8_ = _loc12_;
               if(uint(_loc2_) >= uint(_loc9_))
               {
                  _loc8_ = 0;
               }
               _loc9_ = _loc12_;
               if(uint(_loc2_) >= uint(_loc3_))
               {
                  _loc9_ = _loc8_;
               }
               _loc16_ = _loc20_ + _loc9_;
               _loc3_ = (_loc8_ = _loc13_ + _loc23_) + _loc7_;
               _loc20_ = _loc3_ + _loc16_;
               _loc2_ = _loc12_;
               if(uint(_loc20_) >= uint(_loc3_))
               {
                  _loc2_ = 0;
               }
               _loc9_ = _loc12_;
               if(uint(_loc20_) >= uint(_loc16_))
               {
                  _loc9_ = _loc2_;
               }
               _loc16_ = _loc12_;
               if(uint(_loc3_) >= uint(_loc8_))
               {
                  _loc16_ = 0;
               }
               _loc2_ = _loc12_;
               if(uint(_loc3_) >= uint(_loc7_))
               {
                  _loc2_ = _loc16_;
               }
               _loc7_ = _loc12_;
               if(uint(_loc8_) >= uint(_loc13_))
               {
                  _loc7_ = 0;
               }
               if(uint(_loc8_) >= uint(_loc23_))
               {
                  _loc12_ = _loc7_;
               }
               _loc12_ = (_loc6_ = (_loc6_ = _loc24_ + _loc12_) + _loc2_) + _loc9_;
               _loc6_ = _loc17_ - _loc18_;
               _loc17_ = _loc11_ + _loc6_;
               if(uint(_loc12_) <= 2097151)
               {
                  _loc5_ -= 16;
                  si32(_loc15_,_loc5_ + 8);
                  si32(_loc20_,_loc5_);
                  si32(_loc21_,_loc5_ + 12);
                  si32(_loc12_,_loc5_ + 4);
                  ESP = _loc5_;
                  F___muldi3();
                  _loc23_ = 1;
                  _loc5_ += 16;
                  _loc11_ = eax;
                  _loc18_ = edx;
                  if(_loc11_ == 0)
                  {
                     _loc23_ = 0;
                  }
                  _loc18_ = (_loc6_ = (_loc6_ = _loc1_ << 21) - _loc18_) - _loc23_;
                  _loc17_ += -1;
                  _loc23_ = 0 - _loc11_;
               }
               else
               {
                  _loc5_ -= 16;
                  si32(_loc15_,_loc5_ + 8);
                  si32(_loc21_,_loc5_ + 12);
                  si32(_loc11_ = _loc12_ >>> 1,_loc5_ + 4);
                  si32(_loc20_ = _loc20_ >>> 1 | _loc12_ << 31,_loc5_);
                  ESP = _loc5_;
                  F___muldi3();
                  _loc18_ = 1;
                  _loc5_ += 16;
                  _loc12_ = eax;
                  _loc23_ = edx;
                  if(_loc12_ == 0)
                  {
                     _loc18_ = 0;
                  }
                  _loc18_ = (_loc6_ = (_loc6_ = _loc1_ << 20) - _loc23_) - _loc18_;
                  _loc23_ = 0 - _loc12_;
                  _loc12_ = _loc11_;
               }
               _loc1_ = _loc17_ + 1023;
               if(_loc1_ >= 2047)
               {
                  si32(_loc6_ = _loc22_ | 2146435072,(_loc6_ = _loc10_ - 24) | 4);
                  si32(0,_loc10_ - 24);
                  _loc19_ = lf64(_loc10_ - 24);
               }
               else if(_loc1_ <= 0)
               {
                  si32(_loc22_,(_loc6_ = _loc10_ - 16) | 4);
                  si32(0,_loc10_ - 16);
                  _loc19_ = lf64(_loc10_ - 16);
               }
               else
               {
                  _loc11_ = _loc17_ = 1;
                  if(uint(_loc23_ << 1) <= uint(_loc15_))
                  {
                     _loc11_ = 0;
                  }
                  _loc6_ = _loc23_ >>> 31;
                  _loc15_ = (_loc14_ = _loc18_ << 1) | _loc6_;
                  _loc18_ = _loc17_;
                  if(uint(_loc15_) <= uint(_loc21_))
                  {
                     _loc18_ = 0;
                  }
                  if(_loc15_ != _loc21_)
                  {
                     _loc11_ = _loc18_;
                  }
                  _loc21_ = (_loc6_ = _loc11_ & 1) + _loc20_;
                  _loc15_ = _loc17_;
                  if(uint(_loc21_) >= uint(_loc6_))
                  {
                     _loc15_ = 0;
                  }
                  if(uint(_loc21_) >= uint(_loc20_))
                  {
                     _loc17_ = _loc15_;
                  }
                  _loc14_ = _loc1_ << 20;
                  _loc6_ = _loc12_ & 1048575;
                  _loc6_ = (_loc6_ = (_loc6_ = _loc14_ | _loc6_) + _loc17_) | _loc22_;
                  _loc14_ = (_loc14_ = _loc10_ - 8) | 4;
                  si32(_loc6_,_loc14_);
                  si32(_loc6_ = _loc21_ | 0,_loc10_ - 8);
                  _loc19_ = lf64(_loc10_ - 8);
               }
            }
            §§goto(addr923);
         }
      }
      st0 = _loc19_;
      ESP = _loc5_ = _loc10_;
   }
}
