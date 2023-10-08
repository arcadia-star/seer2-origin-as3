package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.F__write;
   import MEncrypt.___progname;
   import MEncrypt._environ;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___merge_environ() : void
   {
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      if((_loc11_ = li32(_intEnviron)) != 0)
      {
         _loc10_ = li32(_envActive);
         if((_loc9_ = li32(_environ)) == _loc11_)
         {
            _loc1_ = 0;
            if(_loc10_ >= 1)
            {
               _loc1_ = 0;
               if(li32(_loc9_) != 0)
               {
                  §§goto(addr918);
               }
               else
               {
                  addr61:
                  si32(0,_origEnviron);
                  _loc2_ -= 16;
                  si32(0,_loc2_);
                  ESP = _loc2_;
                  F___clean_env();
                  _loc2_ += 16;
                  _loc9_ = li32(_environ);
               }
            }
            §§goto(addr918);
         }
         else if(_loc10_ >= 1)
         {
            §§goto(addr61);
         }
         si32(_loc9_,_origEnviron);
         _loc1_ = 0;
         if(_loc9_ != 0)
         {
            loop0:
            while(true)
            {
               _loc10_ = li32(_loc9_);
               _loc1_ = 0;
               if(_loc10_ != 0)
               {
                  while((_loc11_ = li8(_loc7_ = _loc10_ + _loc1_)) != 0)
                  {
                     if(_loc11_ != 61)
                     {
                        _loc1_ += 1;
                        continue;
                     }
                     if(_loc7_ == 0)
                     {
                        break;
                     }
                     continue loop0;
                  }
                  var _loc6_:*;
                  var _loc8_:* = (_loc6_ = li32(_loc7_ = _loc10_ & -4)) + -16843009;
                  if((_loc8_ = (_loc6_ = (_loc6_ &= -2139062144) ^ -2139062144) & _loc8_) != 0)
                  {
                     _loc11_ = _loc7_ + 4;
                     _loc9_ = 0;
                     while(true)
                     {
                        _loc1_ = _loc10_ + _loc9_;
                        if(uint(_loc1_) < uint(_loc11_))
                        {
                           continue;
                        }
                     }
                     addr300:
                     _loc1_ = li32(___progname);
                     _loc8_ = (_loc6_ = li32(_loc7_ = _loc1_ & -4)) + -16843009;
                     if((_loc8_ = (_loc6_ = (_loc6_ &= -2139062144) ^ -2139062144) & _loc8_) != 0)
                     {
                        _loc5_ = _loc7_ + 4;
                        _loc11_ = 0;
                        while(true)
                        {
                           if((uint(_loc4_ = _loc1_ + _loc11_)) < uint(_loc5_))
                           {
                              continue;
                           }
                        }
                        addr479:
                        _loc2_ -= 16;
                        si32(_loc11_,_loc2_ + 8);
                        si32(_loc1_,_loc2_ + 4);
                        si32(2,_loc2_);
                        ESP = _loc2_;
                        F__write();
                        _loc2_ += 16;
                        _loc2_ -= 16;
                        si32(2,_loc2_ + 8);
                        si32(_progSep_2E_2358,_loc2_ + 4);
                        si32(2,_loc2_);
                        ESP = _loc2_;
                        F__write();
                        _loc2_ += 16;
                        _loc8_ = (_loc6_ = li32(_loc11_ = _CorruptEnvValueMsg & -4)) + -16843009;
                        _loc8_ = (_loc6_ = (_loc6_ &= -2139062144) ^ -2139062144) & _loc8_;
                        _loc7_ = _loc11_ + 4;
                        _loc1_ = 0;
                        if(_loc8_ != 0)
                        {
                           do
                           {
                              _loc8_ = _CorruptEnvValueMsg + _loc1_;
                              _loc7_ = _loc11_ + 4;
                              if(uint(_loc8_) < uint(_loc7_))
                              {
                                 continue;
                              }
                           }
                           while(_loc7_ = _loc11_ + 4, _loc5_ = _CorruptEnvValueMsg, if(uint(_CorruptEnvValueMsg) <= uint(_loc7_))
                           {
                              _loc5_ = _loc7_;
                           }, _loc8_ = _loc5_ ^ -1, if((uint(_loc7_ = _CorruptEnvValueMsg + _loc8_)) <= 4294967256)
                           {
                              _loc7_ = -40;
                           }, _loc7_ ^= -1, _loc1_ += 1, _loc1_ != 40);
                           
                           addr744:
                           _loc2_ -= 16;
                           si32(_loc7_,_loc2_ + 8);
                           si32(_CorruptEnvValueMsg,_loc2_ + 4);
                           si32(2,_loc2_);
                           ESP = _loc2_;
                           F__write();
                           _loc2_ += 16;
                           _loc2_ -= 16;
                           si32(_loc9_,_loc2_ + 8);
                           si32(_loc10_,_loc2_ + 4);
                           si32(2,_loc2_);
                           ESP = _loc2_;
                           F__write();
                           _loc2_ += 16;
                           _loc2_ -= 16;
                           si32(1,_loc2_ + 8);
                           si32(_nl_2E_2357,_loc2_ + 4);
                           si32(2,_loc2_);
                           ESP = _loc2_;
                           F__write();
                           _loc2_ += 16;
                           ESP = _loc2_;
                           F___error();
                           _loc8_ = eax;
                           si32(14,_loc8_);
                           _loc1_ = -1;
                           break;
                        }
                        while(true)
                        {
                           _loc1_ = li32(_loc7_);
                           _loc8_ = _loc1_ + -16843009;
                           if((_loc8_ = (_loc6_ = (_loc6_ = _loc1_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                           {
                              continue;
                           }
                           if((_loc8_ = _loc1_ & 255) == 0)
                           {
                              _loc7_ -= _CorruptEnvValueMsg;
                           }
                           else if((_loc8_ = li8(_loc7_ + 1)) == 0)
                           {
                              _loc7_ += 1 - _CorruptEnvValueMsg;
                           }
                           else if((_loc8_ = li8(_loc7_ + 2)) == 0)
                           {
                              _loc7_ += 2 - _CorruptEnvValueMsg;
                           }
                           else
                           {
                              if((_loc8_ = li8(_loc7_ + 3)) != 0)
                              {
                                 continue;
                              }
                              _loc7_ += 3 - _CorruptEnvValueMsg;
                           }
                           §§goto(addr744);
                        }
                     }
                     _loc11_ = _loc7_ + 4;
                     while(true)
                     {
                        _loc8_ = (_loc7_ = li32(_loc11_)) + -16843009;
                        if((_loc8_ = (_loc6_ = (_loc6_ = _loc7_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                        {
                           continue;
                        }
                        if((_loc8_ = _loc7_ & 255) == 0)
                        {
                           _loc11_ -= _loc1_;
                        }
                        else if((_loc8_ = li8(_loc11_ + 1)) == 0)
                        {
                           _loc11_ = (_loc8_ = 1 - _loc1_) + _loc11_;
                        }
                        else if((_loc8_ = li8(_loc11_ + 2)) == 0)
                        {
                           _loc11_ = (_loc8_ = 2 - _loc1_) + _loc11_;
                        }
                        else
                        {
                           if((_loc8_ = li8(_loc11_ + 3)) != 0)
                           {
                              continue;
                           }
                           _loc11_ = (_loc8_ = 3 - _loc1_) + _loc11_;
                        }
                        §§goto(addr479);
                     }
                  }
                  _loc9_ = _loc7_ + 4;
                  while(true)
                  {
                     _loc1_ = li32(_loc9_);
                     _loc8_ = _loc1_ + -16843009;
                     if((_loc8_ = (_loc6_ = (_loc6_ = _loc1_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                     {
                        continue;
                     }
                     if((_loc8_ = _loc1_ & 255) == 0)
                     {
                        _loc9_ -= _loc10_;
                     }
                     else if((_loc8_ = li8(_loc9_ + 1)) == 0)
                     {
                        _loc9_ = (_loc8_ = 1 - _loc10_) + _loc9_;
                     }
                     else if((_loc8_ = li8(_loc9_ + 2)) == 0)
                     {
                        _loc9_ = (_loc8_ = 2 - _loc10_) + _loc9_;
                     }
                     else
                     {
                        if((_loc8_ = li8(_loc9_ + 3)) != 0)
                        {
                           continue;
                        }
                        _loc9_ = (_loc8_ = 3 - _loc10_) + _loc9_;
                     }
                     §§goto(addr300);
                  }
               }
               break;
            }
         }
      }
      addr918:
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
