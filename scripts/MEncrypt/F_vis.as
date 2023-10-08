package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1477;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str476;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_vis() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc9_ = _loc1_ & 255;
      _loc7_ = (_loc8_ = li32(_loc3_ + 8)) & 128;
      _loc6_ = li32(_loc3_);
      if(_loc7_ != 0)
      {
         if((_loc7_ = li32(___mb_sb_limit)) > _loc9_)
         {
            if((_loc7_ = (_loc7_ = li8((_loc7_ = (_loc7_ = li32(__CurrentRuneLocale)) + (_loc9_ << 2)) + 53)) & 5) == 0)
            {
            }
            addr165:
            _loc4_ = li32(_loc3_ + 12);
            if((_loc7_ = _loc8_ & 256) != 0)
            {
               if(_loc9_ <= 62)
               {
                  if(_loc9_ != 35)
                  {
                     if(_loc9_ != 42)
                     {
                        addr199:
                        if((_loc7_ = li32(___mb_sb_limit)) > _loc9_)
                        {
                           if((_loc7_ = (_loc7_ = li8((_loc7_ = (_loc7_ = li32(__CurrentRuneLocale)) + (_loc9_ << 2)) + 53)) & 8) == 0)
                           {
                              addr230:
                              if((_loc7_ = _loc8_ & 4) == 0)
                              {
                                 if(_loc9_ != 32)
                                 {
                                 }
                                 §§goto(addr288);
                              }
                              if((_loc7_ = _loc8_ & 8) == 0)
                              {
                                 if(_loc9_ != 9)
                                 {
                                 }
                                 §§goto(addr288);
                              }
                              if((_loc7_ = _loc8_ & 16) == 0)
                              {
                                 if(_loc9_ != 10)
                                 {
                                 }
                                 §§goto(addr288);
                              }
                              if((_loc7_ = _loc8_ & 32) != 0)
                              {
                                 if((uint(_loc7_ = _loc9_ + -7)) >= 2)
                                 {
                                    if(_loc9_ == 13)
                                    {
                                       §§goto(addr288);
                                    }
                                    else
                                    {
                                       addr324:
                                       if((_loc7_ = _loc8_ & 2) != 0)
                                       {
                                          if(_loc9_ <= 9)
                                          {
                                             if(_loc9_ <= 7)
                                             {
                                                if(_loc9_ != 0)
                                                {
                                                   if(_loc9_ != 7)
                                                   {
                                                      addr548:
                                                      if((_loc4_ = _loc1_ & 127) != 32)
                                                      {
                                                         if((_loc7_ = li32(___mb_sb_limit)) > _loc9_)
                                                         {
                                                            var _loc5_:*;
                                                            if((_loc7_ = (_loc7_ = li8((_loc7_ = (_loc5_ = li32(__CurrentRuneLocale)) + (_loc9_ << 2)) + 53)) & 8) == 0)
                                                            {
                                                            }
                                                            addr595:
                                                            si8(92,_loc6_);
                                                            si8(_loc5_ = (_loc5_ = (_loc7_ = _loc1_ & 255) >>> 6) | 48,_loc6_ + 1);
                                                            si8(_loc7_ = (_loc7_ = (_loc7_ >>>= 3) & 7) | 48,_loc6_ + 2);
                                                            si8(_loc7_ = (_loc7_ = _loc1_ & 7) | 48,_loc6_ + 3);
                                                            _loc1_ = _loc6_ + 4;
                                                            §§goto(addr771);
                                                         }
                                                         if((_loc7_ = _loc8_ & 1) == 0)
                                                         {
                                                            if((_loc7_ = _loc8_ & 64) == 0)
                                                            {
                                                               si8(92,_loc6_);
                                                               _loc6_ += 1;
                                                            }
                                                            if((_loc7_ = _loc1_ & 128) != 0)
                                                            {
                                                               si8(77,_loc6_);
                                                               _loc6_ += 1;
                                                               _loc9_ = _loc4_;
                                                            }
                                                            if((_loc7_ = li32(___mb_sb_limit)) > _loc9_)
                                                            {
                                                               if((_loc7_ = (_loc7_ = li8((_loc7_ = (_loc7_ = li32(__CurrentRuneLocale)) + (_loc9_ << 2)) + 53)) & 2) != 0)
                                                               {
                                                                  si8(94,_loc6_);
                                                                  if(_loc9_ == 127)
                                                                  {
                                                                     si8(63,_loc6_ + 1);
                                                                     _loc1_ = _loc6_ + 2;
                                                                  }
                                                                  else
                                                                  {
                                                                     si8(_loc7_ = _loc9_ + 64,_loc6_ + 1);
                                                                     _loc1_ = _loc6_ + 2;
                                                                  }
                                                               }
                                                               §§goto(addr771);
                                                            }
                                                            si8(45,_loc6_);
                                                            si8(_loc9_,_loc6_ + 1);
                                                            _loc1_ = _loc6_ + 2;
                                                            §§goto(addr771);
                                                         }
                                                         addr771:
                                                         si8(0,_loc1_);
                                                         §§goto(addr288);
                                                      }
                                                      §§goto(addr595);
                                                   }
                                                   else
                                                   {
                                                      si8(92,_loc6_);
                                                      si8(97,_loc6_ + 1);
                                                      _loc1_ = _loc6_ + 2;
                                                   }
                                                }
                                                else
                                                {
                                                   si8(92,_loc6_);
                                                   si8(48,_loc6_ + 1);
                                                   _loc1_ = _loc6_ + 2;
                                                   if((uint(_loc7_ = (_loc7_ = _loc4_ + -48) & 255)) <= 7)
                                                   {
                                                      si8(48,_loc6_ + 2);
                                                      si8(48,_loc6_ + 3);
                                                      _loc1_ = _loc6_ + 4;
                                                   }
                                                }
                                             }
                                             else if(_loc9_ != 8)
                                             {
                                                if(_loc9_ != 9)
                                                {
                                                   §§goto(addr548);
                                                }
                                                else
                                                {
                                                   si8(92,_loc6_);
                                                   si8(116,_loc6_ + 1);
                                                   _loc1_ = _loc6_ + 2;
                                                }
                                             }
                                             else
                                             {
                                                si8(92,_loc6_);
                                                si8(98,_loc6_ + 1);
                                                _loc1_ = _loc6_ + 2;
                                             }
                                          }
                                          else if(_loc9_ <= 11)
                                          {
                                             if(_loc9_ != 10)
                                             {
                                                if(_loc9_ != 11)
                                                {
                                                   §§goto(addr548);
                                                }
                                                else
                                                {
                                                   si8(92,_loc6_);
                                                   si8(118,_loc6_ + 1);
                                                   _loc1_ = _loc6_ + 2;
                                                }
                                             }
                                             else
                                             {
                                                si8(92,_loc6_);
                                                si8(110,_loc6_ + 1);
                                                _loc1_ = _loc6_ + 2;
                                             }
                                          }
                                          else if(_loc9_ != 12)
                                          {
                                             if(_loc9_ != 13)
                                             {
                                                if(_loc9_ != 32)
                                                {
                                                   §§goto(addr548);
                                                }
                                                else
                                                {
                                                   si8(92,_loc6_);
                                                   si8(115,_loc6_ + 1);
                                                   _loc1_ = _loc6_ + 2;
                                                }
                                             }
                                             else
                                             {
                                                si8(92,_loc6_);
                                                si8(114,_loc6_ + 1);
                                                _loc1_ = _loc6_ + 2;
                                             }
                                          }
                                          else
                                          {
                                             si8(92,_loc6_);
                                             si8(102,_loc6_ + 1);
                                             _loc1_ = _loc6_ + 2;
                                          }
                                          §§goto(addr595);
                                       }
                                       §§goto(addr548);
                                    }
                                 }
                              }
                              §§goto(addr324);
                           }
                           addr288:
                           si8(_loc1_,_loc6_);
                           _loc1_ = _loc6_ + 1;
                           if(_loc9_ == 92)
                           {
                              if((_loc7_ = _loc8_ & 64) == 0)
                              {
                                 si8(92,_loc6_ + 1);
                                 _loc1_ = _loc6_ + 2;
                              }
                           }
                           si8(0,_loc1_);
                           eax = _loc1_;
                           _loc2_ = _loc3_;
                           ESP = _loc2_;
                           return;
                        }
                        §§goto(addr230);
                     }
                  }
               }
               else if(_loc9_ != 63)
               {
                  if(_loc9_ != 91)
                  {
                     §§goto(addr199);
                  }
               }
               §§goto(addr324);
            }
            §§goto(addr199);
         }
         if(_loc9_ <= 38)
         {
            if(_loc9_ != 33)
            {
               if(_loc9_ != 36)
               {
                  addr105:
                  si8(37,_loc6_);
                  _loc2_ -= 16;
                  si32(4,_loc2_ + 4);
                  si32(_loc7_ = _loc6_ + 1,_loc2_);
                  si32(_loc9_,_loc2_ + 12);
                  _loc8_ = L__2E_str476;
                  if(uint(_loc9_) >= 16)
                  {
                     _loc8_ = L__2E_str1477;
                  }
                  si32(_loc8_,_loc2_ + 8);
                  ESP = _loc2_;
                  F_snprintf();
                  _loc2_ += 16;
                  _loc1_ = _loc6_ + 3;
               }
               else
               {
                  §§goto(addr165);
               }
               §§goto(addr595);
            }
         }
         else if((uint(_loc7_ = _loc9_ + -39)) >= 8)
         {
            if(_loc9_ != 95)
            {
               §§goto(addr105);
            }
            else
            {
               §§goto(addr165);
            }
         }
      }
      §§goto(addr165);
   }
}
