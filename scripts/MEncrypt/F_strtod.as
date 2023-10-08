package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str119;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str18;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str220;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._fpinan_2E_3414;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ret_2E_1158;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tinytens;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_strtod() : void
   {
      var _loc13_:int = 0;
      var _loc41_:* = 0;
      var _loc44_:* = 0;
      var _loc17_:* = 0;
      var _loc20_:Number = NaN;
      var _loc14_:* = 0;
      var _loc26_:* = 0;
      var _loc21_:* = NaN;
      var _loc10_:* = 0;
      var _loc23_:* = NaN;
      var _loc1_:* = NaN;
      var _loc2_:* = NaN;
      var _loc6_:Number = NaN;
      var _loc42_:* = 0;
      var _loc43_:* = 0;
      var _loc24_:Number = NaN;
      var _loc29_:* = 0;
      var _loc39_:* = 0;
      var _loc27_:* = 0;
      var _loc32_:* = 0;
      var _loc40_:* = 0;
      var _loc35_:* = 0;
      var _loc16_:* = 0;
      var _loc36_:* = 0;
      var _loc15_:* = 0;
      var _loc18_:* = 0;
      var _loc38_:* = 0;
      var _loc37_:* = 0;
      var _loc11_:* = 0;
      var _loc30_:* = 0;
      var _loc34_:* = 0;
      var _loc25_:* = 0;
      var _loc8_:* = 0;
      var _loc28_:* = 0;
      var _loc31_:* = 0;
      var _loc3_:Number = NaN;
      var _loc12_:* = 0;
      var _loc4_:* = NaN;
      var _loc33_:* = 0;
      var _loc5_:* = NaN;
      var _loc9_:*;
      ESP = _loc9_ = (_loc13_ = ESP) - 464;
      F_localeconv();
      _loc42_ = (_loc43_ = li32(_loc44_ = (_loc28_ = li32(_ret_2E_1158)) & -4)) + -16843009;
      _loc42_ = (_loc43_ = (_loc43_ &= -2139062144) ^ -2139062144) & _loc42_;
      _loc41_ = li32(_loc13_ + 4);
      _loc40_ = li32(_loc13_);
      if(_loc42_ != 0)
      {
         _loc39_ = _loc44_ + 4;
         _loc38_ = 0;
         while(true)
         {
            if((uint(_loc37_ = _loc28_ + _loc38_)) < uint(_loc39_))
            {
               continue;
            }
         }
         §§goto(addr286);
      }
      _loc44_ += 4;
      while(true)
      {
         _loc42_ = (_loc39_ = li32(_loc44_)) + -16843009;
         if((_loc42_ = (_loc43_ = (_loc43_ = _loc39_ & -2139062144) ^ -2139062144) & _loc42_) != 0)
         {
            if((_loc42_ = _loc39_ & 255) == 0)
            {
               _loc38_ = _loc44_ - _loc28_;
            }
            else if((_loc42_ = li8(_loc44_ + 1)) == 0)
            {
               _loc38_ = (_loc42_ = 1 - _loc28_) + _loc44_;
            }
            else if((_loc42_ = li8(_loc44_ + 2)) == 0)
            {
               _loc38_ = (_loc42_ = 2 - _loc28_) + _loc44_;
            }
            else
            {
               if((_loc42_ = li8(_loc44_ + 3)) != 0)
               {
                  continue;
               }
               _loc38_ = (_loc42_ = 3 - _loc28_) + _loc44_;
            }
            addr286:
            _loc25_ = _loc40_;
            loop1:
            while(true)
            {
               si32(_loc25_,_loc13_ - 28);
               _loc33_ = si8(li8(_loc25_));
               _loc34_ = 0;
               if(_loc33_ <= 31)
               {
                  if(_loc33_ != 0)
                  {
                     _loc44_ = _loc34_;
                     if(uint(_loc33_ + -9) < 5)
                     {
                        continue;
                     }
                     addr367:
                     _loc42_ = _loc33_ & 255;
                     _loc35_ = _loc34_;
                     if(_loc42_ == 48)
                     {
                        if((_loc42_ = (_loc42_ = si8(li8(_loc25_ + 1))) | 32) != 120)
                        {
                           _loc25_ += 1;
                           loop4:
                           while(true)
                           {
                              si32(_loc25_,_loc13_ - 28);
                              _loc33_ = li8(_loc25_);
                              _loc29_ = _loc36_ = 0;
                              if(_loc33_ != 0)
                              {
                                 _loc35_ = 1;
                                 if(_loc33_ == 48)
                                 {
                                    continue;
                                 }
                                 addr854:
                                 _loc31_ = (_loc42_ = _loc33_ << 24) >> 24;
                                 _loc42_ = (_loc42_ = _loc33_ + -48) & 255;
                                 _loc32_ = _loc25_;
                                 _loc30_ = _loc34_;
                                 _loc37_ = _loc34_;
                                 _loc39_ = _loc34_;
                                 if(uint(_loc42_) <= 9)
                                 {
                                    _loc32_ = _loc25_ + 1;
                                    _loc37_ = _loc30_ = 0;
                                    _loc39_ = _loc30_;
                                    do
                                    {
                                       _loc27_ = _loc30_;
                                       _loc33_ = _loc32_ + _loc27_;
                                       _loc29_ = _loc25_ + _loc27_;
                                       _loc30_ = _loc27_ + 1;
                                       if(_loc27_ <= 8)
                                       {
                                          _loc37_ = (_loc42_ = _loc31_ + _loc37_ * 10) + -48;
                                       }
                                       else if(_loc27_ <= 15)
                                       {
                                          _loc39_ = (_loc42_ = _loc31_ + _loc39_ * 10) + -48;
                                       }
                                       si32(_loc33_,_loc13_ - 28);
                                    }
                                    while((uint(_loc42_ = (_loc42_ = (_loc31_ = si8(li8(_loc29_ + 1))) + -48) & 255)) < 10);
                                    
                                    _loc32_ = _loc25_ + _loc30_;
                                    _loc33_ = _loc31_;
                                 }
                                 _loc42_ = _loc33_ & 255;
                                 _loc43_ = li8(_loc28_);
                                 _loc29_ = _loc34_;
                                 _loc27_ = _loc34_;
                                 _loc33_ = _loc30_;
                                 _loc26_ = _loc34_;
                                 if(_loc43_ == _loc42_)
                                 {
                                    _loc18_ = _loc32_ + 2;
                                    _loc16_ = 1;
                                    loop6:
                                    do
                                    {
                                       if((_loc17_ = li8(_loc42_ = _loc28_ + _loc16_)) != 0)
                                       {
                                          continue;
                                       }
                                       si32(_loc33_ = _loc32_ + _loc16_,_loc13_ - 28);
                                       _loc31_ = si8(li8(_loc18_ - 1));
                                       _loc29_ = 0;
                                       _loc14_ = _loc25_;
                                       _loc28_ = _loc29_;
                                       _loc36_ = _loc30_;
                                       if(_loc30_ == 0)
                                       {
                                          _loc29_ = _loc15_ = 0;
                                          _loc17_ = _loc33_;
                                          _loc28_ = _loc15_;
                                          if((_loc31_ & 255) == 48)
                                          {
                                             do
                                             {
                                                si32(_loc42_ = _loc18_ + _loc29_,_loc13_ - 28);
                                                _loc31_ = (_loc43_ = (_loc42_ = li8(_loc42_)) << 24) >> 24;
                                                _loc29_ += 1;
                                             }
                                             while(_loc42_ == 48);
                                             
                                             _loc17_ = (_loc42_ = _loc32_ + _loc16_) + _loc29_;
                                             _loc28_ = _loc29_;
                                          }
                                          _loc42_ = _loc31_ + -49;
                                          _loc26_ = 1;
                                          _loc14_ = _loc17_;
                                          _loc36_ = _loc30_;
                                          _loc32_ = _loc17_;
                                          _loc29_ = _loc28_;
                                          _loc27_ = _loc15_;
                                          _loc33_ = _loc30_;
                                          if(uint(_loc42_) <= 8)
                                          {
                                             loop8:
                                             while(true)
                                             {
                                                _loc25_ = _loc31_ + -48;
                                                _loc29_ = _loc15_ + 1;
                                                if(_loc25_ != 0)
                                                {
                                                   _loc33_ = 1;
                                                   if(_loc36_ >= 9)
                                                   {
                                                      _loc33_ = 0;
                                                   }
                                                   _loc28_ += _loc29_;
                                                   if(_loc15_ >= 1)
                                                   {
                                                      if((_loc31_ = _loc15_ + 1) <= 2)
                                                      {
                                                         _loc31_ = 2;
                                                      }
                                                      _loc27_ = _loc31_ + -1;
                                                      _loc32_ = _loc36_ + 1;
                                                      do
                                                      {
                                                         _loc31_ = _loc32_;
                                                         if((_loc42_ = _loc33_ & 1) != 0)
                                                         {
                                                            _loc37_ *= 10;
                                                         }
                                                         else if(_loc31_ <= 16)
                                                         {
                                                            _loc39_ *= 10;
                                                         }
                                                         _loc33_ = 1;
                                                         if(_loc31_ >= 9)
                                                         {
                                                            _loc33_ = 0;
                                                         }
                                                         _loc32_ = _loc31_ + 1;
                                                      }
                                                      while((_loc27_ += -1) != 0);
                                                      
                                                      if(_loc29_ <= 2)
                                                      {
                                                         _loc29_ = 2;
                                                      }
                                                      _loc33_ = _loc29_ + _loc36_;
                                                      if(_loc31_ < 9)
                                                      {
                                                         addr1286:
                                                         _loc37_ = (_loc42_ = _loc37_ * 10) + _loc25_;
                                                         _loc29_ = 0;
                                                         _loc36_ = _loc33_;
                                                         addr1325:
                                                         si32(_loc33_ = _loc17_ + 1,_loc13_ - 28);
                                                         _loc31_ = si8(li8(_loc17_ + 1));
                                                         while(true)
                                                         {
                                                            _loc42_ = _loc31_ + -48;
                                                            _loc26_ = 1;
                                                            _loc17_ = _loc33_;
                                                            _loc15_ = _loc29_;
                                                            _loc32_ = _loc33_;
                                                            _loc25_ = _loc14_;
                                                            _loc27_ = _loc28_;
                                                            _loc33_ = _loc36_;
                                                            if(uint(_loc42_) >= 10)
                                                            {
                                                               break loop6;
                                                            }
                                                            continue loop8;
                                                         }
                                                         addr1342:
                                                      }
                                                      §§goto(addr1325);
                                                   }
                                                   else
                                                   {
                                                      _loc33_ = _loc36_ + 1;
                                                      if(_loc36_ <= 8)
                                                      {
                                                      }
                                                      §§goto(addr1286);
                                                   }
                                                   if(_loc33_ <= 16)
                                                   {
                                                      _loc39_ = (_loc42_ = _loc39_ * 10) + _loc25_;
                                                      _loc29_ = 0;
                                                      _loc36_ = _loc33_;
                                                   }
                                                }
                                                §§goto(addr1286);
                                             }
                                          }
                                          break;
                                       }
                                       §§goto(addr1342);
                                    }
                                    while(_loc16_ += 1, _loc42_ = li8(_loc18_ - 1), _loc29_ = 0, _loc18_ += 1, _loc27_ = _loc29_, _loc33_ = _loc30_, _loc26_ = _loc29_, _loc42_ == _loc17_);
                                    
                                 }
                                 _loc42_ = _loc31_ | 32;
                                 _loc28_ = _loc32_;
                                 if(_loc42_ == 101)
                                 {
                                    if((_loc42_ = (_loc42_ = _loc29_ | _loc35_) | _loc33_) != 0)
                                    {
                                       si32(_loc28_ = _loc32_ + 1,_loc13_ - 28);
                                       _loc31_ = si8(li8(_loc32_ + 1));
                                       _loc17_ = 0;
                                       if(_loc31_ != 43)
                                       {
                                          if(_loc31_ == 45)
                                          {
                                             _loc17_ = 1;
                                             addr1417:
                                             si32(_loc28_ = _loc32_ + 2,_loc13_ - 28);
                                             _loc31_ = si8(li8(_loc32_ + 2));
                                          }
                                          if((uint(_loc42_ = _loc31_ + -48)) <= 9)
                                          {
                                             if(_loc31_ == 48)
                                             {
                                                do
                                                {
                                                   si32(_loc40_ = _loc28_ + 1,_loc13_ - 28);
                                                   _loc31_ = (_loc43_ = (_loc42_ = li8(_loc28_ + 1)) << 24) >> 24;
                                                   _loc28_ = _loc40_;
                                                }
                                                while(_loc42_ == 48);
                                                
                                                _loc28_ = _loc40_;
                                             }
                                             _loc42_ = _loc31_ + -49;
                                             _loc34_ = 0;
                                             _loc40_ = _loc32_;
                                             if(uint(_loc42_) <= 8)
                                             {
                                                si32(_loc40_ = _loc28_ + 1,_loc13_ - 28);
                                                _loc14_ = _loc31_ + -48;
                                                if((uint(_loc42_ = (_loc42_ = (_loc31_ = si8(li8(_loc28_ + 1))) + -48) & 255)) <= 9)
                                                {
                                                   _loc34_ = _loc28_ + 2;
                                                   _loc40_ = _loc28_ + 1;
                                                   do
                                                   {
                                                      _loc42_ = _loc14_ * 10;
                                                      _loc14_ = (_loc42_ = _loc31_ + _loc42_) + -48;
                                                      _loc40_ += 1;
                                                      si32(_loc34_,_loc13_ - 28);
                                                      _loc42_ = _loc34_ + 1;
                                                      _loc43_ = (_loc43_ = (_loc31_ = si8(li8(_loc34_))) + -48) & 255;
                                                      _loc34_ = _loc42_;
                                                   }
                                                   while(uint(_loc43_) < 10);
                                                   
                                                }
                                                _loc36_ = 1;
                                                _loc34_ = 19999;
                                                _loc16_ = _loc36_;
                                                if(_loc14_ <= _loc34_)
                                                {
                                                   _loc16_ = 0;
                                                }
                                                if((_loc42_ = _loc40_ - _loc28_) <= 8)
                                                {
                                                   _loc36_ = 0;
                                                }
                                                if((_loc42_ = _loc36_ | _loc16_) == 0)
                                                {
                                                   _loc34_ = _loc14_;
                                                }
                                                if(_loc17_ != 0)
                                                {
                                                   _loc34_ = 0 - _loc34_;
                                                }
                                                _loc28_ = _loc40_;
                                                _loc40_ = _loc32_;
                                                addr1650:
                                                if(_loc33_ == 0)
                                                {
                                                   _loc29_ = _loc36_ = 0;
                                                   if((_loc29_ | _loc35_) == 0)
                                                   {
                                                      if(_loc26_ == 0)
                                                      {
                                                         _loc39_ = 2;
                                                         if(_loc31_ <= 104)
                                                         {
                                                            if(_loc31_ != 73)
                                                            {
                                                               if(_loc31_ != 78)
                                                               {
                                                                  break loop1;
                                                               }
                                                               addr1691:
                                                               _loc39_ = 0;
                                                               while(true)
                                                               {
                                                                  if(_loc39_ == -2)
                                                                  {
                                                                     si32(_loc43_ = (_loc42_ = _loc28_ - _loc39_) + 1,_loc13_ - 28);
                                                                     _loc29_ = 2146959360;
                                                                     _loc36_ = 0;
                                                                     if(li8(_loc42_ + 1) == 40)
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(_loc42_ = _loc13_ - 72,_loc9_ + 8);
                                                                        si32(_fpinan_2E_3414,_loc9_ + 4);
                                                                        si32(_loc42_ = _loc13_ - 28,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___hexnan_D2A();
                                                                        _loc9_ += 16;
                                                                        _loc29_ = (_loc42_ = li32(_loc13_ - 68)) | 2146959360;
                                                                        _loc36_ = li32(_loc13_ - 72);
                                                                        break loop4;
                                                                     }
                                                                     break loop4;
                                                                  }
                                                                  _loc38_ = (_loc37_ = si8(li8((_loc42_ = _loc28_ - _loc39_) + 1))) + 32;
                                                                  if((uint(_loc42_ = (_loc42_ = _loc37_ + -65) & 255)) >= 26)
                                                                  {
                                                                     _loc38_ = _loc37_;
                                                                  }
                                                                  _loc42_ = si8(li8(_loc42_ = L__2E_str220 - _loc39_));
                                                                  _loc39_ += -1;
                                                                  if(_loc38_ != _loc42_)
                                                                  {
                                                                     break loop1;
                                                                  }
                                                               }
                                                            }
                                                         }
                                                         else if(_loc31_ != 105)
                                                         {
                                                            if(_loc31_ == 110)
                                                            {
                                                               §§goto(addr1691);
                                                            }
                                                            break loop1;
                                                         }
                                                         while(true)
                                                         {
                                                            if(_loc39_ != 0)
                                                            {
                                                               continue;
                                                            }
                                                            si32(_loc42_ = (_loc40_ = _loc28_ - _loc39_) + 2,_loc13_ - 28);
                                                            _loc38_ = 0;
                                                            while(true)
                                                            {
                                                               _loc37_ = _loc38_ + _loc28_;
                                                               if(_loc38_ == 5)
                                                               {
                                                                  si32(_loc42_ = (_loc42_ = _loc37_ - _loc39_) + 3,_loc13_ - 28);
                                                                  _loc29_ = 2146435072;
                                                                  _loc36_ = 0;
                                                                  break loop4;
                                                               }
                                                               _loc30_ = (_loc37_ = si8(li8((_loc42_ = _loc37_ - _loc39_) + 3))) + 32;
                                                               if((uint(_loc42_ = (_loc42_ = _loc37_ + -65) & 255)) >= 26)
                                                               {
                                                                  _loc30_ = _loc37_;
                                                               }
                                                               _loc42_ = si8(li8(_loc42_ = L__2E_str119 + _loc38_));
                                                               _loc38_ += 1;
                                                               if(_loc30_ != _loc42_)
                                                               {
                                                                  si32(_loc42_ = _loc40_ + 3,_loc13_ - 28);
                                                                  _loc29_ = 2146435072;
                                                                  _loc36_ = 0;
                                                                  break loop4;
                                                               }
                                                            }
                                                         }
                                                      }
                                                      break loop1;
                                                   }
                                                   break;
                                                }
                                                sf64(_loc20_ = uint(_loc37_),_loc13_ - 80);
                                                _loc35_ = _loc33_;
                                                if(_loc30_ != 0)
                                                {
                                                   _loc35_ = _loc30_;
                                                }
                                                _loc32_ = 16;
                                                if(_loc33_ <= _loc32_)
                                                {
                                                   _loc32_ = _loc33_;
                                                }
                                                _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 80) | 4);
                                                _loc40_ = _loc36_ = li32(_loc13_ - 80);
                                                _loc28_ = _loc29_;
                                                if(_loc32_ >= 10)
                                                {
                                                   var _loc19_:*;
                                                   sf64(_loc20_ = (_loc19_ = lf64((_loc42_ = (_loc42_ = _loc32_ << 3) + ___tens_D2A) - 72)) * _loc20_ + uint(_loc39_),_loc13_ - 88);
                                                   _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 88) | 4);
                                                   _loc40_ = _loc36_ = li32(_loc13_ - 88);
                                                   _loc28_ = _loc29_;
                                                }
                                                _loc30_ = _loc34_ - _loc27_;
                                                if(_loc33_ <= 15)
                                                {
                                                   if(_loc34_ != _loc27_)
                                                   {
                                                      if(_loc30_ >= 1)
                                                      {
                                                         if(_loc30_ <= 22)
                                                         {
                                                            if(_loc44_ != 0)
                                                            {
                                                               _loc20_ = -_loc20_;
                                                            }
                                                            _loc42_ = _loc30_ << 3;
                                                            _loc19_ = lf64(_loc42_ = ___tens_D2A + _loc42_);
                                                            sf64(_loc19_ = _loc20_ * _loc19_,_loc13_ - 456);
                                                            _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 456) | 4);
                                                            _loc44_ = 0;
                                                            _loc36_ = li32(_loc13_ - 456);
                                                            break;
                                                         }
                                                         if((_loc42_ = 37 - _loc33_) >= _loc30_)
                                                         {
                                                            if(_loc44_ != 0)
                                                            {
                                                               _loc20_ = -_loc20_;
                                                            }
                                                            _loc42_ = (_loc43_ = 15 - _loc33_) << 3;
                                                            _loc19_ = lf64(_loc42_ = ___tens_D2A + _loc42_);
                                                            _loc19_ = _loc20_ * _loc19_;
                                                            _loc43_ = (_loc43_ = _loc30_ - _loc43_) << 3;
                                                            var _loc22_:* = lf64(_loc43_ = ___tens_D2A + _loc43_);
                                                            sf64(_loc19_ *= _loc22_,_loc13_ - 104);
                                                            _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 104) | 4);
                                                            _loc44_ = 0;
                                                            _loc36_ = li32(_loc13_ - 104);
                                                            break;
                                                         }
                                                      }
                                                      else if(_loc30_ >= -22)
                                                      {
                                                         if(_loc44_ != 0)
                                                         {
                                                            _loc20_ = -_loc20_;
                                                         }
                                                         _loc42_ = _loc30_ << 3;
                                                         _loc19_ = lf64(_loc42_ = ___tens_D2A - _loc42_);
                                                         sf64(_loc19_ = _loc20_ / _loc19_,_loc13_ - 96);
                                                         _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 96) | 4);
                                                         _loc44_ = 0;
                                                         _loc36_ = li32(_loc13_ - 96);
                                                         break;
                                                      }
                                                   }
                                                   break;
                                                }
                                                _loc34_ = 1;
                                                if((_loc27_ = _loc30_ + (_loc33_ - _loc32_)) >= 1)
                                                {
                                                   if((_loc40_ = _loc27_ & 15) != 0)
                                                   {
                                                      sf64(_loc20_ *= lf64(_loc42_ = ___tens_D2A + (_loc40_ << 3)),_loc13_ - 136);
                                                      _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 136) | 4);
                                                      _loc36_ = li32(_loc13_ - 136);
                                                      _loc28_ = _loc29_;
                                                   }
                                                   _loc39_ = 0;
                                                   if(uint(_loc27_) >= 16)
                                                   {
                                                      _loc40_ = 0;
                                                      if((_loc27_ & -16) < 309)
                                                      {
                                                         _loc29_ = _loc27_ >> 4;
                                                         _loc39_ = _loc40_ = 0;
                                                         _loc27_ = _loc40_;
                                                         if(_loc29_ >= 2)
                                                         {
                                                            do
                                                            {
                                                               if((_loc42_ = _loc29_ & 1) != 0)
                                                               {
                                                                  _loc20_ *= lf64(_loc42_ = ___bigtens_D2A + (_loc39_ << 3));
                                                               }
                                                               _loc39_ += 1;
                                                            }
                                                            while((_loc29_ >>= 1) > 1);
                                                            
                                                            sf64(_loc20_,_loc13_ - 144);
                                                            _loc28_ = li32(_loc42_ = (_loc42_ = _loc13_ - 144) | 4);
                                                            _loc36_ = li32(_loc13_ - 144);
                                                            _loc27_ = _loc39_;
                                                         }
                                                         _loc42_ = _loc28_ + -55574528;
                                                         _loc43_ = (_loc43_ = _loc13_ - 152) | 4;
                                                         si32(_loc42_,_loc43_);
                                                         si32(_loc36_,_loc13_ - 152);
                                                         _loc42_ = _loc27_ << 3;
                                                         _loc19_ = lf64(_loc42_ = ___bigtens_D2A + _loc42_);
                                                         sf64(_loc19_ = (_loc22_ = lf64(_loc13_ - 152)) * _loc19_,_loc13_ - 160);
                                                         if((uint(_loc27_ = (_loc31_ = li32(_loc42_ = (_loc42_ = _loc13_ - 160) | 4)) & 2146435072)) <= 2090860544)
                                                         {
                                                            _loc29_ = 2146435071;
                                                            _loc36_ = -1;
                                                            _loc39_ = 0;
                                                            if(uint(_loc27_) <= 2089811968)
                                                            {
                                                               _loc36_ = li32(_loc13_ - 160);
                                                               _loc29_ = _loc31_ + 55574528;
                                                               _loc39_ = 0;
                                                               addr2914:
                                                               _loc9_ -= 32;
                                                               si32(_loc38_,_loc9_ + 16);
                                                               si32(_loc37_,_loc9_ + 12);
                                                               si32(_loc33_,_loc9_ + 8);
                                                               si32(_loc35_,_loc9_ + 4);
                                                               si32(_loc25_,_loc9_);
                                                               _loc31_ = -1;
                                                               _loc32_ = 0;
                                                               if(_loc30_ <= _loc31_)
                                                               {
                                                                  _loc32_ = 0 - _loc30_;
                                                               }
                                                               if(_loc30_ <= _loc31_)
                                                               {
                                                                  _loc30_ = 0;
                                                               }
                                                               _loc40_ = 1;
                                                               if(_loc34_ == 1)
                                                               {
                                                                  _loc40_ = 0;
                                                               }
                                                               _loc28_ = _loc39_ + _loc30_;
                                                               _loc26_ = _loc40_ & 1;
                                                               ESP = _loc9_;
                                                               F___s2b_D2A();
                                                               _loc17_ = _loc34_ >> 1;
                                                               _loc9_ += 32;
                                                               _loc14_ = (_loc40_ = eax) + 12;
                                                               _loc27_ = _loc36_;
                                                               _loc25_ = _loc29_;
                                                               loop15:
                                                               while(true)
                                                               {
                                                                  _loc42_ = (_loc42_ = _loc13_ - 168) | 4;
                                                                  si32(_loc25_,_loc42_);
                                                                  si32(_loc27_,_loc13_ - 168);
                                                                  _loc42_ = li32(_loc40_ + 4);
                                                                  _loc9_ -= 16;
                                                                  si32(_loc42_,_loc9_);
                                                                  ESP = _loc9_;
                                                                  F___Balloc_D2A();
                                                                  _loc9_ += 16;
                                                                  _loc37_ = eax;
                                                                  _loc42_ = li32(_loc40_ + 16);
                                                                  _loc9_ -= 16;
                                                                  si32(_loc42_ = (_loc42_ <<= 2) + 8,_loc9_ + 8);
                                                                  si32(_loc14_,_loc9_ + 4);
                                                                  si32(_loc42_ = _loc37_ + 12,_loc9_);
                                                                  ESP = _loc9_;
                                                                  Fmemcpy();
                                                                  _loc9_ = (_loc9_ += 16) - 16;
                                                                  si32(_loc25_,_loc9_ + 4);
                                                                  si32(_loc27_,_loc9_);
                                                                  si32(_loc42_ = _loc13_ - 24,_loc9_ + 12);
                                                                  si32(_loc42_ = _loc13_ - 20,_loc9_ + 8);
                                                                  ESP = _loc9_;
                                                                  F___d2b_D2A();
                                                                  _loc9_ += 16;
                                                                  si32(_loc42_ = eax,_loc13_ - 32);
                                                                  _loc21_ = lf64(_loc13_ - 168);
                                                                  if((_loc42_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(___gdtoa_locks,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F__pthread_mutex_lock();
                                                                     _loc9_ += 16;
                                                                  }
                                                                  if((_loc38_ = li32(_freelist + 4)) != 0)
                                                                  {
                                                                     si32(_loc42_ = li32(_loc38_),_freelist + 4);
                                                                  }
                                                                  else
                                                                  {
                                                                     if((uint(_loc42_ = (_loc42_ = (_loc42_ = (_loc38_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                                                                     {
                                                                        si32(_loc42_ = _loc38_ + 32,_pmem_next);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(32,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F_malloc();
                                                                        _loc9_ += 16;
                                                                        _loc38_ = eax;
                                                                     }
                                                                     si32(1,_loc38_ + 4);
                                                                     si32(2,_loc38_ + 8);
                                                                  }
                                                                  if((_loc42_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(___gdtoa_locks,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F__pthread_mutex_unlock();
                                                                     _loc9_ += 16;
                                                                  }
                                                                  si32(0,_loc38_ + 12);
                                                                  si32(1,_loc38_ + 20);
                                                                  si32(1,_loc38_ + 16);
                                                                  _loc35_ = (_loc42_ = (_loc33_ = li32(_loc13_ - 20)) - _loc39_) + 1075;
                                                                  _loc36_ = li32(_loc13_ - 24);
                                                                  if((_loc42_ = (_loc42_ += _loc36_) + -1) >= -1022)
                                                                  {
                                                                     _loc35_ = 54 - _loc36_;
                                                                  }
                                                                  _loc16_ = _loc33_;
                                                                  if(_loc33_ <= _loc31_)
                                                                  {
                                                                     _loc16_ = 0;
                                                                  }
                                                                  _loc36_ = 0;
                                                                  if(_loc33_ <= _loc31_)
                                                                  {
                                                                     _loc36_ = 0 - _loc33_;
                                                                  }
                                                                  _loc18_ = _loc16_ + _loc32_;
                                                                  _loc33_ = _loc35_ + _loc18_;
                                                                  _loc15_ = _loc16_ = (_loc42_ = _loc28_ + _loc36_) + _loc35_;
                                                                  if(_loc16_ > _loc33_)
                                                                  {
                                                                     _loc15_ = _loc33_;
                                                                  }
                                                                  _loc35_ = _loc36_ = _loc18_ + _loc26_;
                                                                  if(_loc15_ <= _loc36_)
                                                                  {
                                                                     _loc35_ = _loc15_;
                                                                  }
                                                                  if(_loc35_ <= 0)
                                                                  {
                                                                     _loc35_ = 0;
                                                                  }
                                                                  if(_loc32_ >= 1)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc32_,_loc9_ + 4);
                                                                     si32(_loc38_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___pow5mult_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc38_ = eax;
                                                                     _loc15_ = li32(_loc13_ - 32);
                                                                     _loc9_ -= 16;
                                                                     si32(_loc15_,_loc9_ + 4);
                                                                     si32(_loc38_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___mult_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc11_ = eax;
                                                                     if(_loc15_ != 0)
                                                                     {
                                                                        if((_loc18_ = li32(_loc15_ + 4)) >= 10)
                                                                        {
                                                                           _loc9_ -= 16;
                                                                           si32(_loc15_,_loc9_);
                                                                           ESP = _loc9_;
                                                                           F_idalloc();
                                                                           _loc9_ += 16;
                                                                        }
                                                                        else
                                                                        {
                                                                           if((_loc42_ = li32(___isthreaded)) != 0)
                                                                           {
                                                                              _loc9_ -= 16;
                                                                              si32(___gdtoa_locks,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F__pthread_mutex_lock();
                                                                              _loc9_ += 16;
                                                                              _loc18_ = li32(_loc15_ + 4);
                                                                           }
                                                                           _loc42_ = _loc18_ << 2;
                                                                           si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc15_);
                                                                           si32(_loc15_,_loc42_);
                                                                           if((_loc42_ = li32(___isthreaded)) != 0)
                                                                           {
                                                                              _loc9_ -= 16;
                                                                              si32(___gdtoa_locks,_loc9_);
                                                                              ESP = _loc9_;
                                                                              F__pthread_mutex_unlock();
                                                                              _loc9_ += 16;
                                                                           }
                                                                        }
                                                                     }
                                                                     si32(_loc11_,_loc13_ - 32);
                                                                  }
                                                                  if((_loc33_ -= _loc35_) >= 1)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc33_,_loc9_ + 4);
                                                                     si32(li32(_loc13_ - 32),_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___lshift_D2A();
                                                                     _loc9_ += 16;
                                                                     si32(_loc42_ = eax,_loc13_ - 32);
                                                                  }
                                                                  if(_loc30_ >= 1)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc30_,_loc9_ + 4);
                                                                     si32(_loc37_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___pow5mult_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc37_ = eax;
                                                                  }
                                                                  if((_loc33_ = _loc16_ - _loc35_) >= 1)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc33_,_loc9_ + 4);
                                                                     si32(_loc37_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___lshift_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc37_ = eax;
                                                                  }
                                                                  if((_loc33_ = _loc36_ - _loc35_) >= 1)
                                                                  {
                                                                     _loc9_ -= 16;
                                                                     si32(_loc33_,_loc9_ + 4);
                                                                     si32(_loc38_,_loc9_);
                                                                     ESP = _loc9_;
                                                                     F___lshift_D2A();
                                                                     _loc9_ += 16;
                                                                     _loc38_ = eax;
                                                                  }
                                                                  _loc35_ = li32(_loc13_ - 32);
                                                                  _loc9_ -= 16;
                                                                  si32(_loc37_,_loc9_ + 4);
                                                                  si32(_loc35_,_loc9_);
                                                                  ESP = _loc9_;
                                                                  F___diff_D2A();
                                                                  _loc9_ += 16;
                                                                  _loc16_ = li32((_loc33_ = eax) + 12);
                                                                  si32(0,_loc33_ + 12);
                                                                  _loc36_ = li32(_loc38_ + 16);
                                                                  if((_loc15_ = li32(_loc33_ + 16)) != _loc36_)
                                                                  {
                                                                     _loc11_ = _loc15_ - _loc36_;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc42_ = _loc36_ << 2;
                                                                     _loc36_ = (_loc12_ = _loc33_ + 20) + _loc42_;
                                                                     _loc18_ = (_loc42_ = _loc38_ + _loc42_) + 16;
                                                                     do
                                                                     {
                                                                        _loc8_ = li32(_loc18_);
                                                                        if((_loc10_ = li32(_loc36_ - 4)) != _loc8_)
                                                                        {
                                                                           _loc11_ = -1;
                                                                           if(uint(_loc10_) >= uint(_loc8_))
                                                                           {
                                                                              _loc11_ = 1;
                                                                           }
                                                                           break;
                                                                        }
                                                                        _loc36_ += -4;
                                                                        _loc18_ += -4;
                                                                        _loc11_ = 0;
                                                                     }
                                                                     while(uint(_loc36_) > uint(_loc12_));
                                                                     
                                                                  }
                                                                  if(_loc34_ != 1)
                                                                  {
                                                                     if(_loc11_ <= -1)
                                                                     {
                                                                        if((_loc42_ = li32(_loc33_ + 20)) == 0)
                                                                        {
                                                                           _loc36_ = _loc27_;
                                                                           if(_loc15_ >= 2)
                                                                           {
                                                                              addr3906:
                                                                              if(_loc34_ != 0)
                                                                              {
                                                                                 _loc34_ = 1072693248;
                                                                                 _loc30_ = 0;
                                                                                 _loc36_ = _loc27_;
                                                                                 if(_loc16_ != 0)
                                                                                 {
                                                                                 }
                                                                                 break;
                                                                              }
                                                                              _loc36_ = _loc27_;
                                                                              if(_loc16_ == 0)
                                                                              {
                                                                                 _loc34_ = -1074790400;
                                                                                 _loc30_ = 0;
                                                                                 if(_loc27_ == 0)
                                                                                 {
                                                                                    _loc34_ = -1074790400;
                                                                                    _loc30_ = 0;
                                                                                    if((_loc25_ & 1048575) == 0)
                                                                                    {
                                                                                       if(_loc39_ != 0)
                                                                                       {
                                                                                          _loc34_ = -1074790400;
                                                                                          _loc30_ = 0;
                                                                                          _loc27_ = _loc25_;
                                                                                          if((uint(_loc25_ & 2146435072)) >= 111149057)
                                                                                          {
                                                                                             addr3962:
                                                                                             _loc9_ -= 16;
                                                                                             si32(1,_loc9_ + 4);
                                                                                             si32(_loc33_,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F___lshift_D2A();
                                                                                             _loc9_ += 16;
                                                                                             _loc33_ = eax;
                                                                                             _loc34_ = li32(_loc38_ + 16);
                                                                                             if((_loc30_ = li32(_loc33_ + 16)) != _loc34_)
                                                                                             {
                                                                                                _loc31_ = _loc30_ - _loc34_;
                                                                                                addr4079:
                                                                                                _loc34_ = -1074790400;
                                                                                                _loc30_ = 0;
                                                                                                if(_loc31_ <= 0)
                                                                                                {
                                                                                                }
                                                                                                addr4092:
                                                                                                if(_loc39_ != 0)
                                                                                                {
                                                                                                   _loc27_ = _loc25_;
                                                                                                   addr4099:
                                                                                                   if((uint(_loc31_ = _loc27_ & 2146435072)) <= 111149056)
                                                                                                   {
                                                                                                      _loc34_ = (_loc42_ = 112197632 - _loc31_) + _loc34_;
                                                                                                      _loc30_ = 0;
                                                                                                   }
                                                                                                }
                                                                                                if((_loc25_ = (_loc31_ = _loc25_ & 2146435072) + -54525952) >= 1)
                                                                                                {
                                                                                                   _loc27_ = 0;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc31_ = (_loc42_ = 54525952 - _loc31_) >> 20;
                                                                                                   if(_loc42_ <= 20971519)
                                                                                                   {
                                                                                                      _loc25_ = 524288 >>> _loc31_;
                                                                                                      _loc27_ = 0;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc25_ = 0;
                                                                                                      _loc27_ = 1;
                                                                                                      if(_loc31_ + -20 <= 30)
                                                                                                      {
                                                                                                         _loc27_ = 1 << 51 - _loc31_;
                                                                                                         _loc25_ = 0;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                _loc42_ = (_loc42_ = _loc13_ - 272) | 4;
                                                                                                si32(_loc34_,_loc42_);
                                                                                                _loc42_ = (_loc42_ = _loc13_ - 264) | 4;
                                                                                                si32(_loc25_,_loc42_);
                                                                                                si32(_loc30_,_loc13_ - 272);
                                                                                                si32(_loc27_,_loc13_ - 264);
                                                                                                _loc19_ = lf64(_loc13_ - 272);
                                                                                                _loc19_ = (_loc22_ = lf64(_loc13_ - 264)) * _loc19_;
                                                                                                sf64(_loc19_ = _loc21_ + _loc19_,_loc13_ - 280);
                                                                                                _loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 280) | 4);
                                                                                                _loc36_ = li32(_loc13_ - 280);
                                                                                                break;
                                                                                             }
                                                                                             _loc30_ = (_loc42_ = (_loc43_ = _loc34_ << 2) + _loc33_) + 20;
                                                                                             _loc32_ = (_loc42_ = _loc43_ + _loc38_) + 16;
                                                                                             _loc34_ = _loc33_ + 20;
                                                                                             while(true)
                                                                                             {
                                                                                                _loc28_ = li32(_loc32_);
                                                                                                if((_loc27_ = li32(_loc30_ - 4)) == _loc28_)
                                                                                                {
                                                                                                   _loc30_ += -4;
                                                                                                   _loc32_ += -4;
                                                                                                   if(uint(_loc30_) <= uint(_loc34_))
                                                                                                   {
                                                                                                      break;
                                                                                                   }
                                                                                                   continue;
                                                                                                }
                                                                                                if(uint(_loc27_) >= uint(_loc28_))
                                                                                                {
                                                                                                   _loc31_ = 1;
                                                                                                }
                                                                                                §§goto(addr4079);
                                                                                             }
                                                                                             _loc34_ = -1075838976;
                                                                                             _loc30_ = 0;
                                                                                             §§goto(addr4092);
                                                                                          }
                                                                                          §§goto(addr4099);
                                                                                       }
                                                                                       §§goto(addr3962);
                                                                                    }
                                                                                 }
                                                                              }
                                                                              break;
                                                                              §§goto(addr4079);
                                                                           }
                                                                           break;
                                                                        }
                                                                        §§goto(addr3906);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(_loc42_ = _loc13_ - 12,_loc9_ + 4);
                                                                        si32(_loc33_,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___b2d_D2A();
                                                                        _loc9_ += 16;
                                                                        sf64(_loc19_ = st0,_loc13_ - 176);
                                                                        _loc9_ -= 16;
                                                                        si32(_loc42_ = _loc13_ - 16,_loc9_ + 4);
                                                                        si32(_loc38_,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___b2d_D2A();
                                                                        _loc9_ += 16;
                                                                        sf64(_loc19_ = st0,_loc13_ - 184);
                                                                        var _loc7_:*;
                                                                        _loc36_ = (_loc43_ = (_loc43_ = (_loc7_ = li32(_loc33_ + 16)) - li32(_loc38_ + 16)) << 5) + ((_loc42_ = li32(_loc13_ - 12)) - li32(_loc13_ - 16));
                                                                        _loc15_ = li32(_loc42_ = (_loc42_ = _loc13_ - 176) | 4);
                                                                        _loc11_ = li32(_loc42_ = (_loc42_ = _loc13_ - 184) | 4);
                                                                        _loc18_ = li32(_loc13_ - 176);
                                                                        _loc8_ = li32(_loc13_ - 184);
                                                                        if(_loc36_ >= 1)
                                                                        {
                                                                           _loc15_ = (_loc42_ = _loc36_ << 20) + _loc15_;
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc11_ -= _loc36_ << 20;
                                                                        }
                                                                        _loc42_ = (_loc42_ = _loc13_ - 200) | 4;
                                                                        si32(_loc11_,_loc42_);
                                                                        _loc42_ = (_loc42_ = _loc13_ - 192) | 4;
                                                                        si32(_loc15_,_loc42_);
                                                                        si32(_loc8_,_loc13_ - 200);
                                                                        si32(_loc18_,_loc13_ - 192);
                                                                        _loc22_ = lf64(_loc13_ - 200);
                                                                        sf64(_loc24_ = (_loc19_ = lf64(_loc13_ - 192)) / _loc22_,_loc13_ - 208);
                                                                        _loc15_ = 1072693248;
                                                                        if(_loc24_ >= 1)
                                                                        {
                                                                           _loc15_ = li32(_loc42_ = (_loc42_ = _loc13_ - 208) | 4);
                                                                        }
                                                                        _loc42_ = (_loc42_ = _loc13_ - 216) | 4;
                                                                        si32(_loc15_,_loc42_);
                                                                        _loc36_ = 0;
                                                                        if(_loc24_ >= 1)
                                                                        {
                                                                           _loc36_ = li32(_loc13_ - 208);
                                                                        }
                                                                        si32(_loc36_,_loc13_ - 216);
                                                                        if(!((_loc23_ = lf64(_loc13_ - 216)) > 2147483646 | _loc23_ != _loc23_ | false))
                                                                        {
                                                                           if((_loc19_ = uint(_loc18_ = int(uint(_loc23_)))) != _loc23_)
                                                                           {
                                                                              _loc36_ = 1;
                                                                              if(_loc17_ != _loc16_)
                                                                              {
                                                                                 _loc36_ = 0;
                                                                              }
                                                                              _loc42_ = _loc36_ & 1;
                                                                              sf64(_loc19_ = uint(_loc42_ = _loc18_ + _loc42_),_loc13_ - 224);
                                                                              _loc15_ = li32(_loc42_ = (_loc42_ = _loc13_ - 224) | 4);
                                                                              _loc36_ = li32(_loc13_ - 224);
                                                                           }
                                                                        }
                                                                        _loc11_ = _loc25_ & 2146435072;
                                                                        if(_loc39_ != 0)
                                                                        {
                                                                           if(uint(_loc11_) <= 111149056)
                                                                           {
                                                                              _loc15_ = (_loc42_ = 112197632 - _loc11_) + _loc15_;
                                                                           }
                                                                        }
                                                                        if((_loc18_ = _loc11_ + -54525952) >= 1)
                                                                        {
                                                                           _loc11_ = 0;
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc8_ = (_loc42_ = 54525952 - _loc11_) >> 20;
                                                                           if(_loc42_ <= 20971519)
                                                                           {
                                                                              _loc18_ = 524288 >>> _loc8_;
                                                                              _loc11_ = 0;
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc18_ = 0;
                                                                              _loc11_ = 1;
                                                                              if(_loc8_ + -20 <= 30)
                                                                              {
                                                                                 _loc11_ = 1 << 51 - _loc8_;
                                                                                 _loc18_ = 0;
                                                                              }
                                                                           }
                                                                        }
                                                                        _loc42_ = (_loc42_ = _loc13_ - 240) | 4;
                                                                        si32(_loc15_,_loc42_);
                                                                        _loc42_ = (_loc42_ = _loc13_ - 232) | 4;
                                                                        si32(_loc18_,_loc42_);
                                                                        si32(_loc36_,_loc13_ - 240);
                                                                        si32(_loc11_,_loc13_ - 232);
                                                                        _loc22_ = lf64(_loc13_ - 240);
                                                                        _loc1_ = (_loc19_ = lf64(_loc13_ - 232)) * _loc22_;
                                                                        if(_loc16_ != 0)
                                                                        {
                                                                           if((_loc42_ = _loc25_ ^ 2146435071) == 0)
                                                                           {
                                                                              if(_loc27_ == -1)
                                                                              {
                                                                                 addr2411:
                                                                                 ESP = _loc9_;
                                                                                 F___error();
                                                                                 _loc42_ = eax;
                                                                                 si32(34,_loc42_);
                                                                                 _loc25_ = 2146435071;
                                                                                 _loc36_ = -1;
                                                                                 if(_loc34_ != 0)
                                                                                 {
                                                                                    if(_loc34_ != 3)
                                                                                    {
                                                                                       _loc25_ = 2146435072;
                                                                                       _loc36_ = 0;
                                                                                    }
                                                                                 }
                                                                                 _loc29_ = _loc25_;
                                                                                 if(_loc40_ != 0)
                                                                                 {
                                                                                    addr6685:
                                                                                    if(_loc35_ != 0)
                                                                                    {
                                                                                       if((_loc39_ = li32(_loc35_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(_loc35_,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F_idalloc();
                                                                                          _loc9_ += 16;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_lock();
                                                                                             _loc9_ += 16;
                                                                                             _loc39_ = li32(_loc35_ + 4);
                                                                                          }
                                                                                          _loc42_ = _loc39_ << 2;
                                                                                          si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc35_);
                                                                                          si32(_loc35_,_loc42_);
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_unlock();
                                                                                             _loc9_ += 16;
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    if(_loc37_ != 0)
                                                                                    {
                                                                                       if((_loc39_ = li32(_loc37_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(_loc37_,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F_idalloc();
                                                                                          _loc9_ += 16;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_lock();
                                                                                             _loc9_ += 16;
                                                                                             _loc39_ = li32(_loc37_ + 4);
                                                                                          }
                                                                                          _loc42_ = _loc39_ << 2;
                                                                                          si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc37_);
                                                                                          si32(_loc37_,_loc42_);
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_unlock();
                                                                                             _loc9_ += 16;
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    if(_loc38_ != 0)
                                                                                    {
                                                                                       if((_loc39_ = li32(_loc38_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(_loc38_,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F_idalloc();
                                                                                          _loc9_ += 16;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_lock();
                                                                                             _loc9_ += 16;
                                                                                             _loc39_ = li32(_loc38_ + 4);
                                                                                          }
                                                                                          _loc42_ = _loc39_ << 2;
                                                                                          si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc38_);
                                                                                          si32(_loc38_,_loc42_);
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_unlock();
                                                                                             _loc9_ += 16;
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    if(_loc40_ != 0)
                                                                                    {
                                                                                       if((_loc39_ = li32(_loc40_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(_loc40_,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F_idalloc();
                                                                                          _loc9_ += 16;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_lock();
                                                                                             _loc9_ += 16;
                                                                                             _loc39_ = li32(_loc40_ + 4);
                                                                                          }
                                                                                          _loc42_ = _loc39_ << 2;
                                                                                          si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc40_);
                                                                                          si32(_loc40_,_loc42_);
                                                                                          if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                          {
                                                                                             _loc9_ -= 16;
                                                                                             si32(___gdtoa_locks,_loc9_);
                                                                                             ESP = _loc9_;
                                                                                             F__pthread_mutex_unlock();
                                                                                             _loc9_ += 16;
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    _loc29_ = _loc25_;
                                                                                    if(_loc33_ != 0)
                                                                                    {
                                                                                       if((_loc40_ = li32(_loc33_ + 4)) >= 10)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(_loc33_,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F_idalloc();
                                                                                          _loc9_ += 16;
                                                                                          _loc29_ = _loc25_;
                                                                                          break loop4;
                                                                                       }
                                                                                       if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F__pthread_mutex_lock();
                                                                                          _loc9_ += 16;
                                                                                          _loc40_ = li32(_loc33_ + 4);
                                                                                       }
                                                                                       _loc42_ = _loc40_ << 2;
                                                                                       si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc33_);
                                                                                       si32(_loc33_,_loc42_);
                                                                                       _loc42_ = li32(___isthreaded);
                                                                                       _loc29_ = _loc25_;
                                                                                       if(_loc42_ != 0)
                                                                                       {
                                                                                          _loc9_ -= 16;
                                                                                          si32(___gdtoa_locks,_loc9_);
                                                                                          ESP = _loc9_;
                                                                                          F__pthread_mutex_unlock();
                                                                                          _loc9_ += 16;
                                                                                          _loc29_ = _loc25_;
                                                                                          break loop4;
                                                                                       }
                                                                                       break loop4;
                                                                                    }
                                                                                    break loop4;
                                                                                 }
                                                                                 break loop4;
                                                                              }
                                                                           }
                                                                           sf64(_loc19_ = _loc21_ + _loc1_,_loc13_ - 248);
                                                                           _loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 248) | 4);
                                                                           _loc36_ = li32(_loc13_ - 248);
                                                                        }
                                                                        else
                                                                        {
                                                                           sf64(_loc19_ = _loc21_ - _loc1_,_loc13_ - 256);
                                                                           _loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 256) | 4);
                                                                           _loc36_ = li32(_loc13_ - 256);
                                                                        }
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if(_loc11_ <= -1)
                                                                     {
                                                                        _loc36_ = _loc27_;
                                                                        if(_loc16_ == 0)
                                                                        {
                                                                           _loc36_ = _loc27_;
                                                                           if(_loc27_ == 0)
                                                                           {
                                                                              _loc36_ = _loc27_;
                                                                              if((_loc25_ & 1048575) == 0)
                                                                              {
                                                                                 _loc36_ = _loc27_;
                                                                                 if((uint(_loc25_ & 2146435072)) >= 112197633)
                                                                                 {
                                                                                    if((_loc42_ = li32(_loc33_ + 20)) == 0)
                                                                                    {
                                                                                       _loc36_ = _loc27_;
                                                                                       if(_loc15_ >= 2)
                                                                                       {
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    _loc9_ -= 16;
                                                                                    si32(1,_loc9_ + 4);
                                                                                    si32(_loc33_,_loc9_);
                                                                                    ESP = _loc9_;
                                                                                    F___lshift_D2A();
                                                                                    _loc9_ += 16;
                                                                                    _loc33_ = eax;
                                                                                    _loc30_ = li32(_loc38_ + 16);
                                                                                    if((_loc34_ = li32(_loc33_ + 16)) != _loc30_)
                                                                                    {
                                                                                       _loc31_ = _loc34_ - _loc30_;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc28_ = (_loc43_ = (_loc42_ = _loc30_ << 2) + _loc33_) + 20;
                                                                                       _loc29_ = (_loc42_ += _loc38_) + 16;
                                                                                       _loc31_ = _loc33_ + 20;
                                                                                       while(true)
                                                                                       {
                                                                                          _loc30_ = li32(_loc29_);
                                                                                          if((_loc34_ = li32(_loc28_ - 4)) == _loc30_)
                                                                                          {
                                                                                             _loc28_ += -4;
                                                                                             _loc29_ += -4;
                                                                                             _loc36_ = _loc27_;
                                                                                             if(uint(_loc28_) <= uint(_loc31_))
                                                                                             {
                                                                                                break loop15;
                                                                                             }
                                                                                             continue;
                                                                                          }
                                                                                          _loc31_ = -1;
                                                                                          if(uint(_loc34_) >= uint(_loc30_))
                                                                                          {
                                                                                             _loc31_ = 1;
                                                                                          }
                                                                                       }
                                                                                    }
                                                                                    _loc36_ = _loc27_;
                                                                                    if(_loc31_ <= 0)
                                                                                    {
                                                                                       break;
                                                                                    }
                                                                                    addr5052:
                                                                                    _loc30_ = _loc25_ & 2146435072;
                                                                                    if(_loc39_ != 0)
                                                                                    {
                                                                                       if(uint(_loc30_) <= 112197632)
                                                                                       {
                                                                                          _loc36_ = _loc27_;
                                                                                          if(uint(_loc30_) <= 57671680)
                                                                                          {
                                                                                             addr2889:
                                                                                             ESP = _loc9_;
                                                                                             F___error();
                                                                                             _loc42_ = eax;
                                                                                             si32(34,_loc42_);
                                                                                             _loc25_ = _loc36_ = 0;
                                                                                             _loc29_ = _loc36_;
                                                                                             if(_loc40_ != 0)
                                                                                             {
                                                                                                §§goto(addr6685);
                                                                                             }
                                                                                             break loop4;
                                                                                          }
                                                                                          addr6614:
                                                                                          _loc42_ = (_loc42_ = _loc13_ - 440) | 4;
                                                                                          si32(_loc25_,_loc42_);
                                                                                          si32(_loc36_,_loc13_ - 440);
                                                                                          sf64(_loc19_ = (_loc19_ = lf64(_loc13_ - 440)) * 1.232595164407831e-32,_loc13_ - 448);
                                                                                          _loc42_ = (_loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 448) | 4)) & 2146435072;
                                                                                          _loc36_ = li32(_loc13_ - 448);
                                                                                          if(_loc42_ == 0)
                                                                                          {
                                                                                             ESP = _loc9_;
                                                                                             F___error();
                                                                                             si32(34,eax);
                                                                                          }
                                                                                          §§goto(addr6685);
                                                                                          §§goto(addr6685);
                                                                                       }
                                                                                    }
                                                                                    _loc25_ = (_loc42_ = _loc30_ + -1048576) | 1048575;
                                                                                    _loc36_ = -1;
                                                                                    break;
                                                                                 }
                                                                                 break;
                                                                              }
                                                                              break;
                                                                           }
                                                                           break;
                                                                        }
                                                                        break;
                                                                     }
                                                                     if(_loc11_ == 0)
                                                                     {
                                                                        _loc30_ = _loc25_ & 1048575;
                                                                        if(_loc16_ != 0)
                                                                        {
                                                                           if(_loc30_ == 1048575)
                                                                           {
                                                                              _loc30_ = -1;
                                                                              if(_loc39_ != 0)
                                                                              {
                                                                                 _loc34_ = _loc25_ & 2146435072;
                                                                                 _loc30_ = -1;
                                                                                 if(uint(_loc34_) <= 111149056)
                                                                                 {
                                                                                    _loc30_ = -1 << 107 - (_loc34_ >>> 20);
                                                                                 }
                                                                              }
                                                                              if(_loc27_ == _loc30_)
                                                                              {
                                                                                 _loc25_ = (_loc42_ = _loc25_ & 2146435072) + 1048576;
                                                                                 _loc36_ = 0;
                                                                                 break;
                                                                              }
                                                                           }
                                                                        }
                                                                        else if(_loc30_ == 0)
                                                                        {
                                                                           if(_loc27_ != 0)
                                                                           {
                                                                              addr5086:
                                                                              _loc42_ = _loc27_ & 1;
                                                                              _loc36_ = _loc27_;
                                                                              if(_loc42_ != 0)
                                                                              {
                                                                                 if((_loc30_ = (_loc25_ &= 2146435072) + -54525952) >= 1)
                                                                                 {
                                                                                    _loc25_ = 0;
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc34_ = (_loc42_ = 54525952 - _loc25_) >> 20;
                                                                                    if(_loc42_ <= 20971519)
                                                                                    {
                                                                                       _loc30_ = 524288 >>> _loc34_;
                                                                                       _loc25_ = 0;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc30_ = 0;
                                                                                       _loc25_ = 1;
                                                                                       if(_loc34_ + -20 <= 30)
                                                                                       {
                                                                                          _loc25_ = 1 << 51 - _loc34_;
                                                                                          _loc30_ = 0;
                                                                                       }
                                                                                    }
                                                                                 }
                                                                                 _loc42_ = (_loc42_ = _loc13_ - 416) | 4;
                                                                                 si32(_loc30_,_loc42_);
                                                                                 si32(_loc25_,_loc13_ - 416);
                                                                                 _loc2_ = lf64(_loc13_ - 416);
                                                                                 if(_loc16_ != 0)
                                                                                 {
                                                                                    sf64(_loc19_ = _loc21_ + _loc2_,_loc13_ - 424);
                                                                                    _loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 424) | 4);
                                                                                    _loc36_ = li32(_loc13_ - 424);
                                                                                    break;
                                                                                 }
                                                                                 sf64(_loc19_ = _loc21_ - _loc2_,_loc13_ - 432);
                                                                                 _loc25_ = li32(_loc43_ = (_loc43_ = _loc13_ - 432) | 4);
                                                                                 _loc36_ = li32(_loc13_ - 432);
                                                                                 if(_loc19_ != 0)
                                                                                 {
                                                                                    break;
                                                                                 }
                                                                                 §§goto(addr2889);
                                                                              }
                                                                              break;
                                                                           }
                                                                           §§goto(addr5052);
                                                                           §§goto(addr2889);
                                                                        }
                                                                        §§goto(addr5086);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc9_ -= 16;
                                                                        si32(_loc42_ = _loc13_ - 4,_loc9_ + 4);
                                                                        si32(_loc33_,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___b2d_D2A();
                                                                        _loc9_ += 16;
                                                                        sf64(_loc19_ = st0,_loc13_ - 288);
                                                                        _loc9_ -= 16;
                                                                        si32(_loc42_ = _loc13_ - 8,_loc9_ + 4);
                                                                        si32(_loc38_,_loc9_);
                                                                        ESP = _loc9_;
                                                                        F___b2d_D2A();
                                                                        _loc9_ += 16;
                                                                        sf64(_loc19_ = st0,_loc13_ - 296);
                                                                        _loc15_ = (_loc43_ = (_loc43_ = (_loc43_ = li32(_loc33_ + 16)) - li32(_loc38_ + 16)) << 5) + ((_loc43_ = li32(_loc13_ - 4)) - li32(_loc13_ - 8));
                                                                        _loc36_ = li32(_loc42_ = (_loc42_ = _loc13_ - 288) | 4);
                                                                        _loc11_ = li32(_loc42_ = (_loc42_ = _loc13_ - 296) | 4);
                                                                        _loc8_ = li32(_loc13_ - 288);
                                                                        _loc18_ = li32(_loc13_ - 296);
                                                                        if(_loc15_ >= 1)
                                                                        {
                                                                           _loc36_ = (_loc42_ = _loc15_ << 20) + _loc36_;
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc11_ -= _loc15_ << 20;
                                                                        }
                                                                        _loc42_ = (_loc42_ = _loc13_ - 312) | 4;
                                                                        si32(_loc11_,_loc42_);
                                                                        _loc42_ = (_loc42_ = _loc13_ - 304) | 4;
                                                                        si32(_loc36_,_loc42_);
                                                                        si32(_loc18_,_loc13_ - 312);
                                                                        si32(_loc8_,_loc13_ - 304);
                                                                        _loc22_ = lf64(_loc13_ - 312);
                                                                        if(!((_loc24_ = (_loc19_ = lf64(_loc13_ - 304)) / _loc22_) > 2 | _loc24_ != _loc24_ | false))
                                                                        {
                                                                           _loc36_ = 1072693248;
                                                                           _loc11_ = 0;
                                                                           _loc3_ = 1;
                                                                           if(_loc16_ == 0)
                                                                           {
                                                                              if(_loc27_ != 1)
                                                                              {
                                                                                 _loc36_ = -1074790400;
                                                                                 _loc11_ = 0;
                                                                                 _loc3_ = 1;
                                                                                 if(_loc27_ == 0)
                                                                                 {
                                                                                    _loc36_ = -1074790400;
                                                                                    _loc11_ = 0;
                                                                                    _loc3_ = 1;
                                                                                    if((_loc25_ & 1048575) == 0)
                                                                                    {
                                                                                       _loc3_ = 0.5;
                                                                                       if(_loc24_ >= 1)
                                                                                       {
                                                                                          _loc3_ = _loc24_ * 0.5;
                                                                                       }
                                                                                       sf64(_loc3_,_loc13_ - 320);
                                                                                       _loc36_ = (_loc42_ = li32(_loc42_ = (_loc42_ = _loc13_ - 320) | 4)) ^ -2147483648;
                                                                                       _loc11_ = li32(_loc13_ - 320);
                                                                                    }
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc36_ = -1074790400;
                                                                                 _loc11_ = 0;
                                                                                 _loc3_ = 1;
                                                                                 if(_loc25_ == 0)
                                                                                 {
                                                                                    §§goto(addr2889);
                                                                                 }
                                                                                 §§goto(addr6685);
                                                                              }
                                                                              §§goto(addr6685);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc3_ = _loc24_ * 0.5;
                                                                           _loc1_ = _loc3_;
                                                                           if(_loc16_ == 0)
                                                                           {
                                                                              _loc1_ = -_loc3_;
                                                                           }
                                                                           if(_loc34_ != 0)
                                                                           {
                                                                              if(_loc34_ != 2)
                                                                              {
                                                                                 if(_loc34_ != 3)
                                                                                 {
                                                                                    sf64(_loc1_,_loc13_ - 344);
                                                                                    _loc36_ = li32(_loc42_ = (_loc42_ = _loc13_ - 344) | 4);
                                                                                    _loc11_ = li32(_loc13_ - 344);
                                                                                    addr5670:
                                                                                    if((_loc18_ = _loc25_ & 2146435072) == 2145386496)
                                                                                    {
                                                                                       _loc43_ = (_loc43_ = _loc13_ - 384) | 4;
                                                                                       si32(_loc25_ + -55574528,_loc43_);
                                                                                       si32(_loc27_,_loc13_ - 384);
                                                                                       _loc8_ = (_loc12_ = _loc25_ + -55574528 & 2146435072) + -54525952;
                                                                                       _loc21_ = lf64(_loc13_ - 384);
                                                                                       if(_loc8_ >= 1)
                                                                                       {
                                                                                          _loc12_ = 0;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc10_ = (_loc42_ = 54525952 - _loc12_) >> 20;
                                                                                          if(_loc42_ <= 20971519)
                                                                                          {
                                                                                             _loc8_ = 524288 >>> _loc10_;
                                                                                             _loc12_ = 0;
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc8_ = 0;
                                                                                             _loc12_ = 1;
                                                                                             if(_loc10_ + -20 <= 30)
                                                                                             {
                                                                                                _loc12_ = 1 << 51 - _loc10_;
                                                                                                _loc8_ = 0;
                                                                                             }
                                                                                          }
                                                                                       }
                                                                                       _loc42_ = (_loc42_ = _loc13_ - 400) | 4;
                                                                                       si32(_loc36_,_loc42_);
                                                                                       _loc42_ = (_loc42_ = _loc13_ - 392) | 4;
                                                                                       si32(_loc8_,_loc42_);
                                                                                       si32(_loc11_,_loc13_ - 400);
                                                                                       si32(_loc12_,_loc13_ - 392);
                                                                                       _loc22_ = lf64(_loc13_ - 400);
                                                                                       _loc19_ = (_loc19_ = lf64(_loc13_ - 392)) * _loc22_;
                                                                                       sf64(_loc19_ = _loc21_ + _loc19_,_loc13_ - 408);
                                                                                       if((uint(_loc42_ = (_loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 408) | 4)) & 2145386496)) >= 2090860544)
                                                                                       {
                                                                                          _loc25_ = 2146435071;
                                                                                          _loc36_ = -1;
                                                                                          if((_loc25_ ^ 2146435071) == 0)
                                                                                          {
                                                                                             if(_loc27_ != -1)
                                                                                             {
                                                                                                addr6141:
                                                                                                if(_loc35_ != 0)
                                                                                                {
                                                                                                   if((_loc29_ = li32(_loc35_ + 4)) >= 10)
                                                                                                   {
                                                                                                      _loc9_ -= 16;
                                                                                                      si32(_loc35_,_loc9_);
                                                                                                      ESP = _loc9_;
                                                                                                      F_idalloc();
                                                                                                      _loc9_ += 16;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_lock();
                                                                                                         _loc9_ += 16;
                                                                                                         _loc29_ = li32(_loc35_ + 4);
                                                                                                      }
                                                                                                      _loc42_ = _loc29_ << 2;
                                                                                                      si32(_loc42_ = li32(_loc43_ = _freelist + _loc42_),_loc35_);
                                                                                                      si32(_loc35_,_loc43_);
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_unlock();
                                                                                                         _loc9_ += 16;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                if(_loc37_ != 0)
                                                                                                {
                                                                                                   if((_loc35_ = li32(_loc37_ + 4)) >= 10)
                                                                                                   {
                                                                                                      _loc9_ -= 16;
                                                                                                      si32(_loc37_,_loc9_);
                                                                                                      ESP = _loc9_;
                                                                                                      F_idalloc();
                                                                                                      _loc9_ += 16;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_lock();
                                                                                                         _loc9_ += 16;
                                                                                                         _loc35_ = li32(_loc37_ + 4);
                                                                                                      }
                                                                                                      _loc42_ = _loc35_ << 2;
                                                                                                      si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc37_);
                                                                                                      si32(_loc37_,_loc42_);
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_unlock();
                                                                                                         _loc9_ += 16;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                if(_loc38_ != 0)
                                                                                                {
                                                                                                   if((_loc37_ = li32(_loc38_ + 4)) >= 10)
                                                                                                   {
                                                                                                      _loc9_ -= 16;
                                                                                                      si32(_loc38_,_loc9_);
                                                                                                      ESP = _loc9_;
                                                                                                      F_idalloc();
                                                                                                      _loc9_ += 16;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_lock();
                                                                                                         _loc9_ += 16;
                                                                                                         _loc37_ = li32(_loc38_ + 4);
                                                                                                      }
                                                                                                      _loc42_ = _loc37_ << 2;
                                                                                                      si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc38_);
                                                                                                      si32(_loc38_,_loc42_);
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_unlock();
                                                                                                         _loc9_ += 16;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                _loc27_ = _loc36_;
                                                                                                if(_loc33_ != 0)
                                                                                                {
                                                                                                   if((_loc38_ = li32(_loc33_ + 4)) >= 10)
                                                                                                   {
                                                                                                      _loc9_ -= 16;
                                                                                                      si32(_loc33_,_loc9_);
                                                                                                      ESP = _loc9_;
                                                                                                      F_idalloc();
                                                                                                      _loc9_ += 16;
                                                                                                      _loc27_ = _loc36_;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      if((_loc42_ = li32(___isthreaded)) != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_lock();
                                                                                                         _loc9_ += 16;
                                                                                                         _loc38_ = li32(_loc33_ + 4);
                                                                                                      }
                                                                                                      _loc42_ = _loc38_ << 2;
                                                                                                      si32(_loc43_ = li32(_loc42_ = _freelist + _loc42_),_loc33_);
                                                                                                      si32(_loc33_,_loc42_);
                                                                                                      _loc42_ = li32(___isthreaded);
                                                                                                      _loc27_ = _loc36_;
                                                                                                      if(_loc42_ != 0)
                                                                                                      {
                                                                                                         _loc9_ -= 16;
                                                                                                         si32(___gdtoa_locks,_loc9_);
                                                                                                         ESP = _loc9_;
                                                                                                         F__pthread_mutex_unlock();
                                                                                                         _loc9_ += 16;
                                                                                                         _loc27_ = _loc36_;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                continue;
                                                                                             }
                                                                                             §§goto(addr2411);
                                                                                          }
                                                                                          §§goto(addr6141);
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc36_ = li32(_loc13_ - 408);
                                                                                          _loc25_ = _loc29_ + 55574528;
                                                                                          _loc27_ = _loc36_;
                                                                                          _loc29_ = _loc25_;
                                                                                       }
                                                                                       §§goto(addr6141);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       if(_loc39_ != 0)
                                                                                       {
                                                                                          if(uint(_loc18_) <= 111149056)
                                                                                          {
                                                                                             if(!(_loc3_ > 2147483647 | _loc3_ != _loc3_ | false))
                                                                                             {
                                                                                                _loc25_ = int(uint(_loc3_));
                                                                                                _loc3_ = 1;
                                                                                                if(_loc25_ != 0)
                                                                                                {
                                                                                                   _loc3_ = uint(_loc25_);
                                                                                                }
                                                                                                _loc4_ = _loc3_;
                                                                                                if(_loc16_ == 0)
                                                                                                {
                                                                                                   _loc4_ = -_loc3_;
                                                                                                }
                                                                                                sf64(_loc4_,_loc13_ - 352);
                                                                                                _loc36_ = li32(_loc42_ = (_loc42_ = _loc13_ - 352) | 4);
                                                                                                _loc11_ = li32(_loc13_ - 352);
                                                                                             }
                                                                                             _loc36_ = (_loc42_ = 112197632 - _loc18_) + _loc36_;
                                                                                          }
                                                                                       }
                                                                                       if((_loc25_ = _loc18_ + -54525952) >= 1)
                                                                                       {
                                                                                          _loc8_ = 0;
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc27_ = (_loc42_ = 54525952 - _loc18_) >> 20;
                                                                                          if(_loc42_ <= 20971519)
                                                                                          {
                                                                                             _loc25_ = 524288 >>> _loc27_;
                                                                                             _loc8_ = 0;
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc25_ = 0;
                                                                                             _loc8_ = 1;
                                                                                             if(_loc27_ + -20 <= 30)
                                                                                             {
                                                                                                _loc8_ = 1 << 51 - _loc27_;
                                                                                                _loc25_ = 0;
                                                                                             }
                                                                                          }
                                                                                       }
                                                                                       _loc42_ = (_loc42_ = _loc13_ - 368) | 4;
                                                                                       si32(_loc36_,_loc42_);
                                                                                       _loc42_ = (_loc42_ = _loc13_ - 360) | 4;
                                                                                       si32(_loc25_,_loc42_);
                                                                                       si32(_loc11_,_loc13_ - 368);
                                                                                       si32(_loc8_,_loc13_ - 360);
                                                                                       _loc19_ = lf64(_loc13_ - 368);
                                                                                       _loc19_ = (_loc22_ = lf64(_loc13_ - 360)) * _loc19_;
                                                                                       sf64(_loc19_ = _loc21_ + _loc19_,_loc13_ - 376);
                                                                                       _loc25_ = li32(_loc42_ = (_loc42_ = _loc13_ - 376) | 4);
                                                                                       _loc27_ = _loc36_ = li32(_loc13_ - 376);
                                                                                       _loc29_ = _loc25_;
                                                                                    }
                                                                                    if(_loc39_ == 0)
                                                                                    {
                                                                                       if(_loc18_ == (_loc29_ & 2146435072))
                                                                                       {
                                                                                          _loc6_ = _loc3_ - (_loc43_ = _loc3_);
                                                                                          if((_loc27_ | _loc16_) == 0)
                                                                                          {
                                                                                             if((_loc42_ = _loc29_ & 1048575) == 0)
                                                                                             {
                                                                                                if(_loc6_ >= 0.24999995)
                                                                                                {
                                                                                                   §§goto(addr6141);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   §§goto(addr6685);
                                                                                                }
                                                                                             }
                                                                                             §§goto(addr6141);
                                                                                          }
                                                                                          if(_loc6_ >= 0.4999999)
                                                                                          {
                                                                                             if(_loc6_ > 0.5000001)
                                                                                             {
                                                                                                break;
                                                                                             }
                                                                                             §§goto(addr6141);
                                                                                          }
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    §§goto(addr6141);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 sf64(_loc19_ = _loc1_ + -0.5,_loc13_ - 328);
                                                                                 _loc36_ = li32(_loc42_ = (_loc42_ = _loc13_ - 328) | 4);
                                                                                 _loc11_ = li32(_loc13_ - 328);
                                                                              }
                                                                              §§goto(addr5670);
                                                                           }
                                                                           sf64(_loc19_ = _loc1_ + 0.5,_loc13_ - 336);
                                                                           _loc36_ = li32(_loc42_ = (_loc42_ = _loc13_ - 336) | 4);
                                                                           _loc11_ = li32(_loc13_ - 336);
                                                                        }
                                                                        §§goto(addr5670);
                                                                     }
                                                                  }
                                                                  §§goto(addr6141);
                                                               }
                                                               if(_loc39_ != 0)
                                                               {
                                                                  §§goto(addr6614);
                                                               }
                                                               §§goto(addr6685);
                                                            }
                                                            §§goto(addr2914);
                                                         }
                                                      }
                                                      §§goto(addr2411);
                                                   }
                                                }
                                                else
                                                {
                                                   _loc39_ = 0;
                                                   if(_loc27_ <= -1)
                                                   {
                                                      if((_loc39_ = (_loc27_ = 0 - _loc27_) & 15) != 0)
                                                      {
                                                         sf64(_loc20_ /= lf64(_loc42_ = ___tens_D2A + (_loc39_ << 3)),_loc13_ - 112);
                                                         _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 112) | 4);
                                                         _loc40_ = _loc36_ = li32(_loc13_ - 112);
                                                         _loc28_ = _loc29_;
                                                      }
                                                      _loc27_ >>= 4;
                                                      _loc39_ = 0;
                                                      if(_loc27_ != 0)
                                                      {
                                                         if(_loc27_ <= 31)
                                                         {
                                                            _loc39_ = _tinytens;
                                                            _loc32_ = _loc27_;
                                                            if(_loc27_ >= 1)
                                                            {
                                                               do
                                                               {
                                                                  if((_loc42_ = _loc32_ & 1) != 0)
                                                                  {
                                                                     _loc20_ *= lf64(_loc39_);
                                                                  }
                                                                  _loc39_ += 8;
                                                               }
                                                               while((_loc32_ >>= 1) > 0);
                                                               
                                                               sf64(_loc20_,_loc13_ - 120);
                                                               _loc29_ = li32(_loc42_ = (_loc42_ = _loc13_ - 120) | 4);
                                                               _loc40_ = _loc36_ = li32(_loc13_ - 120);
                                                               _loc28_ = _loc29_;
                                                            }
                                                            if((_loc42_ = _loc27_ & 16) != 0)
                                                            {
                                                               if((_loc39_ = 107 - ((_loc42_ = _loc28_ >>> 20) & 2047)) >= 1)
                                                               {
                                                                  if(_loc39_ >= 32)
                                                                  {
                                                                     _loc29_ = 57671680;
                                                                     _loc36_ = 0;
                                                                     if(_loc39_ <= 52)
                                                                     {
                                                                        _loc29_ = (_loc42_ = -1 << _loc39_ + -32) & _loc28_;
                                                                        _loc36_ = 0;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc36_ = (_loc42_ = -1 << _loc39_) & _loc40_;
                                                                  }
                                                               }
                                                            }
                                                            _loc39_ = (_loc42_ = (_loc42_ = _loc27_ << 27) >> 31) & 106;
                                                            _loc42_ = (_loc42_ = _loc13_ - 128) | 4;
                                                            si32(_loc29_,_loc42_);
                                                            si32(_loc36_,_loc13_ - 128);
                                                            if((_loc19_ = lf64(_loc13_ - 128)) != 0 | _loc19_ != _loc19_ | false)
                                                            {
                                                               §§goto(addr2914);
                                                            }
                                                         }
                                                         ESP = _loc9_;
                                                         F___error();
                                                         _loc42_ = eax;
                                                         si32(34,_loc42_);
                                                         _loc29_ = _loc36_ = 0;
                                                         break;
                                                      }
                                                   }
                                                }
                                                §§goto(addr2914);
                                             }
                                          }
                                          else
                                          {
                                             si32(_loc32_,_loc13_ - 28);
                                             _loc34_ = 0;
                                             _loc28_ = _loc32_;
                                             _loc40_ = _loc32_;
                                          }
                                          §§goto(addr1650);
                                       }
                                       §§goto(addr1417);
                                    }
                                    break loop1;
                                 }
                                 §§goto(addr1650);
                              }
                              break;
                           }
                        }
                        else
                        {
                           si32(53,_loc13_ - 64);
                           si32(-1074,(_loc42_ = _loc13_ - 64) | 4);
                           si32(971,_loc13_ - 56);
                           si32(_loc36_ = 0,_loc13_ - 48);
                           si32(1,_loc13_ - 52);
                           _loc9_ -= 32;
                           si32(_loc44_,_loc9_ + 16);
                           si32(_loc43_ = _loc13_ - 32,_loc9_ + 12);
                           si32(_loc43_ = _loc13_ - 36,_loc9_ + 8);
                           si32(_loc42_,_loc9_ + 4);
                           si32(_loc42_ = _loc13_ - 28,_loc9_);
                           ESP = _loc9_;
                           F___gethex_D2A();
                           _loc9_ += 32;
                           _loc39_ = (_loc38_ = eax) & 7;
                           _loc29_ = _loc36_;
                           if(_loc39_ != 0)
                           {
                              if(_loc39_ == 6)
                              {
                                 si32(_loc40_,_loc13_ - 28);
                                 _loc29_ = _loc36_ = 0;
                                 _loc44_ = _loc36_;
                              }
                              else
                              {
                                 if((_loc40_ = li32(_loc13_ - 32)) != 0)
                                 {
                                    _loc25_ = li32(_loc40_ + 16);
                                    _loc37_ = _loc30_ = _loc13_ - 44;
                                    if(_loc25_ >= 1)
                                    {
                                       _loc34_ = (_loc42_ = _loc40_ + (_loc25_ << 2)) + 20;
                                       _loc25_ = _loc40_ + 20;
                                       _loc37_ = _loc13_ - 44;
                                       do
                                       {
                                          si32(_loc42_ = li32(_loc25_),_loc37_);
                                          _loc25_ += 4;
                                          _loc37_ += 4;
                                       }
                                       while(uint(_loc25_) < uint(_loc34_));
                                       
                                    }
                                    _loc30_ += 8;
                                    if(uint(_loc37_) < uint(_loc30_))
                                    {
                                       do
                                       {
                                          si32(0,_loc37_);
                                       }
                                       while((uint(_loc37_ += 4)) < uint(_loc30_));
                                       
                                    }
                                    if((_loc37_ = li32(_loc40_ + 4)) >= 10)
                                    {
                                       _loc9_ -= 16;
                                       si32(_loc40_,_loc9_);
                                       ESP = _loc9_;
                                       F_idalloc();
                                       _loc9_ += 16;
                                    }
                                    else
                                    {
                                       if((_loc42_ = li32(___isthreaded)) != 0)
                                       {
                                          _loc9_ -= 16;
                                          si32(___gdtoa_locks,_loc9_);
                                          ESP = _loc9_;
                                          F__pthread_mutex_lock();
                                          _loc9_ += 16;
                                          _loc37_ = li32(_loc40_ + 4);
                                       }
                                       _loc42_ = _loc37_ << 2;
                                       si32(_loc42_ = li32(_loc43_ = _freelist + _loc42_),_loc40_);
                                       si32(_loc40_,_loc43_);
                                       if((_loc42_ = li32(___isthreaded)) != 0)
                                       {
                                          _loc9_ -= 16;
                                          si32(___gdtoa_locks,_loc9_);
                                          ESP = _loc9_;
                                          F__pthread_mutex_unlock();
                                          _loc9_ += 16;
                                       }
                                    }
                                 }
                                 _loc36_ = 0;
                                 _loc40_ = li32(_loc13_ - 36);
                                 if(_loc39_ <= 2)
                                 {
                                    if(_loc39_ != 1)
                                    {
                                       _loc29_ = _loc36_;
                                       if(_loc39_ == 2)
                                       {
                                          _loc29_ = li32(_loc13_ - 40);
                                          _loc36_ = li32(_loc13_ - 44);
                                       }
                                    }
                                    else
                                    {
                                       addr771:
                                       _loc42_ = (_loc42_ = li32(_loc13_ - 40)) & -1048577;
                                       _loc43_ = (_loc43_ = _loc40_ << 20) + 1127219200;
                                       _loc29_ = _loc42_ | _loc43_;
                                       _loc36_ = li32(_loc13_ - 44);
                                    }
                                 }
                                 else if(_loc39_ != 3)
                                 {
                                    if(_loc39_ != 4)
                                    {
                                       _loc29_ = _loc36_;
                                       if(_loc39_ == 5)
                                       {
                                          §§goto(addr771);
                                       }
                                    }
                                    else
                                    {
                                       _loc29_ = 2146959360;
                                       _loc36_ = 0;
                                    }
                                 }
                                 else
                                 {
                                    _loc29_ = 2146435072;
                                    _loc36_ = 0;
                                 }
                                 if((_loc42_ = _loc38_ & 8) != 0)
                                 {
                                    _loc29_ |= -2147483648;
                                 }
                              }
                           }
                        }
                        §§goto(addr7268);
                     }
                     §§goto(addr854);
                  }
                  break;
               }
               if(_loc33_ != 32)
               {
                  _loc44_ = 1;
                  if(_loc33_ != 45)
                  {
                     _loc44_ = _loc34_;
                     if(_loc33_ == 43)
                     {
                        _loc44_ = 0;
                     }
                     §§goto(addr367);
                  }
                  si32(_loc42_ = _loc25_ + 1,_loc13_ - 28);
                  _loc33_ = li8(_loc25_ + 1);
                  _loc25_ = _loc42_;
                  if(_loc33_ != 0)
                  {
                     §§goto(addr367);
                  }
                  break;
               }
               continue;
               §§goto(addr367);
            }
            si32(_loc40_,_loc13_ - 28);
            _loc29_ = _loc36_ = 0;
            _loc44_ = _loc36_;
            addr7268:
            if(_loc41_ != 0)
            {
               si32(_loc42_ = li32(_loc13_ - 28),_loc41_);
            }
            _loc42_ = (_loc42_ = _loc13_ - 464) | 4;
         }
         continue;
         si32(_loc29_,_loc42_);
         si32(_loc36_,_loc13_ - 464);
         _loc5_ = lf64(_loc13_ - 464);
         if(_loc44_ != 0)
         {
            _loc5_ = -_loc5_;
         }
         st0 = _loc5_;
         ESP = _loc9_ = _loc13_;
         return;
      }
   }
}
