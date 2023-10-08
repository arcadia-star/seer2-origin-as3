package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_load_msgcat;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1200;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str199;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2201;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str3202;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str4203;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str5204;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_catopen() : void
   {
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc19_:* = 0;
      var _loc18_:* = 0;
      var _loc20_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc1_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc16_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc3_:* = ESP;
      _loc8_ = _loc3_;
      _loc3_ -= 1120;
      if((_loc4_ = li32(_loc8_)) != 0)
      {
         if((_loc20_ = li8(_loc4_)) != 0)
         {
            _loc19_ = li32(_loc8_ + 4);
            _loc18_ = _loc4_ + 1;
            while((_loc20_ &= 255) != 0)
            {
               if(_loc20_ == 47)
               {
                  if(_loc18_ != 1)
                  {
                     _loc3_ -= 16;
                     si32(_loc4_,_loc3_);
                     ESP = _loc3_;
                     F_load_msgcat();
                     _loc3_ += 16;
                     _loc16_ = eax;
                     §§goto(addr1486);
                  }
                  break;
               }
               _loc20_ = li8(_loc18_);
               _loc18_ += 1;
            }
            if(_loc19_ == 1)
            {
               _loc3_ -= 16;
               si32(0,_loc3_ + 4);
               si32(6,_loc3_);
               ESP = _loc3_;
               F_setlocale();
               _loc3_ += 16;
               _loc19_ = eax;
            }
            else
            {
               _loc3_ -= 16;
               si32(L__2E_str199,_loc3_);
               ESP = _loc3_;
               F_getenv();
               _loc3_ += 16;
               _loc19_ = eax;
            }
            if(_loc19_ != 0)
            {
               if((_loc18_ = li8(_loc19_)) != 0)
               {
                  var _loc17_:*;
                  var _loc15_:*;
                  if((_loc17_ = (_loc15_ = (_loc15_ &= -2139062144) ^ -2139062144) & (_loc15_ = li32(_loc20_ = _loc19_ & -4)) + -16843009) != 0)
                  {
                     _loc14_ = _loc20_ + 4;
                     _loc16_ = 0;
                     while(true)
                     {
                        if((uint(_loc13_ = _loc19_ + _loc16_)) < uint(_loc14_))
                        {
                           continue;
                        }
                     }
                     §§goto(addr383);
                  }
                  _loc16_ = _loc20_ + 4;
                  while(true)
                  {
                     _loc17_ = (_loc20_ = li32(_loc16_)) + -16843009;
                     if((_loc17_ = (_loc15_ = (_loc15_ = _loc20_ & -2139062144) ^ -2139062144) & _loc17_) == 0)
                     {
                        continue;
                     }
                     if((_loc17_ = _loc20_ & 255) == 0)
                     {
                        _loc16_ -= _loc19_;
                     }
                     else if((_loc17_ = li8(_loc16_ + 1)) == 0)
                     {
                        _loc16_ = (_loc17_ = 1 - _loc19_) + _loc16_;
                     }
                     else if((_loc17_ = li8(_loc16_ + 2)) == 0)
                     {
                        _loc16_ = (_loc17_ = 2 - _loc19_) + _loc16_;
                     }
                     else
                     {
                        if((_loc17_ = li8(_loc16_ + 3)) != 0)
                        {
                           continue;
                        }
                        _loc16_ = (_loc17_ = 3 - _loc19_) + _loc16_;
                     }
                     addr383:
                     if(uint(_loc16_) <= 31)
                     {
                        _loc20_ = _loc18_;
                        if(_loc18_ == 46)
                        {
                           if((_loc16_ = li8(_loc19_ + 1)) != 0)
                           {
                              _loc20_ = 46;
                              if(_loc16_ == 46)
                              {
                                 _loc20_ = _loc18_;
                                 if(li8(_loc19_ + 2) != 0)
                                 {
                                 }
                                 §§goto(addr450);
                              }
                           }
                           §§goto(addr450);
                        }
                        _loc18_ = _loc19_ + 1;
                        while((_loc20_ &= 255) != 0)
                        {
                           if(_loc20_ == 47)
                           {
                              if(_loc18_ != 1)
                              {
                                 §§goto(addr450);
                              }
                              break;
                           }
                           _loc20_ = li8(_loc18_);
                           _loc18_ += 1;
                        }
                     }
                     §§goto(addr450);
                  }
               }
            }
            addr450:
            _loc19_ = L__2E_str1200;
            _loc3_ -= 16;
            si32(_loc19_,_loc3_);
            ESP = _loc3_;
            F_strdup();
            _loc16_ = -1;
            _loc3_ += 16;
            _loc20_ = _loc18_ = eax;
            if(_loc18_ != 0)
            {
               while(true)
               {
                  _loc13_ = li8(_loc20_);
                  _loc16_ = _loc18_;
                  if(_loc13_ == 0)
                  {
                     break;
                  }
                  if(_loc13_ == 64)
                  {
                     _loc16_ = _loc18_;
                     if(_loc20_ != 0)
                     {
                        si8(0,_loc20_);
                        _loc16_ = _loc18_;
                        break;
                     }
                     break;
                  }
                  _loc20_ += 1;
               }
               while(true)
               {
                  _loc14_ = li8(_loc16_);
                  _loc20_ = L__2E_str2201;
                  _loc13_ = _loc18_;
                  if(_loc14_ == 0)
                  {
                     break;
                  }
                  if(_loc14_ == 95)
                  {
                     _loc20_ = L__2E_str2201;
                     _loc13_ = _loc18_;
                     if(_loc16_ != 0)
                     {
                        si8(0,_loc16_);
                        _loc20_ = _loc13_ = _loc16_ + 1;
                        break;
                     }
                     break;
                  }
                  _loc16_ += 1;
               }
               while(true)
               {
                  _loc14_ = li8(_loc13_);
                  _loc16_ = L__2E_str2201;
                  if(_loc14_ == 0)
                  {
                     break;
                  }
                  if(_loc14_ == 46)
                  {
                     _loc16_ = L__2E_str2201;
                     if(_loc13_ != 0)
                     {
                        si8(0,_loc13_);
                        _loc16_ = _loc13_ + 1;
                        break;
                     }
                     break;
                  }
                  _loc13_ += 1;
               }
               _loc3_ -= 16;
               si32(L__2E_str3202,_loc3_);
               ESP = _loc3_;
               F_getenv();
               _loc14_ = L__2E_str4203;
               _loc3_ += 16;
               if((_loc13_ = eax) != 0)
               {
                  _loc14_ = _loc13_;
               }
               _loc3_ -= 16;
               si32(_loc14_,_loc3_);
               ESP = _loc3_;
               F_strdup();
               _loc3_ += 16;
               _loc1_ = eax;
               if(_loc1_ != 0)
               {
                  _loc13_ = (_loc14_ = _loc8_ - 1024) + 1022;
                  _loc9_ = _loc1_;
                  loop6:
                  while(true)
                  {
                     if(_loc9_ == 0)
                     {
                        if(_loc18_ != 0)
                        {
                           _loc3_ -= 16;
                           si32(_loc18_,_loc3_);
                           ESP = _loc3_;
                           F_idalloc();
                           _loc3_ += 16;
                        }
                        if(_loc1_ != 0)
                        {
                           _loc3_ -= 16;
                           si32(_loc1_,_loc3_);
                           ESP = _loc3_;
                           F_idalloc();
                           _loc3_ += 16;
                        }
                        ESP = _loc3_;
                        F___error();
                        _loc17_ = eax;
                        si32(2,_loc17_);
                        _loc16_ = -1;
                        break;
                     }
                     _loc11_ = _loc9_ + 1;
                     loop7:
                     while(true)
                     {
                        _loc10_ = li8(_loc11_ - 1);
                        _loc7_ = 2;
                        while(true)
                        {
                           _loc17_ = li8((_loc17_ = L__2E_str5204 - _loc7_) + 2);
                           _loc2_ = _loc10_ & 255;
                           if(_loc17_ == _loc2_)
                           {
                              break;
                           }
                           if((_loc7_ += -1) != 0)
                           {
                              continue;
                           }
                           continue loop7;
                        }
                        _loc7_ = 0;
                        if(_loc2_ != 0)
                        {
                           si8(0,_loc11_ - 1);
                           _loc7_ = _loc11_;
                        }
                        _loc10_ = li8(_loc9_);
                        _loc11_ = _loc14_;
                        if(_loc10_ != 0)
                        {
                           loop9:
                           while(true)
                           {
                              _loc2_ = _loc10_ & 255;
                              if(_loc2_ != 37)
                              {
                                 if(_loc2_ == 0)
                                 {
                                    si8(0,_loc11_);
                                    _loc3_ -= 16;
                                    si32(_loc17_ = _loc8_ - 1120,_loc3_ + 4);
                                    si32(_loc11_ = _loc8_ - 1024,_loc3_);
                                    ESP = _loc3_;
                                    F_stat();
                                    _loc3_ += 16;
                                    _loc9_ = _loc7_;
                                    if(eax == 0)
                                    {
                                       if(_loc18_ != 0)
                                       {
                                          _loc3_ -= 16;
                                          si32(_loc18_,_loc3_);
                                          ESP = _loc3_;
                                          F_idalloc();
                                          _loc3_ += 16;
                                       }
                                       if(_loc1_ != 0)
                                       {
                                          _loc3_ -= 16;
                                          si32(_loc1_,_loc3_);
                                          ESP = _loc3_;
                                          F_idalloc();
                                          _loc3_ += 16;
                                       }
                                       _loc3_ -= 16;
                                       si32(_loc11_,_loc3_);
                                       ESP = _loc3_;
                                       F_load_msgcat();
                                       _loc3_ += 16;
                                       _loc16_ = eax;
                                       break loop6;
                                    }
                                    continue loop6;
                                 }
                                 if((uint(_loc17_ = _loc11_ - (_loc8_ - 1024))) > 1022)
                                 {
                                    break;
                                 }
                                 si8(_loc10_,_loc11_);
                                 _loc11_ += 1;
                                 _loc2_ = _loc9_;
                                 continue;
                              }
                              _loc12_ = si8(li8(_loc9_ + 1));
                              _loc2_ = _loc9_ + 1;
                              if(_loc12_ <= 98)
                              {
                                 if(_loc12_ != 37)
                                 {
                                    if(_loc12_ != 76)
                                    {
                                       if(_loc12_ == 78)
                                       {
                                          _loc10_ = _loc4_;
                                          addr825:
                                          while(true)
                                          {
                                             _loc12_ = (_loc17_ = (_loc17_ = _loc8_ - 1024) - _loc11_) + 1023;
                                             _loc5_ = _loc10_;
                                             if(_loc12_ != 0)
                                             {
                                                _loc5_ = _loc13_ - _loc11_;
                                                _loc9_ = _loc11_;
                                                _loc6_ = _loc10_;
                                                do
                                                {
                                                   if(_loc5_ != 0)
                                                   {
                                                      continue;
                                                   }
                                                   _loc5_ = _loc6_;
                                                   if(_loc12_ != 0)
                                                   {
                                                      si8(0,_loc9_);
                                                      _loc5_ = _loc6_;
                                                   }
                                                }
                                                while(si8(_loc17_ = li8(_loc6_),_loc9_), _loc9_ += 1, _loc6_ += 1, _loc5_ += -1, _loc17_ != 0);
                                                
                                                addr912:
                                                _loc17_ = _loc10_ ^ -1;
                                                if((uint(_loc17_ = _loc6_ + _loc17_)) >= uint(_loc12_))
                                                {
                                                   break loop9;
                                                }
                                                if((_loc17_ = (_loc15_ = (_loc15_ &= -2139062144) ^ -2139062144) & (_loc15_ = li32(_loc6_ = _loc10_ & -4)) + -16843009) != 0)
                                                {
                                                   _loc12_ = _loc6_ + 4;
                                                   _loc5_ = 0;
                                                   while(true)
                                                   {
                                                      if((uint(_loc9_ = _loc10_ + _loc5_)) < uint(_loc12_))
                                                      {
                                                         continue;
                                                      }
                                                   }
                                                   addr1168:
                                                   _loc11_ += _loc5_;
                                                   continue loop9;
                                                }
                                                _loc12_ = _loc6_ + 4;
                                                while(true)
                                                {
                                                   _loc17_ = (_loc9_ = li32(_loc12_)) + -16843009;
                                                   if((_loc17_ = (_loc15_ = (_loc15_ = _loc9_ & -2139062144) ^ -2139062144) & _loc17_) == 0)
                                                   {
                                                      continue;
                                                   }
                                                   if((_loc17_ = _loc9_ & 255) == 0)
                                                   {
                                                      _loc5_ = _loc12_ - _loc10_;
                                                   }
                                                   else if((_loc17_ = li8(_loc12_ + 1)) == 0)
                                                   {
                                                      _loc5_ = (_loc17_ = 1 - _loc10_) + _loc12_;
                                                   }
                                                   else if((_loc17_ = li8(_loc12_ + 2)) == 0)
                                                   {
                                                      _loc5_ = (_loc17_ = 2 - _loc10_) + _loc12_;
                                                   }
                                                   else
                                                   {
                                                      if((_loc17_ = li8(_loc12_ + 3)) != 0)
                                                      {
                                                         continue;
                                                      }
                                                      _loc5_ = (_loc17_ = 3 - _loc10_) + _loc12_;
                                                   }
                                                   §§goto(addr1168);
                                                }
                                             }
                                             while(true)
                                             {
                                                _loc6_ = _loc5_ + 1;
                                                _loc17_ = li8(_loc5_);
                                                _loc5_ = _loc6_;
                                                if(_loc17_ != 0)
                                                {
                                                   continue;
                                                }
                                                §§goto(addr912);
                                             }
                                          }
                                          addr825:
                                       }
                                    }
                                    else
                                    {
                                       _loc10_ = _loc19_;
                                       §§goto(addr825);
                                    }
                                    §§goto(addr825);
                                 }
                                 else
                                 {
                                    _loc9_ = _loc2_;
                                 }
                                 addr795:
                                 _loc17_ = _loc8_ - 1024;
                                 if((uint(_loc17_ = _loc11_ - _loc17_)) > 1022)
                                 {
                                    break;
                                 }
                                 si8(_loc17_ = li8(_loc9_),_loc11_);
                                 _loc11_ += 1;
                                 _loc2_ = _loc9_;
                                 continue;
                              }
                              if(_loc12_ != 99)
                              {
                                 _loc10_ = _loc18_;
                                 if(_loc12_ != 108)
                                 {
                                    if(_loc12_ == 116)
                                    {
                                       _loc10_ = _loc20_;
                                    }
                                    else
                                    {
                                       §§goto(addr795);
                                    }
                                 }
                              }
                              else
                              {
                                 _loc10_ = _loc16_;
                              }
                           }
                           if(_loc18_ != 0)
                           {
                              _loc3_ -= 16;
                              si32(_loc18_,_loc3_);
                              ESP = _loc3_;
                              F_idalloc();
                              _loc3_ += 16;
                           }
                           if(_loc1_ != 0)
                           {
                              _loc3_ -= 16;
                              si32(_loc1_,_loc3_);
                              ESP = _loc3_;
                              F_idalloc();
                              _loc3_ += 16;
                           }
                           ESP = _loc3_;
                           F___error();
                           _loc17_ = eax;
                           si32(63,_loc17_);
                           _loc16_ = -1;
                           break loop6;
                        }
                        _loc2_ = _loc9_ + -1;
                        _loc11_ = _loc8_ - 1024;
                        _loc10_ = _loc4_;
                        §§goto(addr825);
                     }
                  }
               }
               else
               {
                  ESP = _loc3_;
                  F___error();
                  _loc4_ = li32(_loc17_ = eax);
                  if(_loc18_ != 0)
                  {
                     _loc3_ -= 16;
                     si32(_loc18_,_loc3_);
                     ESP = _loc3_;
                     F_idalloc();
                     _loc3_ += 16;
                  }
                  ESP = _loc3_;
                  F___error();
                  _loc17_ = eax;
                  si32(_loc4_,_loc17_);
                  _loc16_ = -1;
               }
            }
            §§goto(addr1486);
         }
         else
         {
            addr73:
            ESP = _loc3_;
            F___error();
            _loc17_ = eax;
            si32(22,_loc17_);
            _loc16_ = -1;
         }
         addr1486:
         eax = _loc16_;
         _loc3_ = _loc8_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr73);
   }
}
