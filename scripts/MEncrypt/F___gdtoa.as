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
   
   public function F___gdtoa() : void
   {
      var _loc2_:* = 0;
      var _loc9_:* = 0;
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc7_:* = 0;
      var _loc47_:* = 0;
      var _loc3_:* = 0;
      var _loc50_:* = 0;
      var _loc34_:* = 0;
      var _loc35_:* = 0;
      var _loc32_:* = 0;
      var _loc49_:* = 0;
      var _loc30_:int = 0;
      var _loc29_:* = 0;
      var _loc31_:* = 0;
      var _loc33_:* = 0;
      var _loc43_:* = NaN;
      var _loc21_:* = NaN;
      var _loc12_:int = 0;
      var _loc41_:* = NaN;
      var _loc23_:Number = NaN;
      var _loc24_:* = NaN;
      var _loc27_:* = NaN;
      var _loc15_:* = 0;
      var _loc26_:Number = NaN;
      var _loc25_:* = NaN;
      var _loc51_:* = 0;
      var _loc28_:Number = NaN;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc38_:* = 0;
      var _loc36_:* = 0;
      var _loc45_:* = 0;
      var _loc46_:* = 0;
      var _loc37_:* = 0;
      var _loc54_:* = 0;
      var _loc42_:Number = NaN;
      var _loc10_:* = 0;
      var _loc14_:* = 0;
      var _loc22_:Number = NaN;
      var _loc53_:* = 0;
      var _loc52_:* = 0;
      var _loc20_:* = 0;
      var _loc17_:* = 0;
      var _loc8_:* = 0;
      var _loc16_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 224;
      _loc4_ = li32(_loc2_ + 12);
      var _loc19_:*;
      si32(_loc19_ = (_loc20_ = li32(_loc4_)) & -49,_loc4_);
      _loc17_ = _loc20_ & 7;
      _loc16_ = 0;
      _loc13_ = li32(_loc2_ + 28);
      _loc11_ = li32(_loc2_ + 24);
      if(_loc17_ <= 2)
      {
         if(_loc17_ != 0)
         {
            if((uint(_loc19_ = _loc17_ + -1)) < 2)
            {
               _loc7_ = li32(_loc9_ = li32(_loc2_));
               _loc16_ = 32;
               _loc3_ = _loc17_ = 0;
               if(_loc7_ >= 33)
               {
                  do
                  {
                     _loc3_ += 1;
                  }
                  while((_loc16_ <<= 1) < _loc7_);
                  
               }
               _loc51_ = li32(_loc2_ + 20);
               _loc16_ = li32(_loc2_ + 16);
               _loc52_ = li32(_loc2_ + 8);
               _loc53_ = li32(_loc2_ + 4);
               _loc1_ -= 16;
               si32(_loc3_,_loc1_);
               ESP = _loc1_;
               F___Balloc_D2A();
               _loc3_ = (_loc54_ = (_loc19_ = _loc7_ + -1) >> 5) + 1;
               _loc1_ += 16;
               _loc47_ = eax;
               do
               {
                  var _loc48_:* = _loc17_ << 2;
                  _loc19_ = _loc47_ + _loc48_;
                  si32(_loc48_ = li32(_loc48_ = _loc52_ + _loc48_),_loc19_ + 20);
               }
               while((_loc17_ += 1) < _loc3_);
               
               _loc49_ = 1;
               if(_loc3_ <= _loc49_)
               {
                  _loc54_ = 0;
               }
               _loc19_ = _loc54_ << 2;
               _loc19_ = (_loc19_ = _loc47_ + _loc19_) + 24;
               _loc17_ = _loc47_ + 20;
               _loc19_ = (_loc54_ = (_loc19_ -= _loc17_) >> 2) << 5;
               _loc3_ = 0 - _loc19_;
               while(true)
               {
                  _loc46_ = _loc54_ << 2;
                  if((_loc19_ = li32((_loc19_ = _loc47_ + _loc46_) + 16)) == 0)
                  {
                     _loc3_ += 32;
                     if((_loc54_ += -1) == 0)
                     {
                        si32(_loc54_ = 0,_loc47_ + 16);
                        _loc50_ = _loc54_;
                        break;
                     }
                     continue;
                  }
                  si32(_loc54_,_loc47_ + 16);
                  _loc50_ = (_loc45_ = li32(_loc19_ = (_loc19_ = _loc47_ + 16) + _loc46_)) << 16;
                  if(uint(_loc45_) >= 65536)
                  {
                     _loc50_ = _loc45_;
                  }
                  _loc38_ = _loc50_ << 8;
                  if(uint(_loc50_) >= 16777216)
                  {
                     _loc38_ = _loc50_;
                  }
                  _loc46_ = _loc38_ << 4;
                  if(uint(_loc38_) >= 268435456)
                  {
                     _loc46_ = _loc38_;
                  }
                  _loc36_ = _loc46_ << 2;
                  if(uint(_loc46_) >= 1073741824)
                  {
                     _loc36_ = _loc46_;
                  }
                  _loc37_ = 16;
                  if(uint(_loc45_) >= 65536)
                  {
                     _loc37_ = 0;
                  }
                  _loc45_ = _loc37_ | 8;
                  if(uint(_loc50_) >= 16777216)
                  {
                     _loc45_ = _loc37_;
                  }
                  _loc50_ = _loc45_ | 4;
                  if(uint(_loc38_) >= 268435456)
                  {
                     _loc50_ = _loc45_;
                  }
                  _loc38_ = _loc50_ | 2;
                  if(uint(_loc46_) >= 1073741824)
                  {
                     _loc38_ = _loc50_;
                  }
                  if(_loc36_ >= 0)
                  {
                     _loc38_ += 1;
                     _loc46_ = 32;
                     if((_loc36_ & 1073741824) != 0)
                     {
                        addr652:
                        _loc46_ = _loc38_;
                     }
                     _loc50_ = (_loc19_ = 0 - _loc46_) - _loc3_;
                     break;
                  }
                  §§goto(addr652);
               }
               _loc3_ = 0;
               _loc36_ = _loc3_;
               for(; _loc36_ < _loc54_; _loc3_ += 32,_loc36_ += 1)
               {
                  if((_loc46_ = li32((_loc19_ = _loc47_ + (_loc36_ << 2)) + 20)) == 0)
                  {
                     continue;
                  }
                  if((_loc19_ = _loc46_ & 7) != 0)
                  {
                     _loc36_ = 0;
                     if((_loc46_ & 1) == 0)
                     {
                        _loc36_ = 1;
                        if((_loc46_ & 2) == 0)
                        {
                           _loc36_ = 2;
                        }
                     }
                  }
                  else
                  {
                     _loc45_ = _loc46_ >>> 16;
                     if((_loc38_ = _loc46_ & 65535) != 0)
                     {
                        _loc45_ = _loc46_;
                     }
                     _loc54_ = _loc45_ >>> 8;
                     if((_loc36_ = _loc45_ & 255) != 0)
                     {
                        _loc54_ = _loc45_;
                     }
                     _loc37_ = _loc54_ >>> 4;
                     if((_loc45_ = _loc54_ & 15) != 0)
                     {
                        _loc37_ = _loc54_;
                     }
                     _loc54_ = _loc37_ >>> 2;
                     if((_loc46_ = _loc37_ & 3) != 0)
                     {
                        _loc54_ = _loc37_;
                     }
                     _loc37_ = 16;
                     if(_loc38_ != 0)
                     {
                        _loc37_ = 0;
                     }
                     _loc38_ = _loc37_ | 8;
                     if(_loc36_ != 0)
                     {
                        _loc38_ = _loc37_;
                     }
                     _loc36_ = _loc38_ | 4;
                     if(_loc45_ != 0)
                     {
                        _loc36_ = _loc38_;
                     }
                     _loc38_ = _loc36_ | 2;
                     if(_loc46_ != 0)
                     {
                        _loc38_ = _loc36_;
                     }
                     if((_loc19_ = _loc54_ & 1) == 0)
                     {
                        _loc38_ += 1;
                        _loc36_ = 32;
                        if(uint(_loc54_) >= 2)
                        {
                        }
                        addr853:
                        _loc3_ = _loc36_ + _loc3_;
                        break;
                     }
                     _loc36_ = _loc38_;
                  }
                  §§goto(addr853);
               }
               si32(_loc3_,_loc2_ - 4);
               if(_loc3_ == 0)
               {
                  _loc3_ = li32(_loc47_ + 16);
                  _loc34_ = _loc53_;
               }
               else
               {
                  _loc38_ = li32(_loc47_ + 16);
                  _loc45_ = _loc3_ >> 5;
                  _loc54_ = _loc17_;
                  if(_loc38_ > _loc45_)
                  {
                     _loc46_ = (_loc19_ = _loc47_ + (_loc38_ << 2)) + 20;
                     _loc3_ &= 31;
                     if(_loc3_ == 0)
                     {
                        _loc54_ = _loc17_;
                        if(_loc45_ < _loc38_)
                        {
                           _loc3_ = _loc45_ << 2;
                           _loc54_ = _loc47_ + 20;
                           do
                           {
                              si32(_loc19_ = li32(_loc19_ = _loc54_ + _loc3_),_loc54_);
                           }
                           while((uint(_loc19_ = (_loc54_ += 4) + _loc3_)) < uint(_loc46_));
                           
                        }
                     }
                     else
                     {
                        _loc36_ = (_loc19_ = li32((_loc37_ = _loc47_ + (_loc45_ << 2)) + 20)) >>> _loc3_;
                        _loc54_ = _loc17_;
                        if(_loc45_ + 1 < _loc38_)
                        {
                           _loc38_ = 32 - _loc3_;
                           _loc45_ = _loc37_ + 24;
                           _loc54_ = _loc47_ + 20;
                           do
                           {
                              si32(_loc19_ = (_loc19_ = (_loc19_ = li32(_loc45_)) << _loc38_) | _loc36_,_loc54_);
                              _loc36_ = (_loc19_ = li32(_loc45_)) >>> _loc3_;
                              _loc45_ += 4;
                              _loc54_ += 4;
                           }
                           while(uint(_loc45_) < uint(_loc46_));
                           
                        }
                        si32(_loc36_,_loc54_);
                        if(_loc36_ != 0)
                        {
                           _loc54_ += 4;
                        }
                     }
                  }
                  _loc3_ = (_loc19_ = _loc54_ - _loc17_) >> 2;
                  si32(_loc3_,_loc47_ + 16);
                  if(_loc3_ == 0)
                  {
                     si32(0,_loc17_);
                  }
                  _loc19_ = li32(_loc2_ - 4);
                  _loc50_ -= _loc19_;
                  _loc34_ = _loc19_ + _loc53_;
               }
               if(_loc3_ == 0)
               {
                  if(_loc47_ != 0)
                  {
                     if((_loc4_ = li32(_loc47_ + 4)) >= 10)
                     {
                        _loc1_ -= 16;
                        si32(_loc47_,_loc1_);
                        ESP = _loc1_;
                        F_idalloc();
                        _loc1_ += 16;
                     }
                     else
                     {
                        if((_loc19_ = li32(___isthreaded)) != 0)
                        {
                           _loc1_ -= 16;
                           si32(___gdtoa_locks,_loc1_);
                           ESP = _loc1_;
                           F__pthread_mutex_lock();
                           _loc1_ += 16;
                           _loc4_ = li32(_loc47_ + 4);
                        }
                        _loc19_ = _loc4_ << 2;
                        si32(_loc19_ = li32(_loc48_ = _freelist + _loc19_),_loc47_);
                        si32(_loc47_,_loc48_);
                        if((_loc19_ = li32(___isthreaded)) != 0)
                        {
                           _loc1_ -= 16;
                           si32(___gdtoa_locks,_loc1_);
                           ESP = _loc1_;
                           F__pthread_mutex_unlock();
                           _loc1_ += 16;
                        }
                     }
                  }
               }
               else
               {
                  _loc1_ -= 16;
                  si32(_loc19_ = _loc2_ - 4,_loc1_ + 4);
                  si32(_loc47_,_loc1_);
                  ESP = _loc1_;
                  F___b2d_D2A();
                  _loc1_ += 16;
                  var _loc40_:*;
                  sf64(_loc40_ = st0,_loc2_ - 16);
                  si32(_loc46_ = (_loc48_ = (_loc48_ = li32(_loc48_ = (_loc48_ = _loc2_ - 16) | 4)) & 1048575) | 1072693248,(_loc19_ = _loc2_ - 24) | 4);
                  _loc3_ = (_loc54_ = _loc34_ + _loc50_) + -1;
                  si32(_loc3_,_loc2_ - 4);
                  si32(_loc35_ = li32(_loc2_ - 16),_loc2_ - 24);
                  _loc17_ = 1 - _loc54_;
                  if(_loc3_ >= 0)
                  {
                     _loc17_ = _loc3_;
                  }
                  _loc17_ += -1077;
                  _loc40_ = (_loc40_ = _loc3_) * 0.301029995663981;
                  var _loc39_:*;
                  _loc42_ = (_loc39_ = (_loc39_ = (_loc39_ = (_loc39_ = lf64(_loc2_ - 24)) + -1.5) * 0.289529654602168) + 0.1760912590558) + _loc40_;
                  if(_loc17_ >= 1)
                  {
                     _loc42_ = (_loc40_ = (_loc40_ = _loc17_) * 7e-17) + _loc42_;
                  }
                  _loc17_ = _loc42_;
                  if(!(_loc42_ >= 0 | _loc42_ != _loc42_ | false))
                  {
                     if((_loc40_ = _loc17_) != _loc42_)
                     {
                        _loc17_ += -1;
                     }
                  }
                  _loc32_ = (_loc19_ = (_loc19_ = (_loc19_ = _loc54_ << 20) + _loc46_) + -1048576) | 0;
                  if(uint(_loc17_) <= 22)
                  {
                     si32(_loc32_,(_loc19_ = _loc2_ - 32) | 4);
                     si32(_loc35_,_loc2_ - 32);
                     _loc49_ = 0;
                     _loc54_ = 1;
                     if((_loc39_ = lf64(_loc2_ - 32)) >= lf64(_loc19_ = ___tens_D2A + (_loc17_ << 3)))
                     {
                        _loc54_ = _loc49_;
                     }
                     _loc19_ = _loc54_ & 1;
                     _loc17_ -= _loc19_;
                  }
                  _loc54_ = _loc50_ - _loc3_;
                  _loc33_ = 0;
                  if(_loc54_ <= 0)
                  {
                     _loc33_ = 1 - _loc54_;
                  }
                  _loc30_ = _loc54_ + -1;
                  if(_loc54_ <= 0)
                  {
                     _loc30_ = 0;
                  }
                  if(_loc17_ >= 0)
                  {
                     _loc30_ = _loc17_ + _loc30_;
                     _loc31_ = 0;
                     _loc29_ = _loc17_;
                  }
                  else
                  {
                     _loc33_ -= _loc17_;
                     _loc31_ = 0 - _loc17_;
                     _loc29_ = 0;
                  }
                  _loc54_ = 0;
                  if(uint(_loc16_) <= 9)
                  {
                     _loc54_ = _loc16_;
                  }
                  _loc38_ = _loc54_ + -4;
                  if(_loc54_ <= 5)
                  {
                     _loc38_ = _loc54_;
                  }
                  _loc6_ = 1;
                  if(_loc38_ <= 2)
                  {
                     if(uint(_loc38_) >= 2)
                     {
                        if(_loc38_ == 2)
                        {
                           _loc16_ = 0;
                           addr1668:
                           if(_loc51_ >= _loc6_)
                           {
                              _loc6_ = _loc51_;
                           }
                           _loc3_ = _loc6_;
                           si32(_loc3_,_loc2_ - 4);
                           _loc6_ = _loc16_;
                           _loc5_ = _loc3_;
                           _loc36_ = _loc3_;
                           _loc51_ = _loc3_;
                        }
                     }
                     else
                     {
                        _loc3_ = (_loc19_ = _loc40_ = (_loc40_ = _loc7_) * 0.30103) + 3;
                        si32(_loc3_,_loc2_ - 4);
                        _loc51_ = 0;
                        _loc5_ = -1;
                        _loc6_ = 1;
                        _loc36_ = _loc5_;
                     }
                  }
                  else
                  {
                     if(_loc38_ != 3)
                     {
                        _loc16_ = _loc6_;
                        if(_loc38_ != 4)
                        {
                           if(_loc38_ != 5)
                           {
                              addr1726:
                              _loc46_ = 4;
                              _loc16_ = 0;
                              if(uint(_loc3_) >= 20)
                              {
                                 do
                                 {
                                    _loc16_ += 1;
                                 }
                                 while((uint(_loc19_ = (_loc46_ <<= 1) + 16)) <= uint(_loc3_));
                                 
                              }
                              addr1755:
                              _loc1_ -= 16;
                              si32(_loc16_,_loc1_);
                              ESP = _loc1_;
                              F___Balloc_D2A();
                              _loc1_ += 16;
                              _loc3_ = eax;
                              si32(_loc16_,_loc3_);
                              _loc16_ = (_loc19_ = li32(_loc9_ + 12)) + -1;
                              _loc45_ = 0;
                              if(_loc16_ != 0)
                              {
                                 _loc45_ = 2;
                                 if(_loc16_ >= 0)
                                 {
                                    _loc45_ = _loc16_;
                                 }
                                 if((_loc19_ = _loc20_ & 8) != 0)
                                 {
                                    _loc45_ = 3 - _loc45_;
                                 }
                              }
                              _loc46_ = _loc20_ = 1;
                              if(_loc54_ >= 6)
                              {
                                 _loc46_ = 0;
                              }
                              if(uint(_loc36_) >= 15)
                              {
                                 _loc20_ = 0;
                              }
                              _loc16_ = _loc3_ + 4;
                              if(_loc45_ == 0)
                              {
                                 if((_loc19_ = (_loc19_ = _loc20_ & _loc46_) & 1) != 0)
                                 {
                                    if(_loc17_ == 0)
                                    {
                                       si32(_loc10_ = 0,_loc2_ - 4);
                                       if(_loc17_ >= 1)
                                       {
                                          _loc37_ = 2;
                                          _loc54_ = _loc35_;
                                          _loc46_ = _loc32_;
                                          if(((_loc10_ = _loc17_ >> 4) & 16) != 0)
                                          {
                                             si32(_loc32_,(_loc19_ = _loc2_ - 72) | 4);
                                             si32(_loc35_,_loc2_ - 72);
                                             sf64(_loc40_ = (_loc40_ = lf64(_loc2_ - 72)) / 1e+256,_loc2_ - 80);
                                             _loc10_ &= 15;
                                             _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 80) | 4);
                                             _loc37_ = 3;
                                             _loc54_ = li32(_loc2_ - 80);
                                          }
                                          _loc19_ = (_loc19_ = _loc17_ & 15) << 3;
                                          _loc41_ = lf64(_loc19_ = ___tens_D2A + _loc19_);
                                          _loc8_ = 0;
                                          if(_loc10_ != 0)
                                          {
                                             do
                                             {
                                                if((_loc19_ = _loc10_ & 1) != 0)
                                                {
                                                   _loc41_ = (_loc40_ = lf64(_loc19_ = ___bigtens_D2A + (_loc8_ << 3))) * _loc41_;
                                                   _loc37_ += 1;
                                                }
                                                _loc8_ += 1;
                                             }
                                             while((_loc10_ >>= 1) != 0);
                                             
                                             si32(_loc8_,_loc2_ - 4);
                                          }
                                       }
                                       else
                                       {
                                          _loc41_ = 1;
                                          _loc37_ = 2;
                                          _loc54_ = _loc35_;
                                          _loc46_ = _loc32_;
                                          if(_loc17_ != 0)
                                          {
                                             si32(_loc32_,(_loc48_ = _loc2_ - 40) | 4);
                                             si32(_loc35_,_loc2_ - 40);
                                             var _loc44_:*;
                                             sf64(_loc39_ = (_loc44_ = lf64(_loc2_ - 40)) * lf64(_loc48_ = ___tens_D2A + ((_loc48_ = 0 - _loc17_ & 15) << 3)),_loc2_ - 48);
                                             _loc8_ = 0 - _loc17_ >> 4;
                                             _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 48) | 4);
                                             _loc41_ = 1;
                                             _loc37_ = 2;
                                             _loc54_ = li32(_loc2_ - 48);
                                             if(_loc8_ != 0)
                                             {
                                                do
                                                {
                                                   if((_loc19_ = _loc8_ & 1) != 0)
                                                   {
                                                      si32(_loc46_,(_loc19_ = _loc2_ - 56) | 4);
                                                      si32(_loc54_,_loc2_ - 56);
                                                      sf64(_loc40_ = (_loc39_ = lf64(_loc2_ - 56)) * lf64(_loc19_ = ___bigtens_D2A + (_loc10_ << 3)),_loc2_ - 64);
                                                      _loc37_ += 1;
                                                      _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 64) | 4);
                                                      _loc54_ = li32(_loc2_ - 64);
                                                   }
                                                   _loc10_ += 1;
                                                }
                                                while((_loc8_ >>= 1) != 0);
                                                
                                                si32(_loc10_,_loc2_ - 4);
                                                _loc41_ = 1;
                                             }
                                          }
                                       }
                                       _loc10_ = _loc17_;
                                       _loc14_ = _loc36_;
                                       if(_loc49_ != 0)
                                       {
                                          si32(_loc46_,(_loc19_ = _loc2_ - 88) | 4);
                                          si32(_loc54_,_loc2_ - 88);
                                          _loc43_ = lf64(_loc2_ - 88);
                                          _loc10_ = _loc17_;
                                          _loc14_ = _loc36_;
                                          if(!(_loc43_ >= 1 | _loc43_ != _loc43_ | false))
                                          {
                                             _loc10_ = _loc17_;
                                             _loc14_ = _loc36_;
                                             if(_loc36_ >= 1)
                                             {
                                                if(_loc5_ >= 1)
                                                {
                                                   sf64(_loc40_ = _loc43_ * 10,_loc2_ - 96);
                                                   _loc37_ += 1;
                                                   _loc10_ = _loc17_ + -1;
                                                   _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 96) | 4);
                                                   _loc54_ = li32(_loc2_ - 96);
                                                   _loc14_ = _loc5_;
                                                }
                                                addr2891:
                                                if(_loc34_ >= 0)
                                                {
                                                   if(_loc17_ <= 14)
                                                   {
                                                      _loc25_ = lf64(_loc19_ = ___tens_D2A + (_loc17_ << 3));
                                                      if(_loc51_ <= -1)
                                                      {
                                                         if(_loc36_ <= 0)
                                                         {
                                                            _loc54_ = 0;
                                                            _loc20_ = _loc47_;
                                                            _loc46_ = _loc54_;
                                                            if(_loc36_ >= 0)
                                                            {
                                                               si32(_loc32_,(_loc19_ = _loc2_ - 216) | 4);
                                                               si32(_loc35_,_loc2_ - 216);
                                                               _loc39_ = _loc25_ * 5;
                                                               _loc54_ = 0;
                                                               _loc40_ = lf64(_loc2_ - 216);
                                                               _loc20_ = _loc47_;
                                                               _loc46_ = _loc54_;
                                                               _loc10_ = _loc17_;
                                                               _loc14_ = _loc54_;
                                                               if(_loc40_ > _loc39_ | _loc40_ != _loc40_ | _loc39_ != _loc39_)
                                                               {
                                                                  addr4666:
                                                                  si8(49,_loc16_);
                                                                  _loc17_ = _loc10_ + 1;
                                                                  _loc37_ = _loc16_ + 1;
                                                                  _loc51_ = 0;
                                                                  _loc8_ = 32;
                                                                  _loc20_ = _loc47_;
                                                                  _loc46_ = _loc14_;
                                                               }
                                                               §§goto(addr6483);
                                                            }
                                                            addr4654:
                                                            _loc17_ = _loc51_ ^ -1;
                                                            _loc51_ = 0;
                                                            _loc8_ = 16;
                                                            _loc37_ = _loc16_;
                                                            addr6483:
                                                            if(_loc46_ != 0)
                                                            {
                                                               if((_loc52_ = li32(_loc46_ + 4)) >= 10)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(_loc46_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F_idalloc();
                                                                  _loc1_ += 16;
                                                               }
                                                               else
                                                               {
                                                                  if((_loc19_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_lock();
                                                                     _loc1_ += 16;
                                                                     _loc52_ = li32(_loc46_ + 4);
                                                                  }
                                                                  _loc19_ = _loc52_ << 2;
                                                                  si32(_loc19_ = li32(_loc48_ = _freelist + _loc19_),_loc46_);
                                                                  si32(_loc46_,_loc48_);
                                                                  if((_loc19_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_unlock();
                                                                     _loc1_ += 16;
                                                                  }
                                                               }
                                                            }
                                                            if(_loc54_ != 0)
                                                            {
                                                               if(_loc51_ != 0)
                                                               {
                                                                  if(_loc51_ != _loc54_)
                                                                  {
                                                                     if(_loc51_ != 0)
                                                                     {
                                                                        if((_loc52_ = li32(_loc51_ + 4)) >= 10)
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(_loc51_,_loc1_);
                                                                           ESP = _loc1_;
                                                                           F_idalloc();
                                                                           _loc1_ += 16;
                                                                        }
                                                                        else
                                                                        {
                                                                           if((_loc19_ = li32(___isthreaded)) != 0)
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(___gdtoa_locks,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F__pthread_mutex_lock();
                                                                              _loc1_ += 16;
                                                                              _loc52_ = li32(_loc51_ + 4);
                                                                           }
                                                                           _loc19_ = _loc52_ << 2;
                                                                           si32(_loc19_ = li32(_loc48_ = _freelist + _loc19_),_loc51_);
                                                                           si32(_loc51_,_loc48_);
                                                                           if((_loc19_ = li32(___isthreaded)) != 0)
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(___gdtoa_locks,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F__pthread_mutex_unlock();
                                                                              _loc1_ += 16;
                                                                           }
                                                                        }
                                                                     }
                                                                     if(_loc54_ != 0)
                                                                     {
                                                                     }
                                                                     §§goto(addr6840);
                                                                  }
                                                               }
                                                               if((_loc52_ = li32(_loc54_ + 4)) >= 10)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(_loc54_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F_idalloc();
                                                                  _loc1_ += 16;
                                                               }
                                                               else
                                                               {
                                                                  if((_loc19_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_lock();
                                                                     _loc1_ += 16;
                                                                     _loc52_ = li32(_loc54_ + 4);
                                                                  }
                                                                  _loc19_ = _loc52_ << 2;
                                                                  si32(_loc48_ = li32(_loc19_ = _freelist + _loc19_),_loc54_);
                                                                  si32(_loc54_,_loc19_);
                                                                  if((_loc19_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_unlock();
                                                                     _loc1_ += 16;
                                                                  }
                                                               }
                                                            }
                                                            §§goto(addr6840);
                                                         }
                                                         else
                                                         {
                                                            addr2980:
                                                            si32(1,_loc2_ - 4);
                                                            _loc37_ = _loc3_ + 5;
                                                            while(true)
                                                            {
                                                               _loc19_ = (_loc19_ = _loc2_ - 200) | 4;
                                                               si32(_loc32_,_loc19_);
                                                               si32(_loc35_,_loc2_ - 200);
                                                               si8(_loc48_ = (_loc51_ = _loc39_ = (_loc40_ = lf64(_loc2_ - 200)) / _loc25_) + 48,_loc37_ - 1);
                                                               _loc39_ = (_loc39_ = _loc51_) * _loc25_;
                                                               _loc28_ = _loc40_ - _loc39_;
                                                               _loc8_ = 0;
                                                               _loc20_ = _loc47_;
                                                               if(_loc28_ != 0)
                                                               {
                                                                  if((_loc20_ = li32(_loc2_ - 4)) != _loc36_)
                                                                  {
                                                                     continue;
                                                                  }
                                                                  _loc10_ = _loc17_;
                                                                  if(_loc45_ != 1)
                                                                  {
                                                                     _loc8_ = 16;
                                                                     _loc20_ = _loc47_;
                                                                     if(_loc45_ == 0)
                                                                     {
                                                                        _loc28_ += _loc28_;
                                                                        _loc10_ = _loc17_;
                                                                        if(_loc28_ <= _loc25_)
                                                                        {
                                                                           _loc8_ = 16;
                                                                           if(_loc28_ == _loc25_)
                                                                           {
                                                                              _loc8_ = 16;
                                                                              _loc10_ = _loc17_;
                                                                              if((_loc51_ & 1) != 0)
                                                                              {
                                                                                 addr3108:
                                                                                 _loc17_ = _loc3_ + 4;
                                                                                 while(true)
                                                                                 {
                                                                                    if((_loc51_ = li8((_loc52_ = _loc37_) - 1)) != 57)
                                                                                    {
                                                                                       _loc51_ += 1;
                                                                                       _loc17_ = _loc10_;
                                                                                       break;
                                                                                    }
                                                                                    _loc37_ = _loc52_ + -1;
                                                                                    if(_loc17_ == _loc37_)
                                                                                    {
                                                                                       si8(48,_loc37_);
                                                                                       _loc17_ = _loc10_ + 1;
                                                                                       _loc51_ = 49;
                                                                                       break;
                                                                                    }
                                                                                 }
                                                                                 si8(_loc51_,_loc52_ - 1);
                                                                                 _loc8_ = 32;
                                                                                 _loc20_ = _loc47_;
                                                                                 _loc37_ = _loc52_;
                                                                              }
                                                                              §§goto(addr6840);
                                                                           }
                                                                           addr3091:
                                                                           _loc52_ = _loc37_ + 1;
                                                                           do
                                                                           {
                                                                              _loc37_ = _loc52_ + -1;
                                                                              _loc19_ = li8(_loc52_ - 2);
                                                                              _loc52_ = _loc37_;
                                                                              _loc20_ = _loc47_;
                                                                           }
                                                                           while(_loc19_ == 48);
                                                                           
                                                                           §§goto(addr6840);
                                                                        }
                                                                     }
                                                                     §§goto(addr6840);
                                                                  }
                                                                  §§goto(addr3108);
                                                               }
                                                            }
                                                         }
                                                         §§goto(addr6840);
                                                      }
                                                      §§goto(addr2980);
                                                   }
                                                   else
                                                   {
                                                      addr3229:
                                                      _loc54_ = 0;
                                                      _loc46_ = _loc31_;
                                                      _loc37_ = _loc33_;
                                                      if(_loc6_ != 0)
                                                      {
                                                         if(_loc38_ <= 1)
                                                         {
                                                            _loc54_ = (_loc19_ = _loc7_ - _loc50_) + 1;
                                                            _loc37_ = li32(_loc9_ + 4);
                                                            si32(_loc54_,_loc2_ - 4);
                                                            _loc7_ = _loc31_;
                                                            _loc20_ = _loc33_;
                                                            _loc46_ = _loc31_;
                                                            if(_loc34_ - _loc19_ < _loc37_)
                                                            {
                                                               si32(_loc54_ = (_loc19_ = _loc34_ + 1) - _loc37_,_loc2_ - 4);
                                                               _loc7_ = _loc31_;
                                                               _loc20_ = _loc33_;
                                                               _loc46_ = _loc31_;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc46_ = _loc36_ + -1;
                                                            if(_loc31_ >= _loc46_)
                                                            {
                                                               _loc7_ = _loc31_ - _loc46_;
                                                               _loc46_ = _loc31_;
                                                            }
                                                            else
                                                            {
                                                               _loc29_ = (_loc19_ = _loc29_ - _loc31_) + _loc46_;
                                                               _loc7_ = 0;
                                                            }
                                                            si32(_loc36_,_loc2_ - 4);
                                                            _loc54_ = _loc36_;
                                                            _loc20_ = _loc33_;
                                                            if(_loc36_ <= -1)
                                                            {
                                                               si32(_loc54_ = 0,_loc2_ - 4);
                                                               _loc20_ = _loc33_ - _loc36_;
                                                            }
                                                         }
                                                         if((_loc19_ = li32(___isthreaded)) != 0)
                                                         {
                                                            _loc1_ -= 16;
                                                            si32(___gdtoa_locks,_loc1_);
                                                            ESP = _loc1_;
                                                            F__pthread_mutex_lock();
                                                            _loc1_ += 16;
                                                         }
                                                         _loc30_ = _loc54_ + _loc30_;
                                                         _loc37_ = _loc54_ + _loc33_;
                                                         if((_loc54_ = li32(_freelist + 4)) != 0)
                                                         {
                                                            si32(_loc19_ = li32(_loc54_),_freelist + 4);
                                                         }
                                                         else
                                                         {
                                                            if((uint(_loc19_ = (_loc19_ = (_loc19_ = (_loc54_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                            {
                                                               si32(_loc19_ = _loc54_ + 32,_pmem_next);
                                                            }
                                                            else
                                                            {
                                                               _loc1_ -= 16;
                                                               si32(32,_loc1_);
                                                               ESP = _loc1_;
                                                               F_malloc();
                                                               _loc1_ += 16;
                                                               _loc54_ = eax;
                                                            }
                                                            si32(1,_loc54_ + 4);
                                                            si32(2,_loc54_ + 8);
                                                         }
                                                         if((_loc19_ = li32(___isthreaded)) != 0)
                                                         {
                                                            _loc1_ -= 16;
                                                            si32(___gdtoa_locks,_loc1_);
                                                            ESP = _loc1_;
                                                            F__pthread_mutex_unlock();
                                                            _loc1_ += 16;
                                                         }
                                                         si32(0,_loc54_ + 12);
                                                         si32(1,_loc54_ + 20);
                                                         si32(1,_loc54_ + 16);
                                                         _loc31_ = _loc7_;
                                                         _loc33_ = _loc20_;
                                                      }
                                                      if(_loc33_ >= 1)
                                                      {
                                                         if(_loc30_ >= 1)
                                                         {
                                                            _loc20_ = _loc30_;
                                                            if(_loc30_ > _loc33_)
                                                            {
                                                               _loc20_ = _loc33_;
                                                            }
                                                            si32(_loc20_,_loc2_ - 4);
                                                            _loc30_ -= _loc20_;
                                                            _loc33_ -= _loc20_;
                                                            _loc37_ -= _loc20_;
                                                         }
                                                      }
                                                      _loc20_ = _loc47_;
                                                      if(_loc46_ >= 1)
                                                      {
                                                         if(_loc6_ != 0)
                                                         {
                                                            _loc20_ = _loc47_;
                                                            if(_loc31_ >= 1)
                                                            {
                                                               _loc1_ -= 16;
                                                               si32(_loc31_,_loc1_ + 4);
                                                               si32(_loc54_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___pow5mult_D2A();
                                                               _loc1_ += 16;
                                                               _loc54_ = eax;
                                                               _loc1_ -= 16;
                                                               si32(_loc47_,_loc1_ + 4);
                                                               si32(_loc54_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___mult_D2A();
                                                               _loc1_ += 16;
                                                               _loc20_ = eax;
                                                               if(_loc47_ != 0)
                                                               {
                                                                  if((_loc7_ = li32(_loc47_ + 4)) >= 10)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(_loc47_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F_idalloc();
                                                                     _loc1_ += 16;
                                                                  }
                                                                  else
                                                                  {
                                                                     if((_loc19_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(___gdtoa_locks,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F__pthread_mutex_lock();
                                                                        _loc1_ += 16;
                                                                        _loc7_ = li32(_loc47_ + 4);
                                                                     }
                                                                     _loc19_ = _loc7_ << 2;
                                                                     si32(_loc19_ = li32(_loc48_ = _freelist + _loc19_),_loc47_);
                                                                     si32(_loc47_,_loc48_);
                                                                     if((_loc19_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(___gdtoa_locks,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F__pthread_mutex_unlock();
                                                                        _loc1_ += 16;
                                                                     }
                                                                  }
                                                               }
                                                            }
                                                            if(_loc46_ != _loc31_)
                                                            {
                                                               _loc1_ -= 16;
                                                               si32(_loc20_,_loc1_);
                                                               si32(_loc19_ = _loc46_ - _loc31_,_loc1_ + 4);
                                                               ESP = _loc1_;
                                                               F___pow5mult_D2A();
                                                               _loc1_ += 16;
                                                               _loc20_ = eax;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc1_ -= 16;
                                                            si32(_loc46_,_loc1_ + 4);
                                                            si32(_loc47_,_loc1_);
                                                            ESP = _loc1_;
                                                            F___pow5mult_D2A();
                                                            _loc1_ += 16;
                                                            _loc20_ = eax;
                                                         }
                                                      }
                                                      if((_loc19_ = li32(___isthreaded)) != 0)
                                                      {
                                                         _loc1_ -= 16;
                                                         si32(___gdtoa_locks,_loc1_);
                                                         ESP = _loc1_;
                                                         F__pthread_mutex_lock();
                                                         _loc1_ += 16;
                                                      }
                                                      if((_loc46_ = li32(_freelist + 4)) != 0)
                                                      {
                                                         si32(_loc19_ = li32(_loc46_),_freelist + 4);
                                                      }
                                                      else
                                                      {
                                                         if((uint(_loc19_ = (_loc19_ = (_loc19_ = (_loc46_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                         {
                                                            si32(_loc19_ = _loc46_ + 32,_pmem_next);
                                                         }
                                                         else
                                                         {
                                                            _loc1_ -= 16;
                                                            si32(32,_loc1_);
                                                            ESP = _loc1_;
                                                            F_malloc();
                                                            _loc1_ += 16;
                                                            _loc46_ = eax;
                                                         }
                                                         si32(1,_loc46_ + 4);
                                                         si32(2,_loc46_ + 8);
                                                      }
                                                      if((_loc19_ = li32(___isthreaded)) != 0)
                                                      {
                                                         _loc1_ -= 16;
                                                         si32(___gdtoa_locks,_loc1_);
                                                         ESP = _loc1_;
                                                         F__pthread_mutex_unlock();
                                                         _loc1_ += 16;
                                                      }
                                                      si32(_loc47_ = 0,_loc46_ + 12);
                                                      si32(_loc7_ = 1,_loc46_ + 20);
                                                      si32(_loc7_,_loc46_ + 16);
                                                      if(_loc29_ >= 1)
                                                      {
                                                         _loc1_ -= 16;
                                                         si32(_loc29_,_loc1_ + 4);
                                                         si32(_loc46_,_loc1_);
                                                         ESP = _loc1_;
                                                         F___pow5mult_D2A();
                                                         _loc1_ += 16;
                                                         _loc46_ = eax;
                                                      }
                                                      if(_loc38_ <= 1)
                                                      {
                                                         if(_loc50_ == 1)
                                                         {
                                                            _loc47_ = 0;
                                                            if((_loc19_ = li32(_loc9_ + 4)) + 1 < _loc53_)
                                                            {
                                                               _loc30_ += 1;
                                                               _loc37_ += 1;
                                                               _loc47_ = 1;
                                                            }
                                                         }
                                                      }
                                                      if(_loc29_ != 0)
                                                      {
                                                         _loc34_ = (_loc8_ = li32((_loc19_ = (_loc19_ = (_loc19_ = li32(_loc46_ + 16)) << 2) + _loc46_) + 16)) << 16;
                                                         if(uint(_loc8_) >= 65536)
                                                         {
                                                            _loc34_ = _loc8_;
                                                         }
                                                         _loc7_ = _loc34_ << 8;
                                                         if(uint(_loc34_) >= 16777216)
                                                         {
                                                            _loc7_ = _loc34_;
                                                         }
                                                         _loc53_ = _loc7_ << 4;
                                                         if(uint(_loc7_) >= 268435456)
                                                         {
                                                            _loc53_ = _loc7_;
                                                         }
                                                         _loc9_ = _loc53_ << 2;
                                                         if(uint(_loc53_) >= 1073741824)
                                                         {
                                                            _loc9_ = _loc53_;
                                                         }
                                                         _loc50_ = 16;
                                                         if(uint(_loc8_) >= 65536)
                                                         {
                                                            _loc50_ = 0;
                                                         }
                                                         _loc8_ = _loc50_ | 8;
                                                         if(uint(_loc34_) >= 16777216)
                                                         {
                                                            _loc8_ = _loc50_;
                                                         }
                                                         _loc50_ = _loc8_ | 4;
                                                         if(uint(_loc7_) >= 268435456)
                                                         {
                                                            _loc50_ = _loc8_;
                                                         }
                                                         _loc7_ = _loc50_ | 2;
                                                         if(uint(_loc53_) >= 1073741824)
                                                         {
                                                            _loc7_ = _loc50_;
                                                         }
                                                         if(_loc9_ >= 0)
                                                         {
                                                            _loc7_ += 1;
                                                            _loc9_ = 32;
                                                            if((_loc9_ & 1073741824) != 0)
                                                            {
                                                               addr4172:
                                                               _loc9_ = _loc7_;
                                                            }
                                                            _loc7_ = 32 - _loc9_;
                                                            addr4181:
                                                            si32(_loc9_ = (_loc19_ = _loc7_ + _loc30_) & 31,_loc2_ - 4);
                                                            _loc53_ = 0;
                                                            if(_loc9_ != 0)
                                                            {
                                                               si32(_loc53_ = 32 - _loc9_,_loc2_ - 4);
                                                               if(uint(_loc53_) >= 5)
                                                               {
                                                                  si32(_loc19_ = _loc53_ + -4,_loc2_ - 4);
                                                                  _loc30_ = _loc19_ + _loc30_;
                                                                  _loc33_ = _loc19_ + _loc33_;
                                                                  _loc37_ = _loc19_ + _loc37_;
                                                               }
                                                               else if(uint(_loc53_) <= 3)
                                                               {
                                                                  addr4248:
                                                                  si32(_loc19_ = _loc53_ + 28,_loc2_ - 4);
                                                                  _loc30_ = _loc19_ + _loc30_;
                                                                  _loc33_ = _loc19_ + _loc33_;
                                                                  _loc37_ = _loc19_ + _loc37_;
                                                               }
                                                               if(_loc37_ >= 1)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(_loc37_,_loc1_ + 4);
                                                                  si32(_loc20_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F___lshift_D2A();
                                                                  _loc1_ += 16;
                                                                  _loc20_ = eax;
                                                               }
                                                               if(_loc30_ >= 1)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(_loc30_,_loc1_ + 4);
                                                                  si32(_loc46_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F___lshift_D2A();
                                                                  _loc1_ += 16;
                                                                  _loc46_ = eax;
                                                               }
                                                               if(_loc49_ != 0)
                                                               {
                                                                  _loc49_ = li32(_loc46_ + 16);
                                                                  if((_loc9_ = li32(_loc20_ + 16)) != _loc49_)
                                                                  {
                                                                     _loc53_ = _loc9_ - _loc49_;
                                                                     addr4434:
                                                                     if(_loc53_ <= -1)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(0,_loc1_ + 8);
                                                                        si32(10,_loc1_ + 4);
                                                                        si32(_loc20_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F___multadd_D2A();
                                                                        _loc17_ += -1;
                                                                        _loc1_ += 16;
                                                                        _loc20_ = eax;
                                                                        _loc36_ = _loc5_;
                                                                        if(_loc6_ != 0)
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(0,_loc1_ + 8);
                                                                           si32(10,_loc1_ + 4);
                                                                           si32(_loc54_,_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___multadd_D2A();
                                                                           _loc1_ += 16;
                                                                           _loc54_ = eax;
                                                                           _loc36_ = _loc5_;
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc50_ = (_loc19_ = (_loc48_ = _loc49_ << 2) + _loc20_) + 20;
                                                                     _loc7_ = (_loc19_ = _loc48_ + _loc46_) + 16;
                                                                     _loc53_ = _loc20_ + 20;
                                                                     while(true)
                                                                     {
                                                                        _loc49_ = li32(_loc7_);
                                                                        if((_loc9_ = li32(_loc50_ - 4)) == _loc49_)
                                                                        {
                                                                           _loc50_ += -4;
                                                                           _loc7_ += -4;
                                                                           if(uint(_loc50_) <= uint(_loc53_))
                                                                           {
                                                                              break;
                                                                           }
                                                                           continue;
                                                                        }
                                                                        _loc53_ = -1;
                                                                        if(uint(_loc9_) >= uint(_loc49_))
                                                                        {
                                                                           _loc53_ = 1;
                                                                        }
                                                                        §§goto(addr4434);
                                                                     }
                                                                  }
                                                               }
                                                               if(_loc36_ <= 0)
                                                               {
                                                                  if(_loc38_ >= 3)
                                                                  {
                                                                     if(_loc36_ >= 0)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(0,_loc1_ + 8);
                                                                        si32(5,_loc1_ + 4);
                                                                        si32(_loc46_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F___multadd_D2A();
                                                                        _loc1_ += 16;
                                                                        _loc3_ = li32((_loc46_ = eax) + 16);
                                                                        if((_loc52_ = li32(_loc20_ + 16)) != _loc3_)
                                                                        {
                                                                           _loc52_ -= _loc3_;
                                                                           addr4644:
                                                                           _loc10_ = _loc17_;
                                                                           _loc47_ = _loc20_;
                                                                           _loc14_ = _loc46_;
                                                                           if(_loc52_ > 0)
                                                                           {
                                                                           }
                                                                           §§goto(addr4666);
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc52_ = _loc20_ + 20;
                                                                           _loc49_ = _loc3_ << 2;
                                                                           while(true)
                                                                           {
                                                                              _loc47_ = li32((_loc19_ = _loc46_ + _loc49_) + 16);
                                                                              _loc3_ = li32((_loc19_ = _loc20_ + _loc49_) + 16);
                                                                              if(_loc3_ == _loc47_)
                                                                              {
                                                                                 _loc49_ += -4;
                                                                                 if((uint(_loc19_ = _loc52_ + _loc49_)) <= uint(_loc52_))
                                                                                 {
                                                                                    break;
                                                                                 }
                                                                                 continue;
                                                                              }
                                                                              _loc52_ = -1;
                                                                              if(uint(_loc3_) >= uint(_loc47_))
                                                                              {
                                                                                 _loc52_ = 1;
                                                                              }
                                                                              §§goto(addr4644);
                                                                           }
                                                                        }
                                                                     }
                                                                     §§goto(addr4654);
                                                                  }
                                                                  §§goto(addr4666);
                                                               }
                                                               if(_loc6_ == 0)
                                                               {
                                                                  si32(1,_loc2_ - 4);
                                                                  _loc1_ -= 16;
                                                                  si32(_loc46_,_loc1_ + 4);
                                                                  si32(_loc20_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F___quorem_D2A();
                                                                  _loc1_ += 16;
                                                                  si8(_loc47_ = (_loc19_ = eax) + 48,_loc16_);
                                                                  _loc37_ = _loc16_ + 1;
                                                                  _loc51_ = 0;
                                                                  if((_loc19_ = li32(_loc2_ - 4)) < _loc36_)
                                                                  {
                                                                     _loc37_ = _loc3_ + 5;
                                                                     while(true)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(_loc51_ = 0,_loc1_ + 8);
                                                                        si32(10,_loc1_ + 4);
                                                                        si32(_loc20_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F___multadd_D2A();
                                                                        _loc1_ += 16;
                                                                        _loc20_ = eax;
                                                                        si32(_loc19_ = (_loc19_ = li32(_loc2_ - 4)) + 1,_loc2_ - 4);
                                                                        _loc1_ -= 16;
                                                                        si32(_loc46_,_loc1_ + 4);
                                                                        si32(_loc20_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F___quorem_D2A();
                                                                        _loc1_ += 16;
                                                                        si8(_loc47_ = (_loc19_ = eax) + 48,_loc37_);
                                                                        _loc37_ += 1;
                                                                        if((_loc19_ = li32(_loc2_ - 4)) < _loc36_)
                                                                        {
                                                                           continue;
                                                                        }
                                                                     }
                                                                  }
                                                                  addr6219:
                                                                  if(_loc45_ != 0)
                                                                  {
                                                                     if(_loc45_ == 2)
                                                                     {
                                                                        _loc52_ = li32(_loc20_ + 16);
                                                                     }
                                                                     else
                                                                     {
                                                                        if((_loc19_ = li32(_loc20_ + 16)) <= 1)
                                                                        {
                                                                           if((_loc19_ = li32(_loc20_ + 20)) == 0)
                                                                           {
                                                                              addr6447:
                                                                              _loc19_ = li32(_loc20_ + 20);
                                                                              _loc8_ = 0;
                                                                              if(_loc19_ != 0)
                                                                              {
                                                                                 addr6458:
                                                                                 _loc8_ = 16;
                                                                              }
                                                                              _loc52_ = _loc37_ + 1;
                                                                              while(true)
                                                                              {
                                                                                 _loc37_ = _loc52_ + -1;
                                                                                 _loc19_ = li8(_loc52_ - 2);
                                                                                 _loc52_ = _loc37_;
                                                                                 if(_loc19_ == 48)
                                                                                 {
                                                                                    continue;
                                                                                 }
                                                                                 §§goto(addr4666);
                                                                              }
                                                                           }
                                                                           §§goto(addr4666);
                                                                        }
                                                                        addr6388:
                                                                        _loc3_ += 4;
                                                                        while(true)
                                                                        {
                                                                           if((_loc47_ = li8((_loc52_ = _loc37_) - 1)) != 57)
                                                                           {
                                                                              si8(_loc19_ = _loc47_ + 1,_loc52_ - 1);
                                                                              _loc8_ = 32;
                                                                              _loc37_ = _loc52_;
                                                                              break;
                                                                           }
                                                                           _loc37_ = _loc52_ + -1;
                                                                           if(_loc3_ == _loc37_)
                                                                           {
                                                                              si8(49,_loc37_);
                                                                              _loc17_ += 1;
                                                                              _loc8_ = 32;
                                                                              _loc37_ = _loc52_;
                                                                              break;
                                                                           }
                                                                        }
                                                                        §§goto(addr4666);
                                                                     }
                                                                     §§goto(addr4666);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(1,_loc1_ + 4);
                                                                     si32(_loc20_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___lshift_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc20_ = eax;
                                                                     _loc49_ = li32(_loc46_ + 16);
                                                                     if((_loc52_ = li32(_loc20_ + 16)) != _loc49_)
                                                                     {
                                                                        _loc53_ = _loc52_ - _loc49_;
                                                                        addr6372:
                                                                        if(_loc53_ <= 0)
                                                                        {
                                                                           if(_loc53_ == 0)
                                                                           {
                                                                              addr6380:
                                                                              if((_loc19_ = _loc47_ & 1) == 0)
                                                                              {
                                                                                 addr6443:
                                                                                 if(_loc52_ <= 1)
                                                                                 {
                                                                                    §§goto(addr6447);
                                                                                 }
                                                                                 §§goto(addr6458);
                                                                              }
                                                                              §§goto(addr4666);
                                                                           }
                                                                           §§goto(addr6443);
                                                                        }
                                                                        §§goto(addr6388);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc36_ = (_loc48_ = (_loc19_ = _loc49_ << 2) + _loc20_) + 20;
                                                                        _loc53_ = (_loc19_ += _loc46_) + 16;
                                                                        _loc7_ = _loc20_ + 20;
                                                                        while(true)
                                                                        {
                                                                           _loc49_ = li32(_loc53_);
                                                                           if((_loc9_ = li32(_loc36_ - 4)) == _loc49_)
                                                                           {
                                                                              _loc36_ += -4;
                                                                              _loc53_ += -4;
                                                                              if(uint(_loc36_) <= uint(_loc7_))
                                                                              {
                                                                                 break;
                                                                              }
                                                                              continue;
                                                                           }
                                                                           _loc53_ = -1;
                                                                           if(uint(_loc9_) >= uint(_loc49_))
                                                                           {
                                                                              _loc53_ = 1;
                                                                           }
                                                                           §§goto(addr6372);
                                                                        }
                                                                     }
                                                                     §§goto(addr6380);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  if(_loc33_ >= 1)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(_loc33_,_loc1_ + 4);
                                                                     si32(_loc54_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___lshift_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc54_ = eax;
                                                                  }
                                                                  _loc9_ = _loc54_;
                                                                  if(_loc47_ != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(li32(_loc54_ + 4),_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___Balloc_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc1_ -= 16;
                                                                     si32(_loc48_ = (_loc48_ = li32(_loc54_ + 16) << 2) + 8,_loc1_ + 8);
                                                                     si32(_loc48_ = _loc54_ + 12,_loc1_ + 4);
                                                                     si32(_loc48_ = eax + 12,_loc1_);
                                                                     ESP = _loc1_;
                                                                     Fmemcpy();
                                                                     _loc1_ += 16;
                                                                     _loc1_ -= 16;
                                                                     si32(1,_loc1_ + 4);
                                                                     si32(eax,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___lshift_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc9_ = eax;
                                                                  }
                                                                  _loc49_ = _loc3_ + 4;
                                                                  _loc37_ = _loc3_ + 5;
                                                                  _loc47_ = 1;
                                                                  _loc8_ = 0;
                                                                  _loc51_ = _loc54_;
                                                                  _loc54_ = _loc9_;
                                                                  while(true)
                                                                  {
                                                                     si32(_loc47_,_loc2_ - 4);
                                                                     _loc1_ -= 16;
                                                                     si32(_loc46_,_loc1_ + 4);
                                                                     si32(_loc20_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___quorem_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc9_ = eax;
                                                                     _loc53_ = li32(_loc51_ + 16);
                                                                     _loc7_ = li32(_loc20_ + 16);
                                                                     _loc47_ = _loc9_ + 48;
                                                                     if(_loc7_ != _loc53_)
                                                                     {
                                                                        _loc53_ = _loc7_ - _loc53_;
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc19_ = _loc53_ << 2;
                                                                        _loc5_ = (_loc50_ = _loc20_ + 20) + _loc19_;
                                                                        _loc7_ = (_loc19_ = _loc51_ + _loc19_) + 16;
                                                                        do
                                                                        {
                                                                           _loc6_ = li32(_loc7_);
                                                                           if((_loc33_ = li32(_loc5_ - 4)) != _loc6_)
                                                                           {
                                                                              _loc53_ = -1;
                                                                              if(uint(_loc33_) >= uint(_loc6_))
                                                                              {
                                                                                 _loc53_ = 1;
                                                                              }
                                                                              break;
                                                                           }
                                                                           _loc5_ += -4;
                                                                           _loc7_ += -4;
                                                                           _loc53_ = 0;
                                                                        }
                                                                        while(uint(_loc5_) > uint(_loc50_));
                                                                        
                                                                     }
                                                                     _loc1_ -= 16;
                                                                     si32(_loc54_,_loc1_ + 4);
                                                                     si32(_loc46_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___diff_D2A();
                                                                     _loc1_ += 16;
                                                                     _loc19_ = li32((_loc7_ = eax) + 12);
                                                                     _loc50_ = 1;
                                                                     if(_loc19_ == 0)
                                                                     {
                                                                        _loc33_ = li32(_loc7_ + 16);
                                                                        if((_loc50_ = li32(_loc20_ + 16)) != _loc33_)
                                                                        {
                                                                           _loc50_ -= _loc33_;
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc19_ = _loc33_ << 2;
                                                                           _loc30_ = (_loc34_ = _loc20_ + 20) + _loc19_;
                                                                           _loc33_ = (_loc19_ = _loc7_ + _loc19_) + 16;
                                                                           while(true)
                                                                           {
                                                                              _loc6_ = li32(_loc33_);
                                                                              if((_loc5_ = li32(_loc30_ - 4)) == _loc6_)
                                                                              {
                                                                                 _loc30_ += -4;
                                                                                 _loc33_ += -4;
                                                                                 _loc50_ = 0;
                                                                                 if(uint(_loc30_) <= uint(_loc34_))
                                                                                 {
                                                                                    addr5166:
                                                                                    if(_loc7_ != 0)
                                                                                    {
                                                                                       addr5170:
                                                                                       if((_loc33_ = li32(_loc7_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc7_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F_idalloc();
                                                                                          _loc1_ += 16;
                                                                                          break;
                                                                                       }
                                                                                       if((_loc19_ = li32(___isthreaded)) != 0)
                                                                                       {
                                                                                          _loc1_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F__pthread_mutex_lock();
                                                                                          _loc1_ += 16;
                                                                                          _loc33_ = li32(_loc7_ + 4);
                                                                                       }
                                                                                       _loc19_ = _loc33_ << 2;
                                                                                       si32(_loc48_ = li32(_loc19_ = _freelist + _loc19_),_loc7_);
                                                                                       si32(_loc7_,_loc19_);
                                                                                       if((_loc19_ = li32(___isthreaded)) != 0)
                                                                                       {
                                                                                          _loc1_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F__pthread_mutex_unlock();
                                                                                          _loc1_ += 16;
                                                                                          break;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    break;
                                                                                 }
                                                                                 continue;
                                                                              }
                                                                              _loc50_ = -1;
                                                                              if(uint(_loc5_) >= uint(_loc6_))
                                                                              {
                                                                                 _loc50_ = 1;
                                                                              }
                                                                              §§goto(addr5170);
                                                                           }
                                                                           if((_loc19_ = _loc50_ | _loc38_) == 0)
                                                                           {
                                                                              if((_loc19_ = (_loc19_ = (_loc19_ = li32(_loc52_)) & 1) | _loc45_) != 0)
                                                                              {
                                                                                 addr5349:
                                                                                 if(_loc53_ >= 0)
                                                                                 {
                                                                                    if((_loc19_ = _loc53_ | _loc38_) == 0)
                                                                                    {
                                                                                       if((_loc19_ = (_loc19_ = li8(_loc52_)) & 1) == 0)
                                                                                       {
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    if(_loc50_ >= 1)
                                                                                    {
                                                                                       if(_loc45_ != 2)
                                                                                       {
                                                                                          if(_loc47_ == 57)
                                                                                          {
                                                                                             §§goto(addr5928);
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             si8(_loc19_ = _loc47_ + 1,_loc49_);
                                                                                             _loc8_ = 32;
                                                                                             §§goto(addr4666);
                                                                                          }
                                                                                       }
                                                                                       §§goto(addr6388);
                                                                                    }
                                                                                    si8(_loc47_,_loc49_);
                                                                                    if((_loc19_ = li32(_loc2_ - 4)) != _loc36_)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    §§goto(addr6219);
                                                                                 }
                                                                                 break;
                                                                              }
                                                                              if(_loc47_ != 57)
                                                                              {
                                                                                 if(_loc53_ <= 0)
                                                                                 {
                                                                                    if((_loc19_ = li32(_loc20_ + 16)) >= 2)
                                                                                    {
                                                                                       addr5332:
                                                                                       _loc8_ = 16;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc8_ = 0;
                                                                                       if(li32(_loc20_ + 20) != 0)
                                                                                       {
                                                                                          §§goto(addr5332);
                                                                                       }
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc47_ = _loc9_ + 49;
                                                                                    _loc8_ = 32;
                                                                                 }
                                                                                 si8(_loc47_,_loc49_);
                                                                                 §§goto(addr4666);
                                                                              }
                                                                              else
                                                                              {
                                                                                 addr5928:
                                                                                 si8(57,_loc49_);
                                                                                 _loc37_ = _loc49_ + 1;
                                                                              }
                                                                              §§goto(addr4666);
                                                                              §§goto(addr6388);
                                                                           }
                                                                           §§goto(addr5349);
                                                                        }
                                                                     }
                                                                     §§goto(addr5166);
                                                                  }
                                                                  if(_loc45_ != 0)
                                                                  {
                                                                     if((_loc19_ = li32(_loc20_ + 16)) <= 1)
                                                                     {
                                                                        if((_loc19_ = li32(_loc20_ + 20)) != 0)
                                                                        {
                                                                           addr5394:
                                                                           if(_loc45_ != 2)
                                                                           {
                                                                              _loc9_ = li32(_loc54_ + 16);
                                                                              if((_loc52_ = li32(_loc46_ + 16)) != _loc9_)
                                                                              {
                                                                                 _loc53_ = _loc52_ - _loc9_;
                                                                                 addr5490:
                                                                                 if(_loc53_ >= 1)
                                                                                 {
                                                                                    _loc52_ = _loc46_ + 20;
                                                                                    _loc53_ = _loc54_;
                                                                                    _loc36_ = _loc51_;
                                                                                    while(true)
                                                                                    {
                                                                                       _loc49_ = _loc37_;
                                                                                       si8(_loc47_,_loc49_ - 1);
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc8_,_loc1_ + 8);
                                                                                       si32(10,_loc1_ + 4);
                                                                                       si32(_loc53_,_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___multadd_D2A();
                                                                                       _loc1_ += 16;
                                                                                       _loc54_ = eax;
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc8_,_loc1_ + 8);
                                                                                       si32(10,_loc1_ + 4);
                                                                                       si32(_loc20_,_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___multadd_D2A();
                                                                                       _loc1_ += 16;
                                                                                       _loc20_ = eax;
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc20_,_loc1_);
                                                                                       _loc51_ = _loc54_;
                                                                                       if(_loc36_ != _loc53_)
                                                                                       {
                                                                                          _loc51_ = _loc36_;
                                                                                       }
                                                                                       si32(_loc46_,_loc1_ + 4);
                                                                                       ESP = _loc1_;
                                                                                       F___quorem_D2A();
                                                                                       _loc1_ += 16;
                                                                                       _loc19_ = eax;
                                                                                       _loc53_ = li32(_loc54_ + 16);
                                                                                       _loc9_ = li32(_loc46_ + 16);
                                                                                       _loc47_ = _loc19_ + 48;
                                                                                       if(_loc9_ == _loc53_)
                                                                                       {
                                                                                          _loc19_ = _loc53_ << 2;
                                                                                          _loc9_ = _loc52_ + _loc19_;
                                                                                          _loc7_ = (_loc19_ = _loc54_ + _loc19_) + 16;
                                                                                          while(true)
                                                                                          {
                                                                                             _loc53_ = li32(_loc7_);
                                                                                             if((_loc36_ = li32(_loc9_ - 4)) != _loc53_)
                                                                                             {
                                                                                                _loc9_ = -1;
                                                                                                if(uint(_loc36_) >= uint(_loc53_))
                                                                                                {
                                                                                                   _loc9_ = 1;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc9_ += -4;
                                                                                                _loc7_ += -4;
                                                                                                if(uint(_loc9_) > uint(_loc52_))
                                                                                                {
                                                                                                   continue;
                                                                                                }
                                                                                                addr5715:
                                                                                                if((_loc47_ += 1) != 58)
                                                                                                {
                                                                                                   _loc8_ = 32;
                                                                                                   addr5906:
                                                                                                   si8(_loc47_,_loc49_);
                                                                                                   _loc37_ = _loc49_ + 1;
                                                                                                   §§goto(addr4666);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   §§goto(addr5928);
                                                                                                }
                                                                                             }
                                                                                             §§goto(addr5715);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc9_ -= _loc53_;
                                                                                       }
                                                                                       _loc37_ = _loc49_ + 1;
                                                                                       _loc53_ = _loc54_;
                                                                                       _loc36_ = _loc51_;
                                                                                       if(_loc9_ > 0)
                                                                                       {
                                                                                          continue;
                                                                                       }
                                                                                    }
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc7_ = (_loc19_ = (_loc48_ = _loc9_ << 2) + _loc46_) + 20;
                                                                                 _loc53_ = (_loc19_ = _loc48_ + _loc54_) + 16;
                                                                                 _loc36_ = _loc46_ + 20;
                                                                                 while(true)
                                                                                 {
                                                                                    _loc52_ = li32(_loc53_);
                                                                                    if((_loc9_ = li32(_loc7_ - 4)) == _loc52_)
                                                                                    {
                                                                                       _loc7_ += -4;
                                                                                       _loc53_ += -4;
                                                                                       if(uint(_loc7_) <= uint(_loc36_))
                                                                                       {
                                                                                          break;
                                                                                       }
                                                                                       continue;
                                                                                    }
                                                                                    _loc53_ = -1;
                                                                                    if(uint(_loc9_) >= uint(_loc52_))
                                                                                    {
                                                                                       _loc53_ = 1;
                                                                                    }
                                                                                    §§goto(addr5490);
                                                                                 }
                                                                              }
                                                                              §§goto(addr5715);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc8_ = 16;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           addr5728:
                                                                           if(_loc50_ <= 0)
                                                                           {
                                                                              _loc52_ = li32(_loc20_ + 16);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(1,_loc1_ + 4);
                                                                              si32(_loc20_,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F___lshift_D2A();
                                                                              _loc1_ += 16;
                                                                              _loc20_ = eax;
                                                                              _loc53_ = li32(_loc46_ + 16);
                                                                              if((_loc52_ = li32(_loc20_ + 16)) != _loc53_)
                                                                              {
                                                                                 _loc7_ = _loc52_ - _loc53_;
                                                                                 addr5858:
                                                                                 if(_loc7_ <= 0)
                                                                                 {
                                                                                    _loc8_ = 32;
                                                                                    if(_loc7_ == 0)
                                                                                    {
                                                                                       addr5868:
                                                                                       _loc19_ = _loc47_ & 1;
                                                                                       _loc8_ = 32;
                                                                                       if(_loc19_ != 0)
                                                                                       {
                                                                                       }
                                                                                       addr5890:
                                                                                       if(_loc52_ <= 1)
                                                                                       {
                                                                                          if((_loc19_ = li32(_loc20_ + 20)) != 0)
                                                                                          {
                                                                                          }
                                                                                          §§goto(addr5906);
                                                                                       }
                                                                                       _loc8_ = 16;
                                                                                       §§goto(addr5906);
                                                                                    }
                                                                                    §§goto(addr5890);
                                                                                 }
                                                                                 if((_loc47_ = _loc9_ + 49) != 58)
                                                                                 {
                                                                                    _loc8_ = 32;
                                                                                    §§goto(addr5890);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    §§goto(addr5928);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc45_ = (_loc19_ = (_loc48_ = _loc53_ << 2) + _loc20_) + 20;
                                                                                 _loc38_ = (_loc19_ = _loc48_ + _loc46_) + 16;
                                                                                 _loc7_ = _loc20_ + 20;
                                                                                 while(true)
                                                                                 {
                                                                                    _loc36_ = li32(_loc38_);
                                                                                    if((_loc53_ = li32(_loc45_ - 4)) == _loc36_)
                                                                                    {
                                                                                       _loc45_ += -4;
                                                                                       _loc38_ += -4;
                                                                                       if(uint(_loc45_) <= uint(_loc7_))
                                                                                       {
                                                                                          break;
                                                                                       }
                                                                                       continue;
                                                                                    }
                                                                                    _loc7_ = -1;
                                                                                    if(uint(_loc53_) >= uint(_loc36_))
                                                                                    {
                                                                                       _loc7_ = 1;
                                                                                    }
                                                                                    §§goto(addr5858);
                                                                                 }
                                                                              }
                                                                              §§goto(addr5868);
                                                                           }
                                                                           §§goto(addr5868);
                                                                        }
                                                                        §§goto(addr5906);
                                                                     }
                                                                     §§goto(addr5394);
                                                                  }
                                                                  §§goto(addr5728);
                                                               }
                                                               §§goto(addr4666);
                                                            }
                                                            §§goto(addr4248);
                                                         }
                                                         §§goto(addr4172);
                                                      }
                                                      §§goto(addr4181);
                                                   }
                                                }
                                                §§goto(addr3229);
                                             }
                                          }
                                       }
                                       _loc19_ = (_loc19_ = _loc2_ - 104) | 4;
                                       si32(_loc46_,_loc19_);
                                       si32(_loc54_,_loc2_ - 104);
                                       _loc40_ = _loc37_;
                                       _loc21_ = lf64(_loc2_ - 104);
                                       sf64(_loc40_ = (_loc40_ *= _loc21_) + 7,_loc2_ - 112);
                                       _loc12_ = (_loc19_ = li32(_loc19_ = (_loc19_ = _loc2_ - 112) | 4)) + -54525952;
                                       _loc8_ = li32(_loc2_ - 112);
                                       if(_loc14_ == 0)
                                       {
                                          si32(_loc12_,(_loc19_ = _loc2_ - 192) | 4);
                                          si32(_loc8_,_loc2_ - 192);
                                          _loc21_ += -5;
                                          _loc54_ = 0;
                                          _loc41_ = lf64(_loc2_ - 192);
                                          _loc14_ = _loc54_;
                                          if(_loc21_ <= _loc41_)
                                          {
                                             _loc54_ = 0;
                                             _loc20_ = _loc47_;
                                             _loc46_ = _loc54_;
                                             if(_loc21_ >= -_loc41_)
                                             {
                                                §§goto(addr2891);
                                             }
                                             §§goto(addr4654);
                                          }
                                          §§goto(addr4666);
                                       }
                                       else if(_loc6_ != 0)
                                       {
                                          si32(_loc12_,(_loc19_ = _loc2_ - 120) | 4);
                                          si32(_loc8_,_loc2_ - 120);
                                          si32(_loc8_ = 0,_loc2_ - 4);
                                          _loc22_ = (_loc39_ = _loc41_ * 0.5) / lf64((_loc19_ = (_loc19_ = _loc14_ << 3) + ___tens_D2A) - 8) - lf64(_loc2_ - 120);
                                          _loc37_ = _loc3_ + 5;
                                          while(true)
                                          {
                                             _loc19_ = (_loc19_ = _loc2_ - 128) | 4;
                                             si32(_loc46_,_loc19_);
                                             si32(_loc54_,_loc2_ - 128);
                                             var _loc18_:int;
                                             si8(_loc48_ = (_loc18_ = _loc39_ = (_loc40_ = lf64(_loc2_ - 128)) / _loc41_) + 48,_loc37_ - 1);
                                             _loc39_ = (_loc39_ = _loc18_) * _loc41_;
                                             if(!((_loc23_ = _loc40_ - _loc39_) >= _loc22_ | _loc23_ != _loc23_ | _loc22_ != _loc22_))
                                             {
                                                _loc17_ = _loc10_;
                                                _loc20_ = _loc47_;
                                                if(_loc23_ != 0)
                                                {
                                                   _loc8_ = 16;
                                                   _loc17_ = _loc10_;
                                                   _loc20_ = _loc47_;
                                                   break;
                                                }
                                                break;
                                             }
                                             if((_loc40_ = _loc41_ - _loc23_) >= _loc22_)
                                             {
                                                si32(_loc19_ = (_loc19_ = li32(_loc2_ - 4)) + 1,_loc2_ - 4);
                                                if(_loc19_ < _loc14_)
                                                {
                                                   continue;
                                                }
                                                §§goto(addr2891);
                                             }
                                          }
                                          §§goto(addr6840);
                                       }
                                       else
                                       {
                                          si32(1,_loc2_ - 4);
                                          _loc24_ = lf64((_loc19_ = (_loc19_ = _loc14_ << 3) + ___tens_D2A) - 8);
                                          _loc37_ = _loc3_ + 5;
                                          while(true)
                                          {
                                             _loc19_ = (_loc19_ = _loc2_ - 144) | 4;
                                             si32(_loc46_,_loc19_);
                                             si32(_loc54_,_loc2_ - 144);
                                             if((_loc15_ = _loc40_ = (_loc27_ = lf64(_loc2_ - 144)) / _loc41_) != 0)
                                             {
                                                sf64(_loc40_ = _loc27_ - (_loc40_ = _loc15_) * _loc41_,_loc2_ - 152);
                                                _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 152) | 4);
                                                _loc54_ = li32(_loc2_ - 152);
                                             }
                                             si8(_loc19_ = _loc15_ + 48,_loc37_ - 1);
                                             if((_loc15_ = li32(_loc2_ - 4)) == _loc14_)
                                             {
                                                break;
                                             }
                                             si32(_loc46_,(_loc19_ = _loc2_ - 160) | 4);
                                             si32(_loc54_,_loc2_ - 160);
                                             si32(_loc19_ = _loc15_ + 1,_loc2_ - 4);
                                             sf64(_loc40_ = (_loc40_ = lf64(_loc2_ - 160)) * 10,_loc2_ - 168);
                                             _loc37_ += 1;
                                             _loc46_ = li32(_loc19_ = (_loc19_ = _loc2_ - 168) | 4);
                                             _loc54_ = li32(_loc2_ - 168);
                                          }
                                          si32(_loc12_,(_loc19_ = _loc2_ - 176) | 4);
                                          si32(_loc46_,(_loc19_ = _loc2_ - 184) | 4);
                                          si32(_loc8_,_loc2_ - 176);
                                          si32(_loc54_,_loc2_ - 184);
                                          _loc23_ = (_loc40_ = lf64(_loc2_ - 176)) * _loc24_;
                                          _loc26_ = _loc41_ * 0.5;
                                          if((_loc41_ = lf64(_loc2_ - 184)) <= _loc23_ + _loc26_)
                                          {
                                             _loc40_ = _loc26_ - _loc23_;
                                             if(!(_loc41_ >= _loc40_ | _loc41_ != _loc41_ | _loc40_ != _loc40_))
                                             {
                                                _loc8_ = 0;
                                                _loc17_ = _loc10_;
                                                if(_loc41_ != 0)
                                                {
                                                   _loc8_ = 16;
                                                   _loc17_ = _loc10_;
                                                }
                                                §§goto(addr3091);
                                             }
                                             else
                                             {
                                                §§goto(addr2891);
                                             }
                                             if(_loc13_ != 0)
                                             {
                                                si32(_loc37_,_loc13_);
                                             }
                                             si32(_loc19_ = (_loc19_ = li32(_loc4_)) | _loc8_,_loc4_);
                                             §§goto(addr6985);
                                          }
                                       }
                                       §§goto(addr3108);
                                    }
                                 }
                              }
                              §§goto(addr2891);
                           }
                           §§goto(addr1726);
                        }
                        else
                        {
                           §§goto(addr1668);
                        }
                     }
                     else
                     {
                        _loc6_ = 0;
                     }
                     _loc3_ = (_loc5_ = _loc17_ + _loc51_) + 1;
                     si32(_loc3_,_loc2_ - 4);
                     _loc36_ = _loc3_;
                     if(_loc5_ <= -1)
                     {
                        si32(1,_loc2_ - 4);
                        _loc16_ = 0;
                        _loc36_ = _loc3_;
                     }
                     else
                     {
                        §§goto(addr1726);
                     }
                     §§goto(addr1755);
                  }
                  §§goto(addr1726);
               }
            }
            §§goto(addr6985);
         }
         si32(1,_loc11_);
         _loc1_ -= 16;
         si32(0,_loc1_);
         ESP = _loc1_;
         F___Balloc_D2A();
         _loc1_ += 16;
         _loc19_ = eax;
         si32(0,_loc19_);
         si8(48,_loc19_ + 4);
         si8(0,_loc19_ + 5);
         _loc16_ = _loc19_ + 4;
         if(_loc13_ != 0)
         {
            si32(_loc19_ = _loc16_ + 1,_loc13_);
         }
      }
      else if(_loc17_ != 4)
      {
         if(_loc17_ == 3)
         {
            si32(-32768,_loc11_);
            _loc1_ -= 16;
            si32(0,_loc1_);
            ESP = _loc1_;
            F___Balloc_D2A();
            _loc1_ += 16;
            _loc11_ = eax;
            si32(0,_loc11_);
            si8(73,_loc11_ + 4);
            si8(110,_loc11_ + 5);
            si8(102,_loc11_ + 6);
            si8(105,_loc11_ + 7);
            si8(110,_loc11_ + 8);
            si8(105,_loc11_ + 9);
            si8(116,_loc11_ + 10);
            si8(121,_loc11_ + 11);
            si8(0,_loc11_ + 12);
            _loc16_ = _loc11_ + 4;
            if(_loc13_ != 0)
            {
               si32(_loc19_ = _loc11_ + 12,_loc13_);
            }
         }
      }
      else
      {
         si32(-32768,_loc11_);
         _loc1_ -= 16;
         si32(0,_loc1_);
         ESP = _loc1_;
         F___Balloc_D2A();
         _loc1_ += 16;
         _loc11_ = eax;
         si32(0,_loc11_);
         si8(78,_loc11_ + 4);
         si8(97,_loc11_ + 5);
         si8(78,_loc11_ + 6);
         si8(0,_loc11_ + 7);
         _loc16_ = _loc11_ + 4;
         if(_loc13_ != 0)
         {
            si32(_loc19_ = _loc11_ + 7,_loc13_);
         }
      }
      addr6985:
      eax = _loc16_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
