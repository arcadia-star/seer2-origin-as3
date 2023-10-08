package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___build_env;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___merge_environ;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envActive;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVars;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVarsSize;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVarsTotal;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._environSize;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._intEnviron;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_putenv() : void
   {
      var _loc7_:* = 0;
      var _loc14_:int = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc13_:int = 0;
      var _loc12_:int = 0;
      var _loc1_:int = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc2_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc17_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc19_:* = 0;
      var _loc3_:* = ESP;
      _loc7_ = _loc3_;
      _loc4_ = 0;
      if((_loc19_ = li32(_loc7_)) != 0)
      {
         var _loc18_:*;
         while((_loc17_ = li8(_loc18_ = _loc19_ - _loc4_)) != 0)
         {
            if(_loc17_ == 61)
            {
               if(_loc19_ != _loc4_)
               {
                  if(_loc4_ == 0)
                  {
                     break;
                  }
                  ESP = _loc3_;
                  F___merge_environ();
                  _loc16_ = -1;
                  if((_loc18_ = eax) != -1)
                  {
                     if((_loc15_ = li32(_envVars)) == 0)
                     {
                        ESP = _loc3_;
                        F___build_env();
                        _loc16_ = -1;
                        if((_loc18_ = eax) != -1)
                        {
                           _loc15_ = li32(_envVars);
                        }
                        §§goto(addr890);
                     }
                     _loc14_ = 0 - _loc4_;
                     _loc13_ = (_loc16_ = li32(_envVarsTotal)) + -1;
                     _loc17_ = li32(_envActive);
                     loop1:
                     for(; _loc13_ > -1; _loc13_ += -1)
                     {
                        _loc12_ = _loc13_ * 5;
                        _loc1_ = _loc15_ + _loc13_ * 20;
                        if((_loc18_ = li8(_loc1_ + 17)) != 0)
                        {
                           _loc9_ = li32((_loc8_ = _loc15_ + (_loc12_ << 2)) + 8);
                           _loc10_ = _loc19_;
                           _loc11_ = _loc9_;
                           _loc2_ = _loc14_;
                           if(_loc4_ != 0)
                           {
                              while(true)
                              {
                                 _loc5_ = li8(_loc11_);
                                 _loc18_ = li8(_loc10_);
                                 if(_loc5_ != _loc18_)
                                 {
                                    continue loop1;
                                 }
                                 if(_loc5_ != 0)
                                 {
                                    _loc10_ += 1;
                                    _loc11_ += 1;
                                    _loc2_ += -1;
                                    if(_loc2_ != 0)
                                    {
                                       continue;
                                    }
                                 }
                              }
                           }
                           if((_loc18_ = li8(_loc18_ = _loc9_ - _loc4_)) != 61)
                           {
                              continue;
                           }
                           _loc4_ = (_loc18_ = (_loc18_ = li32(_loc8_ + 8)) - _loc4_) + 1;
                        }
                        else
                        {
                           if((_loc18_ = li8(_loc1_ + 16)) == 0)
                           {
                              continue;
                           }
                           if((_loc18_ = 0 - li32(_loc18_ = _loc15_ + (_loc12_ << 2))) != _loc4_)
                           {
                              continue;
                           }
                           _loc10_ = li32((_loc9_ = _loc15_ + (_loc12_ << 2)) + 8);
                           _loc5_ = _loc19_;
                           _loc11_ = _loc10_;
                           _loc2_ = _loc14_;
                           if(_loc4_ != 0)
                           {
                              while(true)
                              {
                                 _loc8_ = li8(_loc11_);
                                 _loc18_ = li8(_loc5_);
                                 if(_loc8_ != _loc18_)
                                 {
                                    break;
                                 }
                                 if(_loc8_ != 0)
                                 {
                                    _loc5_ += 1;
                                    _loc11_ += 1;
                                    _loc2_ += -1;
                                    if(_loc2_ != 0)
                                    {
                                       continue;
                                    }
                                 }
                              }
                              continue;
                           }
                           if((_loc18_ = li8(_loc18_ = _loc10_ - _loc4_)) != 61)
                           {
                              continue;
                           }
                           _loc4_ = li32(_loc9_ + 12);
                        }
                        if(_loc4_ != 0)
                        {
                           if((_loc18_ = li8(_loc1_ + 17)) == 0)
                           {
                              si8(0,_loc1_ + 16);
                              _loc17_ += -1;
                              _loc15_ = li32(_envVars);
                              _loc16_ = li32(_envVarsTotal);
                              break;
                           }
                           si32(_loc19_,_loc15_ + (_loc12_ << 2) + 8);
                           _loc17_ = li32(_envActive);
                           if((_loc18_ = li32(_environSize)) < _loc17_)
                           {
                              _loc3_ -= 16;
                              si32(li32(_intEnviron),_loc3_);
                              si32(_loc18_ = (_loc18_ = _loc17_ << 3) | 4,_loc3_ + 4);
                              ESP = _loc3_;
                              F_realloc();
                              _loc16_ = -1;
                              _loc3_ += 16;
                              if((_loc19_ = eax) != 0)
                              {
                                 si32(_loc18_ = _loc17_ << 1,_environSize);
                                 si32(_loc19_,_intEnviron);
                              }
                              §§goto(addr890);
                           }
                           si32(_loc17_,_envActive);
                           _loc17_ = 0;
                           _loc16_ = li32(_envVarsTotal);
                           addr532:
                           _loc19_ = li32(_envVars);
                           if(_loc16_ > 0)
                           {
                              _loc16_ += -1;
                              if(li8((_loc18_ = _loc19_ + _loc16_ * 20) - 4) != 0)
                              {
                                 var _loc6_:*;
                                 si32(_loc6_ = li32((_loc6_ = _loc19_ + ((_loc6_ = _loc16_ * 5) << 2)) + 8),(_loc18_ = li32(_intEnviron)) + _loc17_);
                                 _loc17_ += 4;
                              }
                              §§goto(addr532);
                           }
                           si32(_loc16_ = 0,(_loc18_ = li32(_intEnviron)) + _loc17_);
                           si32(_loc18_ = li32(_intEnviron),_environ);
                           §§goto(addr890);
                        }
                        break;
                     }
                     si32(_loc4_ = _loc16_ + 1,_envVarsTotal);
                     _loc18_ = li32(_envVarsSize);
                     if(_loc4_ > _loc18_)
                     {
                        _loc3_ -= 16;
                        si32(_loc15_,_loc3_);
                        si32(_loc18_ = _loc4_ * 40,_loc3_ + 4);
                        ESP = _loc3_;
                        F_realloc();
                        _loc3_ += 16;
                        if((_loc15_ = eax) != 0)
                        {
                           si32(_loc18_ = _loc4_ << 1,_envVarsSize);
                           si32(_loc15_,_envVars);
                        }
                        else
                        {
                           si32(_loc18_ = (_loc18_ = li32(_envVarsTotal)) + -1,_envVarsTotal);
                           _loc16_ = -1;
                           §§goto(addr890);
                        }
                        §§goto(addr890);
                     }
                     _loc18_ = _loc16_ * 20;
                     _loc6_ = _loc15_ + _loc18_;
                     si32(_loc19_,_loc6_ + 8);
                     _loc6_ = (_loc6_ = li32(_envVars)) + _loc18_;
                     si32(_loc16_ = -1,_loc6_);
                     _loc6_ = (_loc6_ = li32(_envVars)) + _loc18_;
                     si32(_loc19_ = 0,_loc6_ + 12);
                     _loc6_ = (_loc6_ = li32(_envVars)) + _loc18_;
                     si32(_loc16_,_loc6_ + 4);
                     _loc6_ = (_loc6_ = li32(_envVars)) + _loc18_;
                     si8(1,_loc6_ + 17);
                     _loc18_ = (_loc6_ = li32(_envVars)) + _loc18_;
                     si8(1,_loc18_ + 16);
                     _loc17_ += 1;
                     if((_loc18_ = li32(_environSize)) < _loc17_)
                     {
                        _loc3_ -= 16;
                        si32(li32(_intEnviron),_loc3_);
                        si32(_loc18_ = (_loc18_ = _loc17_ << 3) | 4,_loc3_ + 4);
                        ESP = _loc3_;
                        F_realloc();
                        _loc3_ += 16;
                        if((_loc15_ = eax) != 0)
                        {
                           si32(_loc18_ = _loc17_ << 1,_environSize);
                           si32(_loc15_,_intEnviron);
                        }
                        §§goto(addr890);
                     }
                     si32(_loc17_,_envActive);
                     _loc16_ = li32(_envVarsTotal);
                     loop4:
                     while(true)
                     {
                        _loc17_ = li32(_envVars);
                        while(_loc16_ > 0)
                        {
                           _loc16_ += -1;
                           if(li8((_loc18_ = _loc17_ + _loc16_ * 20) - 4) != 0)
                           {
                              continue loop4;
                           }
                        }
                        si32(_loc16_ = 0,(_loc18_ = li32(_intEnviron)) + _loc19_);
                        si32(_loc18_ = li32(_intEnviron),_environ);
                     }
                  }
                  §§goto(addr890);
               }
               break;
            }
            _loc4_ += -1;
         }
      }
      ESP = _loc3_;
      F___error();
      _loc18_ = eax;
      si32(22,_loc18_);
      _loc16_ = -1;
      addr890:
      eax = _loc16_;
      _loc3_ = _loc7_;
      ESP = _loc3_;
   }
}
