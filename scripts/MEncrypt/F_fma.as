package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_fma() : void
   {
      var _loc11_:int = 0;
      var _loc15_:* = NaN;
      var _loc12_:* = NaN;
      var _loc13_:* = NaN;
      var _loc30_:* = 0;
      var _loc28_:* = 0;
      var _loc26_:* = 0;
      var _loc23_:* = 0;
      var _loc20_:int = 0;
      var _loc31_:* = 0;
      var _loc25_:* = 0;
      var _loc16_:* = NaN;
      var _loc18_:* = 0;
      var _loc17_:* = NaN;
      var _loc29_:* = 0;
      var _loc2_:* = NaN;
      var _loc1_:* = NaN;
      var _loc24_:* = 0;
      var _loc27_:* = 0;
      var _loc3_:* = NaN;
      var _loc10_:* = (_loc11_ = ESP) - 112;
      _loc13_ = lf64(_loc11_ + 16);
      _loc12_ = lf64(_loc11_ + 8);
      if((_loc15_ = lf64(_loc11_)) != 0)
      {
         if(!(_loc12_ != 0 | _loc12_ != _loc12_ | false))
         {
            addr83:
            var _loc14_:*;
            _loc17_ = (_loc14_ = _loc15_ * _loc12_) + _loc13_;
         }
         else if(!(_loc13_ != 0 | _loc13_ != _loc13_ | false))
         {
            _loc17_ = _loc15_ * _loc12_;
         }
         else
         {
            sf64(_loc15_,_loc11_ - 8);
            var _loc19_:*;
            if((_loc19_ = (_loc19_ = (_loc31_ = li32(_loc19_ = (_loc19_ = _loc11_ - 8) | 4)) >>> 20) & 2047) != 2047)
            {
               _loc30_ = li32(_loc11_ - 8);
               sf64(_loc12_,_loc11_ - 16);
               if((_loc19_ = (_loc19_ = (_loc29_ = li32(_loc19_ = (_loc19_ = _loc11_ - 16) | 4)) >>> 20) & 2047) != 2047)
               {
                  _loc28_ = li32(_loc11_ - 16);
                  sf64(_loc13_,_loc11_ - 24);
                  _loc17_ = _loc13_;
                  if(((_loc19_ = (_loc27_ = li32(_loc19_ = (_loc19_ = _loc11_ - 24) | 4)) >>> 20) & 2047) != 2047)
                  {
                     _loc26_ = li32(_loc11_ - 24);
                     _loc25_ = _loc31_ & 2147483647;
                     _loc18_ = _loc24_ = 0;
                     _loc17_ = _loc15_;
                     if(uint(_loc25_) <= 2146435071)
                     {
                        _loc18_ = 0;
                        _loc17_ = _loc15_;
                        if((_loc25_ | _loc30_) != 0)
                        {
                           _loc20_ = -1022;
                           _loc16_ = _loc15_;
                           if(uint(_loc25_) <= 1048575)
                           {
                              sf64(_loc16_ = _loc15_ * 18014398509481984,_loc11_ - 32);
                              _loc25_ = (_loc31_ = li32(_loc19_ = (_loc19_ = _loc11_ - 32) | 4)) & 2147483647;
                              _loc20_ = -1076;
                           }
                           _loc19_ = (_loc19_ = _loc11_ - 48) | 4;
                           var _loc21_:*;
                           si32(_loc21_ = (_loc21_ = _loc31_ & -2146435073) | 1071644672,_loc19_);
                           sf64(_loc16_,_loc11_ - 40);
                           si32(_loc19_ = li32(_loc11_ - 40),_loc11_ - 48);
                           _loc18_ = (_loc19_ = _loc25_ >>> 20) + _loc20_;
                           _loc17_ = lf64(_loc11_ - 48);
                        }
                     }
                     _loc30_ = _loc29_ & 2147483647;
                     _loc25_ = _loc24_;
                     _loc1_ = _loc12_;
                     if(uint(_loc30_) <= 2146435071)
                     {
                        _loc25_ = 0;
                        _loc1_ = _loc12_;
                        if((_loc30_ | _loc28_) != 0)
                        {
                           _loc31_ = -1022;
                           _loc2_ = _loc12_;
                           if(uint(_loc30_) <= 1048575)
                           {
                              _loc2_ = _loc12_ * 18014398509481984;
                              sf64(_loc2_,_loc11_ - 56);
                              _loc30_ = (_loc29_ = li32(_loc19_ = (_loc19_ = _loc11_ - 56) | 4)) & 2147483647;
                              _loc31_ = -1076;
                           }
                           _loc19_ = (_loc19_ = _loc11_ - 72) | 4;
                           si32(_loc21_ = (_loc21_ = _loc29_ & -2146435073) | 1071644672,_loc19_);
                           sf64(_loc2_,_loc11_ - 64);
                           si32(_loc19_ = li32(_loc11_ - 64),_loc11_ - 72);
                           _loc25_ = (_loc19_ = _loc30_ >>> 20) + _loc31_;
                           _loc1_ = lf64(_loc11_ - 72);
                        }
                     }
                     _loc29_ = _loc27_ & 2147483647;
                     _loc2_ = _loc13_;
                     if(uint(_loc29_) <= 2146435071)
                     {
                        _loc24_ = 0;
                        _loc2_ = _loc13_;
                        if((_loc29_ | _loc26_) != 0)
                        {
                           _loc24_ = -1022;
                           _loc3_ = _loc13_;
                           if(uint(_loc29_) <= 1048575)
                           {
                              _loc3_ = _loc13_ * 18014398509481984;
                              sf64(_loc3_,_loc11_ - 80);
                              _loc29_ = (_loc27_ = li32(_loc19_ = (_loc19_ = _loc11_ - 80) | 4)) & 2147483647;
                              _loc24_ = -1076;
                           }
                           _loc19_ = (_loc19_ = _loc11_ - 96) | 4;
                           si32(_loc21_ = (_loc21_ = _loc27_ & -2146435073) | 1071644672,_loc19_);
                           sf64(_loc3_,_loc11_ - 88);
                           si32(_loc19_ = li32(_loc11_ - 88),_loc11_ - 96);
                           _loc24_ = (_loc19_ = _loc29_ >>> 20) + _loc24_;
                           _loc2_ = lf64(_loc11_ - 96);
                        }
                     }
                     if((_loc24_ = (_loc27_ = _loc25_ + _loc18_) - _loc24_) >= 107)
                     {
                        _loc17_ = _loc15_ * _loc12_;
                        if(_loc13_ >= 0)
                        {
                           _loc10_ -= 16;
                           si32(2146435072,_loc10_ + 12);
                           si32(0,_loc10_ + 8);
                           sf64(_loc17_,_loc10_);
                           ESP = _loc10_;
                           F_nextafter();
                           _loc10_ += 16;
                           _loc17_ = st0;
                        }
                     }
                     else if(_loc24_ <= -54)
                     {
                        _loc27_ = _loc20_ = 1;
                        if(_loc12_ >= 0)
                        {
                           _loc27_ = 0;
                        }
                        if(_loc15_ <= 0)
                        {
                           _loc20_ = 0;
                        }
                        _loc19_ = (_loc19_ = _loc20_ ^ _loc27_) & 1;
                        _loc17_ = _loc13_;
                        if(_loc19_ != 0)
                        {
                           _loc10_ -= 16;
                           si32(2146435072,_loc10_ + 12);
                           si32(0,_loc10_ + 8);
                           sf64(_loc13_,_loc10_);
                           ESP = _loc10_;
                           F_nextafter();
                           _loc10_ += 16;
                           _loc17_ = st0;
                        }
                     }
                     else
                     {
                        var _loc4_:Number = _loc1_ * 134217729;
                        var _loc7_:Number = (_loc14_ = _loc1_ - _loc4_) + _loc4_;
                        _loc4_ = _loc17_ * 134217729;
                        var _loc6_:Number = (_loc14_ = _loc17_ - _loc4_) + _loc4_;
                        _loc14_ = _loc1_ - _loc7_;
                        var _loc9_:Number = (_loc9_ = _loc6_ * _loc14_) + (_loc4_ = _loc17_ - _loc6_) * _loc7_;
                        _loc7_ = (_loc6_ *= _loc7_) + _loc9_;
                        var _loc22_:int = 0 - _loc24_;
                        var _loc5_:Number = _loc2_ * Math.pow(2,_loc22_);
                        sf64(_loc15_ = _loc7_ + _loc5_,_loc11_ - 104);
                        var _loc8_:Number = _loc15_ - _loc7_;
                        _loc12_ = (_loc8_ = _loc7_ - (_loc15_ - _loc8_)) + (_loc5_ - _loc8_) + ((_loc7_ = _loc6_ - _loc7_) + _loc9_ + _loc4_ * _loc14_);
                        if((uint(_loc24_ = (_loc23_ = li32(_loc19_ = (_loc19_ = _loc11_ - 104) | 4)) & 2147483647)) <= 1048575)
                        {
                           _loc26_ = li32(_loc11_ - 104);
                           _loc20_ = -2147483647;
                           if((_loc24_ | _loc26_) != 0)
                           {
                              if(_loc24_ == 0)
                              {
                                 _loc20_ = -1043;
                                 if(_loc26_ >= 1)
                                 {
                                    do
                                    {
                                       _loc20_ += -1;
                                    }
                                    while((_loc26_ <<= 1) > 0);
                                    
                                 }
                              }
                              else
                              {
                                 _loc24_ = _loc23_ << 11;
                                 _loc20_ = -1022;
                                 if(_loc24_ >= 1)
                                 {
                                    do
                                    {
                                       _loc20_ += -1;
                                    }
                                    while((_loc24_ <<= 1) > 0);
                                    
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc20_ = 2147483647;
                           if(uint(_loc24_) <= 2146435071)
                           {
                              _loc20_ = (_loc19_ = _loc24_ >>> 20) + -1023;
                           }
                        }
                        if((_loc19_ = _loc20_ + _loc27_) >= -1022)
                        {
                           _loc15_ += _loc12_;
                        }
                        else
                        {
                           si32(_loc21_ = (_loc21_ = _loc23_ & -2147483648) | 1048576,(_loc19_ = _loc11_ - 112) | 4);
                           si32(0,_loc11_ - 112);
                           _loc21_ = 0 - _loc27_;
                           _loc14_ = (_loc14_ = lf64(_loc11_ - 112)) * Math.pow(2,_loc21_);
                           _loc7_ = (_loc4_ = _loc15_ + _loc14_) - _loc15_;
                           _loc15_ = (_loc4_ += (_loc9_ = (_loc7_ = _loc15_ - (_loc4_ - _loc7_)) + (_loc14_ - _loc7_)) + _loc12_) - _loc14_;
                        }
                        _loc17_ = _loc15_ * Math.pow(2,_loc27_);
                     }
                  }
               }
               §§goto(addr1030);
            }
            _loc17_ = (_loc14_ = _loc15_ * _loc12_) + _loc13_;
         }
         addr1030:
         st0 = _loc17_;
         ESP = _loc10_ = _loc11_;
         return;
      }
      §§goto(addr83);
   }
}
