package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___adddf3() : void
   {
      var _loc4_:* = 0;
      var _loc13_:* = NaN;
      var _loc18_:* = 0;
      var _loc12_:* = 0;
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc17_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc14_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = NaN;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 64;
      sf64(_loc13_ = lf64(_loc4_),_loc4_ - 8);
      sf64(_loc11_ = lf64(_loc4_ + 8),_loc4_ - 16);
      _loc3_ = li32(_loc4_ - 8);
      _loc18_ = _loc3_ + -1;
      _loc16_ = _loc17_ = 1;
      if(uint(_loc18_) >= uint(_loc3_))
      {
         _loc16_ = 0;
      }
      _loc15_ = _loc17_;
      if(_loc3_ == 0)
      {
         _loc15_ = _loc16_;
      }
      _loc15_ = (_loc18_ = (_loc12_ = (_loc14_ = li32(_loc18_ = (_loc18_ = _loc4_ - 8) | 4)) & 2147483647) + _loc15_) + -1;
      _loc16_ = _loc17_;
      if(uint(_loc15_) <= 2146435071)
      {
         _loc16_ = 0;
      }
      if(_loc3_ != 0)
      {
         _loc17_ = 0;
      }
      if(_loc15_ != 2146435071)
      {
         _loc17_ = _loc16_;
      }
      _loc10_ = (_loc15_ = li32(_loc18_ = (_loc18_ = _loc4_ - 16) | 4)) & 2147483647;
      _loc16_ = li32(_loc4_ - 16);
      if(_loc17_ == 0)
      {
         _loc9_ = _loc17_ = 1;
         if(uint(_loc16_ + -1) >= uint(_loc16_))
         {
            _loc9_ = 0;
         }
         _loc1_ = _loc17_;
         if(_loc16_ == 0)
         {
            _loc1_ = _loc9_;
         }
         _loc9_ = (_loc18_ = _loc10_ + _loc1_) + -1;
         _loc1_ = _loc17_;
         if(uint(_loc9_) >= 2146435071)
         {
            _loc1_ = 0;
         }
         if(_loc16_ == 0)
         {
            _loc17_ = 0;
         }
         if(_loc9_ != 2146435071)
         {
            _loc17_ = _loc1_;
         }
         if(_loc17_ == 0)
         {
            §§goto(addr221);
         }
         §§goto(addr424);
      }
      addr221:
      _loc17_ = _loc9_ = 1;
      if(uint(_loc12_) >= 2146435072)
      {
         _loc17_ = 0;
      }
      if(_loc3_ != 0)
      {
         _loc9_ = 0;
      }
      if(_loc12_ != 2146435072)
      {
         _loc9_ = _loc17_;
      }
      if(_loc9_ == 0)
      {
         si32(_loc18_ = _loc14_ | 524288,(_loc18_ = _loc4_ - 56) | 4);
         si32(_loc3_,_loc4_ - 56);
         _loc11_ = lf64(_loc4_ - 56);
      }
      else
      {
         _loc17_ = _loc9_ = 1;
         if(uint(_loc10_) >= 2146435072)
         {
            _loc17_ = 0;
         }
         if(_loc16_ != 0)
         {
            _loc9_ = 0;
         }
         if(_loc10_ != 2146435072)
         {
            _loc9_ = _loc17_;
         }
         if(_loc9_ == 0)
         {
            si32(_loc18_ = _loc15_ | 524288,(_loc18_ = _loc4_ - 48) | 4);
            si32(_loc16_,_loc4_ - 48);
            _loc11_ = lf64(_loc4_ - 48);
         }
         else if((_loc18_ = _loc3_ | _loc12_ ^ 2146435072) == 0)
         {
            _loc11_ = _loc13_;
            var _loc5_:*;
            if((_loc16_ ^ _loc3_ | (_loc5_ = _loc15_ ^ _loc14_) ^ -2147483648) == 0)
            {
               _loc11_ = nan;
            }
         }
         else if((_loc18_ = _loc16_ | _loc10_ ^ 2146435072) != 0)
         {
            if((_loc18_ = _loc3_ | _loc12_) == 0)
            {
               if((_loc18_ = _loc16_ | _loc10_) == 0)
               {
                  si32(_loc15_ & _loc14_,(_loc5_ = _loc4_ - 40) | 4);
                  si32(_loc18_ = _loc16_ & _loc3_,_loc4_ - 40);
                  _loc11_ = lf64(_loc4_ - 40);
               }
            }
            else
            {
               _loc11_ = _loc13_;
               if((_loc16_ | _loc10_) != 0)
               {
                  addr424:
                  _loc7_ = _loc6_ = 1;
                  if(uint(_loc16_) <= uint(_loc3_))
                  {
                     _loc7_ = 0;
                  }
                  if(uint(_loc10_) <= uint(_loc12_))
                  {
                     _loc6_ = 0;
                  }
                  if(_loc10_ != _loc12_)
                  {
                     _loc7_ = _loc6_;
                  }
                  _loc12_ = _loc3_;
                  if(_loc7_ == 0)
                  {
                     _loc12_ = _loc16_;
                  }
                  if(_loc7_ == 0)
                  {
                     _loc16_ = _loc3_;
                  }
                  _loc6_ = _loc14_;
                  if(_loc7_ == 0)
                  {
                     _loc6_ = _loc15_;
                  }
                  if(_loc7_ == 0)
                  {
                     _loc15_ = _loc14_;
                  }
                  _loc7_ = _loc15_ & 1048575;
                  if((_loc14_ = (_loc18_ = _loc15_ >>> 20) & 2047) == 0)
                  {
                     if(_loc7_ != 0)
                     {
                        _loc14_ = (_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ = _loc7_ | _loc7_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
                     }
                     else
                     {
                        _loc5_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ = _loc5_ | (_loc5_ = _loc18_ | (_loc18_ = _loc5_ | (_loc5_ |= (_loc5_ = _loc16_ | _loc16_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459);
                        _loc14_ = (_loc18_ = (_loc18_ = (_loc18_ = (_loc18_ = _loc5_ + (_loc5_ >>> 4)) & 252645135) * 16843009) >>> 24) + 32;
                     }
                     _loc2_ -= 16;
                     si32(_loc16_,_loc2_);
                     si32(_loc18_ = _loc14_ + -11,_loc2_ + 8);
                     si32(_loc7_,_loc2_ + 4);
                     ESP = _loc2_;
                     F___ashldi3();
                     _loc14_ = 12 - _loc14_;
                     _loc2_ += 16;
                     _loc16_ = eax;
                     _loc7_ = edx;
                  }
                  _loc3_ = _loc6_ & 1048575;
                  if((_loc9_ = (_loc18_ = _loc6_ >>> 20) & 2047) == 0)
                  {
                     if(_loc3_ != 0)
                     {
                        _loc10_ = (_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ = _loc5_ | (_loc5_ = _loc18_ | (_loc18_ = _loc3_ | _loc3_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
                     }
                     else
                     {
                        _loc10_ = (_loc18_ = (_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ = _loc12_ | _loc12_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 32;
                     }
                     _loc2_ -= 16;
                     si32(_loc12_,_loc2_);
                     si32(_loc18_ = _loc10_ + -11,_loc2_ + 8);
                     si32(_loc3_,_loc2_ + 4);
                     ESP = _loc2_;
                     F___ashldi3();
                     _loc9_ = 12 - _loc10_;
                     _loc2_ += 16;
                     _loc12_ = eax;
                     _loc3_ = edx;
                  }
                  _loc5_ = _loc12_ >>> 29;
                  _loc10_ = (_loc18_ = (_loc18_ = _loc3_ << 3) | _loc5_) | 8388608;
                  _loc12_ = _loc17_ = _loc12_ << 3;
                  _loc3_ = _loc10_;
                  if(_loc14_ != _loc9_)
                  {
                     _loc9_ = _loc14_ - _loc9_;
                     _loc12_ = 1;
                     _loc3_ = 0;
                     if(uint(_loc9_) <= 63)
                     {
                        _loc2_ -= 16;
                        si32(_loc17_,_loc2_);
                        si32(_loc10_,_loc2_ + 4);
                        si32(_loc9_,_loc2_ + 8);
                        ESP = _loc2_;
                        F___lshrdi3();
                        _loc2_ += 16;
                        _loc12_ = eax;
                        _loc3_ = edx;
                        _loc2_ -= 16;
                        si32(_loc18_ = 64 - _loc9_,_loc2_ + 8);
                        si32(_loc10_,_loc2_ + 4);
                        si32(_loc17_,_loc2_);
                        ESP = _loc2_;
                        F___ashldi3();
                        _loc2_ += 16;
                        _loc10_ = 1;
                        if((eax | edx) == 0)
                        {
                           _loc10_ = 0;
                        }
                        _loc12_ = (_loc18_ = _loc10_ & 1) | _loc12_;
                     }
                  }
                  _loc18_ = _loc15_ ^ _loc6_;
                  _loc5_ = _loc16_ >>> 29;
                  var _loc8_:*;
                  _loc7_ = (_loc5_ = (_loc8_ = _loc7_ << 3) | _loc5_) | 8388608;
                  _loc10_ = _loc16_ << 3;
                  _loc15_ &= -2147483648;
                  if(_loc18_ <= -1)
                  {
                     _loc16_ = 1;
                     if(uint(_loc10_) >= uint(_loc12_))
                     {
                        _loc16_ = 0;
                     }
                     _loc18_ = _loc10_ ^ _loc12_;
                     _loc5_ = _loc7_ ^ _loc3_;
                     _loc18_ |= _loc5_;
                     _loc11_ = 0;
                     if(_loc18_ != 0)
                     {
                        _loc6_ = (_loc18_ = _loc7_ - _loc3_) - _loc16_;
                        _loc16_ = _loc10_ - _loc12_;
                        if(uint(_loc6_) <= 8388607)
                        {
                           if(_loc6_ != 0)
                           {
                              _loc5_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ = _loc6_ | _loc6_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459);
                              _loc3_ = (_loc18_ = (_loc18_ = (_loc18_ = _loc5_ + (_loc5_ >>> 4)) & 252645135) * 16843009) >>> 24;
                           }
                           else
                           {
                              _loc3_ = (_loc18_ = (_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc5_ = _loc18_ - ((_loc5_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ = _loc5_ | (_loc5_ = _loc16_ | _loc16_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 32;
                           }
                           _loc2_ -= 16;
                           si32(_loc16_,_loc2_);
                           si32(_loc6_,_loc2_ + 4);
                           si32(_loc18_ = _loc3_ + -8,_loc2_ + 8);
                           _loc14_ -= _loc18_;
                           ESP = _loc2_;
                           F___ashldi3();
                           _loc2_ += 16;
                           _loc16_ = eax;
                           _loc6_ = edx;
                        }
                     }
                     §§goto(addr1820);
                  }
                  else
                  {
                     _loc16_ = _loc12_ + _loc10_;
                     _loc17_ = _loc6_ = 1;
                     if(uint(_loc16_) >= uint(_loc12_))
                     {
                        _loc17_ = 0;
                     }
                     if(uint(_loc16_) >= uint(_loc10_))
                     {
                        _loc6_ = _loc17_;
                     }
                     if((_loc18_ = (_loc6_ = (_loc18_ = _loc3_ + _loc7_) + _loc6_) & 16777216) != 0)
                     {
                        _loc16_ = _loc16_ >>> 1 | _loc6_ << 31 | (_loc5_ = _loc12_ + _loc10_) & 1;
                        _loc14_ += 1;
                        _loc6_ >>>= 1;
                     }
                  }
                  if(_loc14_ >= 2047)
                  {
                     si32(_loc5_ = _loc15_ | 2146435072,(_loc18_ = _loc4_ - 32) | 4);
                     si32(0,_loc4_ - 32);
                     _loc11_ = lf64(_loc4_ - 32);
                  }
                  else
                  {
                     if(_loc14_ <= 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc16_,_loc2_);
                        si32(_loc6_,_loc2_ + 4);
                        si32(_loc18_ = 1 - _loc14_,_loc2_ + 8);
                        ESP = _loc2_;
                        F___lshrdi3();
                        _loc2_ += 16;
                        _loc12_ = eax;
                        _loc3_ = edx;
                        _loc2_ -= 16;
                        si32(_loc18_ = 64 - _loc18_,_loc2_ + 8);
                        si32(_loc6_,_loc2_ + 4);
                        si32(_loc16_,_loc2_);
                        ESP = _loc2_;
                        F___ashldi3();
                        _loc2_ += 16;
                        _loc16_ = 1;
                        if((eax | edx) == (_loc14_ = 0))
                        {
                           _loc16_ = _loc14_;
                        }
                        _loc16_ = (_loc18_ = _loc16_ & 1) | _loc12_;
                        _loc6_ = _loc3_;
                     }
                     _loc3_ = _loc16_ & 7;
                     _loc7_ = _loc12_ = 1;
                     if(uint(_loc3_) <= 4)
                     {
                        _loc7_ = 0;
                     }
                     _loc7_ &= 1;
                     _loc18_ = _loc16_ >>> 3;
                     _loc5_ = _loc6_ << 29;
                     _loc16_ = (_loc18_ = (_loc18_ |= _loc5_) | 0) + _loc7_;
                     _loc10_ = _loc12_;
                     if(uint(_loc16_) >= uint(_loc18_))
                     {
                        _loc10_ = 0;
                     }
                     if(uint(_loc16_) >= uint(_loc7_))
                     {
                        _loc12_ = _loc10_;
                     }
                     _loc18_ = (_loc18_ = (_loc18_ = _loc6_ >>> 3) & 1048575) | _loc15_;
                     _loc5_ = _loc14_ << 20;
                     _loc15_ = (_loc18_ |= _loc5_) + _loc12_;
                     if(_loc3_ == 4)
                     {
                        _loc3_ = (_loc18_ = _loc16_ & 1) + _loc16_;
                        _loc6_ = _loc14_ = 1;
                        if(uint(_loc3_) >= uint(_loc18_))
                        {
                           _loc6_ = 0;
                        }
                        if(uint(_loc3_) >= uint(_loc16_))
                        {
                           _loc14_ = _loc6_;
                        }
                        _loc15_ += _loc14_;
                        _loc16_ = _loc3_;
                     }
                     _loc18_ = (_loc18_ = _loc4_ - 24) | 4;
                     si32(_loc15_,_loc18_);
                     si32(_loc16_,_loc4_ - 24);
                     _loc11_ = lf64(_loc4_ - 24);
                  }
               }
            }
         }
      }
      addr1820:
      st0 = _loc11_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
