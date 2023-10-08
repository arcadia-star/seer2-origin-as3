package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F_malloc;
   import MEncrypt.F_realloc;
   import MEncrypt.Fmemmove;
   import MEncrypt._environ;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___setenv() : void
   {
      var _loc10_:* = 0;
      var _loc15_:* = 0;
      var _loc16_:* = 0;
      var _loc6_:* = 0;
      var _loc17_:* = 0;
      var _loc22_:* = 0;
      var _loc1_:int = 0;
      var _loc12_:int = 0;
      var _loc11_:* = 0;
      var _loc14_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = 0;
      var _loc13_:* = 0;
      var _loc18_:* = 0;
      var _loc19_:* = 0;
      var _loc20_:* = 0;
      var _loc21_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:*;
      _loc20_ = (_loc21_ = li32(_loc22_ = (_loc6_ = li32((_loc10_ = _loc5_ = ESP) + 8)) & -4)) + -16843009;
      _loc20_ = (_loc21_ = (_loc21_ &= -2139062144) ^ -2139062144) & _loc20_;
      _loc19_ = li32(_envActive);
      _loc18_ = li32(_envVarsTotal);
      _loc17_ = li32(_loc10_ + 12);
      _loc16_ = li32(_loc10_ + 4);
      _loc15_ = li32(_loc10_);
      if(_loc20_ != 0)
      {
         _loc1_ = _loc22_ + 4;
         _loc11_ = 0;
         while(true)
         {
            if((uint(_loc12_ = _loc6_ + _loc11_)) < uint(_loc1_))
            {
               continue;
            }
         }
         addr250:
         _loc13_ = _loc18_ * 20;
         _loc14_ = (_loc22_ = li32(_envVars)) + _loc13_;
         _loc1_ = _loc18_ + -1;
         _loc12_ = 0;
         loop1:
         for(; _loc1_ > -1; _loc1_ += -1,_loc12_ += 20)
         {
            if((_loc20_ = li8((_loc4_ = _loc14_ - _loc12_) - 3)) != 0)
            {
               _loc7_ = li32(_loc4_ - 12);
               _loc8_ = _loc15_;
               _loc9_ = _loc7_;
               _loc3_ = _loc16_;
               if(_loc16_ != 0)
               {
                  while(true)
                  {
                     _loc2_ = li8(_loc9_);
                     _loc20_ = li8(_loc8_);
                     if(_loc2_ != _loc20_)
                     {
                        continue loop1;
                     }
                     if(_loc2_ != 0)
                     {
                        _loc8_ += 1;
                        _loc9_ += 1;
                        _loc3_ += -1;
                        if(_loc3_ != 0)
                        {
                           continue;
                        }
                     }
                  }
               }
               if((_loc20_ = li8(_loc20_ = _loc7_ + _loc16_)) != 61)
               {
                  continue;
               }
               _loc14_ = (_loc20_ = _loc16_ + li32(_loc4_ - 12)) + 1;
            }
            else
            {
               if((_loc20_ = li32(_loc4_ - 20)) != _loc16_)
               {
                  continue;
               }
               _loc2_ = li32(_loc4_ - 12);
               _loc3_ = _loc15_;
               _loc8_ = _loc2_;
               _loc7_ = _loc16_;
               if(_loc16_ != 0)
               {
                  while(true)
                  {
                     _loc9_ = li8(_loc8_);
                     _loc20_ = li8(_loc3_);
                     if(_loc9_ != _loc20_)
                     {
                        break;
                     }
                     if(_loc9_ != 0)
                     {
                        _loc3_ += 1;
                        _loc8_ += 1;
                        if((_loc7_ += -1) != 0)
                        {
                           continue;
                        }
                     }
                  }
                  continue;
               }
               if((_loc20_ = li8(_loc20_ = _loc2_ + _loc16_)) != 61)
               {
                  continue;
               }
               _loc14_ = li32(_loc4_ - 8);
            }
            if(_loc14_ != 0)
            {
               if((_loc20_ = li8(_loc4_ - 4)) != 0)
               {
                  _loc22_ = 0;
                  if(_loc17_ != 0)
                  {
                     si8(0,_loc4_ - 4);
                     _loc19_ += -1;
                     _loc22_ = li32(_envVars);
                     addr487:
                     if((_loc20_ = li8((_loc13_ = (_loc17_ = _loc22_ + _loc13_) - _loc12_) - 3)) != 0)
                     {
                        si32(_loc4_ = (_loc13_ = li32(_envVarsTotal)) + -1,_envVarsTotal);
                        if(_loc4_ > _loc1_)
                        {
                           si32((_loc20_ = (_loc20_ = _loc13_ - _loc18_) * 20) + _loc12_,(_loc5_ -= 16) + 8);
                           si32(_loc20_ = (_loc20_ = _loc17_ + -20) - _loc12_,_loc5_);
                           si32(_loc20_ += 20,_loc5_ + 4);
                           ESP = _loc5_;
                           Fmemmove();
                           _loc5_ += 16;
                           _loc22_ = li32(_envVars);
                           _loc4_ = li32(_envVarsTotal);
                        }
                        _loc20_ = _loc4_ * 20;
                        _loc20_ = _loc22_ + _loc20_;
                        si32(0,_loc20_ + 16);
                        si32(0,_loc20_ + 12);
                        si32(0,_loc20_ + 8);
                        si32(0,_loc20_ + 4);
                        si32(0,_loc20_);
                        _loc18_ = _loc4_;
                        break;
                     }
                     if((uint(_loc20_ = li32(_loc13_ - 16))) < uint(_loc11_))
                     {
                        _loc18_ = li32(_envVarsTotal);
                        break;
                     }
                     addr915:
                     _loc11_ = li32(_loc13_ - 8);
                     _loc16_ = 1;
                     _loc18_ = _loc1_;
                     si8(_loc20_ = li8(_loc6_),_loc11_);
                     if(_loc20_ != 0)
                     {
                        _loc15_ = _loc11_ + 1;
                        _loc6_ += 1;
                        do
                        {
                           si8(_loc20_ = li8(_loc6_),_loc15_);
                           _loc15_ += 1;
                           _loc6_ += 1;
                        }
                        while(_loc20_ != 0);
                        
                     }
                     _loc20_ = _loc18_ * 20;
                     _loc21_ = (_loc21_ = li32(_envVars)) + _loc20_;
                     si32(_loc11_,_loc21_ + 12);
                     _loc20_ = (_loc21_ = li32(_envVars)) + _loc20_;
                     si8(_loc18_ = 1,_loc20_ + 16);
                     _loc19_ += 1;
                     _loc22_ = 0;
                     _loc20_ = li32(_envActive);
                     if(_loc19_ != _loc20_)
                     {
                        _loc18_ = _loc22_;
                     }
                     if((_loc20_ = _loc16_ & _loc18_) == 0)
                     {
                        if((_loc20_ = li32(_environSize)) < _loc19_)
                        {
                           si32(li32(_intEnviron),_loc5_ -= 16);
                           si32(_loc20_ = (_loc20_ = _loc19_ << 3) | 4,_loc5_ + 4);
                           ESP = _loc5_;
                           F_realloc();
                           _loc22_ = -1;
                           _loc5_ += 16;
                           if((_loc18_ = eax) != 0)
                           {
                              si32(_loc20_ = _loc19_ << 1,_environSize);
                              si32(_loc18_,_intEnviron);
                           }
                           §§goto(addr1165);
                        }
                        si32(_loc19_,_envActive);
                        _loc18_ = 0;
                        _loc19_ = li32(_envVarsTotal);
                        loop6:
                        while(true)
                        {
                           _loc6_ = li32(_envVars);
                           while(_loc19_ > 0)
                           {
                              _loc19_ += -1;
                              if(li8((_loc20_ = _loc6_ + _loc19_ * 20) - 4) != 0)
                              {
                                 continue loop6;
                              }
                           }
                           si32(_loc22_ = 0,(_loc20_ = li32(_intEnviron)) + _loc18_);
                           si32(_loc20_ = li32(_intEnviron),_environ);
                        }
                     }
                  }
                  §§goto(addr1165);
               }
               §§goto(addr487);
            }
            break;
         }
         _loc1_ = _loc18_ + 1;
         si32(_loc1_,_envVarsTotal);
         _loc20_ = li32(_envVarsSize);
         if(_loc1_ > _loc20_)
         {
            _loc5_ -= 16;
            si32(_loc22_,_loc5_);
            si32(_loc20_ = _loc1_ * 40,_loc5_ + 4);
            ESP = _loc5_;
            F_realloc();
            _loc5_ += 16;
            if((_loc22_ = eax) != 0)
            {
               si32(_loc20_ = _loc1_ << 1,_envVarsSize);
               si32(_loc22_,_envVars);
               addr715:
               _loc20_ = (_loc20_ = _loc16_ + _loc11_) + 2;
               _loc5_ -= 16;
               si32(_loc20_,_loc5_);
               _loc1_ = _loc18_ * 20;
               _loc21_ = _loc22_ + _loc1_;
               ESP = _loc5_;
               F_malloc();
               _loc5_ += 16;
               si32(_loc20_ = eax,_loc21_ + 8);
               if((_loc20_ = li32((_loc22_ = (_loc20_ = li32(_envVars)) + _loc1_) + 8)) == 0)
               {
                  si32(_loc20_ = (_loc20_ = li32(_envVarsTotal)) + -1,_envVarsTotal);
                  _loc22_ = -1;
               }
               else
               {
                  si32(_loc16_,_loc22_);
                  si32(_loc11_,(_loc20_ = li32(_envVars)) + _loc1_ + 4);
                  _loc11_ = li32((_loc20_ = (_loc20_ = li32(_envVars)) + _loc1_) + 8);
                  si8(_loc20_ = li8(_loc15_),_loc11_);
                  if(_loc20_ != 0)
                  {
                     _loc15_ += 1;
                     do
                     {
                        si8(_loc20_ = li8(_loc15_),_loc11_ + 1);
                        _loc11_ += 1;
                        _loc15_ += 1;
                     }
                     while(_loc20_ != 0);
                     
                  }
                  _loc20_ = li8(_loc20_ = (_loc20_ = li32((_loc20_ = (_loc20_ = li32(_envVars)) + _loc1_) + 8)) + _loc16_);
                  _loc16_ = 0;
                  if(_loc20_ != 61)
                  {
                     si8(61,_loc11_);
                     si8(_loc16_ = 0,_loc11_ + 1);
                     _loc11_ += 1;
                  }
                  §§goto(addr915);
               }
            }
            else
            {
               si32(_loc20_ = (_loc20_ = li32(_envVarsTotal)) + -1,_envVarsTotal);
               _loc22_ = -1;
            }
            addr1165:
            eax = _loc22_;
            ESP = _loc5_ = _loc10_;
            return;
         }
         §§goto(addr715);
      }
      _loc1_ = _loc22_ + 4;
      while(true)
      {
         _loc20_ = (_loc11_ = li32(_loc1_)) + -16843009;
         if((_loc20_ = (_loc21_ = (_loc21_ = _loc11_ & -2139062144) ^ -2139062144) & _loc20_) == 0)
         {
            continue;
         }
         if((_loc20_ = _loc11_ & 255) == 0)
         {
            _loc11_ = _loc1_ - _loc6_;
         }
         else if((_loc20_ = li8(_loc1_ + 1)) == 0)
         {
            _loc11_ = (_loc20_ = 1 - _loc6_) + _loc1_;
         }
         else if((_loc20_ = li8(_loc1_ + 2)) == 0)
         {
            _loc11_ = (_loc20_ = 2 - _loc6_) + _loc1_;
         }
         else
         {
            if((_loc20_ = li8(_loc1_ + 3)) != 0)
            {
               continue;
            }
            _loc11_ = (_loc20_ = 3 - _loc6_) + _loc1_;
         }
         §§goto(addr250);
      }
   }
}
