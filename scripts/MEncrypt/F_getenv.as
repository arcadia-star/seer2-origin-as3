package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVars;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVarsTotal;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._intEnviron;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_getenv() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc13_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      if((_loc13_ = li32(_loc3_)) != 0)
      {
         var _loc12_:*;
         for(; (_loc11_ = li8(_loc12_ = _loc13_ + _loc1_)) != 61; _loc1_ += 1)
         {
            if(_loc11_ != 0)
            {
               continue;
            }
            if(_loc1_ == 0)
            {
               break;
            }
            _loc10_ = 0;
            if((_loc9_ = li32(_environ)) != 0)
            {
               _loc8_ = li32(_loc9_);
               _loc10_ = 0;
               if(_loc8_ != 0)
               {
                  if((_loc11_ = li32(_envVars)) != 0)
                  {
                     if(_loc9_ == li32(_intEnviron))
                     {
                        _loc8_ = (_loc12_ = li32(_envVarsTotal)) + -1;
                        loop1:
                        while(true)
                        {
                           _loc10_ = 0;
                           if(_loc8_ <= -1)
                           {
                              break;
                           }
                           _loc9_ = _loc8_ * 5;
                           if((_loc12_ = li8((_loc10_ = _loc11_ + _loc8_ * 20) + 17)) != 0)
                           {
                              _loc9_ = li32((_loc7_ = _loc11_ + (_loc9_ << 2)) + 8);
                              _loc6_ = _loc13_;
                              _loc5_ = _loc9_;
                              _loc4_ = _loc1_;
                              if(_loc1_ != 0)
                              {
                                 while(true)
                                 {
                                    _loc10_ = li8(_loc5_);
                                    _loc12_ = li8(_loc6_);
                                    if(_loc10_ != _loc12_)
                                    {
                                       continue loop1;
                                    }
                                    if(_loc10_ != 0)
                                    {
                                       _loc6_ += 1;
                                       _loc5_ += 1;
                                       if((_loc4_ += -1) != 0)
                                       {
                                          continue;
                                       }
                                    }
                                 }
                              }
                              if((_loc12_ = li8(_loc12_ = _loc9_ + _loc1_)) == 61)
                              {
                                 _loc10_ = (_loc12_ = (_loc12_ = li32(_loc7_ + 8)) + _loc1_) + 1;
                                 break;
                              }
                           }
                           else if((_loc12_ = li8(_loc10_ + 16)) != 0)
                           {
                              if((_loc12_ = li32(_loc12_ = _loc11_ + (_loc9_ << 2))) == _loc1_)
                              {
                                 _loc10_ = li32((_loc6_ = _loc11_ + (_loc9_ << 2)) + 8);
                                 _loc5_ = _loc13_;
                                 _loc4_ = _loc10_;
                                 _loc9_ = _loc1_;
                                 if(_loc1_ != 0)
                                 {
                                    while(true)
                                    {
                                       _loc7_ = li8(_loc4_);
                                       _loc12_ = li8(_loc5_);
                                       if(_loc7_ != _loc12_)
                                       {
                                          break;
                                       }
                                       if(_loc7_ != 0)
                                       {
                                          _loc5_ += 1;
                                          _loc4_ += 1;
                                          if((_loc9_ += -1) != 0)
                                          {
                                             continue;
                                          }
                                       }
                                    }
                                    continue;
                                 }
                                 if((_loc12_ = li8(_loc12_ = _loc10_ + _loc1_)) == 61)
                                 {
                                    _loc10_ = li32(_loc6_ + 12);
                                    break;
                                 }
                              }
                           }
                        }
                     }
                     §§goto(addr470);
                  }
                  if(_loc1_ == 0)
                  {
                     _loc13_ = _loc9_ + 4;
                     while(true)
                     {
                        _loc10_ = 0;
                        if(_loc8_ != 0)
                        {
                           if((_loc12_ = li8(_loc12_ = _loc8_ + _loc1_)) != 61)
                           {
                              continue;
                           }
                           addr211:
                           _loc10_ = (_loc12_ = _loc8_ + _loc1_) + 1;
                        }
                     }
                  }
                  else
                  {
                     _loc11_ = _loc9_ + 4;
                     while(true)
                     {
                        _loc10_ = 0;
                        if(_loc8_ != 0)
                        {
                           while(true)
                           {
                              _loc9_ = li8(_loc12_ = _loc8_ - _loc10_);
                              _loc12_ = li8(_loc12_ = _loc13_ - _loc10_);
                              if(_loc9_ != _loc12_)
                              {
                                 break;
                              }
                              if(_loc9_ != 0)
                              {
                                 _loc10_ += -1;
                                 if(_loc1_ + _loc10_ != 1)
                                 {
                                    continue;
                                 }
                              }
                              if((_loc12_ = li8(_loc12_ = _loc8_ + _loc1_)) != 61)
                              {
                                 break;
                              }
                              §§goto(addr211);
                           }
                           continue;
                        }
                     }
                  }
               }
            }
            §§goto(addr470);
         }
      }
      ESP = _loc2_;
      F___error();
      _loc12_ = eax;
      si32(22,_loc12_);
      _loc10_ = 0;
      addr470:
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
