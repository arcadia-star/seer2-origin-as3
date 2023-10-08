package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___muldf3() : void
   {
      var _loc10_:int = 0;
      var _loc23_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = 0;
      var _loc3_:* = 0;
      var _loc22_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc19_:* = 0;
      var _loc20_:* = 0;
      var _loc17_:* = 0;
      var _loc21_:* = 0;
      var _loc18_:* = NaN;
      var _loc5_:* = (_loc10_ = ESP) - 80;
      _loc23_ = li32(_loc6_ = (_loc6_ = _loc10_) | 4);
      _loc21_ = (_loc6_ = (_loc22_ = li32(_loc6_ = (_loc6_ = _loc10_ + 8) | 4)) ^ _loc23_) & -2147483648;
      _loc20_ = _loc22_ & 1048575;
      _loc19_ = _loc23_ & 1048575;
      _loc17_ = (_loc6_ = _loc22_ >>> 20) & 2047;
      _loc6_ = (_loc16_ = (_loc6_ = _loc23_ >>> 20) & 2047) + -1;
      _loc15_ = li32(_loc10_ + 8);
      _loc1_ = li32(_loc10_);
      if(uint(_loc6_) <= 2045)
      {
         _loc11_ = 0;
         if(uint(_loc17_ + -1) >= 2046)
         {
            §§goto(addr136);
         }
         §§goto(addr919);
      }
      addr136:
      _loc12_ = _loc23_ & 2147483647;
      _loc11_ = _loc13_ = 1;
      if(uint(_loc12_) >= 2146435072)
      {
         _loc11_ = 0;
      }
      if(_loc1_ != 0)
      {
         _loc13_ = 0;
      }
      if(_loc12_ != 2146435072)
      {
         _loc13_ = _loc11_;
      }
      if(_loc13_ == 0)
      {
         si32(_loc6_ = _loc23_ | 524288,(_loc6_ = _loc10_ - 72) | 4);
         si32(_loc1_,_loc10_ - 72);
         _loc18_ = lf64(_loc10_ - 72);
      }
      else
      {
         _loc23_ = _loc22_ & 2147483647;
         _loc11_ = _loc13_ = 1;
         if(uint(_loc23_) >= 2146435072)
         {
            _loc11_ = 0;
         }
         if(_loc15_ != 0)
         {
            _loc13_ = 0;
         }
         if(_loc23_ != 2146435072)
         {
            _loc13_ = _loc11_;
         }
         if(_loc13_ == 0)
         {
            si32(_loc6_ = _loc22_ | 524288,(_loc6_ = _loc10_ - 64) | 4);
            si32(_loc15_,_loc10_ - 64);
            _loc18_ = lf64(_loc10_ - 64);
         }
         else if((_loc6_ = _loc1_ | _loc12_ ^ 2146435072) == 0)
         {
            _loc18_ = nan;
            if((_loc15_ | _loc23_) != 0)
            {
               var _loc14_:*;
               si32(_loc21_ | _loc12_,(_loc14_ = _loc10_ - 56) | 4);
               si32(_loc6_ = 0 | _loc1_,_loc10_ - 56);
               _loc18_ = lf64(_loc10_ - 56);
            }
         }
         else if((_loc6_ = _loc15_ | _loc23_ ^ 2146435072) == 0)
         {
            _loc18_ = nan;
            if((_loc1_ | _loc12_) != 0)
            {
               si32(_loc21_ | _loc23_,(_loc14_ = _loc10_ - 48) | 4);
               si32(_loc6_ = 0 | _loc15_,_loc10_ - 48);
               _loc18_ = lf64(_loc10_ - 48);
            }
         }
         else if((_loc6_ = _loc1_ | _loc12_) == 0)
         {
            si32(_loc21_,(_loc6_ = _loc10_ - 40) | 4);
            si32(0,_loc10_ - 40);
            _loc18_ = lf64(_loc10_ - 40);
         }
         else if((_loc6_ = _loc15_ | _loc23_) == 0)
         {
            si32(_loc21_,(_loc6_ = _loc10_ - 32) | 4);
            si32(0,_loc10_ - 32);
            _loc18_ = lf64(_loc10_ - 32);
         }
         else
         {
            _loc11_ = 0;
            if(uint(_loc12_) <= 1048575)
            {
               if(_loc19_ != 0)
               {
                  _loc11_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc19_ | _loc19_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
               }
               else
               {
                  _loc11_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ = _loc6_ | (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ = _loc1_ | _loc1_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 32;
               }
               _loc5_ -= 16;
               si32(_loc1_,_loc5_);
               si32(_loc6_ = _loc11_ + -11,_loc5_ + 8);
               si32(_loc19_,_loc5_ + 4);
               ESP = _loc5_;
               F___ashldi3();
               _loc11_ = 12 - _loc11_;
               _loc5_ += 16;
               _loc1_ = eax;
               _loc19_ = edx;
            }
            if(uint(_loc23_) <= 1048575)
            {
               if(_loc20_ != 0)
               {
                  _loc12_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc20_ | _loc20_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
               }
               else
               {
                  _loc14_ = ((_loc14_ = _loc6_ - ((_loc14_ = (_loc6_ = (_loc6_ = _loc14_ | (_loc14_ |= (_loc14_ |= (_loc14_ |= (_loc14_ = _loc15_ | _loc15_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc14_ >>>= 2) & 858993459);
                  _loc12_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = _loc14_ + (_loc14_ >>> 4)) & 252645135) * 16843009) >>> 24) + 32;
               }
               _loc5_ -= 16;
               si32(_loc15_,_loc5_);
               si32(_loc6_ = _loc12_ + -11,_loc5_ + 8);
               si32(_loc20_,_loc5_ + 4);
               _loc11_ = (_loc6_ = _loc11_ + 12) - _loc12_;
               ESP = _loc5_;
               F___ashldi3();
               _loc5_ += 16;
               _loc15_ = eax;
               _loc20_ = edx;
               addr919:
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(0,_loc5_ + 4);
               si32(_loc6_ = _loc19_ | 1048576,_loc5_ + 8);
               _loc14_ = _loc15_ >>> 21;
               var _loc4_:* = _loc20_ << 11;
               si32(_loc14_ = (_loc14_ |= _loc4_) | -2147483648,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc20_ = eax;
               _loc19_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc4_ = _loc15_ << 11,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc6_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc6_ = eax;
               _loc12_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc1_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc14_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc23_ = eax;
               _loc13_ = edx;
               _loc5_ -= 16;
               si32(0,_loc5_ + 12);
               si32(_loc1_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(_loc4_,_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc6_ &= -2048;
               _loc5_ += 16;
               _loc15_ = eax;
               _loc7_ = edx;
               _loc8_ = _loc6_ + _loc7_;
               _loc1_ = _loc22_ = 1;
               if(uint(_loc8_) >= uint(_loc6_))
               {
                  _loc1_ = 0;
               }
               _loc9_ = _loc22_;
               if(uint(_loc8_) >= uint(_loc7_))
               {
                  _loc9_ = _loc1_;
               }
               _loc1_ = _loc8_ + _loc23_;
               _loc7_ = _loc22_;
               if(uint(_loc1_) >= uint(_loc8_))
               {
                  _loc7_ = 0;
               }
               _loc8_ = _loc22_;
               if(uint(_loc1_) >= uint(_loc23_))
               {
                  _loc8_ = _loc7_;
               }
               _loc3_ = _loc9_ + _loc8_;
               _loc23_ = (_loc7_ = (_loc9_ = _loc12_ + _loc20_) + _loc13_) + _loc3_;
               _loc2_ = _loc22_;
               if(uint(_loc23_) >= uint(_loc7_))
               {
                  _loc2_ = 0;
               }
               _loc8_ = _loc22_;
               if(uint(_loc23_) >= uint(_loc3_))
               {
                  _loc8_ = _loc2_;
               }
               _loc3_ = _loc22_;
               if(uint(_loc7_) >= uint(_loc9_))
               {
                  _loc3_ = 0;
               }
               _loc2_ = _loc22_;
               if(uint(_loc7_) >= uint(_loc13_))
               {
                  _loc2_ = _loc3_;
               }
               _loc13_ = _loc22_;
               if(uint(_loc9_) >= uint(_loc12_))
               {
                  _loc13_ = 0;
               }
               if(uint(_loc9_) >= uint(_loc20_))
               {
                  _loc22_ = _loc13_;
               }
               _loc14_ = (_loc20_ = (_loc6_ = (_loc6_ = _loc19_ + _loc22_) + _loc2_) + _loc8_) & 1048576;
               _loc16_ = (_loc6_ = _loc17_ + _loc16_) + _loc11_;
               _loc17_ = _loc15_ & -2048;
               if(_loc14_ != 0)
               {
                  _loc16_ += -1022;
               }
               else
               {
                  _loc1_ = (_loc4_ = _loc1_ << 1) | _loc17_ >>> 31;
                  _loc20_ = (_loc4_ = _loc20_ << 1) | _loc23_ >>> 31;
                  _loc17_ <<= 1;
                  _loc16_ += -1023;
                  _loc23_ = (_loc6_ = _loc23_ << 1) | _loc1_ >>> 31;
               }
               if(_loc16_ >= 2047)
               {
                  si32(_loc14_ = _loc21_ | 2146435072,(_loc6_ = _loc10_ - 24) | 4);
                  si32(0,_loc10_ - 24);
                  _loc18_ = lf64(_loc10_ - 24);
               }
               else
               {
                  if(_loc16_ <= 0)
                  {
                     if((uint(_loc15_ = 1 - _loc16_)) >= 64)
                     {
                        si32(_loc21_,(_loc6_ = _loc10_ - 16) | 4);
                        si32(0,_loc10_ - 16);
                        _loc18_ = lf64(_loc10_ - 16);
                        §§goto(addr1713);
                     }
                     else
                     {
                        _loc5_ -= 16;
                        si32(_loc15_,_loc5_ + 8);
                        si32(_loc23_,_loc5_);
                        si32(_loc20_,_loc5_ + 4);
                        ESP = _loc5_;
                        F___lshrdi3();
                        _loc5_ += 16;
                        _loc11_ = eax;
                        _loc16_ = edx;
                        _loc5_ -= 16;
                        si32(_loc6_ = 64 - _loc15_,_loc5_ + 8);
                        si32(_loc20_,_loc5_ + 4);
                        si32(_loc23_,_loc5_);
                        ESP = _loc5_;
                        F___ashldi3();
                        _loc5_ += 16;
                        _loc19_ = eax;
                        _loc20_ = edx;
                        _loc5_ -= 16;
                        si32(_loc15_,_loc5_ + 8);
                        si32(_loc1_,_loc5_ + 4);
                        si32(_loc17_,_loc5_);
                        ESP = _loc5_;
                        F___lshrdi3();
                        _loc5_ += 16;
                        _loc12_ = eax;
                        _loc15_ = edx;
                        _loc5_ -= 16;
                        si32(_loc6_,_loc5_ + 8);
                        si32(_loc1_,_loc5_ + 4);
                        si32(_loc17_,_loc5_);
                        ESP = _loc5_;
                        F___ashldi3();
                        _loc5_ += 16;
                        _loc1_ = 1;
                        if((eax | edx) == 0)
                        {
                           _loc1_ = 0;
                        }
                        _loc6_ = _loc1_ & 1;
                        _loc17_ = (_loc14_ = _loc19_ | _loc12_) | _loc6_;
                        _loc1_ = _loc20_ | _loc15_;
                     }
                     §§goto(addr1713);
                  }
                  else
                  {
                     _loc16_ = _loc16_ << 20 | _loc20_ & 1048575;
                     _loc11_ = _loc23_;
                  }
                  _loc15_ = _loc20_ = 1;
                  if(uint(_loc1_) <= 2147483648)
                  {
                     _loc15_ = 0;
                  }
                  _loc19_ = _loc20_;
                  if(_loc17_ == 0)
                  {
                     _loc19_ = 0;
                  }
                  if(_loc1_ != -2147483648)
                  {
                     _loc19_ = _loc15_;
                  }
                  _loc19_ &= 1;
                  _loc11_ = (_loc6_ = _loc11_ | 0) + _loc19_;
                  _loc15_ = _loc20_;
                  if(uint(_loc11_) >= uint(_loc6_))
                  {
                     _loc15_ = 0;
                  }
                  if(uint(_loc11_) >= uint(_loc19_))
                  {
                     _loc20_ = _loc15_;
                  }
                  _loc21_ = (_loc6_ = _loc16_ | _loc21_) + _loc20_;
                  _loc6_ = _loc1_ ^ -2147483648;
                  if((_loc6_ = _loc17_ | _loc6_) == 0)
                  {
                     _loc16_ = (_loc6_ = _loc11_ & 1) + _loc11_;
                     _loc1_ = 1;
                     _loc17_ = _loc1_;
                     if(uint(_loc16_) >= uint(_loc6_))
                     {
                        _loc17_ = 0;
                     }
                     if(uint(_loc16_) >= uint(_loc11_))
                     {
                        _loc1_ = _loc17_;
                     }
                     _loc21_ += _loc1_;
                     _loc11_ = _loc16_;
                  }
                  _loc6_ = (_loc6_ = _loc10_ - 8) | 4;
                  si32(_loc21_,_loc6_);
                  si32(_loc11_,_loc10_ - 8);
                  _loc18_ = lf64(_loc10_ - 8);
               }
            }
            §§goto(addr919);
         }
      }
      addr1713:
      st0 = _loc18_;
      ESP = _loc5_ = _loc10_;
   }
}
