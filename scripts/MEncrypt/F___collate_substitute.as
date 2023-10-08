package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2402;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_3039;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_3112;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___collate_substitute() : void
   {
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:int = 0;
      var _loc8_:int = 0;
      var _loc7_:* = 0;
      var _loc1_:int = 0;
      var _loc13_:* = 0;
      var _loc10_:* = 0;
      var _loc14_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc12_:* = 0;
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32(_loc4_ = _loc2_);
      _loc14_ = (_loc15_ = li32(_loc16_ = _loc3_ & -4)) + -16843009;
      if((_loc14_ = (_loc15_ = (_loc15_ &= -2139062144) ^ -2139062144) & _loc14_) != 0)
      {
         _loc13_ = _loc16_ + 4;
         _loc12_ = 0;
         while(true)
         {
            if((uint(_loc11_ = _loc3_ + _loc12_)) < uint(_loc13_))
            {
               continue;
            }
         }
         addr217:
         if(_loc3_ != 0)
         {
            if((_loc11_ = li8(_loc3_)) == 0)
            {
               addr228:
               _loc12_ = (_loc16_ = L__2E_str2402 & -4) + 4;
               _loc13_ = 0;
               _loc3_ = 1;
               if(uint(L__2E_str2402) < uint(_loc12_))
               {
                  _loc3_ = _loc13_;
               }
               _loc14_ = (_loc15_ = li32(_loc16_)) + -16843009;
               if((_loc14_ = (_loc15_ = (_loc15_ &= -2139062144) ^ -2139062144) & _loc14_) != 0)
               {
                  if((_loc14_ = _loc3_ & 1) != 0)
                  {
                     while(true)
                     {
                        _loc14_ = (_loc16_ = li32(_loc12_)) + -16843009;
                        if((_loc14_ = (_loc15_ = (_loc15_ = _loc16_ & -2139062144) ^ -2139062144) & _loc14_) != 0)
                        {
                           if((_loc14_ = _loc16_ & 255) == 0)
                           {
                              _loc13_ = _loc12_ - L__2E_str2402;
                              break;
                           }
                           if((_loc14_ = li8(_loc12_ + 1)) == 0)
                           {
                              _loc13_ = _loc12_ + (1 - L__2E_str2402);
                              break;
                           }
                           if((_loc14_ = li8(_loc12_ + 2)) == 0)
                           {
                              _loc13_ = _loc12_ + (2 - L__2E_str2402);
                              break;
                           }
                           if((_loc14_ = li8(_loc12_ + 3)) == 0)
                           {
                              _loc13_ = _loc12_ + (3 - L__2E_str2402);
                              break;
                           }
                        }
                        _loc12_ += 4;
                     }
                     addr281:
                  }
                  _loc2_ -= 16;
                  si32(_loc16_ = _loc13_ + 1,_loc2_);
                  ESP = _loc2_;
                  F_malloc();
                  _loc2_ += 16;
                  if((_loc12_ = eax) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_loc16_,_loc2_ + 8);
                     si32(L__2E_str2402,_loc2_ + 4);
                     si32(_loc12_,_loc2_);
                     ESP = _loc2_;
                     Fmemcpy();
                     _loc2_ += 16;
                  }
                  else
                  {
                     _loc2_ -= 16;
                     si32(___func___2E_3112,_loc2_ + 4);
                     si32(71,_loc2_);
                     ESP = _loc2_;
                     F___collate_err();
                     _loc2_ += 16;
                     addr474:
                     _loc14_ = (_loc14_ = _loc12_ >> 31) >>> 29;
                     _loc16_ = (_loc14_ = (_loc14_ = _loc12_ + _loc14_) >> 3) + _loc12_;
                     _loc2_ -= 16;
                     si32(_loc16_,_loc2_);
                     ESP = _loc2_;
                     F_malloc();
                     _loc2_ += 16;
                     if((_loc12_ = eax) != 0)
                     {
                        _loc13_ = _loc3_ + 1;
                        _loc10_ = 0;
                        _loc3_ = _loc16_;
                        while((_loc9_ = _loc11_ & 255) != 0)
                        {
                           _loc1_ = _loc7_ + _loc10_;
                           if(_loc3_ <= _loc1_)
                           {
                              _loc2_ -= 16;
                              si32(_loc12_,_loc2_);
                              _loc3_ = _loc1_ + _loc16_;
                              si32(_loc3_,_loc2_ + 4);
                              ESP = _loc2_;
                              F_realloc();
                              _loc2_ += 16;
                              if((_loc5_ = eax) == 0)
                              {
                                 if(_loc12_ != 0)
                                 {
                                    if(_loc3_ != 0)
                                    {
                                       _loc2_ -= 16;
                                       si32(_loc12_,_loc2_);
                                       ESP = _loc2_;
                                       F_idalloc();
                                       _loc2_ += 16;
                                    }
                                 }
                              }
                              if(_loc5_ != 0)
                              {
                                 _loc11_ = li8(_loc13_ - 1);
                                 _loc9_ = li32(___collate_substitute_table_ptr);
                                 _loc12_ = _loc5_;
                              }
                              else
                              {
                                 _loc2_ -= 16;
                                 si32(___func___2E_3039,_loc2_ + 4);
                                 si32(71,_loc2_);
                                 ESP = _loc2_;
                                 F___collate_err();
                                 _loc2_ += 16;
                              }
                           }
                           _loc10_ = _loc12_ + _loc10_;
                           _loc14_ = (_loc14_ = _loc11_ & 255) * 10;
                           si8(_loc14_ = li8(_loc9_ += _loc14_),_loc10_);
                           if(_loc14_ != 0)
                           {
                              _loc11_ = _loc10_ + 1;
                              _loc9_ += 1;
                              do
                              {
                                 si8(_loc14_ = li8(_loc9_),_loc11_);
                                 _loc11_ += 1;
                                 _loc9_ += 1;
                              }
                              while(_loc14_ != 0);
                              
                           }
                           _loc14_ = _loc13_ + 1;
                           _loc11_ = li8(_loc13_);
                           _loc13_ = _loc14_;
                           _loc10_ = _loc1_;
                        }
                        §§goto(addr942);
                     }
                     else
                     {
                        _loc2_ -= 16;
                        si32(___func___2E_3039,_loc2_ + 4);
                        si32(71,_loc2_);
                        ESP = _loc2_;
                        F___collate_err();
                        _loc2_ += 16;
                     }
                     while(true)
                     {
                        _loc14_ = _loc9_ * 10;
                        _loc1_ = (_loc9_ = li32(___collate_substitute_table_ptr)) + _loc14_;
                        _loc14_ = (_loc15_ = li32(_loc5_ = _loc1_ & -4)) + -16843009;
                        if((_loc14_ = (_loc15_ = (_loc15_ &= -2139062144) ^ -2139062144) & _loc14_) != 0)
                        {
                           _loc6_ = _loc5_ + 4;
                           _loc7_ = 0;
                           while(true)
                           {
                              if((uint(_loc8_ = _loc1_ + _loc7_)) < uint(_loc6_))
                              {
                                 continue;
                              }
                           }
                           §§goto(addr748);
                        }
                        _loc5_ += 4;
                        while(true)
                        {
                           _loc14_ = (_loc7_ = li32(_loc5_)) + -16843009;
                           if((_loc14_ = (_loc15_ = (_loc15_ = _loc7_ & -2139062144) ^ -2139062144) & _loc14_) == 0)
                           {
                              continue;
                           }
                           if((_loc14_ = _loc7_ & 255) == 0)
                           {
                              _loc7_ = _loc5_ - _loc1_;
                           }
                           else if((_loc14_ = li8(_loc5_ + 1)) == 0)
                           {
                              _loc7_ = (_loc14_ = 1 - _loc1_) + _loc5_;
                           }
                           else if((_loc14_ = li8(_loc5_ + 2)) == 0)
                           {
                              _loc7_ = (_loc14_ = 2 - _loc1_) + _loc5_;
                           }
                           else
                           {
                              if((_loc14_ = li8(_loc5_ + 3)) != 0)
                              {
                                 continue;
                              }
                              _loc7_ = (_loc14_ = 3 - _loc1_) + _loc5_;
                           }
                           §§goto(addr748);
                        }
                     }
                  }
                  addr942:
                  eax = _loc12_;
                  _loc2_ = _loc4_;
                  ESP = _loc2_;
                  return;
               }
               §§goto(addr281);
            }
            §§goto(addr474);
         }
         §§goto(addr228);
      }
      _loc12_ = _loc16_ + 4;
      while(true)
      {
         _loc14_ = (_loc16_ = li32(_loc12_)) + -16843009;
         if((_loc14_ = (_loc15_ = (_loc15_ = _loc16_ & -2139062144) ^ -2139062144) & _loc14_) == 0)
         {
            continue;
         }
         if((_loc14_ = _loc16_ & 255) == 0)
         {
            _loc12_ -= _loc3_;
         }
         else if((_loc14_ = li8(_loc12_ + 1)) == 0)
         {
            _loc12_ = (_loc14_ = 1 - _loc3_) + _loc12_;
         }
         else if((_loc14_ = li8(_loc12_ + 2)) == 0)
         {
            _loc12_ = (_loc14_ = 2 - _loc3_) + _loc12_;
         }
         else
         {
            if((_loc14_ = li8(_loc12_ + 3)) != 0)
            {
               continue;
            }
            _loc12_ = (_loc14_ = 3 - _loc3_) + _loc12_;
         }
         §§goto(addr217);
      }
   }
}
