package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2321;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str319;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str3322;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str4323;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str5324;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str6325;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str7326;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_2786;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ret_2E_1158;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___printf_render_float() : void
   {
      var _loc2_:* = 0;
      var _loc9_:* = 0;
      var _loc22_:* = 0;
      var _loc5_:* = NaN;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc24_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc17_:* = 0;
      var _loc25_:* = 0;
      var _loc20_:* = 0;
      var _loc16_:* = 0;
      var _loc7_:* = 0;
      var _loc23_:* = 0;
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc19_:* = 0;
      var _loc18_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc13_:* = 0;
      var _loc21_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 144;
      _loc25_ = li32(_loc9_ = li32(_loc2_ + 4));
      si8(0,_loc2_ - 41);
      si8(_loc24_ = li32(_loc9_ + 40),_loc2_ - 21);
      ESP = _loc1_;
      F_localeconv();
      si8(_loc24_ = li8(_loc24_ = li32(_ret_2E_1158 + 4)),_loc2_ - 43);
      _loc24_ = li32(_loc9_ + 28);
      _loc23_ = 0;
      if(_loc24_ != 0)
      {
         ESP = _loc1_;
         F_localeconv();
         _loc23_ = li32(_ret_2E_1158 + 8);
      }
      _loc22_ = li32(_loc2_ + 8);
      _loc21_ = li32(_loc2_);
      ESP = _loc1_;
      F_localeconv();
      _loc20_ = li32(_loc9_ + 8);
      _loc19_ = li32(_ret_2E_1158);
      if(_loc20_ <= 96)
      {
         if(_loc20_ <= 69)
         {
            if(_loc20_ != 65)
            {
               if(_loc20_ != 69)
               {
                  addr451:
                  _loc1_ -= 16;
                  si32(L__2E_str2321,_loc1_ + 12);
                  si32(242,_loc1_ + 8);
                  si32(L__2E_str319,_loc1_ + 4);
                  si32(___func___2E_2786,_loc1_);
                  ESP = _loc1_;
                  F___assert();
                  _loc1_ += 16;
                  addr486:
                  _loc14_ = 6;
                  if(_loc25_ >= 0)
                  {
                     _loc14_ = _loc25_;
                  }
                  var _loc15_:* = li32(_loc9_ + 12);
                  _loc5_ = lf64(_loc24_ = li32(_loc22_));
                  if(_loc15_ != 0)
                  {
                     sf64(_loc5_,_loc2_ - 40);
                     _loc1_ -= 32;
                     si32(_loc24_ = _loc2_ - 20,_loc1_ + 20);
                     si32(_loc24_ = _loc2_ - 16,_loc1_ + 16);
                     si32(_loc24_ = _loc2_ - 12,_loc1_ + 12);
                     si32(_loc14_,_loc1_ + 8);
                     _loc22_ = 3;
                     if((_loc18_ & 255) != 0)
                     {
                        _loc22_ = 2;
                     }
                     si32(_loc22_,_loc1_ + 4);
                     si32(_loc24_ = _loc2_ - 40,_loc1_);
                     ESP = _loc1_;
                     F___ldtoa();
                     _loc1_ += 32;
                     _loc22_ = eax;
                  }
                  else
                  {
                     _loc1_ -= 32;
                     si32(_loc24_ = _loc2_ - 20,_loc1_ + 24);
                     si32(_loc24_ = _loc2_ - 16,_loc1_ + 20);
                     si32(_loc24_ = _loc2_ - 12,_loc1_ + 16);
                     si32(_loc14_,_loc1_ + 12);
                     sf64(_loc5_,_loc1_);
                     _loc22_ = 3;
                     if((_loc18_ & 255) != 0)
                     {
                        _loc22_ = 2;
                     }
                     si32(_loc22_,_loc1_ + 8);
                     ESP = _loc1_;
                     F___dtoa();
                     _loc1_ += 32;
                     _loc22_ = eax;
                     if((_loc24_ = li32(_loc2_ - 12)) == 9999)
                     {
                        si32(2147483647,_loc2_ - 12);
                     }
                  }
               }
               else
               {
                  addr421:
                  _loc6_ = 7;
                  if(_loc25_ >= 0)
                  {
                     _loc6_ = _loc25_ + 1;
                  }
                  _loc18_ = _loc20_;
                  _loc25_ = _loc6_;
                  §§goto(addr486);
               }
               §§goto(addr486);
            }
            else
            {
               addr198:
               _loc18_ = 120;
               if(_loc20_ != 97)
               {
                  _loc18_ = 88;
               }
               si8(_loc18_,_loc2_ - 41);
               _loc6_ = ___lowercase_hex;
               if(_loc20_ != 97)
               {
                  _loc6_ = ___uppercase_hex;
               }
               _loc18_ = 112;
               if(_loc20_ != 97)
               {
                  _loc18_ = 80;
               }
               _loc14_ = (_loc24_ = (_loc24_ = _loc25_ >>> 31) ^ 1) + _loc25_;
               _loc15_ = li32(_loc9_ + 12);
               _loc5_ = lf64(_loc24_ = li32(_loc22_));
               if(_loc15_ != 0)
               {
                  sf64(_loc5_,_loc2_ - 40);
                  _loc1_ -= 32;
                  si32(_loc24_ = _loc2_ - 20,_loc1_ + 24);
                  si32(_loc24_ = _loc2_ - 16,_loc1_ + 20);
                  si32(_loc24_ = _loc2_ - 12,_loc1_ + 16);
                  si32(_loc14_,_loc1_ + 12);
                  si32(_loc6_,_loc1_ + 8);
                  sf64(_loc5_,_loc1_);
                  ESP = _loc1_;
                  F___hdtoa();
                  _loc1_ += 32;
                  _loc22_ = eax;
               }
               else
               {
                  _loc1_ -= 32;
                  si32(_loc24_ = _loc2_ - 20,_loc1_ + 24);
                  si32(_loc24_ = _loc2_ - 16,_loc1_ + 20);
                  si32(_loc24_ = _loc2_ - 12,_loc1_ + 16);
                  si32(_loc14_,_loc1_ + 12);
                  si32(_loc6_,_loc1_ + 8);
                  sf64(_loc5_,_loc1_);
                  ESP = _loc1_;
                  F___hdtoa();
                  _loc1_ += 32;
                  _loc22_ = eax;
               }
               if(_loc14_ <= -1)
               {
                  _loc14_ = (_loc24_ = li32(_loc2_ - 20)) - _loc22_;
               }
               if((_loc24_ = li32(_loc2_ - 12)) == 2147483647)
               {
                  si8(0,_loc2_ - 41);
               }
            }
            addr680:
            if((_loc24_ = li32(_loc2_ - 16)) != 0)
            {
               si8(45,_loc2_ - 21);
            }
            if((_loc6_ = li32(_loc2_ - 12)) == 2147483647)
            {
               _loc20_ = li32(_loc9_ + 8);
               if((_loc24_ = li8(_loc22_)) == 78)
               {
                  si8(0,_loc2_ - 21);
                  _loc25_ = L__2E_str3322;
                  if(_loc20_ <= 96)
                  {
                     _loc25_ = L__2E_str4323;
                  }
                  _loc16_ = 1;
                  _loc17_ = 3;
                  _loc10_ = _loc23_;
                  _loc20_ = _loc14_;
               }
               else
               {
                  _loc25_ = L__2E_str5324;
                  if(_loc20_ <= 96)
                  {
                     _loc25_ = L__2E_str6325;
                  }
                  _loc16_ = 1;
                  _loc17_ = 3;
                  _loc10_ = _loc23_;
                  _loc20_ = _loc14_;
               }
            }
            else
            {
               _loc11_ = (_loc24_ = li32(_loc2_ - 20)) - _loc22_;
               if((_loc24_ = (_loc24_ = li32(_loc9_ + 8)) | 32) == 103)
               {
                  _loc20_ = li32(_loc9_ + 28);
                  if(_loc6_ >= -3)
                  {
                     if(_loc6_ <= _loc14_)
                     {
                        _loc25_ = 0;
                        _loc18_ = _loc11_;
                        if(_loc20_ != _loc25_)
                        {
                           _loc18_ = _loc14_;
                        }
                        if((_loc20_ = _loc18_ - _loc6_) >= _loc25_)
                        {
                           _loc25_ = _loc20_;
                        }
                        _loc14_ = _loc25_;
                     }
                     else
                     {
                        addr822:
                        if(_loc20_ == 0)
                        {
                           _loc14_ = _loc11_;
                           addr829:
                           if((_loc24_ = _loc18_ & 255) != 0)
                           {
                              si8(_loc18_,_loc2_ - 29);
                              _loc25_ = _loc6_ + -1;
                              _loc20_ = 45;
                              _loc16_ = 0;
                              if(_loc25_ >= _loc16_)
                              {
                                 _loc20_ = 43;
                              }
                              si8(_loc20_,_loc2_ - 28);
                              _loc12_ = 1 - _loc6_;
                              if(_loc25_ >= _loc16_)
                              {
                                 _loc12_ = _loc25_;
                              }
                              _loc10_ = (_loc20_ = _loc2_ - 29) + 2;
                              if(_loc12_ >= 10)
                              {
                                 _loc25_ = (_loc13_ = _loc2_ - 6) + 6;
                                 _loc8_ = 0;
                                 do
                                 {
                                    _loc24_ = _loc12_;
                                    _loc17_ = _loc13_ - _loc8_;
                                    si8(_loc15_ = (_loc15_ = _loc24_ % 10) + 48,_loc17_ + 5);
                                    _loc8_ += 1;
                                    _loc12_ = _loc24_ / 10;
                                 }
                                 while(_loc24_ > 99);
                                 
                                 si8(_loc24_ = _loc12_ + 48,_loc17_ + 4);
                                 _loc12_ = (_loc24_ = _loc13_ - _loc8_) + 5;
                                 if(uint(_loc25_) > uint(_loc12_))
                                 {
                                    _loc1_ -= 16;
                                    si32(_loc10_,_loc1_);
                                    si32(_loc24_ = _loc8_ + 1,_loc1_ + 8);
                                    si32(_loc12_,_loc1_ + 4);
                                    _loc10_ = (_loc24_ = _loc20_ + _loc8_) + 3;
                                    ESP = _loc1_;
                                    Fmemcpy();
                                    _loc1_ += 16;
                                 }
                              }
                              else
                              {
                                 if((_loc24_ = (_loc24_ = (_loc24_ = _loc18_ << 24) >> 24) | 32) == 101)
                                 {
                                    si8(48,_loc2_ - 27);
                                    _loc10_ = _loc20_ + 3;
                                 }
                                 si8(_loc24_ = _loc12_ + 48,_loc10_);
                                 _loc10_ += 1;
                              }
                              _loc17_ = (_loc13_ = _loc10_ - _loc20_) + _loc14_;
                              if(_loc14_ <= 1)
                              {
                                 _loc10_ = _loc23_;
                                 _loc25_ = _loc22_;
                                 _loc20_ = _loc14_;
                                 if(li32(_loc9_ + 28) != 0)
                                 {
                                 }
                                 addr1243:
                                 _loc7_ = 1;
                                 _loc4_ = 0;
                                 _loc3_ = li8(_loc2_ - 21);
                                 if(_loc3_ == _loc4_)
                                 {
                                    _loc7_ = _loc4_;
                                 }
                                 _loc23_ = -1;
                                 if(_loc17_ >= _loc23_)
                                 {
                                    _loc23_ = _loc17_;
                                 }
                                 _loc23_ = (_loc24_ = _loc7_ & 1) + _loc23_;
                                 if((_loc24_ = li8(_loc2_ - 41)) != _loc4_)
                                 {
                                    _loc23_ += 2;
                                 }
                                 if((_loc24_ = li32(_loc9_ + 56)) != 48)
                                 {
                                    _loc4_ = 0;
                                    if(li32(_loc9_ + 36) == 0)
                                    {
                                       _loc1_ -= 16;
                                       si32(0,_loc1_ + 8);
                                       si32(_loc24_ = li32(_loc9_ + 4) - _loc23_,_loc1_ + 4);
                                       si32(_loc21_,_loc1_);
                                       ESP = _loc1_;
                                       F___printf_pad();
                                       _loc1_ += 16;
                                       _loc4_ = eax;
                                       _loc3_ = li8(_loc2_ - 21);
                                    }
                                 }
                                 if((_loc24_ = _loc3_ & 255) != 0)
                                 {
                                    _loc3_ = 0;
                                    if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                    {
                                       si32(_loc15_ = _loc2_ - 21,li32(_loc21_ + 80));
                                       _loc3_ = 1;
                                       si32(_loc3_,li32(_loc21_ + 80) + 4);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                       if(_loc24_ >= 8)
                                       {
                                          _loc1_ -= 16;
                                          si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                          si32(li32(_loc21_),_loc1_);
                                          ESP = _loc1_;
                                          F___sfvwrite();
                                          _loc1_ += 16;
                                          si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                          si32(_loc24_,_loc21_ + 4);
                                          si32(0,_loc21_ + 12);
                                          si32(0,_loc21_ + 8);
                                          _loc3_ = 1;
                                       }
                                    }
                                    _loc4_ = _loc3_ + _loc4_;
                                 }
                                 if((_loc24_ = li8(_loc2_ - 41)) != 0)
                                 {
                                    si8(48,_loc2_ - 42);
                                    _loc3_ = 0;
                                    if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                    {
                                       si32(_loc15_ = _loc2_ - 42,li32(_loc21_ + 80));
                                       _loc3_ = 2;
                                       si32(_loc3_,li32(_loc21_ + 80) + 4);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 2,_loc21_ + 12);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                       si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                       if(_loc24_ >= 8)
                                       {
                                          _loc1_ -= 16;
                                          si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                          si32(li32(_loc21_),_loc1_);
                                          ESP = _loc1_;
                                          F___sfvwrite();
                                          _loc1_ += 16;
                                          si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                          si32(_loc24_,_loc21_ + 4);
                                          si32(0,_loc21_ + 12);
                                          si32(0,_loc21_ + 8);
                                          _loc3_ = 2;
                                       }
                                    }
                                    _loc4_ = _loc3_ + _loc4_;
                                 }
                                 if((_loc24_ = li32(_loc9_ + 56)) == 48)
                                 {
                                    if((_loc24_ = li32(_loc9_ + 36)) == 0)
                                    {
                                       _loc1_ -= 16;
                                       si32(1,_loc1_ + 8);
                                       si32(_loc24_ = li32(_loc9_ + 4) - _loc23_,_loc1_ + 4);
                                       si32(_loc21_,_loc1_);
                                       ESP = _loc1_;
                                       F___printf_pad();
                                       _loc1_ += 16;
                                       _loc4_ = (_loc24_ = eax) + _loc4_;
                                    }
                                 }
                                 _loc1_ -= 16;
                                 si32(1,_loc1_ + 8);
                                 si32(_loc21_,_loc1_);
                                 si32(_loc24_ = _loc17_ ^ -1,_loc1_ + 4);
                                 ESP = _loc1_;
                                 F___printf_pad();
                                 _loc1_ += 16;
                                 _loc4_ = (_loc24_ = eax) + _loc4_;
                                 if(_loc16_ != 0)
                                 {
                                    _loc19_ = 0;
                                    if(((_loc24_ = li16((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                    {
                                       if(_loc17_ != 0)
                                       {
                                          si32(_loc25_,li32(_loc21_ + 80));
                                          si32(_loc17_,li32(_loc21_ + 80) + 4);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + _loc17_,_loc21_ + 12);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                          _loc19_ = _loc17_;
                                          if(_loc24_ >= 8)
                                          {
                                             _loc1_ -= 16;
                                             si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                             si32(li32(_loc21_),_loc1_);
                                             ESP = _loc1_;
                                             F___sfvwrite();
                                             _loc1_ += 16;
                                             si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                             si32(_loc24_,_loc21_ + 4);
                                             si32(0,_loc21_ + 12);
                                             si32(0,_loc21_ + 8);
                                             _loc19_ = _loc17_;
                                          }
                                       }
                                    }
                                    _loc19_ += _loc4_;
                                 }
                                 else if((_loc24_ = _loc18_ & 255) == 0)
                                 {
                                    if(_loc6_ <= 0)
                                    {
                                       _loc18_ = 0;
                                       if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                       {
                                          si32(L__2E_str7326,li32(_loc21_ + 80));
                                          si32(_loc18_ = 1,li32(_loc21_ + 80) + 4);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                          if(_loc24_ >= 8)
                                          {
                                             _loc1_ -= 16;
                                             si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                             si32(li32(_loc21_),_loc1_);
                                             ESP = _loc1_;
                                             F___sfvwrite();
                                             _loc1_ += 16;
                                             si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                             si32(_loc24_,_loc21_ + 4);
                                             si32(0,_loc21_ + 12);
                                             si32(0,_loc21_ + 8);
                                             _loc18_ = 1;
                                          }
                                       }
                                       _loc18_ += _loc4_;
                                       if(_loc20_ == 0)
                                       {
                                          if((_loc24_ = li32(_loc9_ + 28)) != 0)
                                          {
                                             addr2111:
                                             _loc24_ = (_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64;
                                             _loc11_ = 0;
                                             if(_loc24_ == 0)
                                             {
                                                si32(_loc19_,li32(_loc21_ + 80));
                                                si32(_loc11_ = 1,li32(_loc21_ + 80) + 4);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                                if(_loc24_ >= 8)
                                                {
                                                   _loc1_ -= 16;
                                                   si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                                   si32(li32(_loc21_),_loc1_);
                                                   ESP = _loc1_;
                                                   F___sfvwrite();
                                                   _loc1_ += 16;
                                                   si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                   si32(_loc24_,_loc21_ + 4);
                                                   si32(0,_loc21_ + 12);
                                                   si32(0,_loc21_ + 8);
                                                   _loc11_ = 1;
                                                }
                                             }
                                             _loc18_ = _loc11_ + _loc18_;
                                          }
                                          _loc1_ -= 16;
                                          si32(1,_loc1_ + 8);
                                          si32(_loc21_,_loc1_);
                                          si32(_loc24_ = 0 - _loc6_,_loc1_ + 4);
                                          _loc6_ += _loc20_;
                                          ESP = _loc1_;
                                          F___printf_pad();
                                          _loc1_ += 16;
                                          _loc18_ = (_loc24_ = eax) + _loc18_;
                                          §§goto(addr3177);
                                       }
                                       §§goto(addr2111);
                                    }
                                    else
                                    {
                                       _loc6_ = (_loc24_ = li32(_loc2_ - 20)) - _loc25_;
                                       _loc18_ = _loc8_;
                                       if(_loc6_ <= _loc8_)
                                       {
                                          _loc18_ = _loc6_;
                                       }
                                       if(_loc18_ >= 1)
                                       {
                                          _loc6_ = 0;
                                          if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                          {
                                             si32(_loc25_,li32(_loc21_ + 80));
                                             si32(_loc18_,li32(_loc21_ + 80) + 4);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + _loc18_,_loc21_ + 12);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                             _loc6_ = _loc18_;
                                             if(_loc24_ >= 8)
                                             {
                                                _loc1_ -= 16;
                                                si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                                si32(li32(_loc21_),_loc1_);
                                                ESP = _loc1_;
                                                F___sfvwrite();
                                                _loc1_ += 16;
                                                si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                si32(_loc24_,_loc21_ + 4);
                                                si32(0,_loc21_ + 12);
                                                si32(0,_loc21_ + 8);
                                                _loc6_ = _loc18_;
                                             }
                                          }
                                          _loc4_ = _loc6_ + _loc4_;
                                       }
                                       _loc1_ -= 16;
                                       si32(_loc6_ = 1,_loc1_ + 8);
                                       si32(_loc21_,_loc1_);
                                       _loc11_ = 0;
                                       if(_loc18_ >= _loc11_)
                                       {
                                          _loc11_ = _loc18_;
                                       }
                                       si32(_loc24_ = _loc8_ - _loc11_,_loc1_ + 4);
                                       _loc25_ += _loc8_;
                                       ESP = _loc1_;
                                       F___printf_pad();
                                       _loc1_ += 16;
                                       _loc18_ = (_loc24_ = eax) + _loc4_;
                                       if(_loc10_ != 0)
                                       {
                                          if(_loc12_ <= 0)
                                          {
                                             _loc6_ = 0;
                                          }
                                          if(_loc14_ <= 0)
                                          {
                                             if(_loc12_ >= 1)
                                             {
                                                addr2553:
                                                _loc16_ = _loc21_ + 16;
                                                _loc11_ = _loc21_ + 4;
                                                while(true)
                                                {
                                                   if(_loc6_ == 0)
                                                   {
                                                      _loc10_ += -1;
                                                   }
                                                   _loc24_ = (_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64;
                                                   _loc4_ = 0;
                                                   if(_loc24_ == 0)
                                                   {
                                                      si32(_loc24_ = _loc2_ - 43,li32(_loc21_ + 80));
                                                      si32(_loc4_ = 1,li32(_loc21_ + 80) + 4);
                                                      si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                                      si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                                      si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                                      if(_loc24_ >= 8)
                                                      {
                                                         _loc1_ -= 16;
                                                         si32(_loc11_,_loc1_ + 4);
                                                         si32(li32(_loc21_),_loc1_);
                                                         ESP = _loc1_;
                                                         F___sfvwrite();
                                                         _loc1_ += 16;
                                                         si32(_loc16_,_loc21_ + 80);
                                                         si32(_loc16_,_loc21_ + 4);
                                                         si32(0,_loc21_ + 12);
                                                         si32(0,_loc21_ + 8);
                                                         _loc4_ = 1;
                                                      }
                                                   }
                                                   _loc17_ = (_loc24_ = li32(_loc2_ - 20)) - _loc25_;
                                                   _loc8_ = _loc13_ = si8(li8(_loc10_));
                                                   if(_loc13_ >= _loc17_)
                                                   {
                                                      _loc8_ = _loc17_;
                                                   }
                                                   _loc18_ = _loc4_ + _loc18_;
                                                   if(_loc8_ >= 1)
                                                   {
                                                      _loc13_ = 0;
                                                      if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                                      {
                                                         si32(_loc25_,li32(_loc21_ + 80));
                                                         si32(_loc8_,li32(_loc21_ + 80) + 4);
                                                         si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + _loc8_,_loc21_ + 12);
                                                         si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                                         si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                                         _loc13_ = _loc8_;
                                                         if(_loc24_ >= 8)
                                                         {
                                                            _loc1_ -= 16;
                                                            si32(_loc11_,_loc1_ + 4);
                                                            si32(li32(_loc21_),_loc1_);
                                                            ESP = _loc1_;
                                                            F___sfvwrite();
                                                            _loc1_ += 16;
                                                            si32(_loc16_,_loc21_ + 80);
                                                            si32(_loc16_,_loc21_ + 4);
                                                            si32(0,_loc21_ + 12);
                                                            si32(0,_loc21_ + 8);
                                                            _loc13_ = _loc8_;
                                                         }
                                                      }
                                                      _loc18_ = _loc13_ + _loc18_;
                                                      _loc13_ = li8(_loc10_);
                                                   }
                                                   _loc1_ -= 16;
                                                   si32(_loc21_,_loc1_);
                                                   _loc17_ = 0;
                                                   if(_loc8_ >= 0)
                                                   {
                                                      _loc17_ = _loc8_;
                                                   }
                                                   _loc24_ = (_loc24_ = _loc6_ << 31) >> 31;
                                                   _loc12_ += _loc24_;
                                                   si32(_loc24_ = (_loc24_ = (_loc24_ = _loc13_ << 24) >> 24) - _loc17_,_loc1_ + 4);
                                                   si32(_loc8_ = 1,_loc1_ + 8);
                                                   if(_loc12_ <= 0)
                                                   {
                                                      _loc8_ = 0;
                                                   }
                                                   _loc24_ = (_loc24_ = (_loc24_ = _loc6_ ^ -1) << 31) >> 31;
                                                   _loc14_ += _loc24_;
                                                   ESP = _loc1_;
                                                   F___printf_pad();
                                                   _loc1_ += 16;
                                                   _loc18_ = (_loc24_ = eax) + _loc18_;
                                                   _loc24_ = si8(li8(_loc10_));
                                                   _loc25_ += _loc24_;
                                                   _loc6_ = _loc8_;
                                                   if(_loc14_ <= 0)
                                                   {
                                                      _loc6_ = _loc8_;
                                                      if(_loc12_ <= 0)
                                                      {
                                                         break;
                                                      }
                                                   }
                                                }
                                             }
                                             _loc6_ = li32(_loc2_ - 20);
                                             if(uint(_loc25_) > uint(_loc6_))
                                             {
                                                _loc25_ = _loc6_;
                                             }
                                             §§goto(addr3013);
                                          }
                                          §§goto(addr2553);
                                       }
                                       addr3013:
                                       if(_loc20_ == 0)
                                       {
                                          _loc6_ = 0;
                                          if(li32(_loc9_ + 28) != 0)
                                          {
                                          }
                                          §§goto(addr3177);
                                       }
                                       _loc24_ = (_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64;
                                       _loc6_ = 0;
                                       if(_loc24_ == 0)
                                       {
                                          si32(_loc19_,li32(_loc21_ + 80));
                                          si32(_loc6_ = 1,li32(_loc21_ + 80) + 4);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                          si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                          if(_loc24_ >= 8)
                                          {
                                             _loc1_ -= 16;
                                             si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                             si32(li32(_loc21_),_loc1_);
                                             ESP = _loc1_;
                                             F___sfvwrite();
                                             _loc1_ += 16;
                                             si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                             si32(_loc24_,_loc21_ + 4);
                                             si32(0,_loc21_ + 12);
                                             si32(0,_loc21_ + 8);
                                             _loc6_ = 1;
                                          }
                                       }
                                       _loc18_ = _loc6_ + _loc18_;
                                       _loc6_ = _loc20_;
                                       §§goto(addr3177);
                                    }
                                    _loc25_ = 0;
                                    if(_loc19_ >= _loc25_)
                                    {
                                       _loc25_ = _loc19_;
                                    }
                                    si32(_loc24_ = _loc6_ - _loc25_,_loc1_ + 4);
                                    ESP = _loc1_;
                                    F___printf_pad();
                                    _loc1_ += 16;
                                    _loc19_ = (_loc24_ = eax) + _loc18_;
                                    §§goto(addr4088);
                                 }
                                 else
                                 {
                                    if(_loc20_ <= 1)
                                    {
                                       if((_loc24_ = li32(_loc9_ + 28)) != 0)
                                       {
                                          addr3411:
                                          si8(_loc24_ = li8(_loc25_),_loc2_ - 143);
                                          si8(_loc24_ = li8(_loc19_),_loc2_ - 142);
                                          _loc24_ = (_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64;
                                          _loc18_ = _loc19_ = 0;
                                          if(_loc24_ == 0)
                                          {
                                             si32(_loc24_ = _loc2_ - 143,li32(_loc21_ + 80));
                                             si32(_loc18_ = 2,li32(_loc21_ + 80) + 4);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 2,_loc21_ + 12);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                             if(_loc24_ >= 8)
                                             {
                                                _loc1_ -= 16;
                                                si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                                si32(li32(_loc21_),_loc1_);
                                                ESP = _loc1_;
                                                F___sfvwrite();
                                                _loc1_ += 16;
                                                si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                si32(_loc24_,_loc21_ + 4);
                                                si32(0,_loc21_ + 12);
                                                si32(0,_loc21_ + 8);
                                                _loc18_ = 2;
                                             }
                                          }
                                          if((_loc24_ = (_loc24_ = li16((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                          {
                                             if((_loc6_ = _loc11_ + -1) != 0)
                                             {
                                                si32(_loc25_ + 1,li32(_loc21_ + 80));
                                                si32(_loc6_,li32(_loc21_ + 80) + 4);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + _loc6_,_loc21_ + 12);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                                si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                                _loc19_ = _loc6_;
                                                if(_loc24_ >= 8)
                                                {
                                                   _loc1_ -= 16;
                                                   si32(_loc24_ = _loc21_ + 4,_loc1_ + 4);
                                                   si32(li32(_loc21_),_loc1_);
                                                   ESP = _loc1_;
                                                   F___sfvwrite();
                                                   _loc1_ += 16;
                                                   si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                   si32(_loc24_,_loc21_ + 4);
                                                   si32(0,_loc21_ + 12);
                                                   si32(0,_loc21_ + 8);
                                                   _loc19_ = _loc6_;
                                                }
                                             }
                                          }
                                          _loc1_ -= 16;
                                          si32(1,_loc1_ + 8);
                                          si32(_loc21_,_loc1_);
                                          si32(_loc24_ = _loc20_ - _loc11_,_loc1_ + 4);
                                          _loc15_ = (_loc24_ = _loc18_ + _loc4_) + _loc19_;
                                          ESP = _loc1_;
                                          F___printf_pad();
                                          _loc1_ += 16;
                                          _loc24_ = eax;
                                          _loc25_ = _loc15_ + _loc24_;
                                       }
                                       else
                                       {
                                          _loc19_ = 0;
                                          if(((_loc24_ = li8((_loc24_ = li32(_loc21_)) + 12)) & 64) == 0)
                                          {
                                             si32(_loc25_,li32(_loc21_ + 80));
                                             si32(1,li32(_loc21_ + 80) + 4);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + 1,_loc21_ + 12);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                             _loc19_ = 1;
                                             if(_loc24_ >= 8)
                                             {
                                                _loc1_ -= 16;
                                                si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                                si32(li32(_loc21_),_loc1_);
                                                ESP = _loc1_;
                                                F___sfvwrite();
                                                _loc1_ += 16;
                                                si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                si32(_loc24_,_loc21_ + 4);
                                                si32(0,_loc21_ + 12);
                                                si32(0,_loc21_ + 8);
                                                _loc19_ = 1;
                                             }
                                          }
                                          _loc25_ = _loc19_ + _loc4_;
                                       }
                                       _loc24_ = (_loc24_ = li16((_loc24_ = li32(_loc21_)) + 12)) & 64;
                                       _loc19_ = 0;
                                       if(_loc24_ == 0)
                                       {
                                          if(_loc13_ != 0)
                                          {
                                             si32(_loc24_ = _loc2_ - 29,li32(_loc21_ + 80));
                                             si32(_loc13_,li32(_loc21_ + 80) + 4);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 12)) + _loc13_,_loc21_ + 12);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 80)) + 8,_loc21_ + 80);
                                             si32(_loc24_ = (_loc24_ = li32(_loc21_ + 8)) + 1,_loc21_ + 8);
                                             _loc19_ = _loc13_;
                                             if(_loc24_ >= 8)
                                             {
                                                _loc1_ -= 16;
                                                si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                                si32(li32(_loc21_),_loc1_);
                                                ESP = _loc1_;
                                                F___sfvwrite();
                                                _loc1_ += 16;
                                                si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                                si32(_loc24_,_loc21_ + 4);
                                                si32(0,_loc21_ + 12);
                                                si32(0,_loc21_ + 8);
                                                _loc19_ = _loc13_;
                                             }
                                          }
                                       }
                                       _loc19_ += _loc25_;
                                       addr4088:
                                       if((_loc24_ = li32(_loc9_ + 36)) != 0)
                                       {
                                          _loc1_ -= 16;
                                          si32(0,_loc1_ + 8);
                                          si32(_loc24_ = li32(_loc9_ + 4) - _loc23_,_loc1_ + 4);
                                          si32(_loc21_,_loc1_);
                                          ESP = _loc1_;
                                          F___printf_pad();
                                          _loc1_ += 16;
                                          _loc19_ = (_loc24_ = eax) + _loc19_;
                                       }
                                       _loc24_ = li32(_loc21_);
                                       _loc1_ -= 16;
                                       si32(_loc15_ = _loc21_ + 4,_loc1_ + 4);
                                       si32(_loc24_,_loc1_);
                                       ESP = _loc1_;
                                       F___sfvwrite();
                                       _loc1_ += 16;
                                       si32(_loc24_ = _loc21_ + 16,_loc21_ + 80);
                                       si32(_loc24_,_loc21_ + 4);
                                       si32(0,_loc21_ + 12);
                                       si32(0,_loc21_ + 8);
                                       if(_loc22_ != 0)
                                       {
                                          si32(_loc21_ = li32(_loc22_ - 4),_loc22_);
                                          si32(_loc24_ = 1 << _loc21_,_loc22_ + 4);
                                          if((_loc9_ = _loc22_ + -4) != 0)
                                          {
                                             if(_loc21_ >= 10)
                                             {
                                                _loc1_ -= 16;
                                                si32(_loc9_,_loc1_);
                                                ESP = _loc1_;
                                                F_idalloc();
                                                _loc1_ += 16;
                                             }
                                             else
                                             {
                                                if((_loc24_ = li32(___isthreaded)) != 0)
                                                {
                                                   _loc1_ -= 16;
                                                   si32(___gdtoa_locks,_loc1_);
                                                   ESP = _loc1_;
                                                   F__pthread_mutex_lock();
                                                   _loc1_ += 16;
                                                   _loc21_ = li32(_loc22_);
                                                }
                                                _loc24_ = _loc21_ << 2;
                                                si32(_loc15_ = li32(_loc24_ = _freelist + _loc24_),_loc9_);
                                                si32(_loc9_,_loc24_);
                                                if((_loc24_ = li32(___isthreaded)) != 0)
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
                                       eax = _loc19_;
                                       _loc1_ = _loc2_;
                                       ESP = _loc1_;
                                       return;
                                    }
                                    §§goto(addr3411);
                                 }
                                 §§goto(addr3177);
                              }
                              _loc17_ += 1;
                              _loc16_ = 0;
                              _loc10_ = _loc23_;
                              _loc25_ = _loc22_;
                              _loc20_ = _loc14_;
                           }
                           §§goto(addr1243);
                        }
                        §§goto(addr829);
                     }
                     _loc17_ = 1;
                     if(_loc6_ >= _loc17_)
                     {
                        _loc17_ = _loc6_;
                     }
                     if(_loc14_ == 0)
                     {
                        _loc20_ = 0;
                        if(li32(_loc9_ + 28) != 0)
                        {
                           addr1112:
                           _loc17_ = (_loc24_ = _loc17_ + _loc14_) + 1;
                           _loc20_ = _loc14_;
                        }
                        _loc10_ = 0;
                        _loc8_ = _loc6_;
                        _loc25_ = _loc22_;
                        _loc18_ = _loc10_;
                        _loc16_ = _loc10_;
                        if(_loc23_ != 0)
                        {
                           _loc18_ = 0;
                           _loc8_ = _loc6_;
                           _loc10_ = _loc23_;
                           _loc25_ = _loc22_;
                           _loc16_ = _loc18_;
                           if(_loc6_ >= 1)
                           {
                              _loc18_ = li8(_loc23_);
                              _loc12_ = 0;
                              _loc8_ = _loc6_;
                              _loc14_ = _loc12_;
                              loop0:
                              while(true)
                              {
                                 _loc10_ = _loc23_ + _loc14_;
                                 if((_loc24_ = _loc18_ & 255) != 127)
                                 {
                                    _loc25_ = _loc14_ + 1;
                                    _loc16_ = (_loc24_ = _loc18_ << 24) >> 24;
                                    while(_loc16_ < _loc8_)
                                    {
                                       if((_loc18_ = li8(_loc10_ + 1)) != 0)
                                       {
                                          continue loop0;
                                       }
                                       _loc8_ -= _loc16_;
                                       _loc12_ += 1;
                                    }
                                    break;
                                 }
                                 break;
                              }
                              _loc17_ = (_loc24_ = _loc12_ + _loc17_) + _loc14_;
                              _loc18_ = 0;
                              _loc25_ = _loc22_;
                              _loc16_ = _loc18_;
                           }
                        }
                        §§goto(addr1243);
                     }
                     §§goto(addr1112);
                  }
                  §§goto(addr822);
               }
               §§goto(addr829);
            }
            §§goto(addr1243);
         }
         else
         {
            _loc18_ = 0;
            if(_loc20_ != 70)
            {
               if(_loc20_ != 71)
               {
                  §§goto(addr451);
               }
               else
               {
                  addr438:
                  _loc18_ = _loc20_ + -2;
                  if(_loc25_ == 0)
                  {
                     _loc25_ = 1;
                  }
               }
            }
         }
      }
      else if(_loc20_ <= 101)
      {
         if(_loc20_ != 97)
         {
            if(_loc20_ != 101)
            {
               §§goto(addr451);
            }
            else
            {
               §§goto(addr421);
            }
         }
         else
         {
            §§goto(addr198);
         }
         §§goto(addr680);
      }
      else
      {
         _loc18_ = 0;
         if(_loc20_ != 102)
         {
            if(_loc20_ != 103)
            {
               §§goto(addr451);
            }
            else
            {
               §§goto(addr438);
            }
         }
      }
      §§goto(addr451);
   }
}
