package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2338;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str3339;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str336;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str4340;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str5341;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str6342;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_2805;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_2938;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ret_2E_1158;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___printf_render_int() : void
   {
      var _loc9_:int = 0;
      var _loc14_:* = 0;
      var _loc21_:* = 0;
      var _loc15_:* = 0;
      var _loc16_:int = 0;
      var _loc5_:* = 0;
      var _loc18_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc13_:* = 0;
      var _loc17_:* = 0;
      var _loc2_:int = 0;
      var _loc20_:* = 0;
      var _loc7_:* = 0;
      var _loc11_:* = 0;
      var _loc19_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:* = (_loc9_ = ESP) - 80;
      si8(_loc5_ = 0,_loc9_ - 65);
      _loc20_ = li32((_loc21_ = li32(_loc9_ + 4)) + 44);
      _loc19_ = _loc5_;
      _loc18_ = _loc5_;
      if(_loc20_ != 0)
      {
         ESP = _loc4_;
         F_localeconv();
         _loc19_ = li8(_loc20_ = li32(_ret_2E_1158 + 4));
         ESP = _loc4_;
         F_localeconv();
         _loc5_ = 1;
         _loc18_ = li32(_ret_2E_1158 + 8);
      }
      _loc16_ = (_loc17_ = _loc9_ - 64) + 63;
      _loc15_ = li32(_loc9_ + 8);
      _loc14_ = li32(_loc9_);
      _loc1_ = li32(_loc21_ + 8);
      if(_loc1_ <= 104)
      {
         if(_loc1_ <= 87)
         {
            if(_loc1_ != 79)
            {
               if(_loc1_ != 85)
               {
                  addr207:
                  _loc20_ = li32(___stderrp);
                  _loc4_ -= 16;
                  si32(_loc1_,_loc4_ + 8);
                  si32(L__2E_str3339,_loc4_ + 4);
                  si32(_loc20_,_loc4_);
                  ESP = _loc4_;
                  F_fprintf();
                  _loc4_ = (_loc4_ += 16) - 16;
                  si32(L__2E_str4340,_loc4_ + 12);
                  si32(310,_loc4_ + 8);
                  si32(L__2E_str336,_loc4_ + 4);
                  si32(___func___2E_2938,_loc4_);
                  ESP = _loc4_;
                  F___assert();
                  _loc4_ += 16;
                  _loc1_ = li32(_loc15_);
                  si8(_loc20_ = li32(_loc21_ + 40),_loc9_ - 65);
                  _loc15_ = 0;
                  _loc10_ = 10;
                  _loc11_ = ___lowercase_hex;
               }
               else
               {
                  addr187:
                  _loc10_ = 10;
                  _loc11_ = ___lowercase_hex;
                  addr200:
                  _loc1_ = li32(_loc15_);
                  _loc15_ = 1;
               }
               addr295:
               if((_loc20_ = li32(_loc21_ + 12)) == 0)
               {
                  if((_loc20_ = li32(_loc21_ + 60)) == 0)
                  {
                     if((_loc20_ = li32(_loc21_ + 64)) == 0)
                     {
                        if((_loc20_ = li32(_loc21_ + 72)) == 0)
                        {
                           if((_loc20_ = li32(_loc21_ + 68)) != 0)
                           {
                              addr340:
                              _loc12_ = li32(_loc1_ + 4);
                              _loc13_ = 1;
                              if(_loc12_ <= -1)
                              {
                                 _loc13_ = 0;
                              }
                              _loc20_ = _loc15_ | _loc13_;
                              _loc1_ = li32(_loc1_);
                              if(_loc20_ == 0)
                              {
                                 si8(45,_loc9_ - 65);
                                 _loc15_ = 1;
                                 if(_loc1_ == 0)
                                 {
                                    _loc15_ = 0;
                                 }
                                 _loc12_ = (_loc20_ = 0 - _loc12_) - _loc15_;
                                 _loc1_ = 0 - _loc1_;
                              }
                              addr578:
                              if(_loc12_ == 0)
                              {
                                 §§goto(addr582);
                              }
                              §§goto(addr918);
                           }
                           else if((_loc20_ = li32(_loc21_ + 24)) != 0)
                           {
                              _loc1_ = li32(_loc1_);
                              _loc12_ = 1;
                              if(_loc1_ <= -1)
                              {
                                 _loc12_ = 0;
                              }
                              if((_loc20_ = _loc15_ | _loc12_) == 0)
                              {
                                 si8(45,_loc9_ - 65);
                                 _loc1_ = 0 - _loc1_;
                                 _loc12_ = 0;
                              }
                              else
                              {
                                 _loc12_ = 0;
                              }
                           }
                           else if((_loc20_ = li32(_loc21_ + 20)) != 0)
                           {
                              _loc1_ = li32(_loc1_);
                              if(_loc15_ == 0)
                              {
                                 if((_loc15_ = (_loc20_ = _loc1_ << 16) >> 16) <= -1)
                                 {
                                    si8(45,_loc9_ - 65);
                                    _loc1_ = 0 - _loc15_;
                                    _loc12_ = _loc1_ >> 31;
                                    §§goto(addr578);
                                 }
                                 §§goto(addr582);
                              }
                              _loc1_ &= 65535;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc1_ = li32(_loc1_);
                              if((_loc20_ = li32(_loc21_ + 16)) != 0)
                              {
                                 if(_loc15_ == 0)
                                 {
                                    if((_loc15_ = (_loc20_ = _loc1_ << 24) >> 24) <= -1)
                                    {
                                       si8(45,_loc9_ - 65);
                                       _loc1_ = 0 - _loc15_;
                                       _loc12_ = _loc1_ >> 31;
                                       §§goto(addr578);
                                    }
                                    §§goto(addr582);
                                 }
                                 _loc1_ &= 255;
                                 _loc12_ = 0;
                              }
                              else
                              {
                                 _loc12_ = 1;
                                 if(_loc1_ <= -1)
                                 {
                                    _loc12_ = 0;
                                 }
                                 if((_loc20_ = _loc15_ | _loc12_) == 0)
                                 {
                                    si8(45,_loc9_ - 65);
                                    _loc1_ = 0 - _loc1_;
                                    _loc12_ = 0;
                                 }
                                 else
                                 {
                                    _loc12_ = 0;
                                 }
                              }
                           }
                           addr582:
                           if(_loc10_ != 16)
                           {
                              if(_loc10_ != 10)
                              {
                                 if(_loc10_ == 8)
                                 {
                                    _loc15_ = (_loc20_ = _loc9_ - 64) + 63;
                                    _loc19_ = _loc1_;
                                    while(true)
                                    {
                                       si8(_loc20_ = (_loc20_ = _loc19_ & 7) | 48,_loc15_ - 1);
                                       _loc15_ += -1;
                                       if((_loc19_ >>>= 3) != 0)
                                       {
                                          continue;
                                       }
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(L__2E_str2338,_loc4_ + 12);
                                    si32(157,_loc4_ + 8);
                                    si32(L__2E_str336,_loc4_ + 4);
                                    si32(___func___2E_2805,_loc4_);
                                    ESP = _loc4_;
                                    F___assert();
                                    _loc4_ += 16;
                                    addr918:
                                    if(_loc10_ != 16)
                                    {
                                       if(_loc10_ != 10)
                                       {
                                          if(_loc10_ == 8)
                                          {
                                             _loc15_ = _loc17_ + 63;
                                             _loc18_ = _loc1_;
                                             _loc19_ = _loc12_;
                                             while(true)
                                             {
                                                si8(_loc20_ = (_loc20_ = _loc18_ & 7) | 48,_loc15_ - 1);
                                                var _loc3_:* = _loc18_ >>> 3;
                                                _loc20_ = _loc19_ << 29;
                                                _loc18_ = _loc3_ | _loc20_;
                                                _loc19_ >>>= 3;
                                                _loc20_ = _loc18_ | _loc19_;
                                                _loc15_ += -1;
                                                if(_loc20_ != 0)
                                                {
                                                   continue;
                                                }
                                             }
                                          }
                                          else
                                          {
                                             ESP = _loc4_;
                                             F_abort();
                                          }
                                       }
                                       else
                                       {
                                          _loc6_ = 0;
                                          _loc15_ = _loc16_;
                                          _loc13_ = _loc1_;
                                          _loc11_ = _loc12_;
                                          if(_loc12_ <= -1)
                                          {
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 12);
                                             si32(10,_loc4_ + 8);
                                             si32(_loc1_,_loc4_);
                                             si32(_loc12_,_loc4_ + 4);
                                             ESP = _loc4_;
                                             F___udivdi3();
                                             _loc4_ += 16;
                                             _loc13_ = eax;
                                             _loc11_ = edx;
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 12);
                                             si32(10,_loc4_ + 8);
                                             si32(_loc12_,_loc4_ + 4);
                                             si32(_loc1_,_loc4_);
                                             ESP = _loc4_;
                                             F___umoddi3();
                                             _loc4_ += 16;
                                             si8(_loc20_ = (_loc20_ = eax) | 48,_loc9_ - 2);
                                             _loc15_ = _loc17_ + 62;
                                             _loc6_ = 1;
                                          }
                                          _loc7_ = _loc15_;
                                          if(_loc5_ == 0)
                                          {
                                             do
                                             {
                                                _loc4_ -= 16;
                                                si32(0,_loc4_ + 12);
                                                si32(10,_loc4_ + 8);
                                                si32(_loc13_,_loc4_);
                                                si32(_loc11_,_loc4_ + 4);
                                                ESP = _loc4_;
                                                F___divdi3();
                                                _loc4_ += 16;
                                                _loc6_ = eax;
                                                _loc5_ = edx;
                                                _loc4_ -= 16;
                                                si32(0,_loc4_ + 12);
                                                si32(10,_loc4_ + 8);
                                                si32(_loc11_,_loc4_ + 4);
                                                si32(_loc13_,_loc4_);
                                                ESP = _loc4_;
                                                F___moddi3();
                                                _loc4_ += 16;
                                                si8(_loc20_ = (_loc20_ = eax) + 48,_loc15_ - 1);
                                                _loc7_ = _loc13_ + 9;
                                                _loc18_ = _loc19_ = 1;
                                                if(uint(_loc7_) <= 18)
                                                {
                                                   _loc18_ = 0;
                                                }
                                                _loc8_ = _loc19_;
                                                if(uint(_loc7_) >= uint(_loc13_))
                                                {
                                                   _loc8_ = 0;
                                                }
                                                _loc13_ = _loc19_;
                                                if(uint(_loc7_) >= 9)
                                                {
                                                   _loc13_ = _loc8_;
                                                }
                                                if((_loc11_ += _loc13_) == 0)
                                                {
                                                   _loc19_ = 0;
                                                }
                                                if(_loc11_ != 0)
                                                {
                                                   _loc18_ = _loc19_;
                                                }
                                                _loc15_ += -1;
                                                _loc13_ = _loc6_;
                                                _loc11_ = _loc5_;
                                             }
                                             while(_loc18_ != 0);
                                             
                                          }
                                          else
                                          {
                                             do
                                             {
                                                _loc4_ -= 16;
                                                si32(0,_loc4_ + 12);
                                                si32(10,_loc4_ + 8);
                                                si32(_loc13_,_loc4_);
                                                si32(_loc11_,_loc4_ + 4);
                                                ESP = _loc4_;
                                                F___moddi3();
                                                _loc4_ += 16;
                                                si8(_loc20_ = (_loc20_ = eax) + 48,_loc7_ - 1);
                                                _loc6_ += 1;
                                                _loc15_ = _loc7_ + -1;
                                                if((_loc5_ = li8(_loc18_)) != 127)
                                                {
                                                   if((_loc20_ = (_loc20_ = _loc5_ << 24) >> 24) == _loc6_)
                                                   {
                                                      _loc8_ = _loc5_ = 1;
                                                      if(uint(_loc13_) >= 10)
                                                      {
                                                         _loc8_ = 0;
                                                      }
                                                      if(_loc11_ >= 0)
                                                      {
                                                         _loc5_ = 0;
                                                      }
                                                      if(_loc11_ != 0)
                                                      {
                                                         _loc8_ = _loc5_;
                                                      }
                                                      if(_loc8_ == 0)
                                                      {
                                                         si8(_loc19_,_loc7_ - 2);
                                                         _loc15_ = _loc7_ + -2;
                                                         _loc6_ = 0;
                                                         if(li8(_loc18_ + 1) != 0)
                                                         {
                                                            _loc18_ += 1;
                                                            _loc6_ = 0;
                                                         }
                                                      }
                                                   }
                                                }
                                                _loc4_ -= 16;
                                                si32(10,_loc4_ + 8);
                                                si32(0,_loc4_ + 12);
                                                si32(_loc13_,_loc4_);
                                                _loc2_ = _loc13_ + 9;
                                                _loc5_ = _loc7_ = 1;
                                                if(uint(_loc2_) <= 18)
                                                {
                                                   _loc5_ = 0;
                                                }
                                                _loc8_ = _loc7_;
                                                if(uint(_loc2_) >= uint(_loc13_))
                                                {
                                                   _loc8_ = 0;
                                                }
                                                _loc13_ = _loc7_;
                                                if(uint(_loc2_) >= 9)
                                                {
                                                   _loc13_ = _loc8_;
                                                }
                                                si32(_loc11_,_loc4_ + 4);
                                                if((_loc11_ += _loc13_) == 0)
                                                {
                                                   _loc7_ = 0;
                                                }
                                                if(_loc11_ != 0)
                                                {
                                                   _loc5_ = _loc7_;
                                                }
                                                ESP = _loc4_;
                                                F___divdi3();
                                                _loc4_ += 16;
                                                _loc13_ = eax;
                                                _loc11_ = edx;
                                                _loc7_ = _loc15_;
                                             }
                                             while(_loc5_ != 0);
                                             
                                          }
                                       }
                                    }
                                    else
                                    {
                                       _loc15_ = _loc17_ + 63;
                                       _loc19_ = _loc1_;
                                       _loc18_ = _loc12_;
                                       do
                                       {
                                          _loc20_ = _loc19_ & 15;
                                          si8(_loc20_ = li8(_loc20_ = _loc11_ + _loc20_),_loc15_ - 1);
                                          _loc3_ = _loc19_ >>> 4;
                                          _loc20_ = _loc18_ << 28;
                                          _loc19_ = _loc3_ | _loc20_;
                                          _loc18_ >>>= 4;
                                          _loc20_ = _loc19_ | _loc18_;
                                          _loc15_ += -1;
                                       }
                                       while(_loc20_ != 0);
                                       
                                    }
                                 }
                              }
                              else if(uint(_loc1_) <= 9)
                              {
                                 si8(_loc20_ = _loc1_ + 48,_loc9_ - 2);
                                 _loc15_ = (_loc20_ = _loc9_ - 64) + 62;
                              }
                              else
                              {
                                 _loc11_ = 0;
                                 _loc15_ = _loc16_;
                                 _loc13_ = _loc1_;
                                 if(_loc1_ <= -1)
                                 {
                                    si8(_loc20_ = (_loc20_ = uint(_loc1_) % 10) | 48,_loc9_ - 2);
                                    _loc13_ = uint(_loc1_) / 10;
                                    _loc15_ = (_loc20_ = _loc9_ - 64) + 62;
                                    _loc11_ = 1;
                                 }
                                 if(_loc5_ == 0)
                                 {
                                    do
                                    {
                                       si8(_loc20_ = (_loc20_ = _loc13_ % 10) + 48,_loc15_ - 1);
                                       _loc15_ += -1;
                                       _loc3_ = _loc13_ / 10;
                                       _loc20_ = _loc13_ + 9;
                                       _loc13_ = _loc3_;
                                    }
                                    while(uint(_loc20_) > 18);
                                    
                                 }
                                 else
                                 {
                                    do
                                    {
                                       _loc6_ = _loc15_;
                                       si8(_loc20_ = (_loc20_ = (_loc5_ = _loc13_) % 10) + 48,_loc6_ - 1);
                                       _loc11_ += 1;
                                       _loc15_ = _loc6_ + -1;
                                       if((_loc13_ = si8(li8(_loc18_))) == _loc11_)
                                       {
                                          if((_loc20_ = _loc13_ & 255) != 127)
                                          {
                                             if(_loc5_ >= 10)
                                             {
                                                si8(_loc19_,_loc6_ - 2);
                                                _loc15_ = _loc6_ + -2;
                                                _loc11_ = 0;
                                                if(li8(_loc18_ + 1) != 0)
                                                {
                                                   _loc18_ += 1;
                                                   _loc11_ = 0;
                                                }
                                             }
                                          }
                                       }
                                       _loc13_ = _loc5_ / 10;
                                    }
                                    while((uint(_loc20_ = _loc5_ + 9)) > 18);
                                    
                                 }
                              }
                           }
                           else
                           {
                              _loc15_ = (_loc20_ = _loc9_ - 64) + 63;
                              _loc19_ = _loc1_;
                              while(true)
                              {
                                 _loc20_ = _loc19_ & 15;
                                 si8(_loc20_ = li8(_loc20_ = _loc11_ + _loc20_),_loc15_ - 1);
                                 _loc15_ += -1;
                                 if((_loc19_ >>>= 4) != 0)
                                 {
                                    continue;
                                 }
                              }
                           }
                           if((_loc20_ = _loc1_ | _loc12_) == 0)
                           {
                              _loc1_ = _loc12_ = 0;
                              if(li32(_loc21_) == 0)
                              {
                                 if((_loc20_ = li32(_loc21_ + 28)) != 0)
                                 {
                                    _loc1_ = _loc12_ = 0;
                                    if(_loc10_ != 8)
                                    {
                                    }
                                    §§goto(addr1639);
                                 }
                                 _loc12_ = 0;
                                 _loc15_ = _loc16_;
                                 _loc1_ = _loc12_;
                              }
                           }
                           else
                           {
                              _loc1_ = _loc12_ = 0;
                              if(li32(_loc21_ + 28) != 0)
                              {
                                 if(_loc10_ != 16)
                                 {
                                    _loc1_ = _loc12_ = 0;
                                    if(_loc10_ == 8)
                                    {
                                       si8(48,_loc15_ - 1);
                                       _loc15_ += -1;
                                       _loc1_ = _loc12_ = 0;
                                    }
                                 }
                                 else
                                 {
                                    _loc1_ = L__2E_str5341;
                                    if(li32(_loc21_ + 8) != 120)
                                    {
                                       _loc1_ = L__2E_str6342;
                                    }
                                    _loc12_ = 2;
                                 }
                              }
                           }
                           addr1639:
                           _loc10_ = 1;
                           if((_loc20_ = li8(_loc9_ - 65)) == 0)
                           {
                              _loc10_ = 0;
                           }
                           _loc20_ = _loc10_ & 1;
                           _loc3_ = _loc12_ + _loc16_;
                           _loc3_ -= _loc15_;
                           _loc12_ = _loc3_ + _loc20_;
                           _loc20_ = _loc16_ - _loc15_;
                           if((_loc10_ = li32(_loc21_)) > _loc20_)
                           {
                              _loc10_ = (_loc20_ = _loc15_ - _loc16_) + _loc10_;
                              addr1747:
                              _loc12_ = _loc10_ + _loc12_;
                              _loc17_ = _loc9_ - 64;
                              if(_loc10_ >= 1)
                              {
                                 if(uint(_loc17_) < uint(_loc15_))
                                 {
                                    _loc18_ = (_loc17_ = _loc9_ - 64) - _loc15_;
                                    _loc19_ = _loc11_ = 0 - _loc10_;
                                    if(uint(_loc18_) >= uint(_loc11_))
                                    {
                                       _loc19_ = _loc18_;
                                    }
                                    if(uint(_loc18_) <= uint(_loc11_))
                                    {
                                       _loc18_ = _loc11_;
                                    }
                                    _loc10_ = _loc19_ + _loc10_;
                                    _loc18_ = 0 - _loc18_;
                                    _loc11_ = _loc15_ + -1;
                                    do
                                    {
                                       si8(48,_loc11_);
                                       _loc11_ += -1;
                                    }
                                    while((_loc18_ += -1) != 0);
                                    
                                    _loc15_ += _loc19_;
                                 }
                              }
                           }
                           else
                           {
                              if(_loc10_ == -1)
                              {
                                 if((_loc20_ = li32(_loc21_ + 56)) == 48)
                                 {
                                    _loc19_ = li32(_loc21_ + 4);
                                    _loc10_ = (_loc20_ = _loc12_ << 24) >> 24;
                                    if(_loc19_ > _loc10_)
                                    {
                                       _loc10_ = _loc19_ - _loc10_;
                                       if((_loc20_ = li32(_loc21_ + 36)) != 0)
                                       {
                                          _loc10_ = 0;
                                       }
                                       §§goto(addr1747);
                                    }
                                    §§goto(addr1839);
                                 }
                              }
                              _loc10_ = 0;
                           }
                           addr1839:
                           if((_loc19_ = (_loc20_ = _loc12_ << 24) >> 24) <= 63)
                           {
                              if((_loc10_ = li8(_loc9_ - 65)) != 0)
                              {
                                 si8(_loc10_,_loc15_ - 1);
                                 _loc15_ += -1;
                              }
                              else if(_loc1_ != 0)
                              {
                                 si8(_loc20_ = li8(_loc1_ + 1),_loc15_ - 1);
                                 si8(_loc20_ = li8(_loc1_),_loc15_ - 2);
                                 _loc15_ += -2;
                              }
                              _loc20_ = _loc16_ - _loc15_;
                              _loc10_ = li32(_loc21_ + 4);
                              _loc12_ = 0;
                              if(_loc10_ > _loc20_)
                              {
                                 _loc12_ = 0;
                                 if(li32(_loc21_ + 36) == 0)
                                 {
                                    _loc1_ = (_loc20_ = _loc10_ - _loc16_) + _loc15_;
                                    if((_loc20_ = (_loc20_ = _loc1_ << 24) >> 24) >= 1)
                                    {
                                       if(uint(_loc17_) < uint(_loc15_))
                                       {
                                          _loc17_ = (_loc20_ = _loc9_ - 64) - _loc15_;
                                          _loc12_ = (_loc20_ = (_loc20_ = (_loc20_ = (_loc20_ = _loc15_ + _loc10_) + -1) - _loc16_) ^ -1) | -256;
                                          _loc1_ = _loc17_;
                                          if(uint(_loc17_) <= uint(_loc12_))
                                          {
                                             _loc1_ = _loc12_;
                                          }
                                          _loc20_ = _loc16_ ^ -1;
                                          _loc12_ = (_loc20_ = (_loc10_ = (_loc20_ = _loc10_ + _loc20_) + _loc15_) ^ -1) | -256;
                                          if(uint(_loc17_) <= uint(_loc12_))
                                          {
                                             _loc17_ = _loc12_;
                                          }
                                          _loc12_ = 0 - _loc1_;
                                          _loc19_ = _loc17_ ^ 255;
                                          _loc1_ = _loc15_ + -1;
                                          do
                                          {
                                             si8(32,_loc1_);
                                             _loc1_ += -1;
                                          }
                                          while((_loc12_ += -1) != 0);
                                          
                                          _loc15_ += _loc17_;
                                          _loc1_ = _loc10_ - _loc19_;
                                       }
                                    }
                                    _loc20_ = _loc1_ & 255;
                                    _loc12_ = 0;
                                    if(_loc20_ != 0)
                                    {
                                       _loc4_ -= 16;
                                       si32(0,_loc4_ + 8);
                                       si32(_loc14_,_loc4_);
                                       si32(_loc20_ = (_loc20_ = _loc1_ << 24) >> 24,_loc4_ + 4);
                                       ESP = _loc4_;
                                       F___printf_pad();
                                       _loc4_ += 16;
                                       _loc12_ = eax;
                                    }
                                 }
                              }
                           }
                           else
                           {
                              _loc12_ = 0;
                              if(li32(_loc21_ + 36) == 0)
                              {
                                 _loc17_ = li32(_loc21_ + 4);
                                 _loc12_ = 0;
                                 if(_loc17_ > _loc19_)
                                 {
                                    _loc4_ -= 16;
                                    si32(0,_loc4_ + 8);
                                    si32(_loc14_,_loc4_);
                                    si32(_loc20_ = _loc17_ - _loc19_,_loc4_ + 4);
                                    ESP = _loc4_;
                                    F___printf_pad();
                                    _loc4_ += 16;
                                    _loc12_ = eax;
                                 }
                              }
                              if((_loc20_ = li8(_loc9_ - 65)) != 0)
                              {
                                 _loc17_ = 0;
                                 if(((_loc20_ = li8((_loc20_ = li32(_loc14_)) + 12)) & 64) == 0)
                                 {
                                    si32(_loc20_ = _loc9_ - 65,li32(_loc14_ + 80));
                                    si32(_loc17_ = 1,li32(_loc14_ + 80) + 4);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 12)) + 1,_loc14_ + 12);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 80)) + 8,_loc14_ + 80);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 8)) + 1,_loc14_ + 8);
                                    if(_loc20_ >= 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc14_ + 4,_loc4_ + 4);
                                       si32(li32(_loc14_),_loc4_);
                                       ESP = _loc4_;
                                       F___sfvwrite();
                                       _loc4_ += 16;
                                       si32(_loc20_ = _loc14_ + 16,_loc14_ + 80);
                                       si32(_loc20_,_loc14_ + 4);
                                       si32(0,_loc14_ + 12);
                                       si32(0,_loc14_ + 8);
                                       _loc17_ = 1;
                                    }
                                 }
                                 _loc12_ = _loc17_ + _loc12_;
                              }
                              else if(_loc1_ != 0)
                              {
                                 _loc17_ = 0;
                                 if(((_loc20_ = li8((_loc20_ = li32(_loc14_)) + 12)) & 64) == 0)
                                 {
                                    si32(_loc1_,li32(_loc14_ + 80));
                                    si32(_loc17_ = 2,li32(_loc14_ + 80) + 4);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 12)) + 2,_loc14_ + 12);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 80)) + 8,_loc14_ + 80);
                                    si32(_loc20_ = (_loc20_ = li32(_loc14_ + 8)) + 1,_loc14_ + 8);
                                    if(_loc20_ >= 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc20_ = _loc14_ + 4,_loc4_ + 4);
                                       si32(li32(_loc14_),_loc4_);
                                       ESP = _loc4_;
                                       F___sfvwrite();
                                       _loc4_ += 16;
                                       si32(_loc20_ = _loc14_ + 16,_loc14_ + 80);
                                       si32(_loc20_,_loc14_ + 4);
                                       si32(0,_loc14_ + 12);
                                       si32(0,_loc14_ + 8);
                                       _loc17_ = 2;
                                    }
                                 }
                                 _loc12_ = _loc17_ + _loc12_;
                              }
                              if(_loc10_ >= 1)
                              {
                                 _loc4_ -= 16;
                                 si32(1,_loc4_ + 8);
                                 si32(_loc10_,_loc4_ + 4);
                                 si32(_loc14_,_loc4_);
                                 ESP = _loc4_;
                                 F___printf_pad();
                                 _loc4_ += 16;
                                 _loc12_ = (_loc20_ = eax) + _loc12_;
                              }
                           }
                           _loc20_ = (_loc20_ = li16((_loc20_ = li32(_loc14_)) + 12)) & 64;
                           _loc17_ = 0;
                           if(_loc20_ == 0)
                           {
                              if(_loc16_ != _loc15_)
                              {
                                 _loc17_ = _loc16_ - _loc15_;
                                 si32(_loc15_,li32(_loc14_ + 80));
                                 si32(_loc17_,li32(_loc14_ + 80) + 4);
                                 si32(_loc20_ = (_loc20_ = li32(_loc14_ + 12)) + _loc17_,_loc14_ + 12);
                                 si32(_loc20_ = (_loc20_ = li32(_loc14_ + 80)) + 8,_loc14_ + 80);
                                 si32(_loc20_ = (_loc20_ = li32(_loc14_ + 8)) + 1,_loc14_ + 8);
                                 if(_loc20_ >= 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc20_ = _loc14_ + 4,_loc4_ + 4);
                                    si32(li32(_loc14_),_loc4_);
                                    ESP = _loc4_;
                                    F___sfvwrite();
                                    _loc4_ += 16;
                                    si32(_loc20_ = _loc14_ + 16,_loc14_ + 80);
                                    si32(_loc20_,_loc14_ + 4);
                                    si32(0,_loc14_ + 12);
                                    si32(0,_loc14_ + 8);
                                 }
                              }
                           }
                           _loc16_ = _loc17_ + _loc12_;
                           if((_loc15_ = li32(_loc21_ + 4)) > _loc16_)
                           {
                              if((_loc20_ = li32(_loc21_ + 36)) != 0)
                              {
                                 _loc4_ -= 16;
                                 si32(0,_loc4_ + 8);
                                 si32(_loc14_,_loc4_);
                                 si32(_loc20_ = _loc15_ - _loc16_,_loc4_ + 4);
                                 ESP = _loc4_;
                                 F___printf_pad();
                                 _loc4_ += 16;
                                 _loc16_ = (_loc20_ = eax) + _loc16_;
                              }
                           }
                           _loc3_ = li32(_loc14_);
                           _loc4_ -= 16;
                           si32(_loc20_ = _loc14_ + 4,_loc4_ + 4);
                           si32(_loc3_,_loc4_);
                           ESP = _loc4_;
                           F___sfvwrite();
                           _loc4_ += 16;
                           si32(_loc20_ = _loc14_ + 16,_loc14_ + 80);
                           si32(_loc20_,_loc14_ + 4);
                           si32(0,_loc14_ + 12);
                           si32(0,_loc14_ + 8);
                           eax = _loc16_;
                           ESP = _loc4_ = _loc9_;
                           return;
                        }
                     }
                  }
               }
               §§goto(addr340);
            }
            else
            {
               addr194:
               _loc10_ = 8;
               _loc11_ = ___lowercase_hex;
            }
         }
         else if(_loc1_ != 88)
         {
            if(_loc1_ != 100)
            {
            }
            §§goto(addr207);
         }
         else
         {
            _loc10_ = 16;
            _loc11_ = ___uppercase_hex;
            §§goto(addr200);
         }
         §§goto(addr200);
      }
      else
      {
         if(_loc1_ <= 116)
         {
            if(_loc1_ != 105)
            {
               if(_loc1_ != 111)
               {
                  §§goto(addr207);
               }
               else
               {
                  §§goto(addr194);
               }
            }
            §§goto(addr207);
         }
         else if(_loc1_ != 117)
         {
            _loc10_ = 16;
            _loc11_ = ___lowercase_hex;
            if(_loc1_ != 120)
            {
               §§goto(addr207);
            }
            else
            {
               §§goto(addr200);
            }
         }
         else
         {
            §§goto(addr187);
         }
         §§goto(addr187);
      }
   }
}
