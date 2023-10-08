package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___build_env;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___merge_environ;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envActive;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVars;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVarsTotal;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._environSize;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._intEnviron;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_unsetenv() : void
   {
      var _loc7_:* = 0;
      var _loc14_:* = 0;
      var _loc12_:int = 0;
      var _loc10_:* = 0;
      var _loc13_:* = 0;
      var _loc17_:* = 0;
      var _loc8_:int = 0;
      var _loc11_:* = 0;
      var _loc2_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc15_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc16_:* = 0;
      var _loc19_:* = 0;
      var _loc3_:* = ESP;
      _loc7_ = _loc3_;
      _loc4_ = -1;
      if((_loc19_ = li32(_loc7_)) != 0)
      {
         var _loc18_:*;
         for(; (_loc17_ = li8((_loc18_ = _loc19_ - _loc4_) - 1)) != 61; _loc4_ += -1)
         {
            if(_loc17_ != 0)
            {
               continue;
            }
            if(_loc4_ == -1)
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
                  §§goto(addr653);
               }
               _loc14_ = _loc4_ ^ -1;
               _loc13_ = (_loc17_ = li32(_envVarsTotal)) * 20;
               _loc12_ = _loc15_ + _loc13_;
               _loc15_ = _loc17_ + -1;
               _loc1_ = _loc16_ = 0;
               loop1:
               for(; _loc15_ > -1; _loc15_ += -1,_loc1_ += 20)
               {
                  if((_loc18_ = li8((_loc8_ = _loc12_ - _loc1_) - 3)) != 0)
                  {
                     _loc9_ = li32(_loc8_ - 12);
                     _loc10_ = _loc19_;
                     _loc11_ = _loc9_;
                     _loc2_ = _loc14_;
                     if(_loc4_ != -1)
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
                     if((_loc18_ = li8((_loc18_ = _loc9_ - _loc4_) - 1)) != 61)
                     {
                        continue;
                     }
                     _loc4_ = (_loc18_ = li32(_loc8_ - 12)) - _loc4_;
                  }
                  else
                  {
                     if((_loc18_ = li8(_loc8_ - 4)) == 0)
                     {
                        continue;
                     }
                     if((_loc18_ = _loc4_ + li32(_loc8_ - 20)) != -1)
                     {
                        continue;
                     }
                     _loc10_ = li32(_loc8_ - 12);
                     _loc5_ = _loc19_;
                     _loc9_ = _loc10_;
                     _loc2_ = _loc14_;
                     if(_loc4_ != -1)
                     {
                        while(true)
                        {
                           _loc11_ = li8(_loc9_);
                           _loc18_ = li8(_loc5_);
                           if(_loc11_ != _loc18_)
                           {
                              break;
                           }
                           if(_loc11_ != 0)
                           {
                              _loc5_ += 1;
                              _loc9_ += 1;
                              _loc2_ += -1;
                              if(_loc2_ != 0)
                              {
                                 continue;
                              }
                           }
                        }
                        continue;
                     }
                     if((_loc18_ = li8((_loc18_ = _loc10_ - _loc4_) - 1)) != 61)
                     {
                        continue;
                     }
                     _loc4_ = li32(_loc8_ - 8);
                  }
                  _loc16_ = 0;
                  if(_loc4_ != 0)
                  {
                     si8(_loc4_ = 0,_loc8_ - 4);
                     if((_loc18_ = li8((_loc8_ = (_loc18_ = (_loc16_ = li32(_envVars)) + _loc13_) - _loc1_) - 3)) != 0)
                     {
                        si32(_loc19_ = (_loc13_ = li32(_envVarsTotal)) + -1,_envVarsTotal);
                        if(_loc19_ > _loc15_)
                        {
                           _loc3_ -= 16;
                           si32((_loc18_ = (_loc18_ = _loc13_ - _loc17_) * 20) + _loc1_,_loc3_ + 8);
                           si32(_loc8_,_loc3_ + 4);
                           si32(_loc18_ = _loc8_ + -20,_loc3_);
                           ESP = _loc3_;
                           Fmemmove();
                           _loc3_ += 16;
                           _loc16_ = li32(_envVars);
                           _loc19_ = li32(_envVarsTotal);
                        }
                        _loc18_ = _loc19_ * 20;
                        _loc18_ = _loc16_ + _loc18_;
                        si32(_loc4_,_loc18_ + 16);
                        si32(_loc4_,_loc18_ + 12);
                        si32(_loc4_,_loc18_ + 8);
                        si32(_loc4_,_loc18_ + 4);
                        si32(_loc4_,_loc18_);
                     }
                     _loc17_ = (_loc18_ = li32(_envActive)) + -1;
                     if((_loc18_ = li32(_environSize)) < _loc17_)
                     {
                        _loc3_ -= 16;
                        si32(li32(_intEnviron),_loc3_);
                        si32(_loc18_ = (_loc18_ = _loc17_ << 3) | 4,_loc3_ + 4);
                        ESP = _loc3_;
                        F_realloc();
                        _loc16_ = 0;
                        _loc3_ += 16;
                        if((_loc15_ = eax) != 0)
                        {
                           si32(_loc18_ = _loc17_ << 1,_environSize);
                           si32(_loc15_,_intEnviron);
                        }
                        break;
                     }
                     si32(_loc17_,_envActive);
                     _loc17_ = li32(_envVarsTotal);
                     addr626:
                     _loc15_ = li32(_envVars);
                     if(_loc17_ > 0)
                     {
                        _loc17_ += -1;
                        if(li8((_loc18_ = _loc15_ + _loc17_ * 20) - 4) != 0)
                        {
                           var _loc6_:*;
                           si32(_loc6_ = li32((_loc6_ = _loc15_ + ((_loc6_ = _loc17_ * 5) << 2)) + 8),(_loc18_ = li32(_intEnviron)) + _loc4_);
                           _loc4_ += 4;
                        }
                        §§goto(addr626);
                     }
                     si32(_loc16_ = 0,(_loc18_ = li32(_intEnviron)) + _loc4_);
                     si32(_loc18_ = li32(_intEnviron),_environ);
                     break;
                  }
                  break;
               }
            }
            §§goto(addr653);
         }
      }
      ESP = _loc3_;
      F___error();
      _loc18_ = eax;
      si32(22,_loc18_);
      _loc16_ = -1;
      addr653:
      eax = _loc16_;
      _loc3_ = _loc7_;
      ESP = _loc3_;
   }
}
