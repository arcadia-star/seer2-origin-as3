package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_rvOK;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1180;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str179;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2181;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._fivesbits;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ret_2E_1158;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___strtodg() : void
   {
      var _loc2_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc16_:* = 0;
      var _loc18_:* = 0;
      var _loc7_:* = 0;
      var _loc24_:* = 0;
      var _loc6_:* = 0;
      var _loc52_:* = 0;
      var _loc36_:* = 0;
      var _loc37_:* = 0;
      var _loc50_:* = 0;
      var _loc47_:* = 0;
      var _loc54_:* = 0;
      var _loc49_:* = 0;
      var _loc38_:* = 0;
      var _loc40_:Number = NaN;
      var _loc41_:Number = NaN;
      var _loc43_:Number = NaN;
      var _loc26_:* = NaN;
      var _loc28_:Number = NaN;
      var _loc27_:Number = NaN;
      var _loc20_:* = 0;
      var _loc22_:* = 0;
      var _loc23_:* = 0;
      var _loc9_:* = 0;
      var _loc32_:* = 0;
      var _loc35_:* = 0;
      var _loc29_:* = 0;
      var _loc33_:* = 0;
      var _loc10_:* = 0;
      var _loc53_:* = 0;
      var _loc48_:* = 0;
      var _loc51_:int = 0;
      var _loc31_:* = 0;
      var _loc45_:* = 0;
      var _loc46_:* = 0;
      var _loc30_:* = 0;
      var _loc34_:* = 0;
      var _loc8_:* = 0;
      var _loc11_:* = 0;
      var _loc17_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc44_:Number = NaN;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc19_:* = 0;
      var _loc25_:* = 0;
      var _loc3_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 224;
      ESP = _loc1_;
      F_localeconv();
      _loc20_ = (_loc23_ = li32(_loc24_ = (_loc7_ = li32(_ret_2E_1158)) & -4)) + -16843009;
      _loc20_ = (_loc23_ = (_loc23_ &= -2139062144) ^ -2139062144) & _loc20_;
      _loc18_ = li32(_loc2_ + 16);
      _loc16_ = li32(_loc2_ + 12);
      _loc14_ = li32(_loc2_ + 8);
      _loc12_ = li32(_loc2_ + 4);
      _loc10_ = li32(_loc2_);
      if(_loc20_ != 0)
      {
         _loc6_ = _loc24_ + 4;
         _loc51_ = 0;
         while(true)
         {
            if((uint(_loc52_ = _loc7_ + _loc51_)) < uint(_loc6_))
            {
               continue;
            }
         }
         §§goto(addr321);
      }
      _loc52_ = _loc24_ + 4;
      while(true)
      {
         _loc20_ = (_loc6_ = li32(_loc52_)) + -16843009;
         if((_loc20_ = (_loc23_ = (_loc23_ = _loc6_ & -2139062144) ^ -2139062144) & _loc20_) != 0)
         {
            if((_loc20_ = _loc6_ & 255) == 0)
            {
               _loc51_ = _loc52_ - _loc7_;
            }
            else if((_loc20_ = li8(_loc52_ + 1)) == 0)
            {
               _loc51_ = (_loc20_ = 1 - _loc7_) + _loc52_;
            }
            else if((_loc20_ = li8(_loc52_ + 2)) == 0)
            {
               _loc51_ = (_loc20_ = 2 - _loc7_) + _loc52_;
            }
            else
            {
               if((_loc20_ = li8(_loc52_ + 3)) != 0)
               {
                  continue;
               }
               _loc51_ = (_loc20_ = 3 - _loc7_) + _loc52_;
            }
            addr321:
            si32(_loc53_ = 0,_loc2_ - 20);
            si32(_loc53_,_loc2_ - 36);
            _loc52_ = li32(_loc14_);
            _loc54_ = _loc10_;
            loop1:
            while(true)
            {
               si32(_loc54_,_loc2_ - 32);
               if((_loc47_ = si8(li8(_loc54_))) <= 31)
               {
                  if(_loc47_ == 0)
                  {
                     addr407:
                     si32(6,_loc2_ - 20);
                     si32(_loc10_,_loc2_ - 32);
                     _loc6_ = 0;
                     break;
                  }
                  _loc6_ = _loc53_;
                  if(uint(_loc47_ + -9) < 5)
                  {
                     continue;
                  }
               }
               else
               {
                  if(_loc47_ == 32)
                  {
                     continue;
                  }
                  _loc6_ = 1;
                  if(_loc47_ != 45)
                  {
                     _loc6_ = _loc53_;
                     if(_loc47_ == 43)
                     {
                        _loc6_ = 0;
                     }
                     addr428:
                     _loc20_ = _loc47_ & 255;
                     _loc48_ = _loc53_;
                     if(_loc20_ == 48)
                     {
                        if((_loc20_ = (_loc20_ = si8(li8(_loc54_ + 1))) | 32) == 120)
                        {
                           _loc1_ -= 32;
                           si32(_loc6_,_loc1_ + 16);
                           si32(_loc20_ = _loc2_ - 36,_loc1_ + 12);
                           si32(_loc16_,_loc1_ + 8);
                           si32(_loc14_,_loc1_ + 4);
                           si32(_loc20_ = _loc2_ - 32,_loc1_);
                           ESP = _loc1_;
                           F___gethex_D2A();
                           _loc1_ += 32;
                           si32(_loc20_ = eax,_loc2_ - 20);
                           if(_loc20_ == 6)
                           {
                              si32(_loc10_,_loc2_ - 32);
                              _loc6_ = 0;
                              break;
                           }
                           break;
                        }
                        _loc54_ += 1;
                        while(true)
                        {
                           si32(_loc54_,_loc2_ - 32);
                           if((_loc47_ = li8(_loc54_)) != 0)
                           {
                              _loc48_ = 1;
                              if(_loc47_ == 48)
                              {
                                 continue;
                              }
                              addr554:
                              _loc24_ = li32(_loc14_ + 16);
                              _loc49_ = (_loc20_ = _loc47_ << 24) >> 24;
                              _loc20_ = (_loc20_ = _loc47_ + -48) & 255;
                              _loc50_ = _loc54_;
                              _loc46_ = _loc53_;
                              _loc45_ = _loc53_;
                              _loc38_ = _loc53_;
                              if(uint(_loc20_) <= 9)
                              {
                                 _loc36_ = _loc54_ + 1;
                                 _loc45_ = _loc46_ = 0;
                                 _loc38_ = _loc46_;
                                 do
                                 {
                                    _loc37_ = _loc38_;
                                    _loc47_ = _loc36_ + _loc37_;
                                    _loc50_ = _loc54_ + _loc37_;
                                    _loc38_ = _loc37_ + 1;
                                    if(_loc37_ <= 8)
                                    {
                                       _loc45_ = (_loc20_ = _loc49_ + _loc45_ * 10) + -48;
                                    }
                                    else if(_loc37_ <= 15)
                                    {
                                       _loc46_ = (_loc20_ = _loc49_ + _loc46_ * 10) + -48;
                                    }
                                    si32(_loc47_,_loc2_ - 32);
                                 }
                                 while((uint(_loc20_ = (_loc20_ = (_loc49_ = si8(li8(_loc50_ + 1))) + -48) & 255)) < 10);
                                 
                                 _loc50_ = _loc54_ + _loc38_;
                                 _loc47_ = _loc49_;
                              }
                              _loc23_ = _loc47_ & 255;
                              _loc20_ = li8(_loc7_);
                              _loc36_ = _loc53_;
                              _loc37_ = _loc53_;
                              _loc47_ = _loc38_;
                              _loc34_ = _loc53_;
                              if(_loc20_ == _loc23_)
                              {
                                 _loc35_ = _loc50_ + 2;
                                 _loc32_ = 1;
                                 loop6:
                                 do
                                 {
                                    if((_loc33_ = li8(_loc20_ = _loc7_ + _loc32_)) != 0)
                                    {
                                       continue;
                                    }
                                    si32(_loc47_ = _loc50_ + _loc32_,_loc2_ - 32);
                                    _loc49_ = si8(li8(_loc35_ - 1));
                                    _loc36_ = 0;
                                    _loc30_ = _loc54_;
                                    _loc7_ = _loc36_;
                                    _loc31_ = _loc38_;
                                    if(_loc38_ == 0)
                                    {
                                       _loc36_ = _loc29_ = 0;
                                       _loc33_ = _loc47_;
                                       _loc7_ = _loc29_;
                                       if((_loc49_ & 255) == 48)
                                       {
                                          do
                                          {
                                             si32(_loc20_ = _loc35_ + _loc36_,_loc2_ - 32);
                                             _loc49_ = (_loc20_ = (_loc23_ = li8(_loc20_)) << 24) >> 24;
                                             _loc36_ += 1;
                                          }
                                          while(_loc23_ == 48);
                                          
                                          _loc33_ = (_loc20_ = _loc50_ + _loc32_) + _loc36_;
                                          _loc7_ = _loc36_;
                                       }
                                       _loc20_ = _loc49_ + -49;
                                       _loc34_ = 1;
                                       _loc30_ = _loc33_;
                                       _loc31_ = _loc38_;
                                       _loc50_ = _loc33_;
                                       _loc36_ = _loc7_;
                                       _loc37_ = _loc29_;
                                       _loc47_ = _loc38_;
                                       if(uint(_loc20_) <= 8)
                                       {
                                          loop8:
                                          while(true)
                                          {
                                             _loc54_ = _loc49_ + -48;
                                             _loc36_ = _loc29_ + 1;
                                             if(_loc54_ != 0)
                                             {
                                                _loc47_ = 1;
                                                if(_loc31_ >= 9)
                                                {
                                                   _loc47_ = 0;
                                                }
                                                _loc7_ += _loc36_;
                                                if(_loc29_ >= 1)
                                                {
                                                   if((_loc49_ = _loc29_ + 1) <= 2)
                                                   {
                                                      _loc49_ = 2;
                                                   }
                                                   _loc37_ = _loc49_ + -1;
                                                   _loc50_ = _loc31_ + 1;
                                                   do
                                                   {
                                                      _loc49_ = _loc50_;
                                                      if((_loc20_ = _loc47_ & 1) != 0)
                                                      {
                                                         _loc45_ *= 10;
                                                      }
                                                      else if(_loc49_ <= 16)
                                                      {
                                                         _loc46_ *= 10;
                                                      }
                                                      _loc47_ = 1;
                                                      if(_loc49_ >= 9)
                                                      {
                                                         _loc47_ = 0;
                                                      }
                                                      _loc50_ = _loc49_ + 1;
                                                   }
                                                   while((_loc37_ += -1) != 0);
                                                   
                                                   if(_loc36_ <= 2)
                                                   {
                                                      _loc36_ = 2;
                                                   }
                                                   _loc47_ = _loc36_ + _loc31_;
                                                   if(_loc49_ < 9)
                                                   {
                                                      addr991:
                                                      _loc45_ = (_loc20_ = _loc45_ * 10) + _loc54_;
                                                      _loc36_ = 0;
                                                      _loc31_ = _loc47_;
                                                      addr1030:
                                                      si32(_loc47_ = _loc33_ + 1,_loc2_ - 32);
                                                      _loc49_ = si8(li8(_loc33_ + 1));
                                                      while(true)
                                                      {
                                                         _loc20_ = _loc49_ + -48;
                                                         _loc34_ = 1;
                                                         _loc33_ = _loc47_;
                                                         _loc29_ = _loc36_;
                                                         _loc50_ = _loc47_;
                                                         _loc54_ = _loc30_;
                                                         _loc37_ = _loc7_;
                                                         _loc47_ = _loc31_;
                                                         if(uint(_loc20_) >= 10)
                                                         {
                                                            break loop6;
                                                         }
                                                         continue loop8;
                                                      }
                                                      addr1047:
                                                   }
                                                   §§goto(addr1030);
                                                }
                                                else
                                                {
                                                   _loc47_ = _loc31_ + 1;
                                                   if(_loc31_ <= 8)
                                                   {
                                                   }
                                                   §§goto(addr991);
                                                }
                                                if(_loc47_ <= 16)
                                                {
                                                   _loc46_ = (_loc20_ = _loc46_ * 10) + _loc54_;
                                                   _loc36_ = 0;
                                                   _loc31_ = _loc47_;
                                                }
                                             }
                                             §§goto(addr991);
                                          }
                                       }
                                       break;
                                    }
                                    §§goto(addr1047);
                                 }
                                 while(_loc32_ += 1, _loc20_ = li8(_loc35_ - 1), _loc36_ = 0, _loc35_ += 1, _loc37_ = _loc36_, _loc47_ = _loc38_, _loc34_ = _loc36_, _loc20_ == _loc33_);
                                 
                              }
                              _loc20_ = _loc49_ | 32;
                              _loc7_ = _loc50_;
                              if(_loc20_ == 101)
                              {
                                 if((_loc20_ = (_loc20_ = _loc36_ | _loc48_) | _loc47_) == 0)
                                 {
                                    si32(6,_loc2_ - 20);
                                    si32(_loc10_,_loc2_ - 32);
                                    break loop1;
                                 }
                                 si32(_loc7_ = _loc50_ + 1,_loc2_ - 32);
                                 _loc49_ = si8(li8(_loc50_ + 1));
                                 _loc33_ = 0;
                                 if(_loc49_ != 43)
                                 {
                                    if(_loc49_ == 45)
                                    {
                                       _loc33_ = 1;
                                       addr1134:
                                       si32(_loc7_ = _loc50_ + 2,_loc2_ - 32);
                                       _loc49_ = si8(li8(_loc50_ + 2));
                                    }
                                    if((uint(_loc20_ = _loc49_ + -48)) <= 9)
                                    {
                                       if(_loc49_ == 48)
                                       {
                                          do
                                          {
                                             si32(_loc53_ = _loc7_ + 1,_loc2_ - 32);
                                             _loc49_ = (_loc20_ = (_loc23_ = li8(_loc7_ + 1)) << 24) >> 24;
                                             _loc7_ = _loc53_;
                                          }
                                          while(_loc23_ == 48);
                                          
                                          _loc7_ = _loc53_;
                                       }
                                       _loc20_ = _loc49_ + -49;
                                       _loc53_ = 0;
                                       _loc10_ = _loc50_;
                                       if(uint(_loc20_) <= 8)
                                       {
                                          si32(_loc10_ = _loc7_ + 1,_loc2_ - 32);
                                          _loc31_ = _loc49_ + -48;
                                          if((uint(_loc20_ = (_loc20_ = (_loc49_ = si8(li8(_loc7_ + 1))) + -48) & 255)) <= 9)
                                          {
                                             _loc53_ = _loc7_ + 2;
                                             _loc10_ = _loc7_ + 1;
                                             do
                                             {
                                                _loc20_ = _loc31_ * 10;
                                                _loc31_ = (_loc20_ = _loc49_ + _loc20_) + -48;
                                                _loc10_ += 1;
                                                si32(_loc53_,_loc2_ - 32);
                                                _loc20_ = _loc53_ + 1;
                                                _loc23_ = (_loc23_ = (_loc49_ = si8(li8(_loc53_))) + -48) & 255;
                                                _loc53_ = _loc20_;
                                             }
                                             while(uint(_loc23_) < 10);
                                             
                                          }
                                          _loc29_ = 1;
                                          _loc53_ = 19999;
                                          _loc30_ = _loc29_;
                                          if(_loc31_ <= _loc53_)
                                          {
                                             _loc30_ = 0;
                                          }
                                          if((_loc20_ = _loc10_ - _loc7_) <= 8)
                                          {
                                             _loc29_ = 0;
                                          }
                                          if((_loc20_ = _loc29_ | _loc30_) == 0)
                                          {
                                             _loc53_ = _loc31_;
                                          }
                                          if(_loc33_ != 0)
                                          {
                                             _loc53_ = 0 - _loc53_;
                                          }
                                          _loc7_ = _loc10_;
                                          _loc10_ = _loc50_;
                                          addr1367:
                                          if(_loc47_ == 0)
                                          {
                                             if((_loc20_ = _loc36_ | _loc48_) == 0)
                                             {
                                                if(_loc34_ == 0)
                                                {
                                                   _loc53_ = 2;
                                                   if(_loc49_ <= 104)
                                                   {
                                                      if(_loc49_ != 73)
                                                      {
                                                         if(_loc49_ != 78)
                                                         {
                                                            addr1726:
                                                            si32(6,_loc2_ - 20);
                                                            si32(_loc10_,_loc2_ - 32);
                                                            break loop1;
                                                         }
                                                         addr1406:
                                                         _loc51_ = 0;
                                                         while(true)
                                                         {
                                                            if(_loc51_ != -2)
                                                            {
                                                               continue;
                                                            }
                                                            si32(_loc23_ = (_loc20_ = _loc7_ - _loc51_) + 1,_loc2_ - 32);
                                                            si32(4,_loc2_ - 20);
                                                            si32(_loc23_ = (_loc23_ = li32(_loc14_ + 8)) + 1,_loc16_);
                                                            _loc53_ = _loc14_ + 8;
                                                            _loc46_ = 0;
                                                            if(li8(_loc20_ + 1) == 40)
                                                            {
                                                               _loc1_ -= 16;
                                                               si32(_loc18_,_loc1_ + 8);
                                                               si32(_loc14_,_loc1_ + 4);
                                                               si32(_loc20_ = _loc2_ - 32,_loc1_);
                                                               ESP = _loc1_;
                                                               F___hexnan_D2A();
                                                               _loc1_ += 16;
                                                               si32(5,_loc2_ - 20);
                                                               _loc46_ = 0;
                                                               addr10540:
                                                               si32(_loc20_ = (_loc20_ = li32(_loc53_)) + 1,_loc16_);
                                                               if(_loc46_ != 0)
                                                               {
                                                                  addr10556:
                                                                  if(_loc24_ != 0)
                                                                  {
                                                                     si32(0,li32(_loc2_ - 36) + 16);
                                                                     si32(80,_loc2_ - 20);
                                                                     ESP = _loc1_;
                                                                     F___error();
                                                                     si32(34,eax);
                                                                     break loop1;
                                                                  }
                                                                  _loc14_ = 2;
                                                                  if(li32((_loc20_ = li32(_loc2_ - 36)) + 16) <= 0)
                                                                  {
                                                                     _loc14_ = 0;
                                                                  }
                                                                  _loc23_ = (_loc20_ = li32(_loc2_ - 20)) & -8;
                                                                  si32(_loc14_ |= _loc23_,_loc2_ - 20);
                                                                  if((_loc20_ &= 48) != 0)
                                                                  {
                                                                     si32(_loc20_ = _loc14_ | 64,_loc2_ - 20);
                                                                     ESP = _loc1_;
                                                                     F___error();
                                                                     si32(34,eax);
                                                                     break loop1;
                                                                  }
                                                                  break loop1;
                                                               }
                                                               break loop1;
                                                            }
                                                            §§goto(addr10540);
                                                         }
                                                      }
                                                   }
                                                   else if(_loc49_ != 105)
                                                   {
                                                      if(_loc49_ == 110)
                                                      {
                                                         §§goto(addr1406);
                                                      }
                                                      §§goto(addr1726);
                                                   }
                                                   §§goto(addr10540);
                                                }
                                                §§goto(addr1726);
                                             }
                                             break loop1;
                                          }
                                          si32(1,_loc2_ - 20);
                                          _loc48_ = _loc53_ - _loc37_;
                                          if((_loc49_ = (_loc20_ = li32(_loc14_ + 12)) & 3) != 0)
                                          {
                                             if(_loc49_ != 3)
                                             {
                                                _loc10_ = 0;
                                                if(_loc49_ == 2)
                                                {
                                                   _loc10_ = 2 - _loc6_;
                                                }
                                             }
                                             else
                                             {
                                                _loc10_ = _loc6_ + 1;
                                             }
                                          }
                                          else
                                          {
                                             _loc10_ = 1;
                                          }
                                          _loc49_ = _loc47_;
                                          if(_loc38_ != 0)
                                          {
                                             _loc49_ = _loc38_;
                                          }
                                          _loc38_ = 16;
                                          if(_loc47_ <= _loc38_)
                                          {
                                             _loc38_ = _loc47_;
                                          }
                                          _loc40_ = uint(_loc45_);
                                          if(_loc38_ >= 10)
                                          {
                                             var _loc39_:*;
                                             _loc40_ = (_loc39_ = lf64((_loc20_ = (_loc20_ = _loc38_ << 3) + ___tens_D2A) - 72)) * _loc40_ + uint(_loc46_);
                                          }
                                          sf64(_loc40_,_loc2_ - 48);
                                          _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 48) | 4);
                                          _loc50_ = li32(_loc2_ - 48);
                                          _loc7_ = _loc48_;
                                          if(_loc52_ <= 53)
                                          {
                                             _loc7_ = _loc48_;
                                             if(_loc47_ <= 15)
                                             {
                                                if(_loc53_ == _loc37_)
                                                {
                                                   _loc1_ -= 32;
                                                   si32(_loc20_ = _loc2_ - 20,_loc1_ + 28);
                                                   si32(_loc10_,_loc1_ + 24);
                                                   si32(1,_loc1_ + 20);
                                                   si32(_loc18_,_loc1_ + 16);
                                                   si32(_loc16_,_loc1_ + 12);
                                                   si32(_loc14_,_loc1_ + 8);
                                                   sf64(_loc40_,_loc1_);
                                                   ESP = _loc1_;
                                                   F_rvOK();
                                                   _loc1_ += 32;
                                                   _loc7_ = _loc48_;
                                                   if(eax != 0)
                                                   {
                                                      break loop1;
                                                   }
                                                }
                                                else if(_loc48_ >= 1)
                                                {
                                                   if(_loc48_ <= 22)
                                                   {
                                                      _loc53_ = li32(_loc20_ = _fivesbits + (_loc48_ << 2));
                                                      if(_loc50_ != 0)
                                                      {
                                                         if((_loc20_ = _loc50_ & 7) != 0)
                                                         {
                                                            _loc7_ = 0;
                                                            if((_loc50_ & 1) == 0)
                                                            {
                                                               _loc7_ = 1;
                                                               if((_loc50_ & 2) == 0)
                                                               {
                                                                  _loc7_ = 2;
                                                               }
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc37_ = _loc50_ >>> 16;
                                                            if((_loc34_ = _loc50_ & 65535) != 0)
                                                            {
                                                               _loc37_ = _loc50_;
                                                            }
                                                            _loc46_ = _loc37_ >>> 8;
                                                            if((_loc7_ = _loc37_ & 255) != 0)
                                                            {
                                                               _loc46_ = _loc37_;
                                                            }
                                                            _loc33_ = _loc46_ >>> 4;
                                                            if((_loc37_ = _loc46_ & 15) != 0)
                                                            {
                                                               _loc33_ = _loc46_;
                                                            }
                                                            _loc46_ = _loc33_ >>> 2;
                                                            if((_loc50_ = _loc33_ & 3) != 0)
                                                            {
                                                               _loc46_ = _loc33_;
                                                            }
                                                            _loc33_ = 16;
                                                            if(_loc34_ != 0)
                                                            {
                                                               _loc33_ = 0;
                                                            }
                                                            _loc34_ = _loc33_ | 8;
                                                            if(_loc7_ != 0)
                                                            {
                                                               _loc34_ = _loc33_;
                                                            }
                                                            _loc7_ = _loc34_ | 4;
                                                            if(_loc37_ != 0)
                                                            {
                                                               _loc7_ = _loc34_;
                                                            }
                                                            _loc37_ = _loc7_ | 2;
                                                            if(_loc50_ != 0)
                                                            {
                                                               _loc37_ = _loc7_;
                                                            }
                                                            if((_loc20_ = _loc46_ & 1) == 0)
                                                            {
                                                               _loc37_ += 1;
                                                               _loc7_ = 32;
                                                               if(uint(_loc46_) >= 2)
                                                               {
                                                               }
                                                               addr2109:
                                                               _loc46_ = 53 - _loc7_;
                                                               addr2275:
                                                               _loc1_ -= 32;
                                                               si32(_loc20_ = _loc2_ - 20,_loc1_ + 28);
                                                               si32(_loc10_,_loc1_ + 24);
                                                               si32(_loc18_,_loc1_ + 16);
                                                               si32(_loc16_,_loc1_ + 12);
                                                               si32(_loc14_,_loc1_ + 8);
                                                               _loc20_ = _loc46_ + _loc53_;
                                                               _loc53_ = 1;
                                                               if(_loc20_ >= 54)
                                                               {
                                                                  _loc53_ = 0;
                                                               }
                                                               si32(_loc20_ = _loc53_ & 1,_loc1_ + 20);
                                                               _loc20_ = _loc48_ << 3;
                                                               _loc39_ = lf64(_loc20_ = ___tens_D2A + _loc20_);
                                                               sf64(_loc41_ = _loc40_ * _loc39_,_loc1_);
                                                               ESP = _loc1_;
                                                               F_rvOK();
                                                               _loc1_ += 32;
                                                               if((_loc20_ = eax) == 0)
                                                               {
                                                                  sf64(_loc41_,_loc2_ - 72);
                                                                  _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 72) | 4);
                                                                  _loc7_ = 0;
                                                                  _loc50_ = li32(_loc2_ - 72);
                                                                  addr2636:
                                                                  _loc20_ = _loc47_ - _loc38_;
                                                                  if((_loc53_ = _loc7_ + _loc20_) >= 1)
                                                                  {
                                                                     if((_loc38_ = _loc53_ & 15) != 0)
                                                                     {
                                                                        si32(_loc46_,(_loc20_ = _loc2_ - 128) | 4);
                                                                        si32(_loc50_,_loc2_ - 128);
                                                                        sf64(_loc39_ = (_loc39_ = lf64(_loc2_ - 128)) * lf64(_loc20_ = ___tens_D2A + (_loc38_ << 3)),_loc2_ - 136);
                                                                        _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 136) | 4);
                                                                        _loc50_ = li32(_loc2_ - 136);
                                                                     }
                                                                     _loc38_ = 0;
                                                                     if(uint(_loc53_) >= 16)
                                                                     {
                                                                        _loc53_ >>= 4;
                                                                        _loc38_ = (_loc23_ = (_loc23_ = _loc46_ >>> 20) & 2047) + -1023;
                                                                        _loc46_ = (_loc20_ = _loc46_ & -2146435073) | 1072693248;
                                                                        if(_loc53_ >= 16)
                                                                        {
                                                                           do
                                                                           {
                                                                              _loc20_ = (_loc20_ = _loc2_ - 144) | 4;
                                                                              si32(_loc46_,_loc20_);
                                                                              si32(_loc50_,_loc2_ - 144);
                                                                              sf64(_loc39_ = (_loc39_ = lf64(_loc2_ - 144)) * 1e+256,_loc2_ - 152);
                                                                              _loc23_ = (_loc23_ = (_loc20_ = li32(_loc20_ = (_loc20_ = _loc2_ - 152) | 4)) >>> 20) & 2047;
                                                                              _loc38_ = (_loc23_ = _loc38_ + _loc23_) + -1023;
                                                                              _loc53_ += -16;
                                                                              _loc46_ = (_loc20_ &= -2146435073) | 1072693248;
                                                                              _loc50_ = li32(_loc2_ - 152);
                                                                           }
                                                                           while(_loc53_ > 15);
                                                                           
                                                                        }
                                                                        _loc36_ = ___bigtens_D2A;
                                                                        if(_loc53_ >= 1)
                                                                        {
                                                                           do
                                                                           {
                                                                              if((_loc20_ = _loc53_ & 1) != 0)
                                                                              {
                                                                                 si32(_loc46_,(_loc20_ = _loc2_ - 160) | 4);
                                                                                 si32(_loc50_,_loc2_ - 160);
                                                                                 sf64(_loc39_ = (_loc39_ = lf64(_loc2_ - 160)) * lf64(_loc36_),_loc2_ - 168);
                                                                                 _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 168) | 4);
                                                                                 _loc50_ = li32(_loc2_ - 168);
                                                                              }
                                                                              _loc36_ += 8;
                                                                           }
                                                                           while((_loc53_ >>= 1) > 0);
                                                                           
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc38_ = 0;
                                                                     if(_loc53_ <= -1)
                                                                     {
                                                                        if((_loc38_ = (_loc53_ = 0 - _loc53_) & 15) != 0)
                                                                        {
                                                                           si32(_loc46_,(_loc20_ = _loc2_ - 80) | 4);
                                                                           si32(_loc50_,_loc2_ - 80);
                                                                           var _loc42_:*;
                                                                           sf64(_loc39_ = (_loc42_ = lf64(_loc2_ - 80)) / lf64(_loc20_ = ___tens_D2A + (_loc38_ << 3)),_loc2_ - 88);
                                                                           _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 88) | 4);
                                                                           _loc50_ = li32(_loc2_ - 88);
                                                                        }
                                                                        _loc38_ = 0;
                                                                        if(uint(_loc53_) >= 16)
                                                                        {
                                                                           _loc53_ >>= 4;
                                                                           _loc38_ = (_loc23_ = (_loc23_ = _loc46_ >>> 20) & 2047) + -1023;
                                                                           _loc46_ = (_loc20_ = _loc46_ & -2146435073) | 1072693248;
                                                                           if(_loc53_ >= 16)
                                                                           {
                                                                              do
                                                                              {
                                                                                 _loc20_ = (_loc20_ = _loc2_ - 96) | 4;
                                                                                 si32(_loc46_,_loc20_);
                                                                                 si32(_loc50_,_loc2_ - 96);
                                                                                 sf64(_loc39_ = (_loc39_ = lf64(_loc2_ - 96)) * 1e-256,_loc2_ - 104);
                                                                                 _loc23_ = (_loc23_ = (_loc20_ = li32(_loc20_ = (_loc20_ = _loc2_ - 104) | 4)) >>> 20) & 2047;
                                                                                 _loc38_ = (_loc23_ = _loc38_ + _loc23_) + -1023;
                                                                                 _loc53_ += -16;
                                                                                 _loc46_ = (_loc20_ &= -2146435073) | 1072693248;
                                                                                 _loc50_ = li32(_loc2_ - 104);
                                                                              }
                                                                              while(_loc53_ > 15);
                                                                              
                                                                           }
                                                                           _loc36_ = ___tinytens_D2A;
                                                                           if(_loc53_ >= 1)
                                                                           {
                                                                              do
                                                                              {
                                                                                 if((_loc20_ = _loc53_ & 1) != 0)
                                                                                 {
                                                                                    si32(_loc46_,(_loc20_ = _loc2_ - 112) | 4);
                                                                                    si32(_loc50_,_loc2_ - 112);
                                                                                    sf64(_loc39_ = (_loc39_ = lf64(_loc2_ - 112)) * lf64(_loc36_),_loc2_ - 120);
                                                                                    _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 120) | 4);
                                                                                    _loc50_ = li32(_loc2_ - 120);
                                                                                 }
                                                                                 _loc36_ += 8;
                                                                              }
                                                                              while((_loc53_ >>= 1) > 0);
                                                                              
                                                                           }
                                                                        }
                                                                     }
                                                                  }
                                                                  _loc1_ -= 16;
                                                                  si32(_loc50_,_loc1_);
                                                                  si32(_loc20_ = _loc2_ - 24,_loc1_ + 12);
                                                                  si32(_loc20_ = _loc2_ - 28,_loc1_ + 8);
                                                                  si32(_loc46_,_loc1_ + 4);
                                                                  ESP = _loc1_;
                                                                  F___d2b_D2A();
                                                                  _loc1_ += 16;
                                                                  si32(_loc53_ = eax,_loc2_ - 36);
                                                                  si32(_loc7_ = (_loc20_ = li32(_loc2_ - 28)) + _loc38_,_loc2_ - 28);
                                                                  if((_loc46_ = (_loc50_ = li32(_loc2_ - 24)) - _loc52_) >= 1)
                                                                  {
                                                                     _loc31_ = li32(_loc53_ + 16);
                                                                     _loc33_ = _loc46_ >> 5;
                                                                     _loc37_ = _loc38_ = _loc53_ + 20;
                                                                     if(_loc31_ > _loc33_)
                                                                     {
                                                                        _loc36_ = (_loc20_ = _loc53_ + (_loc31_ << 2)) + 20;
                                                                        if((_loc50_ = _loc46_ & 31) == 0)
                                                                        {
                                                                           _loc37_ = _loc38_;
                                                                           if(_loc33_ < _loc31_)
                                                                           {
                                                                              _loc50_ = _loc33_ << 2;
                                                                              _loc37_ = _loc53_ + 20;
                                                                              do
                                                                              {
                                                                                 si32(_loc20_ = li32(_loc20_ = _loc37_ + _loc50_),_loc37_);
                                                                              }
                                                                              while((uint(_loc20_ = (_loc37_ += 4) + _loc50_)) < uint(_loc36_));
                                                                              
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc7_ = (_loc20_ = li32((_loc34_ = _loc53_ + (_loc33_ << 2)) + 20)) >>> _loc50_;
                                                                           _loc37_ = _loc38_;
                                                                           if(_loc33_ + 1 < _loc31_)
                                                                           {
                                                                              _loc33_ = 32 - _loc50_;
                                                                              _loc34_ += 24;
                                                                              _loc37_ = _loc53_ + 20;
                                                                              do
                                                                              {
                                                                                 si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc34_)) << _loc33_) | _loc7_,_loc37_);
                                                                                 _loc7_ = (_loc20_ = li32(_loc34_)) >>> _loc50_;
                                                                                 _loc34_ += 4;
                                                                                 _loc37_ += 4;
                                                                              }
                                                                              while(uint(_loc34_) < uint(_loc36_));
                                                                              
                                                                           }
                                                                           si32(_loc7_,_loc37_);
                                                                           if(_loc7_ != 0)
                                                                           {
                                                                              _loc37_ += 4;
                                                                           }
                                                                        }
                                                                     }
                                                                     si32(_loc20_ = (_loc20_ = _loc37_ - _loc38_) >> 2,_loc53_ + 16);
                                                                     if(_loc20_ == 0)
                                                                     {
                                                                        si32(0,_loc38_);
                                                                     }
                                                                     si32(_loc52_,_loc2_ - 24);
                                                                     si32(_loc7_ = (_loc20_ = li32(_loc2_ - 28)) + _loc46_,_loc2_ - 28);
                                                                     _loc50_ = _loc52_;
                                                                  }
                                                                  _loc37_ = (_loc20_ = _loc7_ - _loc52_) + _loc50_;
                                                                  _loc53_ = _loc14_ + 8;
                                                                  _loc20_ = (_loc20_ = li32(_loc14_ + 8)) + 1;
                                                                  _loc46_ = 0;
                                                                  if(_loc20_ >= _loc37_)
                                                                  {
                                                                     _loc38_ = li32(_loc14_ + 4);
                                                                     _loc36_ = _loc37_;
                                                                     _loc46_ = 0;
                                                                     if(_loc38_ > _loc37_)
                                                                     {
                                                                        if((_loc7_ -= _loc38_) >= 1)
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(li32(_loc2_ - 36),_loc1_);
                                                                           si32(_loc7_,_loc1_ + 4);
                                                                           ESP = _loc1_;
                                                                           F___lshift_D2A();
                                                                           _loc1_ += 16;
                                                                           si32(_loc20_ = eax,_loc2_ - 36);
                                                                           si32(_loc20_ = (_loc20_ = li32(_loc2_ - 24)) + _loc7_,_loc2_ - 24);
                                                                        }
                                                                        else if(_loc7_ <= -1)
                                                                        {
                                                                           si32(_loc46_ = _loc7_ + _loc50_,_loc2_ - 24);
                                                                           if(_loc46_ <= 0)
                                                                           {
                                                                              if(_loc46_ > -2)
                                                                              {
                                                                                 _loc20_ = li32(_loc2_ - 36);
                                                                                 si32(1,_loc2_ - 24);
                                                                                 si32(1,_loc20_ + 16);
                                                                                 si32(1,_loc20_ + 20);
                                                                                 addr3895:
                                                                                 si32(_loc38_,_loc2_ - 28);
                                                                                 _loc46_ = 1;
                                                                                 _loc36_ = _loc38_;
                                                                                 if(_loc24_ != 0)
                                                                                 {
                                                                                    _loc46_ = 1;
                                                                                    _loc36_ = _loc38_;
                                                                                    if(_loc37_ + 1 >= _loc38_)
                                                                                    {
                                                                                       addr3919:
                                                                                       _loc1_ -= 32;
                                                                                       si32(_loc51_,_loc1_ + 16);
                                                                                       si32(_loc45_,_loc1_ + 12);
                                                                                       si32(_loc47_,_loc1_ + 8);
                                                                                       si32(_loc49_,_loc1_ + 4);
                                                                                       si32(_loc54_,_loc1_);
                                                                                       _loc50_ = 0;
                                                                                       if(_loc48_ <= -1)
                                                                                       {
                                                                                          _loc50_ = 0 - _loc48_;
                                                                                       }
                                                                                       if(_loc48_ <= -1)
                                                                                       {
                                                                                          _loc48_ = 0;
                                                                                       }
                                                                                       ESP = _loc1_;
                                                                                       F___s2b_D2A();
                                                                                       _loc7_ = _loc52_ + 1;
                                                                                       _loc34_ = _loc10_ & 1;
                                                                                       _loc1_ += 32;
                                                                                       _loc33_ = (_loc51_ = eax) + 12;
                                                                                       _loc37_ = 17;
                                                                                       _loc31_ = 0;
                                                                                       loop21:
                                                                                       while(true)
                                                                                       {
                                                                                          _loc20_ = li32(_loc51_ + 4);
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc20_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___Balloc_D2A();
                                                                                          _loc1_ += 16;
                                                                                          _loc54_ = eax;
                                                                                          _loc20_ = li32(_loc51_ + 16);
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc20_ = (_loc20_ <<= 2) + 8,_loc1_ + 8);
                                                                                          si32(_loc33_,_loc1_ + 4);
                                                                                          si32(_loc20_ = _loc54_ + 12,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          Fmemcpy();
                                                                                          _loc1_ += 16;
                                                                                          _loc20_ = li32((_loc20_ = li32(_loc2_ - 36)) + 4);
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc20_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___Balloc_D2A();
                                                                                          _loc1_ += 16;
                                                                                          _loc49_ = eax;
                                                                                          _loc23_ = li32((_loc20_ = li32(_loc2_ - 36)) + 16);
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc23_ = (_loc23_ <<= 2) + 8,_loc1_ + 8);
                                                                                          si32(_loc20_ += 12,_loc1_ + 4);
                                                                                          si32(_loc20_ = _loc49_ + 12,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          Fmemcpy();
                                                                                          _loc1_ += 16;
                                                                                          _loc32_ = li32(_loc2_ - 28);
                                                                                          _loc9_ = li32(_loc2_ - 24);
                                                                                          if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F__pthread_mutex_lock();
                                                                                             _loc1_ += 16;
                                                                                          }
                                                                                          _loc29_ = _loc32_ + _loc31_;
                                                                                          _loc35_ = _loc9_ - _loc31_;
                                                                                          if((_loc45_ = li32(_freelist + 4)) != 0)
                                                                                          {
                                                                                             si32(_loc20_ = li32(_loc45_),_freelist + 4);
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             if((uint(_loc20_ = (_loc20_ = (_loc20_ = (_loc45_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                                                             {
                                                                                                si32(_loc20_ = _loc45_ + 32,_pmem_next);
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc1_ -= 16;
                                                                                                si32(32,_loc1_);
                                                                                                ESP = _loc1_;
                                                                                                F_malloc();
                                                                                                _loc1_ += 16;
                                                                                                _loc45_ = eax;
                                                                                             }
                                                                                             si32(1,_loc45_ + 4);
                                                                                             si32(2,_loc45_ + 8);
                                                                                          }
                                                                                          if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F__pthread_mutex_unlock();
                                                                                             _loc1_ += 16;
                                                                                          }
                                                                                          si32(_loc47_ = 0,_loc45_ + 12);
                                                                                          si32(1,_loc45_ + 20);
                                                                                          si32(1,_loc45_ + 16);
                                                                                          _loc30_ = _loc29_;
                                                                                          if(_loc29_ <= -1)
                                                                                          {
                                                                                             _loc30_ = _loc47_;
                                                                                          }
                                                                                          if(_loc29_ <= -1)
                                                                                          {
                                                                                             _loc47_ = _loc29_;
                                                                                          }
                                                                                          _loc29_ = _loc7_ - _loc35_;
                                                                                          if((_loc32_ = (_loc20_ = _loc9_ - _loc52_) + _loc32_) < _loc38_)
                                                                                          {
                                                                                             _loc29_ = (_loc20_ = _loc32_ - _loc38_) + _loc29_;
                                                                                          }
                                                                                          _loc30_ += _loc50_;
                                                                                          _loc20_ = _loc48_ - _loc47_;
                                                                                          _loc32_ = _loc29_ + _loc30_;
                                                                                          _loc47_ = _loc9_ = _loc29_ + _loc20_;
                                                                                          if(_loc9_ > _loc32_)
                                                                                          {
                                                                                             _loc47_ = _loc32_;
                                                                                          }
                                                                                          _loc29_ = _loc30_;
                                                                                          if(_loc47_ <= _loc30_)
                                                                                          {
                                                                                             _loc29_ = _loc47_;
                                                                                          }
                                                                                          if(_loc29_ <= 0)
                                                                                          {
                                                                                             _loc29_ = 0;
                                                                                          }
                                                                                          _loc47_ = _loc49_;
                                                                                          if(_loc50_ >= 1)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc50_,_loc1_ + 4);
                                                                                             si32(_loc45_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___pow5mult_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc45_ = eax;
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc49_,_loc1_ + 4);
                                                                                             si32(_loc45_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___mult_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc47_ = eax;
                                                                                             if(_loc49_ != 0)
                                                                                             {
                                                                                                if((_loc8_ = li32(_loc49_ + 4)) >= 10)
                                                                                                {
                                                                                                   _loc1_ -= 16;
                                                                                                   si32(_loc49_,_loc1_);
                                                                                                   ESP = _loc1_;
                                                                                                   F_idalloc();
                                                                                                   _loc1_ += 16;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                   {
                                                                                                      _loc1_ -= 16;
                                                                                                      si32(___gdtoa_locks,_loc1_);
                                                                                                      ESP = _loc1_;
                                                                                                      F__pthread_mutex_lock();
                                                                                                      _loc1_ += 16;
                                                                                                      _loc8_ = li32(_loc49_ + 4);
                                                                                                   }
                                                                                                   _loc20_ = _loc8_ << 2;
                                                                                                   si32(_loc23_ = li32(_loc20_ = _freelist + _loc20_),_loc49_);
                                                                                                   si32(_loc49_,_loc20_);
                                                                                                   if((_loc20_ = li32(___isthreaded)) != 0)
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
                                                                                          _loc20_ = _loc32_ - _loc29_;
                                                                                          _loc49_ = _loc9_ - _loc29_;
                                                                                          _loc30_ -= _loc29_;
                                                                                          if((_loc29_ = _loc20_ - _loc31_) >= 1)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc29_,_loc1_ + 4);
                                                                                             si32(_loc47_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___lshift_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc47_ = eax;
                                                                                          }
                                                                                          else if(_loc29_ <= -1)
                                                                                          {
                                                                                             _loc9_ = li32(_loc47_ + 16);
                                                                                             _loc31_ = _loc47_ + 20;
                                                                                             _loc13_ = (_loc8_ = 0 - _loc29_) >> 5;
                                                                                             _loc32_ = _loc31_;
                                                                                             if(_loc9_ > _loc13_)
                                                                                             {
                                                                                                _loc29_ = (_loc20_ = _loc47_ + (_loc9_ << 2)) + 20;
                                                                                                if((_loc8_ &= 31) == 0)
                                                                                                {
                                                                                                   _loc32_ = _loc31_;
                                                                                                   if(_loc13_ < _loc9_)
                                                                                                   {
                                                                                                      _loc9_ = _loc13_ << 2;
                                                                                                      _loc32_ = _loc47_ + 20;
                                                                                                      do
                                                                                                      {
                                                                                                         si32(_loc20_ = li32(_loc20_ = _loc32_ + _loc9_),_loc32_);
                                                                                                      }
                                                                                                      while((uint(_loc20_ = (_loc32_ += 4) + _loc9_)) < uint(_loc29_));
                                                                                                      
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc17_ = (_loc20_ = li32((_loc11_ = _loc47_ + (_loc13_ << 2)) + 20)) >>> _loc8_;
                                                                                                   _loc32_ = _loc31_;
                                                                                                   if(_loc13_ + 1 < _loc9_)
                                                                                                   {
                                                                                                      _loc9_ = 32 - _loc8_;
                                                                                                      _loc11_ += 24;
                                                                                                      _loc32_ = _loc47_ + 20;
                                                                                                      do
                                                                                                      {
                                                                                                         si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc11_)) << _loc9_) | _loc17_,_loc32_);
                                                                                                         _loc17_ = (_loc20_ = li32(_loc11_)) >>> _loc8_;
                                                                                                         _loc11_ += 4;
                                                                                                         _loc32_ += 4;
                                                                                                      }
                                                                                                      while(uint(_loc11_) < uint(_loc29_));
                                                                                                      
                                                                                                   }
                                                                                                   si32(_loc17_,_loc32_);
                                                                                                   if(_loc17_ != 0)
                                                                                                   {
                                                                                                      _loc32_ += 4;
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             si32(_loc20_ = (_loc20_ = _loc32_ - _loc31_) >> 2,_loc47_ + 16);
                                                                                             if(_loc20_ == 0)
                                                                                             {
                                                                                                si32(0,_loc31_);
                                                                                             }
                                                                                          }
                                                                                          if(_loc48_ >= 1)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc48_,_loc1_ + 4);
                                                                                             si32(_loc54_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___pow5mult_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc54_ = eax;
                                                                                          }
                                                                                          if(_loc49_ >= 1)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc49_,_loc1_ + 4);
                                                                                             si32(_loc54_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___lshift_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc54_ = eax;
                                                                                          }
                                                                                          if(_loc30_ >= 1)
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc30_,_loc1_ + 4);
                                                                                             si32(_loc45_,_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___lshift_D2A();
                                                                                             _loc1_ += 16;
                                                                                             _loc45_ = eax;
                                                                                          }
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc54_,_loc1_ + 4);
                                                                                          si32(_loc47_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___diff_D2A();
                                                                                          _loc1_ += 16;
                                                                                          if((_loc31_ = li32((_loc49_ = eax) + 16)) <= 1)
                                                                                          {
                                                                                             if((_loc20_ = li32(_loc49_ + 20)) != 0)
                                                                                             {
                                                                                                addr5008:
                                                                                                _loc9_ = li32(_loc49_ + 12);
                                                                                                si32(0,_loc49_ + 12);
                                                                                                _loc30_ = li32(_loc45_ + 16);
                                                                                                if(_loc31_ != _loc30_)
                                                                                                {
                                                                                                   _loc29_ = _loc31_ - _loc30_;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc20_ = _loc30_ << 2;
                                                                                                   _loc31_ = (_loc17_ = _loc49_ + 20) + _loc20_;
                                                                                                   _loc30_ = (_loc20_ = _loc45_ + _loc20_) + 16;
                                                                                                   do
                                                                                                   {
                                                                                                      _loc8_ = li32(_loc30_);
                                                                                                      if((_loc32_ = li32(_loc31_ - 4)) != _loc8_)
                                                                                                      {
                                                                                                         _loc29_ = -1;
                                                                                                         if(uint(_loc32_) >= uint(_loc8_))
                                                                                                         {
                                                                                                            _loc29_ = 1;
                                                                                                         }
                                                                                                         break;
                                                                                                      }
                                                                                                      _loc31_ += -4;
                                                                                                      _loc30_ += -4;
                                                                                                      _loc29_ = 0;
                                                                                                   }
                                                                                                   while(uint(_loc31_) > uint(_loc17_));
                                                                                                   
                                                                                                }
                                                                                                if(_loc10_ != 0)
                                                                                                {
                                                                                                   if(_loc29_ <= 0)
                                                                                                   {
                                                                                                      si32(1,_loc2_ - 20);
                                                                                                      if(_loc34_ == _loc9_)
                                                                                                      {
                                                                                                         _loc10_ = 17;
                                                                                                         if(_loc9_ == 0)
                                                                                                         {
                                                                                                            _loc10_ = 33;
                                                                                                         }
                                                                                                         si32(_loc10_,_loc2_ - 20);
                                                                                                         break;
                                                                                                      }
                                                                                                      _loc31_ = _loc9_ ^ _loc34_;
                                                                                                      if(_loc9_ != 0)
                                                                                                      {
                                                                                                         si32(33,_loc2_ - 20);
                                                                                                         _loc8_ = 1072693248;
                                                                                                         _loc17_ = 0;
                                                                                                         _loc30_ = 32;
                                                                                                         _loc44_ = 1;
                                                                                                         _loc32_ = _loc17_;
                                                                                                         _loc11_ = _loc17_;
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         si32(_loc37_,_loc2_ - 20);
                                                                                                         if(_loc36_ != _loc38_)
                                                                                                         {
                                                                                                            _loc30_ = (_loc32_ = li32(_loc2_ - 36)) + 20;
                                                                                                            _loc29_ = _loc52_;
                                                                                                            while(true)
                                                                                                            {
                                                                                                               if(_loc29_ > 31)
                                                                                                               {
                                                                                                                  continue;
                                                                                                               }
                                                                                                               if(_loc29_ >= 2)
                                                                                                               {
                                                                                                                  if((_loc20_ = (_loc32_ = li32(_loc30_)) & 7) != 0)
                                                                                                                  {
                                                                                                                     _loc8_ = 0;
                                                                                                                     if((_loc32_ & 1) == 0)
                                                                                                                     {
                                                                                                                        if((_loc20_ = _loc32_ & 2) != 0)
                                                                                                                        {
                                                                                                                           si32(_loc20_ = _loc32_ >>> 1,_loc30_);
                                                                                                                           _loc8_ = 1;
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           si32(_loc20_ = _loc32_ >>> 2,_loc30_);
                                                                                                                           _loc8_ = 2;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc8_ = _loc32_ >>> 16;
                                                                                                                     if((_loc13_ = _loc32_ & 65535) != 0)
                                                                                                                     {
                                                                                                                        _loc8_ = _loc32_;
                                                                                                                     }
                                                                                                                     _loc32_ = _loc8_ >>> 8;
                                                                                                                     if((_loc11_ = _loc8_ & 255) != 0)
                                                                                                                     {
                                                                                                                        _loc32_ = _loc8_;
                                                                                                                     }
                                                                                                                     _loc15_ = _loc32_ >>> 4;
                                                                                                                     if((_loc17_ = _loc32_ & 15) != 0)
                                                                                                                     {
                                                                                                                        _loc15_ = _loc32_;
                                                                                                                     }
                                                                                                                     _loc32_ = _loc15_ >>> 2;
                                                                                                                     if((_loc8_ = _loc15_ & 3) != 0)
                                                                                                                     {
                                                                                                                        _loc32_ = _loc15_;
                                                                                                                     }
                                                                                                                     _loc15_ = 16;
                                                                                                                     if(_loc13_ != 0)
                                                                                                                     {
                                                                                                                        _loc15_ = 0;
                                                                                                                     }
                                                                                                                     _loc13_ = _loc15_ | 8;
                                                                                                                     if(_loc11_ != 0)
                                                                                                                     {
                                                                                                                        _loc13_ = _loc15_;
                                                                                                                     }
                                                                                                                     _loc11_ = _loc13_ | 4;
                                                                                                                     if(_loc17_ != 0)
                                                                                                                     {
                                                                                                                        _loc11_ = _loc13_;
                                                                                                                     }
                                                                                                                     _loc17_ = _loc11_ | 2;
                                                                                                                     if(_loc8_ != 0)
                                                                                                                     {
                                                                                                                        _loc17_ = _loc11_;
                                                                                                                     }
                                                                                                                     if((_loc20_ = _loc32_ & 1) == 0)
                                                                                                                     {
                                                                                                                        _loc32_ >>>= 1;
                                                                                                                        _loc17_ += 1;
                                                                                                                        _loc8_ = 32;
                                                                                                                        if(_loc32_ != 0)
                                                                                                                        {
                                                                                                                        }
                                                                                                                        addr5373:
                                                                                                                        _loc20_ = _loc29_ + -1;
                                                                                                                        if(_loc8_ >= _loc20_)
                                                                                                                        {
                                                                                                                           _loc32_ = li32(_loc2_ - 36);
                                                                                                                           addr5388:
                                                                                                                           si32(_loc20_ = _loc36_ + -1,_loc2_ - 28);
                                                                                                                           si32(_loc52_,_loc2_ - 24);
                                                                                                                           _loc10_ = li32(_loc32_ + 4);
                                                                                                                           _loc48_ = (_loc20_ = _loc52_ + 31) >> 5;
                                                                                                                           if(_loc10_ < _loc48_)
                                                                                                                           {
                                                                                                                              if(_loc32_ != 0)
                                                                                                                              {
                                                                                                                                 if(_loc10_ >= 10)
                                                                                                                                 {
                                                                                                                                    _loc1_ -= 16;
                                                                                                                                    si32(_loc32_,_loc1_);
                                                                                                                                    ESP = _loc1_;
                                                                                                                                    F_idalloc();
                                                                                                                                    _loc1_ += 16;
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(___gdtoa_locks,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F__pthread_mutex_lock();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                       _loc10_ = li32(_loc32_ + 4);
                                                                                                                                    }
                                                                                                                                    _loc20_ = _loc10_ << 2;
                                                                                                                                    si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc32_);
                                                                                                                                    si32(_loc32_,_loc23_);
                                                                                                                                    if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(___gdtoa_locks,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F__pthread_mutex_unlock();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              _loc1_ -= 16;
                                                                                                                              si32(_loc48_,_loc1_);
                                                                                                                              ESP = _loc1_;
                                                                                                                              F___Balloc_D2A();
                                                                                                                              _loc1_ += 16;
                                                                                                                              _loc32_ = eax;
                                                                                                                           }
                                                                                                                           _loc10_ = _loc52_ & 31;
                                                                                                                           _loc48_ = 1;
                                                                                                                           if(_loc10_ == 0)
                                                                                                                           {
                                                                                                                              _loc48_ = 0;
                                                                                                                           }
                                                                                                                           _loc23_ = _loc48_ & 1;
                                                                                                                           _loc20_ = _loc52_ >> 5;
                                                                                                                           si32(_loc38_ = _loc23_ + _loc20_,_loc32_ + 16);
                                                                                                                           _loc48_ = _loc32_ + 20;
                                                                                                                           if(_loc38_ >= 1)
                                                                                                                           {
                                                                                                                              _loc38_ = _loc48_ + (_loc38_ << 2);
                                                                                                                              _loc48_ = _loc32_ + 20;
                                                                                                                              do
                                                                                                                              {
                                                                                                                                 si32(-1,_loc48_);
                                                                                                                              }
                                                                                                                              while((uint(_loc48_ += 4)) < uint(_loc38_));
                                                                                                                              
                                                                                                                           }
                                                                                                                           if(_loc10_ != 0)
                                                                                                                           {
                                                                                                                              si32(_loc20_ = (_loc20_ = li32(_loc48_ - 4)) >>> 32 - _loc10_,_loc48_ - 4);
                                                                                                                           }
                                                                                                                           si32(_loc32_,_loc2_ - 36);
                                                                                                                           break loop21;
                                                                                                                        }
                                                                                                                        break;
                                                                                                                     }
                                                                                                                     si32(_loc32_,_loc30_);
                                                                                                                     _loc8_ = _loc17_;
                                                                                                                  }
                                                                                                                  §§goto(addr5373);
                                                                                                               }
                                                                                                               §§goto(addr5388);
                                                                                                            }
                                                                                                            addr6852:
                                                                                                            _loc8_ = 1072693248;
                                                                                                            _loc17_ = 0;
                                                                                                            _loc30_ = 32;
                                                                                                            _loc44_ = 1;
                                                                                                            _loc32_ = _loc17_;
                                                                                                            _loc11_ = _loc17_;
                                                                                                            if(_loc9_ == 0)
                                                                                                            {
                                                                                                            }
                                                                                                            addr7087:
                                                                                                            _loc35_ = li32(_loc2_ - 28);
                                                                                                            _loc9_ = li32(_loc2_ - 24);
                                                                                                            if(_loc46_ == 0)
                                                                                                            {
                                                                                                               if(_loc9_ < _loc52_)
                                                                                                               {
                                                                                                                  _loc1_ -= 16;
                                                                                                                  si32(li32(_loc2_ - 36),_loc1_);
                                                                                                                  si32(_loc20_ = _loc52_ - _loc9_,_loc1_ + 4);
                                                                                                                  ESP = _loc1_;
                                                                                                                  F___lshift_D2A();
                                                                                                                  _loc1_ += 16;
                                                                                                                  si32(_loc23_ = eax,_loc2_ - 36);
                                                                                                                  si32(_loc20_ = (_loc23_ = li32(_loc2_ - 28)) - _loc20_,_loc2_ - 28);
                                                                                                                  si32(_loc52_,_loc2_ - 24);
                                                                                                               }
                                                                                                            }
                                                                                                            _loc35_ = _loc9_ + _loc35_;
                                                                                                            _loc20_ = (_loc20_ = _loc2_ - 224) | 4;
                                                                                                            si32(_loc8_,_loc20_);
                                                                                                            _loc1_ -= 16;
                                                                                                            si32(_loc17_,_loc1_);
                                                                                                            si32(_loc20_ = _loc2_ - 16,_loc1_ + 12);
                                                                                                            si32(_loc20_ = _loc2_ - 12,_loc1_ + 8);
                                                                                                            si32(_loc17_,_loc2_ - 224);
                                                                                                            si32(_loc8_,_loc1_ + 4);
                                                                                                            ESP = _loc1_;
                                                                                                            F___d2b_D2A();
                                                                                                            _loc26_ = lf64(_loc2_ - 224);
                                                                                                            _loc1_ += 16;
                                                                                                            _loc8_ = eax;
                                                                                                            if((_loc13_ = li32(_loc2_ - 12)) <= -1)
                                                                                                            {
                                                                                                               _loc19_ = li32(_loc8_ + 16);
                                                                                                               _loc17_ = _loc8_ + 20;
                                                                                                               _loc22_ = (_loc25_ = 0 - _loc13_) >> 5;
                                                                                                               _loc13_ = _loc17_;
                                                                                                               if(_loc19_ > _loc22_)
                                                                                                               {
                                                                                                                  _loc15_ = (_loc20_ = _loc8_ + (_loc19_ << 2)) + 20;
                                                                                                                  if((_loc25_ &= 31) == 0)
                                                                                                                  {
                                                                                                                     _loc13_ = _loc17_;
                                                                                                                     if(_loc22_ < _loc19_)
                                                                                                                     {
                                                                                                                        _loc25_ = _loc22_ << 2;
                                                                                                                        _loc13_ = _loc8_ + 20;
                                                                                                                        do
                                                                                                                        {
                                                                                                                           si32(_loc20_ = li32(_loc20_ = _loc13_ + _loc25_),_loc13_);
                                                                                                                        }
                                                                                                                        while((uint(_loc20_ = (_loc13_ += 4) + _loc25_)) < uint(_loc15_));
                                                                                                                        
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc4_ = (_loc20_ = li32((_loc5_ = _loc8_ + (_loc22_ << 2)) + 20)) >>> _loc25_;
                                                                                                                     _loc13_ = _loc17_;
                                                                                                                     if(_loc22_ + 1 < _loc19_)
                                                                                                                     {
                                                                                                                        _loc19_ = 32 - _loc25_;
                                                                                                                        _loc22_ = _loc5_ + 24;
                                                                                                                        _loc13_ = _loc8_ + 20;
                                                                                                                        do
                                                                                                                        {
                                                                                                                           si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc22_)) << _loc19_) | _loc4_,_loc13_);
                                                                                                                           _loc4_ = (_loc20_ = li32(_loc22_)) >>> _loc25_;
                                                                                                                           _loc22_ += 4;
                                                                                                                           _loc13_ += 4;
                                                                                                                        }
                                                                                                                        while(uint(_loc22_) < uint(_loc15_));
                                                                                                                        
                                                                                                                     }
                                                                                                                     si32(_loc4_,_loc13_);
                                                                                                                     if(_loc4_ != 0)
                                                                                                                     {
                                                                                                                        _loc13_ += 4;
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                               si32(_loc20_ = (_loc20_ = _loc13_ - _loc17_) >> 2,_loc8_ + 16);
                                                                                                               if(_loc20_ == 0)
                                                                                                               {
                                                                                                                  si32(0,_loc17_);
                                                                                                               }
                                                                                                            }
                                                                                                            else if(_loc13_ >= 1)
                                                                                                            {
                                                                                                               _loc1_ -= 16;
                                                                                                               si32(_loc13_,_loc1_ + 4);
                                                                                                               si32(_loc8_,_loc1_);
                                                                                                               ESP = _loc1_;
                                                                                                               F___lshift_D2A();
                                                                                                               _loc1_ += 16;
                                                                                                               _loc8_ = eax;
                                                                                                            }
                                                                                                            _loc17_ = li32(_loc2_ - 36);
                                                                                                            if(_loc11_ != 0)
                                                                                                            {
                                                                                                               _loc1_ -= 16;
                                                                                                               si32(_loc8_,_loc1_ + 4);
                                                                                                               si32(_loc17_,_loc1_);
                                                                                                               ESP = _loc1_;
                                                                                                               F___diff_D2A();
                                                                                                               _loc1_ += 16;
                                                                                                               si32(_loc11_ = eax,_loc2_ - 36);
                                                                                                               if(_loc46_ == 0)
                                                                                                               {
                                                                                                                  if((_loc20_ = li32(_loc11_ + 16)) > (_loc13_ = li32(_loc17_ + 16)) + -1)
                                                                                                                  {
                                                                                                                     _loc15_ = _loc13_ << 2;
                                                                                                                     _loc5_ = (_loc4_ = li32((_loc20_ = _loc11_ + _loc15_) + 16)) << 16;
                                                                                                                     if(uint(_loc4_) >= 65536)
                                                                                                                     {
                                                                                                                        _loc5_ = _loc4_;
                                                                                                                     }
                                                                                                                     _loc19_ = _loc5_ << 8;
                                                                                                                     if(uint(_loc5_) >= 16777216)
                                                                                                                     {
                                                                                                                        _loc19_ = _loc5_;
                                                                                                                     }
                                                                                                                     _loc13_ = _loc19_ << 4;
                                                                                                                     if(uint(_loc19_) >= 268435456)
                                                                                                                     {
                                                                                                                        _loc13_ = _loc19_;
                                                                                                                     }
                                                                                                                     _loc25_ = _loc13_ << 2;
                                                                                                                     if(uint(_loc13_) >= 1073741824)
                                                                                                                     {
                                                                                                                        _loc25_ = _loc13_;
                                                                                                                     }
                                                                                                                     _loc22_ = 16;
                                                                                                                     if(uint(_loc4_) >= 65536)
                                                                                                                     {
                                                                                                                        _loc22_ = 0;
                                                                                                                     }
                                                                                                                     _loc4_ = _loc22_ | 8;
                                                                                                                     if(uint(_loc5_) >= 16777216)
                                                                                                                     {
                                                                                                                        _loc4_ = _loc22_;
                                                                                                                     }
                                                                                                                     _loc22_ = _loc4_ | 4;
                                                                                                                     if(uint(_loc19_) >= 268435456)
                                                                                                                     {
                                                                                                                        _loc22_ = _loc4_;
                                                                                                                     }
                                                                                                                     _loc19_ = _loc22_ | 2;
                                                                                                                     if(uint(_loc13_) >= 1073741824)
                                                                                                                     {
                                                                                                                        _loc19_ = _loc22_;
                                                                                                                     }
                                                                                                                     if(_loc25_ >= 0)
                                                                                                                     {
                                                                                                                        _loc19_ += 1;
                                                                                                                        _loc13_ = 32;
                                                                                                                        if((_loc25_ & 1073741824) != 0)
                                                                                                                        {
                                                                                                                           addr7669:
                                                                                                                           _loc13_ = _loc19_;
                                                                                                                        }
                                                                                                                        _loc5_ = (_loc22_ = li32((_loc20_ = _loc17_ + _loc15_) + 16)) << 16;
                                                                                                                        if(uint(_loc22_) >= 65536)
                                                                                                                        {
                                                                                                                           _loc5_ = _loc22_;
                                                                                                                        }
                                                                                                                        _loc19_ = _loc5_ << 8;
                                                                                                                        if(uint(_loc5_) >= 16777216)
                                                                                                                        {
                                                                                                                           _loc19_ = _loc5_;
                                                                                                                        }
                                                                                                                        _loc25_ = _loc19_ << 4;
                                                                                                                        if(uint(_loc19_) >= 268435456)
                                                                                                                        {
                                                                                                                           _loc25_ = _loc19_;
                                                                                                                        }
                                                                                                                        _loc15_ = _loc25_ << 2;
                                                                                                                        if(uint(_loc25_) >= 1073741824)
                                                                                                                        {
                                                                                                                           _loc15_ = _loc25_;
                                                                                                                        }
                                                                                                                        _loc4_ = 16;
                                                                                                                        if(uint(_loc22_) >= 65536)
                                                                                                                        {
                                                                                                                           _loc4_ = 0;
                                                                                                                        }
                                                                                                                        _loc22_ = _loc4_ | 8;
                                                                                                                        if(uint(_loc5_) >= 16777216)
                                                                                                                        {
                                                                                                                           _loc22_ = _loc4_;
                                                                                                                        }
                                                                                                                        _loc4_ = _loc22_ | 4;
                                                                                                                        if(uint(_loc19_) >= 268435456)
                                                                                                                        {
                                                                                                                           _loc4_ = _loc22_;
                                                                                                                        }
                                                                                                                        _loc19_ = _loc4_ | 2;
                                                                                                                        if(uint(_loc25_) >= 1073741824)
                                                                                                                        {
                                                                                                                           _loc19_ = _loc4_;
                                                                                                                        }
                                                                                                                        if(_loc15_ >= 0)
                                                                                                                        {
                                                                                                                           _loc19_ += 1;
                                                                                                                           _loc15_ = 32;
                                                                                                                           if((_loc15_ & 1073741824) != 0)
                                                                                                                           {
                                                                                                                              addr7785:
                                                                                                                              _loc15_ = _loc19_;
                                                                                                                           }
                                                                                                                           if(_loc13_ > _loc15_)
                                                                                                                           {
                                                                                                                              addr7792:
                                                                                                                              if(_loc36_ == _loc38_)
                                                                                                                              {
                                                                                                                                 si32(_loc20_ = (_loc20_ = li32(_loc2_ - 24)) + -1,_loc2_ - 24);
                                                                                                                                 _loc46_ = 1;
                                                                                                                                 addr8330:
                                                                                                                                 if(_loc8_ != 0)
                                                                                                                                 {
                                                                                                                                    if((_loc11_ = li32(_loc8_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc8_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc11_ = li32(_loc8_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc11_ << 2;
                                                                                                                                       si32(_loc23_ = li32(_loc20_ = _freelist + _loc20_),_loc8_);
                                                                                                                                       si32(_loc8_,_loc20_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_unlock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(_loc17_ != 0)
                                                                                                                                 {
                                                                                                                                    if((_loc8_ = li32(_loc17_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc17_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc8_ = li32(_loc17_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc8_ << 2;
                                                                                                                                       si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc17_);
                                                                                                                                       si32(_loc17_,_loc23_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_unlock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(_loc31_ != 0)
                                                                                                                                 {
                                                                                                                                    break;
                                                                                                                                 }
                                                                                                                                 if(_loc35_ == (_loc23_ = li32(_loc2_ - 24)) + li32(_loc2_ - 28))
                                                                                                                                 {
                                                                                                                                    if(_loc32_ != 0)
                                                                                                                                    {
                                                                                                                                       _loc27_ = _loc44_ + -0.5;
                                                                                                                                       _loc39_ = -(_loc28_ = _loc26_ * 5e-16);
                                                                                                                                       if(!(_loc27_ >= _loc39_ | _loc27_ != _loc27_ | _loc39_ != _loc39_))
                                                                                                                                       {
                                                                                                                                          if(!(_loc44_ <= _loc28_ | _loc44_ != _loc44_ | _loc28_ != _loc28_))
                                                                                                                                          {
                                                                                                                                             si32(_loc20_ = (_loc20_ = li32(_loc2_ - 20)) | _loc30_,_loc2_ - 20);
                                                                                                                                             break;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else if(!(_loc27_ <= _loc28_ | _loc27_ != _loc27_ | _loc28_ != _loc28_))
                                                                                                                                       {
                                                                                                                                          if(!((_loc39_ = 1 - _loc28_) <= _loc44_ | _loc39_ != _loc39_ | _loc44_ != _loc44_))
                                                                                                                                          {
                                                                                                                                             si32(_loc20_ = (_loc20_ = li32(_loc2_ - 20)) | _loc30_,_loc2_ - 20);
                                                                                                                                             break;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 _loc31_ = 0;
                                                                                                                                 if(_loc46_ == 0)
                                                                                                                                 {
                                                                                                                                    _loc29_ = li32((_loc35_ = li32(_loc2_ - 36)) + 16);
                                                                                                                                    _loc32_ = _loc31_ = 0;
                                                                                                                                    for(; _loc32_ < _loc29_; _loc31_ += 32,_loc32_ += 1)
                                                                                                                                    {
                                                                                                                                       if((_loc30_ = li32((_loc20_ = _loc35_ + (_loc32_ << 2)) + 20)) == 0)
                                                                                                                                       {
                                                                                                                                          continue;
                                                                                                                                       }
                                                                                                                                       if((_loc20_ = _loc30_ & 7) != 0)
                                                                                                                                       {
                                                                                                                                          _loc29_ = 0;
                                                                                                                                          if((_loc30_ & 1) == 0)
                                                                                                                                          {
                                                                                                                                             _loc29_ = 1;
                                                                                                                                             if((_loc30_ & 2) == 0)
                                                                                                                                             {
                                                                                                                                                _loc29_ = 2;
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc29_ = _loc30_ >>> 16;
                                                                                                                                          if((_loc9_ = _loc30_ & 65535) != 0)
                                                                                                                                          {
                                                                                                                                             _loc29_ = _loc30_;
                                                                                                                                          }
                                                                                                                                          _loc30_ = _loc29_ >>> 8;
                                                                                                                                          if((_loc32_ = _loc29_ & 255) != 0)
                                                                                                                                          {
                                                                                                                                             _loc30_ = _loc29_;
                                                                                                                                          }
                                                                                                                                          _loc8_ = _loc30_ >>> 4;
                                                                                                                                          if((_loc35_ = _loc30_ & 15) != 0)
                                                                                                                                          {
                                                                                                                                             _loc8_ = _loc30_;
                                                                                                                                          }
                                                                                                                                          _loc30_ = _loc8_ >>> 2;
                                                                                                                                          if((_loc29_ = _loc8_ & 3) != 0)
                                                                                                                                          {
                                                                                                                                             _loc30_ = _loc8_;
                                                                                                                                          }
                                                                                                                                          _loc8_ = 16;
                                                                                                                                          if(_loc9_ != 0)
                                                                                                                                          {
                                                                                                                                             _loc8_ = 0;
                                                                                                                                          }
                                                                                                                                          _loc9_ = _loc8_ | 8;
                                                                                                                                          if(_loc32_ != 0)
                                                                                                                                          {
                                                                                                                                             _loc9_ = _loc8_;
                                                                                                                                          }
                                                                                                                                          _loc32_ = _loc9_ | 4;
                                                                                                                                          if(_loc35_ != 0)
                                                                                                                                          {
                                                                                                                                             _loc32_ = _loc9_;
                                                                                                                                          }
                                                                                                                                          _loc35_ = _loc32_ | 2;
                                                                                                                                          if(_loc29_ != 0)
                                                                                                                                          {
                                                                                                                                             _loc35_ = _loc32_;
                                                                                                                                          }
                                                                                                                                          if((_loc20_ = _loc30_ & 1) == 0)
                                                                                                                                          {
                                                                                                                                             _loc35_ += 1;
                                                                                                                                             _loc29_ = 32;
                                                                                                                                             if(uint(_loc30_) >= 2)
                                                                                                                                             {
                                                                                                                                             }
                                                                                                                                             addr8899:
                                                                                                                                             _loc31_ = _loc29_ + _loc31_;
                                                                                                                                             break;
                                                                                                                                          }
                                                                                                                                          _loc29_ = _loc35_;
                                                                                                                                       }
                                                                                                                                       §§goto(addr8899);
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(_loc47_ != 0)
                                                                                                                                 {
                                                                                                                                    if((_loc30_ = li32(_loc47_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc47_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc30_ = li32(_loc47_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc30_ << 2;
                                                                                                                                       si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc47_);
                                                                                                                                       si32(_loc47_,_loc23_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
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
                                                                                                                                    if((_loc47_ = li32(_loc54_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc54_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc47_ = li32(_loc54_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc47_ << 2;
                                                                                                                                       si32(_loc23_ = li32(_loc20_ = _freelist + _loc20_),_loc54_);
                                                                                                                                       si32(_loc54_,_loc20_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_unlock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(_loc45_ != 0)
                                                                                                                                 {
                                                                                                                                    if((_loc54_ = li32(_loc45_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc45_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc54_ = li32(_loc45_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc54_ << 2;
                                                                                                                                       si32(_loc23_ = li32(_loc20_ = _freelist + _loc20_),_loc45_);
                                                                                                                                       si32(_loc45_,_loc20_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_unlock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 if(_loc49_ != 0)
                                                                                                                                 {
                                                                                                                                    if((_loc45_ = li32(_loc49_ + 4)) >= 10)
                                                                                                                                    {
                                                                                                                                       _loc1_ -= 16;
                                                                                                                                       si32(_loc49_,_loc1_);
                                                                                                                                       ESP = _loc1_;
                                                                                                                                       F_idalloc();
                                                                                                                                       _loc1_ += 16;
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_lock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                          _loc45_ = li32(_loc49_ + 4);
                                                                                                                                       }
                                                                                                                                       _loc20_ = _loc45_ << 2;
                                                                                                                                       si32(_loc23_ = li32(_loc20_ = _freelist + _loc20_),_loc49_);
                                                                                                                                       si32(_loc49_,_loc20_);
                                                                                                                                       if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                       {
                                                                                                                                          _loc1_ -= 16;
                                                                                                                                          si32(___gdtoa_locks,_loc1_);
                                                                                                                                          ESP = _loc1_;
                                                                                                                                          F__pthread_mutex_unlock();
                                                                                                                                          _loc1_ += 16;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 continue;
                                                                                                                              }
                                                                                                                              _loc1_ -= 16;
                                                                                                                              si32(1,_loc1_ + 4);
                                                                                                                              si32(_loc11_,_loc1_);
                                                                                                                              ESP = _loc1_;
                                                                                                                              F___lshift_D2A();
                                                                                                                              _loc1_ += 16;
                                                                                                                              si32(_loc20_ = eax,_loc2_ - 36);
                                                                                                                              si32(_loc20_ = (_loc20_ = li32(_loc2_ - 28)) + -1,_loc2_ - 28);
                                                                                                                              _loc36_ += -1;
                                                                                                                              _loc32_ = _loc31_ = 0;
                                                                                                                              §§goto(addr8330);
                                                                                                                           }
                                                                                                                           §§goto(addr8330);
                                                                                                                        }
                                                                                                                        §§goto(addr7785);
                                                                                                                     }
                                                                                                                     §§goto(addr7669);
                                                                                                                  }
                                                                                                                  §§goto(addr7792);
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc1_ -= 16;
                                                                                                               si32(_loc8_,_loc1_ + 4);
                                                                                                               si32(_loc17_,_loc1_);
                                                                                                               ESP = _loc1_;
                                                                                                               F___sum_D2A();
                                                                                                               _loc1_ += 16;
                                                                                                               si32(_loc11_ = eax,_loc2_ - 36);
                                                                                                               if(li32(_loc17_ + 16) > (_loc13_ = li32(_loc11_ + 16)) + -1)
                                                                                                               {
                                                                                                                  _loc25_ = _loc13_ << 2;
                                                                                                                  _loc3_ = (_loc22_ = li32((_loc20_ = _loc11_ + _loc25_) + 16)) << 16;
                                                                                                                  if(uint(_loc22_) >= 65536)
                                                                                                                  {
                                                                                                                     _loc3_ = _loc22_;
                                                                                                                  }
                                                                                                                  _loc4_ = _loc3_ << 8;
                                                                                                                  if(uint(_loc3_) >= 16777216)
                                                                                                                  {
                                                                                                                     _loc4_ = _loc3_;
                                                                                                                  }
                                                                                                                  _loc19_ = _loc4_ << 4;
                                                                                                                  if(uint(_loc4_) >= 268435456)
                                                                                                                  {
                                                                                                                     _loc19_ = _loc4_;
                                                                                                                  }
                                                                                                                  _loc15_ = _loc19_ << 2;
                                                                                                                  if(uint(_loc19_) >= 1073741824)
                                                                                                                  {
                                                                                                                     _loc15_ = _loc19_;
                                                                                                                  }
                                                                                                                  _loc5_ = 16;
                                                                                                                  if(uint(_loc22_) >= 65536)
                                                                                                                  {
                                                                                                                     _loc5_ = 0;
                                                                                                                  }
                                                                                                                  _loc22_ = _loc5_ | 8;
                                                                                                                  if(uint(_loc3_) >= 16777216)
                                                                                                                  {
                                                                                                                     _loc22_ = _loc5_;
                                                                                                                  }
                                                                                                                  _loc5_ = _loc22_ | 4;
                                                                                                                  if(uint(_loc4_) >= 268435456)
                                                                                                                  {
                                                                                                                     _loc5_ = _loc22_;
                                                                                                                  }
                                                                                                                  _loc4_ = _loc5_ | 2;
                                                                                                                  if(uint(_loc19_) >= 1073741824)
                                                                                                                  {
                                                                                                                     _loc4_ = _loc5_;
                                                                                                                  }
                                                                                                                  if(_loc15_ >= 0)
                                                                                                                  {
                                                                                                                     _loc4_ += 1;
                                                                                                                     _loc15_ = 32;
                                                                                                                     if((_loc15_ & 1073741824) != 0)
                                                                                                                     {
                                                                                                                        addr8037:
                                                                                                                        _loc15_ = _loc4_;
                                                                                                                     }
                                                                                                                     _loc3_ = (_loc22_ = li32((_loc20_ = _loc17_ + _loc25_) + 16)) << 16;
                                                                                                                     if(uint(_loc22_) >= 65536)
                                                                                                                     {
                                                                                                                        _loc3_ = _loc22_;
                                                                                                                     }
                                                                                                                     _loc4_ = _loc3_ << 8;
                                                                                                                     if(uint(_loc3_) >= 16777216)
                                                                                                                     {
                                                                                                                        _loc4_ = _loc3_;
                                                                                                                     }
                                                                                                                     _loc19_ = _loc4_ << 4;
                                                                                                                     if(uint(_loc4_) >= 268435456)
                                                                                                                     {
                                                                                                                        _loc19_ = _loc4_;
                                                                                                                     }
                                                                                                                     _loc25_ = _loc19_ << 2;
                                                                                                                     if(uint(_loc19_) >= 1073741824)
                                                                                                                     {
                                                                                                                        _loc25_ = _loc19_;
                                                                                                                     }
                                                                                                                     _loc5_ = 16;
                                                                                                                     if(uint(_loc22_) >= 65536)
                                                                                                                     {
                                                                                                                        _loc5_ = 0;
                                                                                                                     }
                                                                                                                     _loc22_ = _loc5_ | 8;
                                                                                                                     if(uint(_loc3_) >= 16777216)
                                                                                                                     {
                                                                                                                        _loc22_ = _loc5_;
                                                                                                                     }
                                                                                                                     _loc5_ = _loc22_ | 4;
                                                                                                                     if(uint(_loc4_) >= 268435456)
                                                                                                                     {
                                                                                                                        _loc5_ = _loc22_;
                                                                                                                     }
                                                                                                                     _loc4_ = _loc5_ | 2;
                                                                                                                     if(uint(_loc19_) >= 1073741824)
                                                                                                                     {
                                                                                                                        _loc4_ = _loc5_;
                                                                                                                     }
                                                                                                                     if(_loc25_ >= 0)
                                                                                                                     {
                                                                                                                        _loc4_ += 1;
                                                                                                                        _loc25_ = 32;
                                                                                                                        if((_loc25_ & 1073741824) != 0)
                                                                                                                        {
                                                                                                                           addr8153:
                                                                                                                           _loc25_ = _loc4_;
                                                                                                                        }
                                                                                                                        if(_loc15_ < _loc25_)
                                                                                                                        {
                                                                                                                           addr8160:
                                                                                                                           if(_loc46_ != 0)
                                                                                                                           {
                                                                                                                              si32(_loc20_ = (_loc20_ = li32(_loc2_ - 24)) + 1,_loc2_ - 24);
                                                                                                                              if(_loc20_ == _loc52_)
                                                                                                                              {
                                                                                                                                 _loc46_ = 0;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc46_ = _loc32_ = _loc11_ + 20;
                                                                                                                              if(_loc13_ >= 1)
                                                                                                                              {
                                                                                                                                 _loc15_ = (_loc20_ = li32(_loc11_ + 20)) >>> 1;
                                                                                                                                 _loc46_ = _loc32_;
                                                                                                                                 if(_loc13_ >= 2)
                                                                                                                                 {
                                                                                                                                    _loc25_ = (_loc46_ = _loc11_ + 20) + (_loc13_ << 2);
                                                                                                                                    _loc13_ = _loc11_ + 24;
                                                                                                                                    do
                                                                                                                                    {
                                                                                                                                       si32(_loc23_ = (_loc23_ = (_loc20_ = li32(_loc46_ + 4)) << 31) | _loc15_,_loc46_);
                                                                                                                                       _loc13_ += 4;
                                                                                                                                       _loc46_ += 4;
                                                                                                                                       _loc15_ = _loc20_ >>> 1;
                                                                                                                                    }
                                                                                                                                    while(uint(_loc13_) < uint(_loc25_));
                                                                                                                                    
                                                                                                                                 }
                                                                                                                                 si32(_loc15_,_loc46_);
                                                                                                                                 if(_loc15_ != 0)
                                                                                                                                 {
                                                                                                                                    _loc46_ += 4;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              si32(_loc20_ = (_loc20_ = _loc46_ - _loc32_) >> 2,_loc11_ + 16);
                                                                                                                              if(_loc20_ == 0)
                                                                                                                              {
                                                                                                                                 si32(0,_loc32_);
                                                                                                                              }
                                                                                                                              si32(_loc20_ = (_loc20_ = li32(_loc2_ - 28)) + 1,_loc2_ - 28);
                                                                                                                              _loc36_ += 1;
                                                                                                                              _loc46_ = _loc32_ = 0;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        §§goto(addr8330);
                                                                                                                     }
                                                                                                                     §§goto(addr8153);
                                                                                                                  }
                                                                                                                  §§goto(addr8037);
                                                                                                               }
                                                                                                               §§goto(addr8160);
                                                                                                            }
                                                                                                            §§goto(addr8330);
                                                                                                         }
                                                                                                         _loc8_ = 1072693248;
                                                                                                         _loc17_ = 0;
                                                                                                         _loc11_ = 1;
                                                                                                         _loc30_ = 16;
                                                                                                         _loc44_ = 1;
                                                                                                         _loc32_ = _loc17_;
                                                                                                         if(_loc46_ != 0)
                                                                                                         {
                                                                                                            _loc32_ = _loc17_;
                                                                                                            if(_loc35_ <= 1)
                                                                                                            {
                                                                                                               _loc10_ = li32(_loc2_ - 36);
                                                                                                               addr6896:
                                                                                                               si32(0,_loc10_ + 16);
                                                                                                               si32(_loc38_,_loc2_ - 28);
                                                                                                               si32(80,_loc2_ - 20);
                                                                                                               break;
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      §§goto(addr7087);
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      addr5667:
                                                                                                      if(_loc29_ <= -1)
                                                                                                      {
                                                                                                         _loc10_ = 33;
                                                                                                         if(_loc9_ != 0)
                                                                                                         {
                                                                                                            _loc10_ = 17;
                                                                                                         }
                                                                                                         si32(_loc10_,_loc2_ - 20);
                                                                                                         _loc48_ = _loc10_ = 1;
                                                                                                         if(_loc9_ == 0)
                                                                                                         {
                                                                                                            _loc48_ = 0;
                                                                                                         }
                                                                                                         _loc37_ = _loc10_;
                                                                                                         if(_loc35_ <= _loc10_)
                                                                                                         {
                                                                                                            _loc37_ = 0;
                                                                                                         }
                                                                                                         if(_loc46_ == 0)
                                                                                                         {
                                                                                                            _loc10_ = 0;
                                                                                                         }
                                                                                                         if(_loc36_ != _loc38_)
                                                                                                         {
                                                                                                            if((_loc20_ = (_loc20_ = _loc37_ | _loc48_) | _loc10_) == 0)
                                                                                                            {
                                                                                                               _loc1_ -= 16;
                                                                                                               si32(1,_loc1_ + 4);
                                                                                                               si32(_loc49_,_loc1_);
                                                                                                               ESP = _loc1_;
                                                                                                               F___lshift_D2A();
                                                                                                               _loc1_ += 16;
                                                                                                               _loc49_ = eax;
                                                                                                               _loc48_ = li32(_loc45_ + 16);
                                                                                                               if((_loc10_ = li32(_loc49_ + 16)) != _loc48_)
                                                                                                               {
                                                                                                                  _loc37_ = _loc10_ - _loc48_;
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc50_ = (_loc20_ = (_loc23_ = _loc48_ << 2) + _loc49_) + 20;
                                                                                                                  _loc37_ = (_loc20_ = _loc23_ + _loc45_) + 16;
                                                                                                                  _loc7_ = _loc49_ + 20;
                                                                                                                  while(true)
                                                                                                                  {
                                                                                                                     _loc48_ = li32(_loc37_);
                                                                                                                     if((_loc10_ = li32(_loc50_ - 4)) == _loc48_)
                                                                                                                     {
                                                                                                                        _loc50_ += -4;
                                                                                                                        _loc37_ += -4;
                                                                                                                        if(uint(_loc50_) <= uint(_loc7_))
                                                                                                                        {
                                                                                                                           break loop21;
                                                                                                                        }
                                                                                                                        continue;
                                                                                                                     }
                                                                                                                     _loc37_ = -1;
                                                                                                                     if(uint(_loc10_) >= uint(_loc48_))
                                                                                                                     {
                                                                                                                        _loc37_ = 1;
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                               if(_loc37_ <= 0)
                                                                                                               {
                                                                                                                  break;
                                                                                                               }
                                                                                                               si32(17,_loc2_ - 20);
                                                                                                               if(_loc36_ != _loc38_)
                                                                                                               {
                                                                                                                  addr6047:
                                                                                                                  si32(_loc20_ = (_loc20_ = li32(_loc2_ - 28)) - _loc52_,_loc2_ - 28);
                                                                                                                  _loc10_ = li32(_loc2_ - 36);
                                                                                                                  si32(_loc52_,_loc2_ - 24);
                                                                                                                  _loc48_ = (_loc20_ = _loc52_ + 31) >> 5;
                                                                                                                  if((_loc38_ = li32(_loc10_ + 4)) < _loc48_)
                                                                                                                  {
                                                                                                                     if(_loc10_ != 0)
                                                                                                                     {
                                                                                                                        if(_loc38_ >= 10)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(_loc10_,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F_idalloc();
                                                                                                                           _loc1_ += 16;
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                           {
                                                                                                                              _loc1_ -= 16;
                                                                                                                              si32(___gdtoa_locks,_loc1_);
                                                                                                                              ESP = _loc1_;
                                                                                                                              F__pthread_mutex_lock();
                                                                                                                              _loc1_ += 16;
                                                                                                                              _loc38_ = li32(_loc10_ + 4);
                                                                                                                           }
                                                                                                                           _loc20_ = _loc38_ << 2;
                                                                                                                           si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc10_);
                                                                                                                           si32(_loc10_,_loc23_);
                                                                                                                           if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                           {
                                                                                                                              _loc1_ -= 16;
                                                                                                                              si32(___gdtoa_locks,_loc1_);
                                                                                                                              ESP = _loc1_;
                                                                                                                              F__pthread_mutex_unlock();
                                                                                                                              _loc1_ += 16;
                                                                                                                           }
                                                                                                                        }
                                                                                                                     }
                                                                                                                     _loc1_ -= 16;
                                                                                                                     si32(_loc48_,_loc1_);
                                                                                                                     ESP = _loc1_;
                                                                                                                     F___Balloc_D2A();
                                                                                                                     _loc1_ += 16;
                                                                                                                     _loc10_ = eax;
                                                                                                                  }
                                                                                                                  _loc48_ = _loc52_ & 31;
                                                                                                                  _loc38_ = 1;
                                                                                                                  if(_loc48_ == 0)
                                                                                                                  {
                                                                                                                     _loc38_ = 0;
                                                                                                                  }
                                                                                                                  _loc23_ = _loc38_ & 1;
                                                                                                                  _loc20_ = _loc52_ >> 5;
                                                                                                                  si32(_loc36_ = _loc23_ + _loc20_,_loc10_ + 16);
                                                                                                                  _loc38_ = _loc10_ + 20;
                                                                                                                  if(_loc36_ >= 1)
                                                                                                                  {
                                                                                                                     _loc36_ = _loc38_ + (_loc36_ << 2);
                                                                                                                     _loc38_ = _loc10_ + 20;
                                                                                                                     do
                                                                                                                     {
                                                                                                                        si32(-1,_loc38_);
                                                                                                                     }
                                                                                                                     while((uint(_loc38_ += 4)) < uint(_loc36_));
                                                                                                                     
                                                                                                                  }
                                                                                                                  if(_loc48_ != 0)
                                                                                                                  {
                                                                                                                     si32(_loc20_ = (_loc20_ = li32(_loc38_ - 4)) >>> 32 - _loc48_,_loc38_ - 4);
                                                                                                                  }
                                                                                                                  si32(_loc10_,_loc2_ - 36);
                                                                                                                  break;
                                                                                                               }
                                                                                                            }
                                                                                                            break;
                                                                                                         }
                                                                                                         break;
                                                                                                      }
                                                                                                      if(_loc29_ == 0)
                                                                                                      {
                                                                                                         if(_loc9_ != 0)
                                                                                                         {
                                                                                                            _loc10_ = 1;
                                                                                                            if(_loc46_ != 0)
                                                                                                            {
                                                                                                               _loc37_ = (_loc36_ = li32(_loc2_ - 24)) >> 5;
                                                                                                               _loc48_ = 0;
                                                                                                               _loc10_ = li32(_loc2_ - 36);
                                                                                                               do
                                                                                                               {
                                                                                                                  if(_loc48_ < _loc37_)
                                                                                                                  {
                                                                                                                     continue;
                                                                                                                  }
                                                                                                                  if((_loc36_ &= 31) != 0)
                                                                                                                  {
                                                                                                                     if((_loc20_ = (_loc23_ = li32((_loc23_ = _loc10_ + (_loc48_ << 2)) + 20)) | -1 << _loc36_) != -1)
                                                                                                                     {
                                                                                                                        break;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  si32(_loc48_ = 1,_loc10_ + 16);
                                                                                                                  _loc20_ = li32(_loc2_ - 36);
                                                                                                                  si32(_loc48_,_loc20_ + 20);
                                                                                                                  si32(_loc48_,_loc2_ - 24);
                                                                                                                  si32(_loc20_ = (_loc20_ = _loc52_ + _loc38_) + -1,_loc2_ - 28);
                                                                                                                  si32(33,_loc2_ - 20);
                                                                                                                  _loc46_ = 0;
                                                                                                                  if(_loc52_ != _loc48_)
                                                                                                                  {
                                                                                                                     _loc46_ = _loc52_ - _loc48_;
                                                                                                                     _loc10_ = li32(_loc2_ - 36);
                                                                                                                     if(_loc46_ >= 1)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc46_,_loc1_ + 4);
                                                                                                                        si32(_loc10_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F___lshift_D2A();
                                                                                                                        _loc1_ += 16;
                                                                                                                        si32(_loc20_ = eax,_loc2_ - 36);
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _loc7_ = li32(_loc10_ + 16);
                                                                                                                        _loc36_ = _loc10_ + 20;
                                                                                                                        _loc34_ = (_loc37_ = 0 - _loc46_) >> 5;
                                                                                                                        _loc38_ = _loc36_;
                                                                                                                        if(_loc7_ > _loc34_)
                                                                                                                        {
                                                                                                                           _loc48_ = (_loc20_ = _loc10_ + (_loc7_ << 2)) + 20;
                                                                                                                           if((_loc50_ = _loc37_ & 31) == 0)
                                                                                                                           {
                                                                                                                              _loc38_ = _loc36_;
                                                                                                                              if(_loc34_ < _loc7_)
                                                                                                                              {
                                                                                                                                 _loc37_ = _loc34_ << 2;
                                                                                                                                 _loc38_ = _loc10_ + 20;
                                                                                                                                 do
                                                                                                                                 {
                                                                                                                                    si32(_loc20_ = li32(_loc20_ = _loc38_ + _loc37_),_loc38_);
                                                                                                                                 }
                                                                                                                                 while((uint(_loc20_ = (_loc38_ += 4) + _loc37_)) < uint(_loc48_));
                                                                                                                                 
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc37_ = (_loc20_ = li32((_loc33_ = _loc10_ + (_loc34_ << 2)) + 20)) >>> _loc50_;
                                                                                                                              _loc38_ = _loc36_;
                                                                                                                              if(_loc34_ + 1 < _loc7_)
                                                                                                                              {
                                                                                                                                 _loc7_ = 32 - _loc50_;
                                                                                                                                 _loc34_ = _loc33_ + 24;
                                                                                                                                 _loc38_ = _loc10_ + 20;
                                                                                                                                 do
                                                                                                                                 {
                                                                                                                                    si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc34_)) << _loc7_) | _loc37_,_loc38_);
                                                                                                                                    _loc37_ = (_loc20_ = li32(_loc34_)) >>> _loc50_;
                                                                                                                                    _loc34_ += 4;
                                                                                                                                    _loc38_ += 4;
                                                                                                                                 }
                                                                                                                                 while(uint(_loc34_) < uint(_loc48_));
                                                                                                                                 
                                                                                                                              }
                                                                                                                              si32(_loc37_,_loc38_);
                                                                                                                              if(_loc37_ != 0)
                                                                                                                              {
                                                                                                                                 _loc38_ += 4;
                                                                                                                              }
                                                                                                                           }
                                                                                                                        }
                                                                                                                        si32(_loc20_ = (_loc20_ = _loc38_ - _loc36_) >> 2,_loc10_ + 16);
                                                                                                                        if(_loc20_ == 0)
                                                                                                                        {
                                                                                                                           si32(0,_loc36_);
                                                                                                                        }
                                                                                                                     }
                                                                                                                     si32(_loc20_ = (_loc20_ = li32(_loc2_ - 28)) - _loc46_,_loc2_ - 28);
                                                                                                                     _loc46_ = 0;
                                                                                                                  }
                                                                                                                  si32(_loc20_ = li32(_loc2_ - 28),_loc16_);
                                                                                                                  if(_loc47_ != 0)
                                                                                                                  {
                                                                                                                     if((_loc10_ = li32(_loc47_ + 4)) >= 10)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc47_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F_idalloc();
                                                                                                                        _loc1_ += 16;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_lock();
                                                                                                                           _loc1_ += 16;
                                                                                                                           _loc10_ = li32(_loc47_ + 4);
                                                                                                                        }
                                                                                                                        _loc20_ = _loc10_ << 2;
                                                                                                                        si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc47_);
                                                                                                                        si32(_loc47_,_loc23_);
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
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
                                                                                                                     if((_loc10_ = li32(_loc54_ + 4)) >= 10)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc54_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F_idalloc();
                                                                                                                        _loc1_ += 16;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_lock();
                                                                                                                           _loc1_ += 16;
                                                                                                                           _loc10_ = li32(_loc54_ + 4);
                                                                                                                        }
                                                                                                                        _loc20_ = _loc10_ << 2;
                                                                                                                        si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc54_);
                                                                                                                        si32(_loc54_,_loc23_);
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_unlock();
                                                                                                                           _loc1_ += 16;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  if(_loc45_ != 0)
                                                                                                                  {
                                                                                                                     if((_loc10_ = li32(_loc45_ + 4)) >= 10)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc45_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F_idalloc();
                                                                                                                        _loc1_ += 16;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_lock();
                                                                                                                           _loc1_ += 16;
                                                                                                                           _loc10_ = li32(_loc45_ + 4);
                                                                                                                        }
                                                                                                                        _loc20_ = _loc10_ << 2;
                                                                                                                        si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc45_);
                                                                                                                        si32(_loc45_,_loc23_);
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_unlock();
                                                                                                                           _loc1_ += 16;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  if(_loc51_ != 0)
                                                                                                                  {
                                                                                                                     if((_loc10_ = li32(_loc51_ + 4)) >= 10)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc51_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F_idalloc();
                                                                                                                        _loc1_ += 16;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_lock();
                                                                                                                           _loc1_ += 16;
                                                                                                                           _loc10_ = li32(_loc51_ + 4);
                                                                                                                        }
                                                                                                                        _loc20_ = _loc10_ << 2;
                                                                                                                        si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc51_);
                                                                                                                        si32(_loc51_,_loc23_);
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_unlock();
                                                                                                                           _loc1_ += 16;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  if(_loc49_ != 0)
                                                                                                                  {
                                                                                                                     if((_loc10_ = li32(_loc49_ + 4)) >= 10)
                                                                                                                     {
                                                                                                                        _loc1_ -= 16;
                                                                                                                        si32(_loc49_,_loc1_);
                                                                                                                        ESP = _loc1_;
                                                                                                                        F_idalloc();
                                                                                                                        _loc1_ += 16;
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_lock();
                                                                                                                           _loc1_ += 16;
                                                                                                                           _loc10_ = li32(_loc49_ + 4);
                                                                                                                        }
                                                                                                                        _loc20_ = _loc10_ << 2;
                                                                                                                        si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc49_);
                                                                                                                        si32(_loc49_,_loc23_);
                                                                                                                        if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                        {
                                                                                                                           _loc1_ -= 16;
                                                                                                                           si32(___gdtoa_locks,_loc1_);
                                                                                                                           ESP = _loc1_;
                                                                                                                           F__pthread_mutex_unlock();
                                                                                                                           _loc1_ += 16;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  _loc23_ = li32(_loc53_);
                                                                                                                  _loc20_ = li32(_loc2_ - 28);
                                                                                                                  if(_loc23_ < _loc20_)
                                                                                                                  {
                                                                                                                     if((_loc10_ = (_loc20_ = li32(_loc14_ + 12)) & 3) != 1)
                                                                                                                     {
                                                                                                                        if(_loc10_ != 3)
                                                                                                                        {
                                                                                                                           if(_loc10_ == 2)
                                                                                                                           {
                                                                                                                              if(_loc6_ == 0)
                                                                                                                              {
                                                                                                                                 addr10510:
                                                                                                                                 _loc20_ = li32(_loc2_ - 36);
                                                                                                                                 si32(0,_loc20_ + 16);
                                                                                                                                 si32(163,_loc2_ - 20);
                                                                                                                                 ESP = _loc1_;
                                                                                                                                 F___error();
                                                                                                                                 _loc20_ = eax;
                                                                                                                                 si32(34,_loc20_);
                                                                                                                              }
                                                                                                                              §§goto(addr10540);
                                                                                                                           }
                                                                                                                           addr10280:
                                                                                                                           if((_loc53_ = li32(_loc2_ - 36)) != 0)
                                                                                                                           {
                                                                                                                              if((_loc10_ = li32(_loc53_ + 4)) >= 10)
                                                                                                                              {
                                                                                                                                 _loc1_ -= 16;
                                                                                                                                 si32(_loc53_,_loc1_);
                                                                                                                                 ESP = _loc1_;
                                                                                                                                 F_idalloc();
                                                                                                                                 _loc1_ += 16;
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                 {
                                                                                                                                    _loc1_ -= 16;
                                                                                                                                    si32(___gdtoa_locks,_loc1_);
                                                                                                                                    ESP = _loc1_;
                                                                                                                                    F__pthread_mutex_lock();
                                                                                                                                    _loc1_ += 16;
                                                                                                                                    _loc10_ = li32(_loc53_ + 4);
                                                                                                                                 }
                                                                                                                                 _loc20_ = _loc10_ << 2;
                                                                                                                                 si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc53_);
                                                                                                                                 si32(_loc53_,_loc23_);
                                                                                                                                 if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                                                                 {
                                                                                                                                    _loc1_ -= 16;
                                                                                                                                    si32(___gdtoa_locks,_loc1_);
                                                                                                                                    ESP = _loc1_;
                                                                                                                                    F__pthread_mutex_unlock();
                                                                                                                                    _loc1_ += 16;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                           }
                                                                                                                           si32(0,_loc2_ - 36);
                                                                                                                           si32(17,_loc2_ - 20);
                                                                                                                           si32(_loc20_ = li32(_loc14_ + 8),_loc16_);
                                                                                                                           if((_loc16_ = (_loc53_ = (_loc10_ = li32(_loc14_)) + 31) >> 5) >= 1)
                                                                                                                           {
                                                                                                                              _loc1_ -= 16;
                                                                                                                              si32(255,_loc1_ + 4);
                                                                                                                              si32(_loc18_,_loc1_);
                                                                                                                              si32(_loc20_ = (_loc20_ = _loc53_ >> 3) & -4,_loc1_ + 8);
                                                                                                                              ESP = _loc1_;
                                                                                                                              Fmemset();
                                                                                                                              _loc1_ += 16;
                                                                                                                              _loc10_ = li32(_loc14_);
                                                                                                                           }
                                                                                                                           if((_loc14_ = _loc10_ & 31) != 0)
                                                                                                                           {
                                                                                                                              _loc20_ = (_loc20_ = _loc16_ << 2) + _loc18_;
                                                                                                                              si32(_loc23_ = li32(_loc20_ - 4) >>> 32 - _loc14_,_loc20_ - 4);
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else if(_loc6_ == 0)
                                                                                                                        {
                                                                                                                           §§goto(addr10280);
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           §§goto(addr10510);
                                                                                                                        }
                                                                                                                     }
                                                                                                                     §§goto(addr10510);
                                                                                                                  }
                                                                                                                  §§goto(addr10540);
                                                                                                               }
                                                                                                               while(_loc48_ += 1, li32((_loc20_ = _loc10_ + (_loc48_ << 2)) + 20) == -1);
                                                                                                               
                                                                                                               si32(17,_loc2_ - 20);
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               addr6328:
                                                                                                               si32(_loc37_,_loc2_ - 20);
                                                                                                               if(_loc35_ < _loc52_)
                                                                                                               {
                                                                                                                  if(_loc10_ == 0)
                                                                                                                  {
                                                                                                                  }
                                                                                                                  break;
                                                                                                               }
                                                                                                               _loc10_ = li32(_loc2_ - 36);
                                                                                                            }
                                                                                                            if((_loc20_ = (_loc48_ = li32(_loc10_ + 20)) & 1) != 0)
                                                                                                            {
                                                                                                               if(_loc9_ != 0)
                                                                                                               {
                                                                                                                  _loc1_ -= 16;
                                                                                                                  si32(_loc10_,_loc1_);
                                                                                                                  ESP = _loc1_;
                                                                                                                  F___increment_D2A();
                                                                                                                  _loc1_ += 16;
                                                                                                                  si32(_loc20_ = eax,_loc2_ - 36);
                                                                                                                  _loc37_ = (_loc50_ = li32((_loc20_ = (_loc23_ = (_loc23_ = li32(_loc20_ + 16)) << 2) + _loc20_) + 16)) << 16;
                                                                                                                  if(uint(_loc50_) >= 65536)
                                                                                                                  {
                                                                                                                     _loc37_ = _loc50_;
                                                                                                                  }
                                                                                                                  _loc38_ = _loc37_ << 8;
                                                                                                                  if(uint(_loc37_) >= 16777216)
                                                                                                                  {
                                                                                                                     _loc38_ = _loc37_;
                                                                                                                  }
                                                                                                                  _loc48_ = _loc38_ << 4;
                                                                                                                  if(uint(_loc38_) >= 268435456)
                                                                                                                  {
                                                                                                                     _loc48_ = _loc38_;
                                                                                                                  }
                                                                                                                  _loc10_ = _loc48_ << 2;
                                                                                                                  if(uint(_loc48_) >= 1073741824)
                                                                                                                  {
                                                                                                                     _loc10_ = _loc48_;
                                                                                                                  }
                                                                                                                  _loc36_ = 16;
                                                                                                                  if(uint(_loc50_) >= 65536)
                                                                                                                  {
                                                                                                                     _loc36_ = 0;
                                                                                                                  }
                                                                                                                  _loc50_ = _loc36_ | 8;
                                                                                                                  if(uint(_loc37_) >= 16777216)
                                                                                                                  {
                                                                                                                     _loc50_ = _loc36_;
                                                                                                                  }
                                                                                                                  _loc36_ = _loc50_ | 4;
                                                                                                                  if(uint(_loc38_) >= 268435456)
                                                                                                                  {
                                                                                                                     _loc36_ = _loc50_;
                                                                                                                  }
                                                                                                                  _loc38_ = _loc36_ | 2;
                                                                                                                  if(uint(_loc48_) >= 1073741824)
                                                                                                                  {
                                                                                                                     _loc38_ = _loc36_;
                                                                                                                  }
                                                                                                                  _loc48_ = li32(_loc2_ - 24);
                                                                                                                  if(_loc10_ >= 0)
                                                                                                                  {
                                                                                                                     _loc38_ += 1;
                                                                                                                     if((_loc20_ = _loc10_ & 1073741824) != 0)
                                                                                                                     {
                                                                                                                        addr6518:
                                                                                                                        _loc20_ = (_loc20_ = 0 - _loc48_) & 31;
                                                                                                                        if(_loc38_ != _loc20_)
                                                                                                                        {
                                                                                                                           addr6531:
                                                                                                                           si32(_loc20_ = _loc48_ + 1,_loc2_ - 24);
                                                                                                                        }
                                                                                                                        si32(33,_loc2_ - 20);
                                                                                                                        break;
                                                                                                                     }
                                                                                                                     §§goto(addr6531);
                                                                                                                  }
                                                                                                                  §§goto(addr6518);
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  if(_loc35_ != 1)
                                                                                                                  {
                                                                                                                     _loc38_ = (_loc20_ = _loc10_ + ((_loc20_ = li32(_loc10_ + 16)) << 2)) + 20;
                                                                                                                     _loc10_ += 24;
                                                                                                                     while(true)
                                                                                                                     {
                                                                                                                        if(_loc48_ != 0)
                                                                                                                        {
                                                                                                                           si32(_loc20_ = _loc48_ + -1,_loc10_ - 4);
                                                                                                                           break;
                                                                                                                        }
                                                                                                                        si32(-1,_loc10_ - 4);
                                                                                                                        if(uint(_loc10_) >= uint(_loc38_))
                                                                                                                        {
                                                                                                                           break;
                                                                                                                        }
                                                                                                                        _loc48_ = li32(_loc10_);
                                                                                                                        _loc10_ += 4;
                                                                                                                     }
                                                                                                                     si32(17,_loc2_ - 20);
                                                                                                                     break;
                                                                                                                  }
                                                                                                                  §§goto(addr6896);
                                                                                                               }
                                                                                                            }
                                                                                                            break;
                                                                                                         }
                                                                                                         if(_loc35_ == 1)
                                                                                                         {
                                                                                                            si32(1,_loc2_ - 20);
                                                                                                            if(_loc36_ == _loc38_)
                                                                                                            {
                                                                                                               addr6015:
                                                                                                               si32(33,_loc2_ - 20);
                                                                                                               if((_loc20_ = li32((_loc10_ = li32(_loc2_ - 36)) + 16)) == 1)
                                                                                                               {
                                                                                                                  if((_loc20_ = li32(_loc10_ + 20)) == 1)
                                                                                                                  {
                                                                                                                     _loc24_ = 1;
                                                                                                                     break;
                                                                                                                  }
                                                                                                                  break;
                                                                                                               }
                                                                                                               break;
                                                                                                            }
                                                                                                            §§goto(addr6047);
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc10_ = 1;
                                                                                                            if(_loc46_ != 0)
                                                                                                            {
                                                                                                               _loc10_ = 0;
                                                                                                            }
                                                                                                            _loc37_ = 33;
                                                                                                         }
                                                                                                         §§goto(addr6328);
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _loc1_ -= 16;
                                                                                                         si32(_loc20_ = _loc2_ - 4,_loc1_ + 4);
                                                                                                         si32(_loc49_,_loc1_);
                                                                                                         ESP = _loc1_;
                                                                                                         F___b2d_D2A();
                                                                                                         _loc1_ += 16;
                                                                                                         sf64(_loc39_ = st0,_loc2_ - 176);
                                                                                                         _loc1_ -= 16;
                                                                                                         si32(_loc20_ = _loc2_ - 8,_loc1_ + 4);
                                                                                                         si32(_loc45_,_loc1_);
                                                                                                         ESP = _loc1_;
                                                                                                         F___b2d_D2A();
                                                                                                         _loc1_ += 16;
                                                                                                         sf64(_loc39_ = st0,_loc2_ - 184);
                                                                                                         var _loc21_:*;
                                                                                                         _loc31_ = (_loc23_ = (_loc23_ = (_loc21_ = li32(_loc49_ + 16)) - li32(_loc45_ + 16)) << 5) + ((_loc23_ = li32(_loc2_ - 4)) - li32(_loc2_ - 8));
                                                                                                         _loc8_ = li32(_loc20_ = (_loc20_ = _loc2_ - 176) | 4);
                                                                                                         _loc29_ = li32(_loc20_ = (_loc20_ = _loc2_ - 184) | 4);
                                                                                                         _loc32_ = li32(_loc2_ - 176);
                                                                                                         _loc30_ = li32(_loc2_ - 184);
                                                                                                         if(_loc31_ >= 1)
                                                                                                         {
                                                                                                            _loc8_ = (_loc20_ = _loc31_ << 20) + _loc8_;
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc29_ -= _loc31_ << 20;
                                                                                                         }
                                                                                                         _loc20_ = (_loc20_ = _loc2_ - 200) | 4;
                                                                                                         si32(_loc29_,_loc20_);
                                                                                                         _loc20_ = (_loc20_ = _loc2_ - 192) | 4;
                                                                                                         si32(_loc8_,_loc20_);
                                                                                                         si32(_loc30_,_loc2_ - 200);
                                                                                                         si32(_loc32_,_loc2_ - 192);
                                                                                                         _loc42_ = lf64(_loc2_ - 200);
                                                                                                         _loc43_ = (_loc39_ = lf64(_loc2_ - 192)) / _loc42_;
                                                                                                         _loc31_ = 0;
                                                                                                         if(!(_loc43_ > 2 | _loc43_ != _loc43_ | false))
                                                                                                         {
                                                                                                            §§goto(addr6852);
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            sf64(_loc44_ = _loc43_ * 0.5,_loc2_ - 208);
                                                                                                            _loc31_ = 0;
                                                                                                            _loc30_ = 32;
                                                                                                            if(_loc9_ != _loc31_)
                                                                                                            {
                                                                                                               _loc30_ = 16;
                                                                                                            }
                                                                                                            _loc35_ = 1;
                                                                                                            if(_loc9_ != _loc31_)
                                                                                                            {
                                                                                                               _loc35_ = _loc31_;
                                                                                                            }
                                                                                                            _loc11_ = _loc35_ & 1;
                                                                                                            _loc8_ = li32(_loc20_ = (_loc20_ = _loc2_ - 208) | 4);
                                                                                                            _loc17_ = li32(_loc2_ - 208);
                                                                                                            _loc32_ = _loc31_;
                                                                                                            if(!(_loc44_ >= 2147483647 | _loc44_ != _loc44_ | false))
                                                                                                            {
                                                                                                               _loc44_ -= _loc32_ = _loc44_;
                                                                                                               if(_loc10_ != 2)
                                                                                                               {
                                                                                                                  if(_loc10_ != 1)
                                                                                                                  {
                                                                                                                     if(_loc10_ == 0)
                                                                                                                     {
                                                                                                                        if(!(_loc44_ < 0.5 | _loc44_ != _loc44_ | false))
                                                                                                                        {
                                                                                                                           addr7048:
                                                                                                                           _loc30_ = 48 - _loc30_;
                                                                                                                           _loc32_ += 1;
                                                                                                                        }
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else if(_loc9_ == 0)
                                                                                                                  {
                                                                                                                     if(_loc44_ > 0)
                                                                                                                     {
                                                                                                                        §§goto(addr7048);
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc31_ = 1;
                                                                                                                  if(_loc9_ == 0)
                                                                                                                  {
                                                                                                                     _loc31_ = 0;
                                                                                                                  }
                                                                                                                  if(!(_loc44_ <= 0 | _loc44_ != _loc44_ | false))
                                                                                                                  {
                                                                                                                     if((_loc20_ = _loc31_ & 1) != 0)
                                                                                                                     {
                                                                                                                        §§goto(addr7048);
                                                                                                                     }
                                                                                                                  }
                                                                                                               }
                                                                                                               sf64(_loc39_ = _loc32_,_loc2_ - 216);
                                                                                                               _loc8_ = li32(_loc20_ = (_loc20_ = _loc2_ - 216) | 4);
                                                                                                               _loc31_ = 0;
                                                                                                               _loc17_ = li32(_loc2_ - 216);
                                                                                                            }
                                                                                                         }
                                                                                                         §§goto(addr6852);
                                                                                                      }
                                                                                                      §§goto(addr6015);
                                                                                                   }
                                                                                                }
                                                                                                §§goto(addr5667);
                                                                                             }
                                                                                             break;
                                                                                          }
                                                                                          §§goto(addr5008);
                                                                                       }
                                                                                       if(_loc46_ == 0)
                                                                                       {
                                                                                          _loc48_ = li32(_loc2_ - 24);
                                                                                          §§goto(addr9376);
                                                                                       }
                                                                                       §§goto(addr9655);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       addr3631:
                                                                                       _loc20_ = li32(_loc2_ - 36);
                                                                                       si32(0,_loc20_ + 16);
                                                                                       _loc20_ = li32(_loc2_ - 36);
                                                                                       si32(0,_loc20_ + 20);
                                                                                       si32(_loc38_,_loc16_);
                                                                                       si32(80,_loc2_ - 20);
                                                                                    }
                                                                                    §§goto(addr10556);
                                                                                 }
                                                                                 §§goto(addr3919);
                                                                              }
                                                                              §§goto(addr3631);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc31_ = li32((_loc36_ = li32(_loc2_ - 36)) + 16);
                                                                              _loc46_ = _loc36_ + 20;
                                                                              _loc29_ = (_loc34_ = 0 - _loc7_) >> 5;
                                                                              _loc50_ = _loc46_;
                                                                              if(_loc31_ > _loc29_)
                                                                              {
                                                                                 _loc7_ = (_loc20_ = _loc36_ + (_loc31_ << 2)) + 20;
                                                                                 if((_loc33_ = _loc34_ & 31) == 0)
                                                                                 {
                                                                                    _loc50_ = _loc46_;
                                                                                    if(_loc29_ < _loc31_)
                                                                                    {
                                                                                       _loc34_ = _loc29_ << 2;
                                                                                       _loc50_ = _loc36_ + 20;
                                                                                       do
                                                                                       {
                                                                                          si32(_loc20_ = li32(_loc20_ = _loc50_ + _loc34_),_loc50_);
                                                                                       }
                                                                                       while((uint(_loc20_ = (_loc50_ += 4) + _loc34_)) < uint(_loc7_));
                                                                                       
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc34_ = (_loc20_ = li32((_loc30_ = _loc36_ + (_loc29_ << 2)) + 20)) >>> _loc33_;
                                                                                    _loc50_ = _loc46_;
                                                                                    if(_loc29_ + 1 < _loc31_)
                                                                                    {
                                                                                       _loc31_ = 32 - _loc33_;
                                                                                       _loc30_ += 24;
                                                                                       _loc50_ = _loc36_ + 20;
                                                                                       do
                                                                                       {
                                                                                          si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc30_)) << _loc31_) | _loc34_,_loc50_);
                                                                                          _loc34_ = (_loc20_ = li32(_loc30_)) >>> _loc33_;
                                                                                          _loc30_ += 4;
                                                                                          _loc50_ += 4;
                                                                                       }
                                                                                       while(uint(_loc30_) < uint(_loc7_));
                                                                                       
                                                                                    }
                                                                                    si32(_loc34_,_loc50_);
                                                                                    if(_loc34_ != 0)
                                                                                    {
                                                                                       _loc50_ += 4;
                                                                                    }
                                                                                 }
                                                                              }
                                                                              si32(_loc20_ = (_loc20_ = _loc50_ - _loc46_) >> 2,_loc36_ + 16);
                                                                              if(_loc20_ == 0)
                                                                              {
                                                                                 si32(0,_loc46_);
                                                                              }
                                                                           }
                                                                        }
                                                                        §§goto(addr3895);
                                                                     }
                                                                     §§goto(addr3919);
                                                                  }
                                                                  §§goto(addr10510);
                                                               }
                                                               break loop1;
                                                            }
                                                            _loc7_ = _loc37_;
                                                         }
                                                         §§goto(addr2109);
                                                      }
                                                      else
                                                      {
                                                         if((_loc20_ = _loc46_ & 7) != 0)
                                                         {
                                                            _loc37_ = 0;
                                                            if((_loc46_ & 1) == 0)
                                                            {
                                                               _loc37_ = 1;
                                                               if((_loc46_ & 2) == 0)
                                                               {
                                                                  _loc37_ = 2;
                                                               }
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc37_ = (_loc50_ = _loc46_ | 1048576) >>> 16;
                                                            if((_loc34_ = _loc46_ & 65535) != 0)
                                                            {
                                                               _loc37_ = _loc50_;
                                                            }
                                                            _loc46_ = _loc37_ >>> 8;
                                                            if((_loc7_ = _loc37_ & 255) != 0)
                                                            {
                                                               _loc46_ = _loc37_;
                                                            }
                                                            _loc33_ = _loc46_ >>> 4;
                                                            if((_loc50_ = _loc46_ & 15) != 0)
                                                            {
                                                               _loc33_ = _loc46_;
                                                            }
                                                            _loc46_ = _loc33_ >>> 2;
                                                            if((_loc37_ = _loc33_ & 3) != 0)
                                                            {
                                                               _loc46_ = _loc33_;
                                                            }
                                                            _loc33_ = 16;
                                                            if(_loc34_ != 0)
                                                            {
                                                               _loc33_ = 0;
                                                            }
                                                            _loc34_ = _loc33_ | 8;
                                                            if(_loc7_ != 0)
                                                            {
                                                               _loc34_ = _loc33_;
                                                            }
                                                            _loc7_ = _loc34_ | 4;
                                                            if(_loc50_ != 0)
                                                            {
                                                               _loc7_ = _loc34_;
                                                            }
                                                            _loc50_ = _loc7_ | 2;
                                                            if(_loc37_ != 0)
                                                            {
                                                               _loc50_ = _loc7_;
                                                            }
                                                            if((_loc20_ = _loc46_ & 1) == 0)
                                                            {
                                                               _loc50_ += 1;
                                                               _loc37_ = 32;
                                                               if(uint(_loc46_) >= 2)
                                                               {
                                                               }
                                                               addr2269:
                                                               _loc46_ = 21 - _loc37_;
                                                               §§goto(addr2275);
                                                            }
                                                            _loc37_ = _loc50_;
                                                         }
                                                         §§goto(addr2269);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc7_ = _loc48_;
                                                      if(37 - _loc47_ >= _loc48_)
                                                      {
                                                         _loc20_ = 15 - _loc47_;
                                                         _loc1_ -= 32;
                                                         si32(_loc23_ = _loc2_ - 20,_loc1_ + 28);
                                                         si32(_loc10_,_loc1_ + 24);
                                                         si32(_loc7_ = 0,_loc1_ + 20);
                                                         si32(_loc18_,_loc1_ + 16);
                                                         si32(_loc16_,_loc1_ + 12);
                                                         si32(_loc14_,_loc1_ + 8);
                                                         sf64(_loc41_ = _loc40_ * lf64(_loc23_ = ___tens_D2A + (_loc20_ << 3)) * lf64(_loc20_ = ___tens_D2A + ((_loc20_ = _loc48_ - _loc20_) << 3)),_loc1_);
                                                         ESP = _loc1_;
                                                         F_rvOK();
                                                         _loc1_ += 32;
                                                         if((_loc20_ = eax) == 0)
                                                         {
                                                            sf64(_loc41_,_loc2_ - 64);
                                                            _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 64) | 4);
                                                            _loc50_ = li32(_loc2_ - 64);
                                                         }
                                                         break loop1;
                                                      }
                                                   }
                                                }
                                                else
                                                {
                                                   _loc7_ = _loc48_;
                                                   if(_loc48_ >= -22)
                                                   {
                                                      _loc1_ -= 32;
                                                      si32(_loc20_ = _loc2_ - 20,_loc1_ + 28);
                                                      si32(_loc10_,_loc1_ + 24);
                                                      si32(_loc7_ = 0,_loc1_ + 20);
                                                      si32(_loc18_,_loc1_ + 16);
                                                      si32(_loc16_,_loc1_ + 12);
                                                      si32(_loc14_,_loc1_ + 8);
                                                      sf64(_loc41_ = _loc40_ / lf64(_loc20_ = ___tens_D2A - (_loc48_ << 3)),_loc1_);
                                                      ESP = _loc1_;
                                                      F_rvOK();
                                                      _loc1_ += 32;
                                                      if((_loc20_ = eax) == 0)
                                                      {
                                                         sf64(_loc41_,_loc2_ - 56);
                                                         _loc46_ = li32(_loc20_ = (_loc20_ = _loc2_ - 56) | 4);
                                                         _loc50_ = li32(_loc2_ - 56);
                                                      }
                                                      break loop1;
                                                   }
                                                }
                                             }
                                          }
                                          §§goto(addr2636);
                                          §§goto(addr10540);
                                       }
                                    }
                                    else
                                    {
                                       si32(_loc50_,_loc2_ - 32);
                                       _loc53_ = 0;
                                       _loc7_ = _loc50_;
                                       _loc10_ = _loc50_;
                                    }
                                    §§goto(addr1367);
                                 }
                                 §§goto(addr1134);
                              }
                              §§goto(addr1367);
                           }
                           break loop1;
                        }
                     }
                     §§goto(addr554);
                  }
                  si32(_loc20_ = _loc54_ + 1,_loc2_ - 32);
                  _loc47_ = li8(_loc54_ + 1);
                  _loc54_ = _loc20_;
                  if(_loc47_ == 0)
                  {
                     §§goto(addr407);
                  }
               }
               §§goto(addr428);
            }
            if(_loc12_ != 0)
            {
               si32(_loc20_ = li32(_loc2_ - 32),_loc12_);
            }
         }
         continue;
         if(_loc6_ != 0)
         {
            si32(_loc20_ = (_loc20_ = li32(_loc2_ - 20)) | 8,_loc2_ - 20);
         }
         if((_loc12_ = li32(_loc2_ - 36)) != 0)
         {
            _loc6_ = li32(_loc12_ + 16);
            _loc14_ = _loc18_;
            if(_loc6_ >= 1)
            {
               _loc6_ = (_loc20_ = _loc12_ + (_loc6_ << 2)) + 20;
               _loc16_ = _loc12_ + 20;
               _loc14_ = _loc18_;
               do
               {
                  si32(_loc20_ = li32(_loc16_),_loc14_);
                  _loc16_ += 4;
                  _loc14_ += 4;
               }
               while(uint(_loc16_) < uint(_loc6_));
               
            }
            _loc18_ = (_loc20_ = (_loc20_ = (_loc20_ = (_loc20_ = _loc52_ + -1) >> 5) << 2) + _loc18_) + 4;
            if(uint(_loc14_) < uint(_loc18_))
            {
               do
               {
                  si32(0,_loc14_);
               }
               while((uint(_loc14_ += 4)) < uint(_loc18_));
               
            }
            if((_loc18_ = li32(_loc12_ + 4)) >= 10)
            {
               _loc1_ -= 16;
               si32(_loc12_,_loc1_);
               ESP = _loc1_;
               F_idalloc();
               _loc1_ += 16;
            }
            else
            {
               if((_loc20_ = li32(___isthreaded)) != 0)
               {
                  _loc1_ -= 16;
                  si32(___gdtoa_locks,_loc1_);
                  ESP = _loc1_;
                  F__pthread_mutex_lock();
                  _loc1_ += 16;
                  _loc18_ = li32(_loc12_ + 4);
               }
               _loc20_ = _loc18_ << 2;
               si32(_loc20_ = li32(_loc23_ = _freelist + _loc20_),_loc12_);
               si32(_loc12_,_loc23_);
               if((_loc20_ = li32(___isthreaded)) != 0)
               {
                  _loc1_ -= 16;
                  si32(___gdtoa_locks,_loc1_);
                  ESP = _loc1_;
                  F__pthread_mutex_unlock();
                  _loc1_ += 16;
               }
            }
         }
         eax = _loc20_ = li32(_loc2_ - 20);
         _loc1_ = _loc2_;
         ESP = _loc1_;
         return;
      }
   }
}
