package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1348;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2349;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str3350;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str347;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str4351;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str5352;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str6353;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str7354;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str8355;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str9356;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_render_quote() : void
   {
      var _loc7_:* = 0;
      var _loc17_:* = 0;
      var _loc19_:* = 0;
      var _loc14_:int = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = 0;
      var _loc11_:int = 0;
      var _loc9_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc18_:* = 0;
      var _loc3_:* = ESP;
      _loc7_ = _loc3_;
      _loc3_ -= 16;
      var _loc4_:*;
      _loc19_ = li32(_loc4_ = li32(_loc4_ = li32(_loc7_ + 8)));
      _loc18_ = li32(_loc7_ + 4);
      _loc17_ = li32(_loc7_);
      if(_loc19_ == 0)
      {
         _loc3_ -= 16;
         si32(8,_loc3_ + 12);
         si32(L__2E_str347,_loc3_ + 8);
         si32(_loc18_,_loc3_ + 4);
         si32(_loc17_,_loc3_);
         ESP = _loc3_;
         F___printf_out();
         _loc3_ += 16;
         _loc18_ = eax;
      }
      else if((_loc16_ = li8(_loc19_)) != 0)
      {
         _loc15_ = _loc19_ + 1;
         _loc14_ = 0;
         _loc13_ = li32(__CurrentRuneLocale);
         _loc12_ = li32(___mb_sb_limit);
         do
         {
            _loc1_ = (_loc4_ = _loc16_ << 24) >> 24;
            if(_loc1_ >= 0)
            {
               if(_loc12_ > _loc1_)
               {
                  if((_loc4_ = (_loc4_ = li8((_loc4_ = _loc13_ + (_loc1_ << 2)) + 53)) & 64) == 0)
                  {
                     addr203:
                     if((_loc16_ &= 255) != 34)
                     {
                        if(_loc16_ != 92)
                        {
                           continue;
                        }
                     }
                  }
                  _loc14_ += 1;
                  continue;
               }
            }
            §§goto(addr203);
         }
         while(_loc4_ = _loc15_ + 1, _loc16_ = li8(_loc15_), _loc15_ = _loc4_, _loc16_ != 0);
         
         if(_loc14_ == 0)
         {
            var _loc8_:*;
            if((_loc4_ = (_loc8_ = (_loc8_ &= -2139062144) ^ -2139062144) & (_loc8_ = li32(_loc12_ = _loc19_ & -4)) + -16843009) != 0)
            {
               _loc13_ = _loc12_ + 4;
               _loc15_ = 0;
               while(true)
               {
                  if((uint(_loc14_ = _loc19_ + _loc15_)) < uint(_loc13_))
                  {
                     continue;
                  }
               }
               §§goto(addr414);
            }
            _loc14_ = _loc12_ + 4;
            while(true)
            {
               _loc4_ = (_loc13_ = li32(_loc14_)) + -16843009;
               if((_loc4_ = (_loc8_ = (_loc8_ = _loc13_ & -2139062144) ^ -2139062144) & _loc4_) == 0)
               {
                  continue;
               }
               if((_loc4_ = _loc13_ & 255) == 0)
               {
                  _loc15_ = _loc14_ - _loc19_;
               }
               else if((_loc4_ = li8(_loc14_ + 1)) == 0)
               {
                  _loc15_ = (_loc4_ = 1 - _loc19_) + _loc14_;
               }
               else if((_loc4_ = li8(_loc14_ + 2)) == 0)
               {
                  _loc15_ = (_loc4_ = 2 - _loc19_) + _loc14_;
               }
               else
               {
                  if((_loc4_ = li8(_loc14_ + 3)) != 0)
                  {
                     continue;
                  }
                  _loc15_ = (_loc4_ = 3 - _loc19_) + _loc14_;
               }
               §§goto(addr414);
            }
         }
         else
         {
            _loc3_ -= 16;
            si32(1,_loc3_ + 12);
            si32(L__2E_str2349,_loc3_ + 8);
            si32(_loc18_,_loc3_ + 4);
            si32(_loc17_,_loc3_);
            ESP = _loc3_;
            F___printf_out();
            _loc14_ = 0 - _loc19_;
            _loc3_ += 16;
            _loc13_ = eax;
            _loc15_ = 0;
            _loc12_ = _loc19_;
            loop1:
            while(true)
            {
               _loc5_ = _loc19_ + _loc15_;
               _loc2_ = li32(__CurrentRuneLocale);
               _loc10_ = li32(___mb_sb_limit);
               _loc11_ = 0;
               while(true)
               {
                  _loc1_ = _loc5_ + _loc11_;
                  _loc9_ = li8(_loc1_);
                  _loc16_ = L__2E_str3350;
                  if(_loc9_ != 92)
                  {
                     if(_loc9_ != 0)
                     {
                        _loc16_ = L__2E_str4351;
                        if(_loc9_ == 10)
                        {
                           break;
                        }
                        _loc16_ = L__2E_str5352;
                        if(_loc9_ == 13)
                        {
                           break;
                        }
                        _loc16_ = L__2E_str6353;
                        if(_loc9_ == 9)
                        {
                           break;
                        }
                        _loc16_ = L__2E_str7354;
                        if(_loc9_ == 32)
                        {
                           break;
                        }
                        _loc16_ = L__2E_str8355;
                        if(_loc9_ == 34)
                        {
                           break;
                        }
                        if((_loc16_ = (_loc4_ = _loc9_ << 24) >> 24) >= 0)
                        {
                           if(_loc10_ > _loc16_)
                           {
                              if((_loc4_ = (_loc4_ = li8((_loc4_ = _loc2_ + (_loc16_ << 2)) + 53)) & 64) != 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_loc16_,_loc3_ + 8);
                                 si32(L__2E_str9356,_loc3_ + 4);
                                 si32(_loc16_ = _loc7_ - 5,_loc3_);
                                 ESP = _loc3_;
                                 F_sprintf();
                                 _loc3_ += 16;
                                 break;
                              }
                           }
                        }
                        _loc11_ += 1;
                        continue;
                     }
                     if((_loc4_ = _loc12_ + (_loc14_ - _loc15_)) != _loc11_)
                     {
                        _loc3_ -= 16;
                        si32(_loc18_,_loc3_ + 4);
                        si32(_loc17_,_loc3_);
                        si32(_loc12_,_loc3_ + 8);
                        si32(_loc4_ = _loc1_ - _loc12_,_loc3_ + 12);
                        ESP = _loc3_;
                        F___printf_out();
                        _loc3_ += 16;
                        _loc13_ = (_loc4_ = eax) + _loc13_;
                     }
                     _loc3_ -= 16;
                     si32(1,_loc3_ + 12);
                     si32(L__2E_str2349,_loc3_ + 8);
                     si32(_loc18_,_loc3_ + 4);
                     si32(_loc17_,_loc3_);
                     ESP = _loc3_;
                     F___printf_out();
                     _loc3_ += 16;
                     _loc4_ = eax;
                     _loc8_ = li32(_loc17_);
                     _loc3_ -= 16;
                     var _loc6_:int;
                     si32(_loc6_ = _loc17_ + 4,_loc3_ + 4);
                     si32(_loc8_,_loc3_);
                     ESP = _loc3_;
                     F___sfvwrite();
                     _loc3_ += 16;
                     si32(_loc8_ = _loc17_ + 16,_loc17_ + 80);
                     si32(_loc8_,_loc17_ + 4);
                     si32(0,_loc17_ + 12);
                     si32(0,_loc17_ + 8);
                     _loc18_ = _loc4_ + _loc13_;
                     §§goto(addr414);
                  }
                  break;
               }
               _loc4_ = _loc14_ - _loc15_;
               if((_loc4_ = _loc12_ + _loc4_) != _loc11_)
               {
                  _loc3_ -= 16;
                  si32(_loc18_,_loc3_ + 4);
                  si32(_loc17_,_loc3_);
                  si32(_loc12_,_loc3_ + 8);
                  si32(_loc4_ = _loc1_ - _loc12_,_loc3_ + 12);
                  ESP = _loc3_;
                  F___printf_out();
                  _loc3_ += 16;
                  _loc13_ = (_loc4_ = eax) + _loc13_;
               }
               _loc15_ = (_loc4_ = _loc15_ + _loc11_) + 1;
               _loc12_ = _loc1_ + 1;
               _loc1_ = _loc16_ & -4;
               _loc4_ = (_loc8_ = li32(_loc1_)) + -16843009;
               if((_loc4_ = (_loc8_ = (_loc8_ &= -2139062144) ^ -2139062144) & _loc4_) != 0)
               {
                  _loc10_ = _loc1_ + 4;
                  _loc2_ = 0;
                  while(true)
                  {
                     if((uint(_loc5_ = _loc16_ + _loc2_)) < uint(_loc10_))
                     {
                        continue;
                     }
                  }
                  continue;
               }
               _loc10_ = _loc1_ + 4;
               while(true)
               {
                  _loc1_ = li32(_loc10_);
                  _loc4_ = _loc1_ + -16843009;
                  if((_loc4_ = (_loc8_ = (_loc8_ = _loc1_ & -2139062144) ^ -2139062144) & _loc4_) != 0)
                  {
                     if((_loc4_ = _loc1_ & 255) == 0)
                     {
                        _loc2_ = _loc10_ - _loc16_;
                        continue loop1;
                     }
                     if((_loc4_ = li8(_loc10_ + 1)) == 0)
                     {
                        _loc2_ = (_loc4_ = 1 - _loc16_) + _loc10_;
                        continue loop1;
                     }
                     if((_loc4_ = li8(_loc10_ + 2)) == 0)
                     {
                        _loc2_ = (_loc4_ = 2 - _loc16_) + _loc10_;
                        continue loop1;
                     }
                     if((_loc4_ = li8(_loc10_ + 3)) == 0)
                     {
                        _loc2_ = (_loc4_ = 3 - _loc16_) + _loc10_;
                        continue loop1;
                     }
                  }
                  _loc10_ += 4;
               }
            }
         }
      }
      else
      {
         _loc3_ -= 16;
         si32(2,_loc3_ + 12);
         si32(L__2E_str1348,_loc3_ + 8);
         si32(_loc18_,_loc3_ + 4);
         si32(_loc17_,_loc3_);
         ESP = _loc3_;
         F___printf_out();
         _loc3_ += 16;
         _loc18_ = eax;
      }
      addr414:
      _loc3_ -= 16;
      si32(_loc15_,_loc3_ + 12);
      si32(_loc19_,_loc3_ + 8);
      si32(_loc18_,_loc3_ + 4);
      si32(_loc17_,_loc3_);
      ESP = _loc3_;
      F___printf_out();
      _loc3_ += 16;
      _loc18_ = eax;
      eax = _loc18_;
      _loc3_ = _loc7_;
      ESP = _loc3_;
   }
}
