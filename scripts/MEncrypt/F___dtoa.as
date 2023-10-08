package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___dtoa() : void
   {
      var _loc13_:int = 0;
      var _loc42_:* = 0;
      var _loc44_:* = 0;
      var _loc45_:* = 0;
      var _loc46_:* = 0;
      var _loc40_:* = 0;
      var _loc47_:* = 0;
      var _loc48_:* = 0;
      var _loc20_:* = NaN;
      var _loc25_:* = 0;
      var _loc33_:* = 0;
      var _loc34_:* = 0;
      var _loc21_:Number = NaN;
      var _loc29_:* = 0;
      var _loc30_:* = 0;
      var _loc26_:* = 0;
      var _loc32_:* = 0;
      var _loc27_:* = 0;
      var _loc17_:* = 0;
      var _loc24_:* = NaN;
      var _loc23_:* = NaN;
      var _loc18_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:Number = NaN;
      var _loc4_:* = NaN;
      var _loc5_:Number = NaN;
      var _loc12_:* = 0;
      var _loc36_:* = 0;
      var _loc43_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc7_:int = 0;
      var _loc2_:Number = NaN;
      var _loc35_:int = 0;
      var _loc41_:* = 0;
      var _loc6_:Number = NaN;
      var _loc31_:* = 0;
      var _loc39_:* = 0;
      var _loc16_:* = 0;
      var _loc9_:* = (_loc13_ = ESP) - 176;
      var _loc28_:*;
      _loc48_ = li32(_loc28_ = (_loc28_ = _loc13_) | 4);
      _loc47_ = li32(_loc13_);
      _loc46_ = li32(_loc13_ + 24);
      _loc45_ = li32(_loc13_ + 20);
      _loc44_ = li32(_loc13_ + 16);
      _loc43_ = li32(_loc13_ + 12);
      _loc42_ = li32(_loc13_ + 8);
      if(_loc48_ <= -1)
      {
         si32(_loc40_ = 1,_loc45_);
         _loc48_ &= 2147483647;
      }
      else
      {
         si32(_loc40_ = 0,_loc45_);
      }
      if((_loc28_ = _loc48_ & 2146435072) == 2146435072)
      {
         si32(9999,_loc44_);
         _loc9_ -= 16;
         si32(0,_loc9_);
         ESP = _loc9_;
         F___Balloc_D2A();
         _loc9_ += 16;
         _loc44_ = eax;
         si32(0,_loc44_);
         _loc43_ = _loc44_ + 4;
         if(_loc47_ == 0)
         {
            if((_loc28_ = 0 | _loc48_ & 1048575) == 0)
            {
               si8(73,_loc43_);
               si8(110,_loc43_ + 1);
               si8(102,_loc43_ + 2);
               si8(105,_loc43_ + 3);
               si8(110,_loc43_ + 4);
               si8(105,_loc43_ + 5);
               si8(116,_loc43_ + 6);
               si8(121,_loc43_ + 7);
               si8(0,_loc43_ + 8);
               if(_loc46_ != 0)
               {
                  si32(_loc28_ = _loc44_ + 12,_loc46_);
               }
            }
            §§goto(addr5425);
         }
         si8(78,_loc43_);
         si8(97,_loc43_ + 1);
         si8(78,_loc43_ + 2);
         si8(0,_loc43_ + 3);
         if(_loc46_ != 0)
         {
            si32(_loc28_ = _loc43_ + 3,_loc46_);
         }
      }
      else
      {
         si32(_loc48_,(_loc28_ = _loc13_ - 16) | 4);
         si32(_loc47_,_loc13_ - 16);
         if(!((_loc20_ = lf64(_loc13_ - 16)) != 0 | _loc20_ != _loc20_ | false))
         {
            si32(1,_loc44_);
            _loc9_ -= 16;
            si32(0,_loc9_);
            ESP = _loc9_;
            F___Balloc_D2A();
            _loc9_ += 16;
            _loc28_ = eax;
            si32(0,_loc28_);
            si8(48,_loc28_ + 4);
            si8(0,_loc28_ + 5);
            _loc43_ = _loc28_ + 4;
            if(_loc46_ != 0)
            {
               si32(_loc28_ = _loc43_ + 1,_loc46_);
            }
         }
         else
         {
            _loc25_ = 1;
            _loc9_ -= 16;
            si32(_loc28_ = _loc13_ - 4,_loc9_ + 12);
            si32(_loc28_ = _loc13_ - 8,_loc9_ + 8);
            sf64(_loc20_,_loc9_);
            ESP = _loc9_;
            F___d2b_D2A();
            _loc40_ = (_loc28_ = _loc48_ >>> 20) & 2047;
            _loc9_ += 16;
            _loc45_ = eax;
            if(_loc40_ != 0)
            {
               _loc33_ = _loc40_ + -1023;
               _loc40_ = (_loc28_ = _loc48_ & 1048575) | 1072693248;
               _loc34_ = 0;
               _loc36_ = _loc47_;
            }
            else
            {
               if((_loc28_ = (_loc33_ = (_loc28_ = li32(_loc13_ - 8)) + li32(_loc13_ - 4)) + 1074) >= 33)
               {
                  var _loc38_:*;
                  _loc40_ = (_loc38_ = _loc48_ << -1010 - _loc33_) | _loc47_ >>> _loc33_ + 1042;
               }
               else
               {
                  _loc40_ = _loc47_ << -1042 - _loc33_;
               }
               var _loc19_:*;
               sf64(_loc19_ = uint(_loc40_),_loc13_ - 24);
               _loc33_ += -1;
               _loc40_ = (_loc28_ = li32(_loc28_ = (_loc28_ = _loc13_ - 24) | 4)) + -32505856;
               _loc34_ = 1;
               _loc36_ = li32(_loc13_ - 24);
            }
            _loc28_ = (_loc28_ = _loc13_ - 32) | 4;
            si32(_loc40_,_loc28_);
            si32(_loc36_,_loc13_ - 32);
            _loc19_ = (_loc19_ = _loc33_) * 0.301029995663981;
            var _loc22_:*;
            _loc40_ = _loc21_ = (_loc22_ = (_loc22_ = (_loc22_ = (_loc22_ = lf64(_loc13_ - 32)) + -1.5) * 0.289529654602168) + 0.1760912590558) + _loc19_;
            if(!(_loc21_ >= 0 | _loc21_ != _loc21_ | false))
            {
               if((_loc19_ = _loc40_) != _loc21_)
               {
                  _loc40_ += -1;
               }
            }
            _loc29_ = 1;
            if(uint(_loc40_) <= 22)
            {
               _loc29_ = 0;
               _loc36_ = 1;
               if(_loc20_ >= lf64(_loc28_ = ___tens_D2A + (_loc40_ << 3)))
               {
                  _loc36_ = _loc29_;
               }
               _loc28_ = _loc36_ & 1;
               _loc40_ -= _loc28_;
            }
            _loc36_ = (_loc30_ = li32(_loc13_ - 4)) - _loc33_;
            _loc31_ = 0;
            if(_loc36_ <= 0)
            {
               _loc31_ = 1 - _loc36_;
            }
            _loc32_ = _loc36_ + -1;
            if(_loc36_ <= 0)
            {
               _loc32_ = 0;
            }
            if(_loc40_ >= 0)
            {
               _loc32_ += _loc40_;
               _loc27_ = 0;
               _loc26_ = _loc40_;
            }
            else
            {
               _loc31_ -= _loc40_;
               _loc27_ = 0 - _loc40_;
               _loc26_ = 0;
            }
            _loc36_ = 0;
            if(uint(_loc42_) <= 9)
            {
               _loc36_ = _loc42_;
            }
            _loc42_ = _loc36_ + -4;
            if(_loc36_ <= 5)
            {
               _loc42_ = _loc36_;
            }
            _loc18_ = 1;
            if(_loc42_ <= 2)
            {
               _loc16_ = -1;
               _loc17_ = 0;
               _loc14_ = _loc16_;
               _loc15_ = _loc18_;
               _loc11_ = 0;
               if(uint(_loc42_) >= 2)
               {
                  _loc12_ = _loc18_;
                  if(_loc42_ == 2)
                  {
                     _loc12_ = 0;
                     addr806:
                     _loc14_ = _loc18_;
                     if(_loc43_ >= _loc18_)
                     {
                        _loc14_ = _loc43_;
                     }
                     _loc16_ = _loc14_;
                     _loc33_ = _loc14_;
                     _loc43_ = _loc14_;
                  }
                  addr847:
                  _loc15_ = _loc12_;
                  _loc17_ = _loc43_;
                  _loc43_ = 4;
                  _loc11_ = 0;
                  if(uint(_loc33_) >= 20)
                  {
                     do
                     {
                        _loc11_ += 1;
                     }
                     while((uint(_loc28_ = (_loc43_ <<= 1) + 16)) <= uint(_loc33_));
                     
                  }
               }
            }
            else
            {
               if(_loc42_ != 3)
               {
                  _loc12_ = _loc18_;
                  if(_loc42_ != 4)
                  {
                     _loc15_ = _loc18_;
                     _loc12_ = _loc18_;
                     if(_loc42_ == 5)
                     {
                        addr825:
                        _loc16_ = (_loc14_ = _loc40_ + _loc43_) + 1;
                        _loc11_ = 0;
                        _loc12_ = _loc15_;
                        _loc33_ = _loc16_;
                        _loc17_ = _loc43_;
                        if(_loc14_ >= 0)
                        {
                        }
                        addr880:
                        _loc9_ -= 16;
                        si32(_loc11_,_loc9_);
                        ESP = _loc9_;
                        F___Balloc_D2A();
                        _loc9_ += 16;
                        _loc33_ = eax;
                        si32(_loc11_,_loc33_);
                        _loc11_ = 2;
                        _loc43_ = _loc18_;
                        if(_loc42_ >= _loc11_)
                        {
                           _loc43_ = 0;
                        }
                        _loc12_ = _loc18_;
                        if(_loc25_ != _loc18_)
                        {
                           _loc12_ = 0;
                        }
                        if((_loc28_ = _loc43_ | _loc12_) == 0)
                        {
                           _loc15_ = 0;
                        }
                        if(_loc25_ == _loc18_)
                        {
                           _loc18_ = 0;
                        }
                        _loc43_ = _loc33_ + 4;
                        if(uint(_loc16_) <= 14)
                        {
                           if(_loc36_ <= 5)
                           {
                              if(_loc18_ == 0)
                              {
                                 if(_loc40_ >= 1)
                                 {
                                    _loc11_ = 2;
                                    _loc8_ = _loc47_;
                                    _loc10_ = _loc48_;
                                    if(((_loc36_ = _loc40_ >> 4) & 16) != 0)
                                    {
                                       sf64(_loc19_ = _loc20_ / 1e+256,_loc13_ - 64);
                                       _loc36_ &= 15;
                                       _loc10_ = li32(_loc28_ = (_loc28_ = _loc13_ - 64) | 4);
                                       _loc11_ = 3;
                                       _loc8_ = li32(_loc13_ - 64);
                                    }
                                    _loc28_ = (_loc28_ = _loc40_ & 15) << 3;
                                    _loc24_ = lf64(_loc28_ = ___tens_D2A + _loc28_);
                                    _loc12_ = ___bigtens_D2A;
                                    if(_loc36_ != 0)
                                    {
                                       do
                                       {
                                          if((_loc28_ = _loc36_ & 1) != 0)
                                          {
                                             _loc24_ = (_loc19_ = lf64(_loc12_)) * _loc24_;
                                             _loc11_ += 1;
                                          }
                                          _loc12_ += 8;
                                       }
                                       while((_loc36_ >>= 1) != 0);
                                       
                                    }
                                    _loc28_ = (_loc28_ = _loc13_ - 72) | 4;
                                    si32(_loc10_,_loc28_);
                                    si32(_loc8_,_loc13_ - 72);
                                    sf64(_loc19_ = (_loc19_ = lf64(_loc13_ - 72)) / _loc24_,_loc13_ - 80);
                                    _loc8_ = li32(_loc28_ = (_loc28_ = _loc13_ - 80) | 4);
                                    _loc10_ = li32(_loc13_ - 80);
                                 }
                                 else
                                 {
                                    _loc10_ = _loc47_;
                                    _loc8_ = _loc48_;
                                    if(_loc40_ != 0)
                                    {
                                       sf64(_loc22_ = _loc20_ * lf64(_loc38_ = ___tens_D2A + ((_loc38_ = (_loc28_ = 0 - _loc40_) & 15) << 3)),_loc13_ - 40);
                                       _loc18_ = _loc28_ >> 4;
                                       _loc8_ = li32(_loc28_ = (_loc28_ = _loc13_ - 40) | 4);
                                       _loc36_ = ___bigtens_D2A;
                                       _loc11_ = 2;
                                       _loc10_ = li32(_loc13_ - 40);
                                       if(_loc18_ != 0)
                                       {
                                          do
                                          {
                                             if((_loc28_ = _loc18_ & 1) != 0)
                                             {
                                                si32(_loc8_,(_loc28_ = _loc13_ - 48) | 4);
                                                si32(_loc10_,_loc13_ - 48);
                                                sf64(_loc19_ = (_loc22_ = lf64(_loc13_ - 48)) * lf64(_loc36_),_loc13_ - 56);
                                                _loc11_ += 1;
                                                _loc8_ = li32(_loc28_ = (_loc28_ = _loc13_ - 56) | 4);
                                                _loc10_ = li32(_loc13_ - 56);
                                             }
                                             _loc36_ += 8;
                                          }
                                          while((_loc18_ >>= 1) != 0);
                                          
                                       }
                                    }
                                 }
                                 _loc12_ = _loc40_;
                                 _loc36_ = _loc16_;
                                 if(_loc29_ != 0)
                                 {
                                    si32(_loc8_,(_loc28_ = _loc13_ - 88) | 4);
                                    si32(_loc10_,_loc13_ - 88);
                                    _loc24_ = lf64(_loc13_ - 88);
                                    _loc12_ = _loc40_;
                                    _loc36_ = _loc16_;
                                    if(!(_loc24_ >= 1 | _loc24_ != _loc24_ | false))
                                    {
                                       _loc12_ = _loc40_;
                                       _loc36_ = _loc16_;
                                       if(_loc16_ >= 1)
                                       {
                                          if(_loc14_ >= 1)
                                          {
                                             sf64(_loc19_ = _loc24_ * 10,_loc13_ - 96);
                                             _loc11_ += 1;
                                             _loc12_ = _loc40_ + -1;
                                             _loc8_ = li32(_loc28_ = (_loc28_ = _loc13_ - 96) | 4);
                                             _loc10_ = li32(_loc13_ - 96);
                                             _loc36_ = _loc14_;
                                          }
                                          addr1822:
                                          if((_loc11_ = li32(_loc13_ - 8)) >= 0)
                                          {
                                             if(_loc40_ <= 14)
                                             {
                                                _loc4_ = lf64(_loc28_ = ___tens_D2A + (_loc40_ << 3));
                                                if(_loc17_ <= -1)
                                                {
                                                   if(_loc16_ >= 1)
                                                   {
                                                      addr1854:
                                                      _loc36_ = _loc16_ + -1;
                                                      _loc18_ = _loc33_ + 5;
                                                      while(true)
                                                      {
                                                         _loc28_ = (_loc28_ = _loc13_ - 160) | 4;
                                                         si32(_loc48_,_loc28_);
                                                         si32(_loc47_,_loc13_ - 160);
                                                         _loc22_ = (_loc22_ = _loc47_ = _loc22_ = (_loc19_ = lf64(_loc13_ - 160)) / _loc4_) * _loc4_;
                                                         if(!((_loc6_ = _loc19_ - _loc22_) >= 0 | _loc6_ != _loc6_ | false))
                                                         {
                                                            _loc6_ += _loc4_;
                                                            _loc47_ += 255;
                                                         }
                                                         si8(_loc28_ = _loc47_ + 48,_loc18_ - 1);
                                                         _loc12_ = _loc40_;
                                                         if(_loc6_ != 0)
                                                         {
                                                            if(_loc36_ != 0)
                                                            {
                                                               continue;
                                                            }
                                                            if(_loc42_ >= 2)
                                                            {
                                                               _loc12_ = _loc40_;
                                                               if(_loc25_ != 0)
                                                               {
                                                                  _loc11_ = _loc40_;
                                                                  if(_loc25_ != 2)
                                                                  {
                                                                     addr2004:
                                                                     _loc5_ = _loc6_ + _loc6_;
                                                                     _loc11_ = _loc40_;
                                                                     if(_loc5_ <= _loc4_)
                                                                     {
                                                                        _loc12_ = _loc40_;
                                                                        if(!(_loc5_ != _loc4_ | _loc5_ != _loc5_ | _loc4_ != _loc4_))
                                                                        {
                                                                           _loc11_ = _loc40_;
                                                                           _loc12_ = _loc40_;
                                                                           if((_loc47_ & 1) != 0)
                                                                           {
                                                                           }
                                                                        }
                                                                        §§goto(addr5291);
                                                                     }
                                                                  }
                                                                  addr2065:
                                                                  _loc33_ += 4;
                                                                  while(true)
                                                                  {
                                                                     if((_loc25_ = li8((_loc40_ = _loc18_) - 1)) != 57)
                                                                     {
                                                                        _loc33_ = _loc25_ + 1;
                                                                        _loc12_ = _loc11_;
                                                                        break;
                                                                     }
                                                                     _loc18_ = _loc40_ + -1;
                                                                     if(_loc33_ == _loc18_)
                                                                     {
                                                                        si8(48,_loc18_);
                                                                        _loc12_ = _loc11_ + 1;
                                                                        _loc33_ = 49;
                                                                        break;
                                                                     }
                                                                  }
                                                                  si8(_loc33_,_loc40_ - 1);
                                                                  _loc18_ = _loc40_;
                                                               }
                                                               §§goto(addr5291);
                                                            }
                                                            §§goto(addr2004);
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc11_ = _loc36_ = 0;
                                                      if(_loc16_ >= 0)
                                                      {
                                                         _loc19_ = _loc4_ * 5;
                                                         _loc11_ = _loc36_ = 0;
                                                         _loc12_ = _loc40_;
                                                         _loc10_ = _loc36_;
                                                         if(_loc20_ > _loc19_ | _loc20_ != _loc20_ | _loc19_ != _loc19_)
                                                         {
                                                            addr3429:
                                                            si8(49,_loc43_);
                                                            _loc40_ = _loc12_ + 1;
                                                            _loc18_ = _loc43_ + 1;
                                                            _loc42_ = 0;
                                                            _loc11_ = _loc10_;
                                                         }
                                                         §§goto(addr4924);
                                                      }
                                                      addr3419:
                                                      _loc40_ = _loc17_ ^ -1;
                                                      _loc42_ = 0;
                                                      _loc18_ = _loc43_;
                                                      addr4924:
                                                      if(_loc11_ != 0)
                                                      {
                                                         if((_loc33_ = li32(_loc11_ + 4)) >= 10)
                                                         {
                                                            _loc9_ -= 16;
                                                            si32(_loc11_,_loc9_);
                                                            ESP = _loc9_;
                                                            F_idalloc();
                                                            _loc9_ += 16;
                                                         }
                                                         else
                                                         {
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_lock();
                                                               _loc9_ += 16;
                                                               _loc33_ = li32(_loc11_ + 4);
                                                            }
                                                            _loc28_ = _loc33_ << 2;
                                                            si32(_loc28_ = li32(_loc38_ = _freelist + _loc28_),_loc11_);
                                                            si32(_loc11_,_loc38_);
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_unlock();
                                                               _loc9_ += 16;
                                                            }
                                                         }
                                                      }
                                                      _loc12_ = _loc40_;
                                                      if(_loc36_ != 0)
                                                      {
                                                         if(_loc42_ != 0)
                                                         {
                                                            if(_loc42_ != _loc36_)
                                                            {
                                                               if(_loc42_ != 0)
                                                               {
                                                                  if((_loc33_ = li32(_loc42_ + 4)) >= 10)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc42_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F_idalloc();
                                                                     _loc9_ += 16;
                                                                  }
                                                                  else
                                                                  {
                                                                     if((_loc28_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(___gdtoa_locks,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F__pthread_mutex_lock();
                                                                        _loc9_ += 16;
                                                                        _loc33_ = li32(_loc42_ + 4);
                                                                     }
                                                                     _loc28_ = _loc33_ << 2;
                                                                     si32(_loc28_ = li32(_loc38_ = _freelist + _loc28_),_loc42_);
                                                                     si32(_loc42_,_loc38_);
                                                                     if((_loc28_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(___gdtoa_locks,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F__pthread_mutex_unlock();
                                                                        _loc9_ += 16;
                                                                     }
                                                                  }
                                                               }
                                                               _loc12_ = _loc40_;
                                                               if(_loc36_ != 0)
                                                               {
                                                               }
                                                               §§goto(addr5291);
                                                            }
                                                         }
                                                         if((_loc33_ = li32(_loc36_ + 4)) >= 10)
                                                         {
                                                            _loc9_ -= 16;
                                                            si32(_loc36_,_loc9_);
                                                            ESP = _loc9_;
                                                            F_idalloc();
                                                            _loc9_ += 16;
                                                            _loc12_ = _loc40_;
                                                         }
                                                         else
                                                         {
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_lock();
                                                               _loc9_ += 16;
                                                               _loc33_ = li32(_loc36_ + 4);
                                                            }
                                                            _loc28_ = _loc33_ << 2;
                                                            si32(_loc28_ = li32(_loc38_ = _freelist + _loc28_),_loc36_);
                                                            si32(_loc36_,_loc38_);
                                                            _loc28_ = li32(___isthreaded);
                                                            _loc12_ = _loc40_;
                                                            if(_loc28_ != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_unlock();
                                                               _loc9_ += 16;
                                                               _loc12_ = _loc40_;
                                                            }
                                                         }
                                                      }
                                                      §§goto(addr5291);
                                                   }
                                                   §§goto(addr5291);
                                                }
                                                §§goto(addr1854);
                                             }
                                             else
                                             {
                                                addr2136:
                                                _loc36_ = 0;
                                                _loc39_ = _loc31_;
                                                if(_loc15_ != 0)
                                                {
                                                   _loc36_ = 54 - _loc30_;
                                                   if(_loc34_ != 0)
                                                   {
                                                      _loc36_ = _loc11_ + 1075;
                                                   }
                                                   if((_loc28_ = li32(___isthreaded)) != 0)
                                                   {
                                                      _loc9_ -= 16;
                                                      si32(___gdtoa_locks,_loc9_);
                                                      ESP = _loc9_;
                                                      F__pthread_mutex_lock();
                                                      _loc9_ += 16;
                                                   }
                                                   _loc32_ = _loc36_ + _loc32_;
                                                   _loc39_ = _loc36_ + _loc31_;
                                                   if((_loc36_ = li32(_freelist + 4)) != 0)
                                                   {
                                                      si32(_loc28_ = li32(_loc36_),_freelist + 4);
                                                   }
                                                   else
                                                   {
                                                      if((uint(_loc28_ = (_loc28_ = (_loc28_ = (_loc36_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                      {
                                                         si32(_loc28_ = _loc36_ + 32,_pmem_next);
                                                      }
                                                      else
                                                      {
                                                         _loc9_ -= 16;
                                                         si32(32,_loc9_);
                                                         ESP = _loc9_;
                                                         F_malloc();
                                                         _loc9_ += 16;
                                                         _loc36_ = eax;
                                                      }
                                                      si32(1,_loc36_ + 4);
                                                      si32(2,_loc36_ + 8);
                                                   }
                                                   if((_loc28_ = li32(___isthreaded)) != 0)
                                                   {
                                                      _loc9_ -= 16;
                                                      si32(___gdtoa_locks,_loc9_);
                                                      ESP = _loc9_;
                                                      F__pthread_mutex_unlock();
                                                      _loc9_ += 16;
                                                   }
                                                   si32(0,_loc36_ + 12);
                                                   si32(1,_loc36_ + 20);
                                                   si32(1,_loc36_ + 16);
                                                }
                                                if(_loc31_ >= 1)
                                                {
                                                   if(_loc32_ >= 1)
                                                   {
                                                      _loc11_ = _loc32_;
                                                      if(_loc32_ > _loc31_)
                                                      {
                                                         _loc11_ = _loc31_;
                                                      }
                                                      _loc32_ -= _loc11_;
                                                      _loc31_ -= _loc11_;
                                                      _loc39_ -= _loc11_;
                                                   }
                                                }
                                                _loc34_ = _loc45_;
                                                if(_loc27_ >= 1)
                                                {
                                                   if(_loc15_ != 0)
                                                   {
                                                      _loc9_ -= 16;
                                                      si32(_loc27_,_loc9_ + 4);
                                                      si32(_loc36_,_loc9_);
                                                      ESP = _loc9_;
                                                      F___pow5mult_D2A();
                                                      _loc9_ += 16;
                                                      _loc36_ = eax;
                                                      _loc9_ -= 16;
                                                      si32(_loc45_,_loc9_ + 4);
                                                      si32(_loc36_,_loc9_);
                                                      ESP = _loc9_;
                                                      F___mult_D2A();
                                                      _loc9_ += 16;
                                                      _loc34_ = eax;
                                                      if(_loc45_ != 0)
                                                      {
                                                         if((_loc11_ = li32(_loc45_ + 4)) >= 10)
                                                         {
                                                            _loc9_ -= 16;
                                                            si32(_loc45_,_loc9_);
                                                            ESP = _loc9_;
                                                            F_idalloc();
                                                            _loc9_ += 16;
                                                            addr2567:
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_lock();
                                                               _loc9_ += 16;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_lock();
                                                               _loc9_ += 16;
                                                               _loc11_ = li32(_loc45_ + 4);
                                                            }
                                                            _loc28_ = _loc11_ << 2;
                                                            si32(_loc38_ = li32(_loc28_ = _freelist + _loc28_),_loc45_);
                                                            si32(_loc45_,_loc28_);
                                                            if((_loc28_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(___gdtoa_locks,_loc9_);
                                                               ESP = _loc9_;
                                                               F__pthread_mutex_unlock();
                                                               _loc9_ += 16;
                                                               §§goto(addr2567);
                                                            }
                                                         }
                                                         if((_loc11_ = li32(_freelist + 4)) != 0)
                                                         {
                                                            si32(_loc28_ = li32(_loc11_),_freelist + 4);
                                                         }
                                                         else
                                                         {
                                                            if((uint(_loc28_ = (_loc28_ = (_loc28_ = (_loc11_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                            {
                                                               si32(_loc28_ = _loc11_ + 32,_pmem_next);
                                                            }
                                                            else
                                                            {
                                                               _loc9_ -= 16;
                                                               si32(32,_loc9_);
                                                               ESP = _loc9_;
                                                               F_malloc();
                                                               _loc9_ += 16;
                                                               _loc11_ = eax;
                                                            }
                                                            si32(1,_loc11_ + 4);
                                                            si32(2,_loc11_ + 8);
                                                         }
                                                         if((_loc28_ = li32(___isthreaded)) != 0)
                                                         {
                                                            _loc9_ -= 16;
                                                            si32(___gdtoa_locks,_loc9_);
                                                            ESP = _loc9_;
                                                            F__pthread_mutex_unlock();
                                                            _loc9_ += 16;
                                                         }
                                                         si32(_loc18_ = 0,_loc11_ + 12);
                                                         si32(_loc27_ = 1,_loc11_ + 20);
                                                         si32(_loc27_,_loc11_ + 16);
                                                         if(_loc26_ >= 1)
                                                         {
                                                            _loc9_ -= 16;
                                                            si32(_loc26_,_loc9_ + 4);
                                                            si32(_loc11_,_loc9_);
                                                            ESP = _loc9_;
                                                            F___pow5mult_D2A();
                                                            _loc9_ += 16;
                                                            _loc11_ = eax;
                                                         }
                                                         _loc45_ = _loc27_;
                                                         if(_loc42_ >= 2)
                                                         {
                                                            _loc45_ = _loc18_;
                                                         }
                                                         if(_loc15_ == _loc18_)
                                                         {
                                                            _loc27_ = _loc18_;
                                                         }
                                                         if(_loc25_ == 1)
                                                         {
                                                            if((_loc28_ = (_loc28_ = _loc45_ | _loc27_) & 1) != 0)
                                                            {
                                                               _loc18_ = 0;
                                                               if((_loc48_ & 1048575) == 0)
                                                               {
                                                                  if(_loc47_ == 0)
                                                                  {
                                                                     if((_loc28_ = _loc18_ | _loc48_ & 2145386496) != 0)
                                                                     {
                                                                        _loc32_ += 1;
                                                                        _loc39_ += 1;
                                                                        _loc18_ = 1;
                                                                     }
                                                                  }
                                                               }
                                                            }
                                                         }
                                                         _loc45_ = 1;
                                                         if(_loc26_ != 0)
                                                         {
                                                            _loc27_ = (_loc12_ = li32((_loc28_ = (_loc28_ = (_loc28_ = li32(_loc11_ + 16)) << 2) + _loc11_) + 16)) << 16;
                                                            if(uint(_loc12_) >= 65536)
                                                            {
                                                               _loc27_ = _loc12_;
                                                            }
                                                            _loc26_ = _loc27_ << 8;
                                                            if(uint(_loc27_) >= 16777216)
                                                            {
                                                               _loc26_ = _loc27_;
                                                            }
                                                            _loc45_ = _loc26_ << 4;
                                                            if(uint(_loc26_) >= 268435456)
                                                            {
                                                               _loc45_ = _loc26_;
                                                            }
                                                            _loc48_ = _loc45_ << 2;
                                                            if(uint(_loc45_) >= 1073741824)
                                                            {
                                                               _loc48_ = _loc45_;
                                                            }
                                                            _loc30_ = 16;
                                                            if(uint(_loc12_) >= 65536)
                                                            {
                                                               _loc30_ = 0;
                                                            }
                                                            _loc12_ = _loc30_ | 8;
                                                            if(uint(_loc27_) >= 16777216)
                                                            {
                                                               _loc12_ = _loc30_;
                                                            }
                                                            _loc27_ = _loc12_ | 4;
                                                            if(uint(_loc26_) >= 268435456)
                                                            {
                                                               _loc27_ = _loc12_;
                                                            }
                                                            _loc26_ = _loc27_ | 2;
                                                            if(uint(_loc45_) >= 1073741824)
                                                            {
                                                               _loc26_ = _loc27_;
                                                            }
                                                            if(_loc48_ >= 0)
                                                            {
                                                               _loc26_ += 1;
                                                               _loc45_ = 32;
                                                               if((_loc48_ & 1073741824) != 0)
                                                               {
                                                                  addr2955:
                                                                  _loc45_ = _loc26_;
                                                               }
                                                               _loc45_ = 32 - _loc45_;
                                                               addr2964:
                                                               if((_loc45_ = (_loc28_ = _loc45_ + _loc32_) & 31) != 0)
                                                               {
                                                                  _loc45_ = 32 - _loc45_;
                                                               }
                                                               if(uint(_loc45_) >= 5)
                                                               {
                                                                  _loc32_ = (_loc28_ = _loc45_ + -4) + _loc32_;
                                                                  _loc31_ = _loc28_ + _loc31_;
                                                                  _loc39_ = _loc28_ + _loc39_;
                                                               }
                                                               else if(uint(_loc45_) <= 3)
                                                               {
                                                                  _loc32_ = (_loc28_ = _loc45_ + 28) + _loc32_;
                                                                  _loc31_ = _loc28_ + _loc31_;
                                                                  _loc39_ = _loc28_ + _loc39_;
                                                               }
                                                               if(_loc39_ >= 1)
                                                               {
                                                                  _loc9_ -= 16;
                                                                  si32(_loc39_,_loc9_ + 4);
                                                                  si32(_loc34_,_loc9_);
                                                                  ESP = _loc9_;
                                                                  F___lshift_D2A();
                                                                  _loc9_ += 16;
                                                                  _loc34_ = eax;
                                                               }
                                                               _loc45_ = _loc34_;
                                                               if(_loc32_ >= 1)
                                                               {
                                                                  _loc9_ -= 16;
                                                                  si32(_loc32_,_loc9_ + 4);
                                                                  si32(_loc11_,_loc9_);
                                                                  ESP = _loc9_;
                                                                  F___lshift_D2A();
                                                                  _loc9_ += 16;
                                                                  _loc11_ = eax;
                                                               }
                                                               if(_loc29_ != 0)
                                                               {
                                                                  _loc32_ = li32(_loc11_ + 16);
                                                                  if((_loc29_ = li32(_loc45_ + 16)) != _loc32_)
                                                                  {
                                                                     _loc48_ = _loc29_ - _loc32_;
                                                                     addr3197:
                                                                     if(_loc48_ <= -1)
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(0,_loc9_ + 8);
                                                                        si32(10,_loc9_ + 4);
                                                                        si32(_loc45_,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___multadd_D2A();
                                                                        _loc40_ += -1;
                                                                        _loc9_ += 16;
                                                                        _loc45_ = eax;
                                                                        _loc16_ = _loc14_;
                                                                        if(_loc15_ != 0)
                                                                        {
                                                                           _loc9_ -= 16;
                                                                           si32(0,_loc9_ + 8);
                                                                           si32(10,_loc9_ + 4);
                                                                           si32(_loc36_,_loc9_);
                                                                           ESP = _loc9_;
                                                                           F___multadd_D2A();
                                                                           _loc9_ += 16;
                                                                           _loc36_ = eax;
                                                                           _loc16_ = _loc14_;
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc48_ = (_loc28_ = (_loc38_ = _loc32_ << 2) + _loc45_) + 20;
                                                                     _loc39_ = (_loc28_ = _loc38_ + _loc11_) + 16;
                                                                     _loc26_ = _loc45_ + 20;
                                                                     while(true)
                                                                     {
                                                                        _loc29_ = li32(_loc39_);
                                                                        if((_loc32_ = li32(_loc48_ - 4)) == _loc29_)
                                                                        {
                                                                           _loc48_ += -4;
                                                                           _loc39_ += -4;
                                                                           if(uint(_loc48_) <= uint(_loc26_))
                                                                           {
                                                                              break;
                                                                           }
                                                                           continue;
                                                                        }
                                                                        _loc48_ = -1;
                                                                        if(uint(_loc32_) >= uint(_loc29_))
                                                                        {
                                                                           _loc48_ = 1;
                                                                        }
                                                                        §§goto(addr3197);
                                                                     }
                                                                  }
                                                               }
                                                               if(_loc16_ <= 0)
                                                               {
                                                                  if(_loc42_ != 3)
                                                                  {
                                                                     if(_loc42_ != 5)
                                                                     {
                                                                        addr3448:
                                                                        if(_loc15_ == 0)
                                                                        {
                                                                           _loc18_ = _loc33_ + 5;
                                                                           _loc17_ = 1;
                                                                           _loc47_ = 0;
                                                                           while(true)
                                                                           {
                                                                              _loc9_ -= 16;
                                                                              si32(_loc11_,_loc9_ + 4);
                                                                              si32(_loc45_,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F___quorem_D2A();
                                                                              _loc9_ += 16;
                                                                              si8(_loc29_ = (_loc28_ = eax) + 48,_loc18_ - 1);
                                                                              if((_loc28_ = li32(_loc45_ + 20)) != 0)
                                                                              {
                                                                                 continue;
                                                                              }
                                                                              _loc42_ = 0;
                                                                              if(li32(_loc45_ + 16) >= 2)
                                                                              {
                                                                                 continue;
                                                                              }
                                                                              §§goto(addr4924);
                                                                           }
                                                                           addr4695:
                                                                           _loc42_ = _loc47_;
                                                                           if(_loc25_ != 0)
                                                                           {
                                                                              _loc47_ = _loc42_;
                                                                              if(_loc25_ != 2)
                                                                              {
                                                                                 _loc9_ -= 16;
                                                                                 si32(1,_loc9_ + 4);
                                                                                 si32(_loc45_,_loc9_);
                                                                                 ESP = _loc9_;
                                                                                 F___lshift_D2A();
                                                                                 _loc9_ += 16;
                                                                                 _loc45_ = eax;
                                                                                 _loc47_ = li32(_loc11_ + 16);
                                                                                 if((_loc25_ = li32(_loc45_ + 16)) != _loc47_)
                                                                                 {
                                                                                    _loc16_ = _loc25_ - _loc47_;
                                                                                    addr4826:
                                                                                    _loc47_ = _loc42_;
                                                                                    if(_loc16_ <= 0)
                                                                                    {
                                                                                       if(_loc16_ == 0)
                                                                                       {
                                                                                       }
                                                                                       addr4853:
                                                                                       _loc33_ = _loc18_ + 1;
                                                                                       while(true)
                                                                                       {
                                                                                          _loc18_ = _loc33_ + -1;
                                                                                          _loc28_ = li8(_loc33_ - 2);
                                                                                          _loc33_ = _loc18_;
                                                                                          if(_loc28_ == 48)
                                                                                          {
                                                                                             continue;
                                                                                          }
                                                                                          §§goto(addr4924);
                                                                                       }
                                                                                    }
                                                                                    _loc25_ = _loc33_ + 4;
                                                                                    while(true)
                                                                                    {
                                                                                       if((_loc42_ = li8((_loc33_ = _loc18_) - 1)) != 57)
                                                                                       {
                                                                                          si8(_loc28_ = _loc42_ + 1,_loc33_ - 1);
                                                                                          _loc42_ = _loc47_;
                                                                                          _loc18_ = _loc33_;
                                                                                          break;
                                                                                       }
                                                                                       _loc18_ = _loc33_ + -1;
                                                                                       if(_loc25_ == _loc18_)
                                                                                       {
                                                                                          si8(49,_loc18_);
                                                                                          _loc40_ += 1;
                                                                                          _loc42_ = _loc47_;
                                                                                          _loc18_ = _loc33_;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    §§goto(addr4924);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc17_ = (_loc38_ = (_loc28_ = _loc47_ << 2) + _loc45_) + 20;
                                                                                    _loc16_ = (_loc28_ += _loc11_) + 16;
                                                                                    _loc31_ = _loc45_ + 20;
                                                                                    while(true)
                                                                                    {
                                                                                       _loc25_ = li32(_loc16_);
                                                                                       if((_loc47_ = li32(_loc17_ - 4)) == _loc25_)
                                                                                       {
                                                                                          _loc17_ += -4;
                                                                                          _loc16_ += -4;
                                                                                          if(uint(_loc17_) <= uint(_loc31_))
                                                                                          {
                                                                                             break;
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       _loc16_ = -1;
                                                                                       if(uint(_loc47_) >= uint(_loc25_))
                                                                                       {
                                                                                          _loc16_ = 1;
                                                                                       }
                                                                                       §§goto(addr4826);
                                                                                    }
                                                                                 }
                                                                                 _loc28_ = _loc29_ & 1;
                                                                                 _loc47_ = _loc42_;
                                                                                 if(_loc28_ == 0)
                                                                                 {
                                                                                    §§goto(addr4853);
                                                                                 }
                                                                                 §§goto(addr4924);
                                                                              }
                                                                              §§goto(addr4826);
                                                                           }
                                                                           §§goto(addr4853);
                                                                        }
                                                                        else
                                                                        {
                                                                           if(_loc31_ >= 1)
                                                                           {
                                                                              _loc9_ -= 16;
                                                                              si32(_loc31_,_loc9_ + 4);
                                                                              si32(_loc36_,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F___lshift_D2A();
                                                                              _loc9_ += 16;
                                                                              _loc36_ = eax;
                                                                           }
                                                                           _loc17_ = _loc36_;
                                                                           if(_loc18_ != 0)
                                                                           {
                                                                              si32(li32(_loc36_ + 4),_loc9_ -= 16);
                                                                              ESP = _loc9_;
                                                                              F___Balloc_D2A();
                                                                              _loc9_ += 16;
                                                                              _loc9_ -= 16;
                                                                              si32(_loc38_ = (_loc38_ = li32(_loc36_ + 16) << 2) + 8,_loc9_ + 8);
                                                                              si32(_loc38_ = _loc36_ + 12,_loc9_ + 4);
                                                                              si32(_loc38_ = eax + 12,_loc9_);
                                                                              ESP = _loc9_;
                                                                              Fmemcpy();
                                                                              _loc9_ = (_loc9_ += 16) - 16;
                                                                              si32(1,_loc9_ + 4);
                                                                              si32(eax,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F___lshift_D2A();
                                                                              _loc9_ += 16;
                                                                              _loc17_ = eax;
                                                                           }
                                                                           _loc18_ = 1;
                                                                           if(_loc25_ >= _loc18_)
                                                                           {
                                                                              _loc18_ = 0;
                                                                           }
                                                                           _loc15_ = (_loc31_ = _loc47_ & 1) | _loc18_;
                                                                           _loc14_ = _loc16_ + -1;
                                                                           _loc18_ = _loc33_ + 5;
                                                                           _loc47_ = _loc36_;
                                                                           _loc36_ = _loc17_;
                                                                           while(true)
                                                                           {
                                                                              _loc9_ -= 16;
                                                                              si32(_loc11_,_loc9_ + 4);
                                                                              si32(_loc45_,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F___quorem_D2A();
                                                                              _loc9_ += 16;
                                                                              _loc17_ = eax;
                                                                              _loc29_ = li32(_loc47_ + 16);
                                                                              _loc32_ = li32(_loc45_ + 16);
                                                                              _loc16_ = _loc17_ + 48;
                                                                              if(_loc32_ != _loc29_)
                                                                              {
                                                                                 _loc29_ = _loc32_ - _loc29_;
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc28_ = _loc29_ << 2;
                                                                                 _loc39_ = (_loc32_ = _loc45_ + 20) + _loc28_;
                                                                                 _loc48_ = (_loc28_ = _loc47_ + _loc28_) + 16;
                                                                                 do
                                                                                 {
                                                                                    _loc34_ = li32(_loc48_);
                                                                                    if((_loc26_ = li32(_loc39_ - 4)) != _loc34_)
                                                                                    {
                                                                                       _loc29_ = -1;
                                                                                       if(uint(_loc26_) >= uint(_loc34_))
                                                                                       {
                                                                                          _loc29_ = 1;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    _loc39_ += -4;
                                                                                    _loc48_ += -4;
                                                                                    _loc29_ = 0;
                                                                                 }
                                                                                 while(uint(_loc39_) > uint(_loc32_));
                                                                                 
                                                                              }
                                                                              _loc9_ -= 16;
                                                                              si32(_loc36_,_loc9_ + 4);
                                                                              si32(_loc11_,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F___diff_D2A();
                                                                              _loc9_ += 16;
                                                                              if((_loc28_ = li32((_loc48_ = eax) + 12)) != 0)
                                                                              {
                                                                                 _loc32_ = 1;
                                                                                 if(_loc48_ != 0)
                                                                                 {
                                                                                    if((_loc32_ = li32(_loc48_ + 4)) >= 10)
                                                                                    {
                                                                                       _loc9_ -= 16;
                                                                                       si32(_loc48_,_loc9_);
                                                                                       ESP = _loc9_;
                                                                                       F_idalloc();
                                                                                       _loc9_ += 16;
                                                                                       _loc32_ = 1;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       if((_loc28_ = li32(___isthreaded)) != 0)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F__pthread_mutex_lock();
                                                                                          _loc9_ += 16;
                                                                                          _loc32_ = li32(_loc48_ + 4);
                                                                                       }
                                                                                       _loc28_ = _loc32_ << 2;
                                                                                       si32(_loc38_ = li32(_loc28_ = _freelist + _loc28_),_loc48_);
                                                                                       si32(_loc48_,_loc28_);
                                                                                       _loc32_ = 1;
                                                                                       if((_loc28_ = li32(___isthreaded)) != 0)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F__pthread_mutex_unlock();
                                                                                          _loc9_ += 16;
                                                                                          _loc32_ = 1;
                                                                                       }
                                                                                    }
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc32_ = li32(_loc48_ + 16);
                                                                                 if((_loc39_ = li32(_loc45_ + 16)) != _loc32_)
                                                                                 {
                                                                                    _loc32_ = _loc39_ - _loc32_;
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc28_ = _loc32_ << 2;
                                                                                    _loc34_ = (_loc30_ = _loc45_ + 20) + _loc28_;
                                                                                    _loc26_ = (_loc28_ = _loc48_ + _loc28_) + 16;
                                                                                    while(true)
                                                                                    {
                                                                                       _loc27_ = li32(_loc26_);
                                                                                       if((_loc39_ = li32(_loc34_ - 4)) == _loc27_)
                                                                                       {
                                                                                          _loc34_ += -4;
                                                                                          _loc26_ += -4;
                                                                                          _loc32_ = 0;
                                                                                          if(uint(_loc34_) <= uint(_loc30_))
                                                                                          {
                                                                                             addr4002:
                                                                                             if(_loc48_ != 0)
                                                                                             {
                                                                                                addr4006:
                                                                                                if((_loc39_ = li32(_loc48_ + 4)) >= 10)
                                                                                                {
                                                                                                   _loc9_ -= 16;
                                                                                                   si32(_loc48_,_loc9_);
                                                                                                   ESP = _loc9_;
                                                                                                   F_idalloc();
                                                                                                   _loc9_ += 16;
                                                                                                   break;
                                                                                                }
                                                                                                if((_loc28_ = li32(___isthreaded)) != 0)
                                                                                                {
                                                                                                   _loc9_ -= 16;
                                                                                                   si32(___gdtoa_locks,_loc9_);
                                                                                                   ESP = _loc9_;
                                                                                                   F__pthread_mutex_lock();
                                                                                                   _loc9_ += 16;
                                                                                                   _loc39_ = li32(_loc48_ + 4);
                                                                                                }
                                                                                                _loc28_ = _loc39_ << 2;
                                                                                                si32(_loc38_ = li32(_loc28_ = _freelist + _loc28_),_loc48_);
                                                                                                si32(_loc48_,_loc28_);
                                                                                                if((_loc28_ = li32(___isthreaded)) != 0)
                                                                                                {
                                                                                                   _loc9_ -= 16;
                                                                                                   si32(___gdtoa_locks,_loc9_);
                                                                                                   ESP = _loc9_;
                                                                                                   F__pthread_mutex_unlock();
                                                                                                   _loc9_ += 16;
                                                                                                   break;
                                                                                                }
                                                                                                break;
                                                                                             }
                                                                                             break;
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       _loc32_ = -1;
                                                                                       if(uint(_loc39_) >= uint(_loc27_))
                                                                                       {
                                                                                          _loc32_ = 1;
                                                                                       }
                                                                                       §§goto(addr4006);
                                                                                    }
                                                                                    _loc39_ = _loc48_ = 1;
                                                                                    if(_loc42_ != _loc48_)
                                                                                    {
                                                                                       _loc39_ = 0;
                                                                                    }
                                                                                    if(_loc32_ == 0)
                                                                                    {
                                                                                       _loc48_ = 0;
                                                                                    }
                                                                                    if((_loc28_ = (_loc28_ = _loc48_ | _loc39_) | _loc15_) == 0)
                                                                                    {
                                                                                       if(_loc16_ != 57)
                                                                                       {
                                                                                          if(_loc29_ >= 1)
                                                                                          {
                                                                                             _loc16_ = _loc17_ + 49;
                                                                                          }
                                                                                          si8(_loc16_,_loc18_ - 1);
                                                                                          _loc42_ = _loc47_;
                                                                                       }
                                                                                       §§goto(addr4924);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       addr4167:
                                                                                       if(_loc29_ >= 0)
                                                                                       {
                                                                                          _loc48_ = _loc39_ = 1;
                                                                                          if(_loc42_ != _loc39_)
                                                                                          {
                                                                                             _loc48_ = 0;
                                                                                          }
                                                                                          if(_loc29_ == 0)
                                                                                          {
                                                                                             _loc39_ = 0;
                                                                                          }
                                                                                          if((_loc28_ = (_loc28_ = _loc39_ | _loc48_) | _loc31_) != 0)
                                                                                          {
                                                                                             if(_loc32_ <= 0)
                                                                                             {
                                                                                                _loc29_ = _loc16_;
                                                                                                addr4436:
                                                                                                si8(_loc29_,_loc18_ - 1);
                                                                                                if(_loc14_ != 0)
                                                                                                {
                                                                                                   continue;
                                                                                                }
                                                                                                §§goto(addr4695);
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc48_ = _loc16_;
                                                                                                if(_loc25_ == 0)
                                                                                                {
                                                                                                   break;
                                                                                                }
                                                                                                if(_loc16_ == 57)
                                                                                                {
                                                                                                   addr4417:
                                                                                                   si8(57,_loc18_ - 1);
                                                                                                   §§goto(addr4826);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   si8(_loc28_ = _loc16_ + 1,_loc18_ - 1);
                                                                                                   _loc42_ = _loc47_;
                                                                                                   §§goto(addr4924);
                                                                                                }
                                                                                             }
                                                                                             §§goto(addr4924);
                                                                                          }
                                                                                          §§goto(addr4417);
                                                                                       }
                                                                                       if((_loc28_ = li32(_loc45_ + 20)) == 0)
                                                                                       {
                                                                                          _loc29_ = _loc16_;
                                                                                          _loc48_ = _loc16_;
                                                                                          if(li32(_loc45_ + 16) >= 2)
                                                                                          {
                                                                                             addr4223:
                                                                                             if(_loc42_ >= 2)
                                                                                             {
                                                                                                _loc48_ = _loc29_;
                                                                                                if(_loc25_ != 0)
                                                                                                {
                                                                                                   if(_loc25_ == 2)
                                                                                                   {
                                                                                                      §§goto(addr4436);
                                                                                                   }
                                                                                                   §§goto(addr4924);
                                                                                                }
                                                                                                break;
                                                                                             }
                                                                                             _loc48_ = _loc29_;
                                                                                             if(_loc32_ >= 1)
                                                                                             {
                                                                                                _loc9_ -= 16;
                                                                                                si32(1,_loc9_ + 4);
                                                                                                si32(_loc45_,_loc9_);
                                                                                                ESP = _loc9_;
                                                                                                F___lshift_D2A();
                                                                                                _loc9_ += 16;
                                                                                                _loc45_ = eax;
                                                                                                _loc42_ = li32(_loc11_ + 16);
                                                                                                if((_loc25_ = li32(_loc45_ + 16)) != _loc42_)
                                                                                                {
                                                                                                   _loc31_ = _loc25_ - _loc42_;
                                                                                                   addr4362:
                                                                                                   if(_loc31_ <= 0)
                                                                                                   {
                                                                                                      _loc48_ = _loc29_;
                                                                                                      if(_loc31_ == 0)
                                                                                                      {
                                                                                                         addr4372:
                                                                                                         _loc28_ = _loc16_ & 1;
                                                                                                         _loc48_ = _loc29_;
                                                                                                         if(_loc28_ != 0)
                                                                                                         {
                                                                                                         }
                                                                                                         break;
                                                                                                      }
                                                                                                      break;
                                                                                                   }
                                                                                                   if((_loc48_ = _loc17_ + 49) != 58)
                                                                                                   {
                                                                                                      break;
                                                                                                   }
                                                                                                   §§goto(addr4417);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc14_ = (_loc38_ = (_loc28_ = _loc42_ << 2) + _loc45_) + 20;
                                                                                                   _loc15_ = (_loc28_ += _loc11_) + 16;
                                                                                                   _loc31_ = _loc45_ + 20;
                                                                                                   while(true)
                                                                                                   {
                                                                                                      _loc42_ = li32(_loc15_);
                                                                                                      if((_loc25_ = li32(_loc14_ - 4)) == _loc42_)
                                                                                                      {
                                                                                                         _loc14_ += -4;
                                                                                                         _loc15_ += -4;
                                                                                                         if(uint(_loc14_) <= uint(_loc31_))
                                                                                                         {
                                                                                                            break;
                                                                                                         }
                                                                                                         continue;
                                                                                                      }
                                                                                                      _loc31_ = -1;
                                                                                                      if(uint(_loc25_) >= uint(_loc42_))
                                                                                                      {
                                                                                                         _loc31_ = 1;
                                                                                                      }
                                                                                                      §§goto(addr4362);
                                                                                                   }
                                                                                                }
                                                                                                §§goto(addr4372);
                                                                                             }
                                                                                             break;
                                                                                          }
                                                                                          break;
                                                                                       }
                                                                                       _loc29_ = _loc16_;
                                                                                       §§goto(addr4223);
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr4002);
                                                                              }
                                                                              §§goto(addr4167);
                                                                           }
                                                                           si8(_loc48_,_loc18_ - 1);
                                                                           _loc42_ = _loc47_;
                                                                           §§goto(addr4924);
                                                                        }
                                                                     }
                                                                     §§goto(addr4924);
                                                                  }
                                                                  if(_loc16_ >= 0)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(0,_loc9_ + 8);
                                                                     si32(5,_loc9_ + 4);
                                                                     si32(_loc11_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___multadd_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc33_ = li32((_loc11_ = eax) + 16);
                                                                     if((_loc25_ = li32(_loc45_ + 16)) != _loc33_)
                                                                     {
                                                                        _loc42_ = _loc25_ - _loc33_;
                                                                        addr3411:
                                                                        _loc12_ = _loc40_;
                                                                        _loc10_ = _loc11_;
                                                                        if(_loc42_ > 0)
                                                                        {
                                                                        }
                                                                        §§goto(addr3429);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc42_ = _loc45_ + 20;
                                                                        _loc47_ = _loc33_ << 2;
                                                                        while(true)
                                                                        {
                                                                           _loc33_ = li32((_loc28_ = _loc11_ + _loc47_) + 16);
                                                                           if((_loc25_ = li32((_loc28_ = _loc45_ + _loc47_) + 16)) == _loc33_)
                                                                           {
                                                                              _loc47_ += -4;
                                                                              if((uint(_loc28_ = _loc42_ + _loc47_)) <= uint(_loc42_))
                                                                              {
                                                                                 break;
                                                                              }
                                                                              continue;
                                                                           }
                                                                           _loc42_ = -1;
                                                                           if(uint(_loc25_) >= uint(_loc33_))
                                                                           {
                                                                              _loc42_ = 1;
                                                                           }
                                                                           §§goto(addr3411);
                                                                        }
                                                                     }
                                                                  }
                                                                  §§goto(addr3419);
                                                               }
                                                               §§goto(addr3448);
                                                            }
                                                            §§goto(addr2955);
                                                         }
                                                         §§goto(addr2964);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc9_ -= 16;
                                                      si32(_loc27_,_loc9_ + 4);
                                                      si32(_loc45_,_loc9_);
                                                      ESP = _loc9_;
                                                      F___pow5mult_D2A();
                                                      _loc9_ += 16;
                                                      _loc34_ = eax;
                                                   }
                                                }
                                                §§goto(addr2567);
                                             }
                                          }
                                          §§goto(addr2136);
                                       }
                                    }
                                 }
                                 _loc28_ = (_loc28_ = _loc13_ - 104) | 4;
                                 si32(_loc8_,_loc28_);
                                 si32(_loc10_,_loc13_ - 104);
                                 _loc19_ = _loc11_;
                                 _loc23_ = lf64(_loc13_ - 104);
                                 sf64(_loc19_ = (_loc19_ *= _loc23_) + 7,_loc13_ - 112);
                                 _loc11_ = (_loc28_ = li32(_loc28_ = (_loc28_ = _loc13_ - 112) | 4)) + -54525952;
                                 _loc18_ = li32(_loc13_ - 112);
                                 if(_loc36_ == 0)
                                 {
                                    si32(_loc11_,(_loc28_ = _loc13_ - 152) | 4);
                                    si32(_loc18_,_loc13_ - 152);
                                    _loc24_ = _loc23_ + -5;
                                    _loc36_ = 0;
                                    _loc1_ = lf64(_loc13_ - 152);
                                    _loc10_ = _loc36_;
                                    if(_loc24_ <= _loc1_)
                                    {
                                       _loc11_ = _loc36_ = 0;
                                       if(_loc24_ >= -_loc1_)
                                       {
                                          §§goto(addr1822);
                                       }
                                       §§goto(addr3419);
                                    }
                                    §§goto(addr3429);
                                 }
                                 else if(_loc15_ != 0)
                                 {
                                    si32(_loc11_,(_loc28_ = _loc13_ - 120) | 4);
                                    si32(_loc18_,_loc13_ - 120);
                                    _loc2_ = 0.5 / lf64((_loc28_ = (_loc28_ = _loc36_ << 3) + ___tens_D2A) - 8) - lf64(_loc13_ - 120);
                                    _loc18_ = _loc33_ + 5;
                                    _loc7_ = 1;
                                    while(true)
                                    {
                                       _loc28_ = (_loc28_ = _loc13_ - 128) | 4;
                                       si32(_loc8_,_loc28_);
                                       si32(_loc10_,_loc13_ - 128);
                                       var _loc37_:int;
                                       si8(_loc38_ = (_loc37_ = _loc19_ = lf64(_loc13_ - 128)) + 48,_loc18_ - 1);
                                       _loc22_ = _loc37_;
                                       _loc3_ = _loc19_ - _loc22_;
                                       if(_loc3_ >= _loc2_)
                                       {
                                          _loc11_ = _loc12_;
                                          if(1 - _loc3_ >= _loc2_)
                                          {
                                             if(_loc7_ < _loc36_)
                                             {
                                                continue;
                                             }
                                             §§goto(addr1822);
                                          }
                                          §§goto(addr2065);
                                       }
                                       break;
                                    }
                                    §§goto(addr5291);
                                 }
                                 else
                                 {
                                    si32(_loc11_,(_loc28_ = _loc13_ - 144) | 4);
                                    si8(_loc28_ = (_loc38_ = _loc23_) + 48,_loc43_);
                                    si32(_loc18_,_loc13_ - 144);
                                    _loc3_ = _loc23_ - _loc38_;
                                    _loc8_ = 1;
                                    if(_loc3_ != 0)
                                    {
                                       _loc8_ = _loc36_;
                                    }
                                    _loc1_ = lf64(_loc13_ - 144);
                                    _loc18_ = _loc43_ + 1;
                                    if(_loc8_ != 1)
                                    {
                                       _loc18_ = _loc33_ + 5;
                                       _loc7_ = 1;
                                       _loc35_ = 2;
                                       do
                                       {
                                          si8(_loc37_ = (_loc38_ = _loc19_ = _loc3_ * 10) + 48,_loc18_);
                                          _loc22_ = _loc38_;
                                          _loc3_ = _loc19_ - _loc22_;
                                          _loc41_ = _loc35_;
                                          if(_loc3_ != 0)
                                          {
                                             _loc41_ = _loc8_;
                                          }
                                          _loc35_ += 1;
                                          _loc7_ += 1;
                                          _loc18_ += 1;
                                          _loc8_ = _loc41_;
                                       }
                                       while(_loc7_ != _loc41_);
                                       
                                    }
                                    _loc19_ = lf64((_loc28_ = (_loc28_ = _loc36_ << 3) + ___tens_D2A) - 8);
                                    _loc19_ = (_loc21_ = _loc1_ * _loc19_) + 0.5;
                                    _loc11_ = _loc12_;
                                    if(_loc3_ <= _loc19_)
                                    {
                                       _loc19_ = 0.5 - _loc21_;
                                       if(!(_loc3_ >= _loc19_ | _loc3_ != _loc3_ | _loc19_ != _loc19_))
                                       {
                                          _loc40_ = _loc18_ + 1;
                                          do
                                          {
                                             _loc18_ = _loc40_ + -1;
                                             _loc28_ = li8(_loc40_ - 2);
                                             _loc40_ = _loc18_;
                                          }
                                          while(_loc28_ == 48);
                                          
                                       }
                                       else
                                       {
                                          §§goto(addr1822);
                                       }
                                       addr5291:
                                       if(_loc45_ != 0)
                                       {
                                          if((_loc40_ = li32(_loc45_ + 4)) >= 10)
                                          {
                                             _loc9_ -= 16;
                                             si32(_loc45_,_loc9_);
                                             ESP = _loc9_;
                                             F_idalloc();
                                             _loc9_ += 16;
                                          }
                                          else
                                          {
                                             if((_loc28_ = li32(___isthreaded)) != 0)
                                             {
                                                _loc9_ -= 16;
                                                si32(___gdtoa_locks,_loc9_);
                                                ESP = _loc9_;
                                                F__pthread_mutex_lock();
                                                _loc9_ += 16;
                                                _loc40_ = li32(_loc45_ + 4);
                                             }
                                             _loc28_ = _loc40_ << 2;
                                             si32(_loc28_ = li32(_loc38_ = _freelist + _loc28_),_loc45_);
                                             si32(_loc45_,_loc38_);
                                             if((_loc28_ = li32(___isthreaded)) != 0)
                                             {
                                                _loc9_ -= 16;
                                                si32(___gdtoa_locks,_loc9_);
                                                ESP = _loc9_;
                                                F__pthread_mutex_unlock();
                                                _loc9_ += 16;
                                             }
                                          }
                                       }
                                       si8(0,_loc18_);
                                       si32(_loc28_ = _loc12_ + 1,_loc44_);
                                       if(_loc46_ != 0)
                                       {
                                          si32(_loc18_,_loc46_);
                                       }
                                       §§goto(addr5425);
                                    }
                                 }
                                 §§goto(addr2065);
                              }
                           }
                        }
                        §§goto(addr1822);
                     }
                     §§goto(addr880);
                  }
                  else
                  {
                     §§goto(addr806);
                  }
               }
               else
               {
                  _loc15_ = 0;
               }
               §§goto(addr825);
            }
            §§goto(addr825);
         }
      }
      addr5425:
      eax = _loc43_;
      ESP = _loc9_ = _loc13_;
   }
}
