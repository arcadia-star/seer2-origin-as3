package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F___sfvwrite() : void
   {
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc14_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc15_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32((_loc4_ = _loc2_) + 4);
      _loc15_ = li32(_loc3_ + 8);
      _loc14_ = 0;
      if(_loc15_ != 0)
      {
         if((_loc15_ = (_loc12_ = li16((_loc13_ = li32(_loc4_)) + 12)) & 8) != 0)
         {
            if((_loc15_ = li32(_loc13_ + 16)) == 0)
            {
               if((_loc15_ = _loc12_ & 512) == 0)
               {
                  addr83:
                  _loc2_ -= 16;
                  si32(_loc13_,_loc2_);
                  ESP = _loc2_;
                  F___swsetup();
                  _loc14_ = -1;
                  _loc2_ += 16;
                  if((_loc15_ = eax) == 0)
                  {
                     _loc12_ = li16(_loc13_ + 12);
                  }
                  §§goto(addr1111);
               }
            }
            _loc15_ = _loc12_ & 2;
            _loc11_ = li32((_loc14_ = li32(_loc3_)) + 4);
            _loc10_ = li32(_loc14_);
            if(_loc15_ != 0)
            {
               _loc12_ = _loc14_ + 12;
               while(true)
               {
                  while(_loc11_ != 0)
                  {
                     _loc2_ -= 16;
                     si32(_loc10_,_loc2_ + 4);
                     si32(_loc13_,_loc2_);
                     _loc14_ = 1024;
                     if(uint(_loc11_) <= uint(_loc14_))
                     {
                        _loc14_ = _loc11_;
                     }
                     si32(_loc14_,_loc2_ + 8);
                     ESP = _loc2_;
                     F__swrite();
                     _loc2_ += 16;
                     if((_loc9_ = eax) >= 1)
                     {
                        var _loc8_:*;
                        si32(_loc15_ = (_loc8_ = li32(_loc3_ + 8)) - _loc9_,_loc3_ + 8);
                        _loc11_ -= _loc9_;
                        _loc10_ += _loc9_;
                        _loc14_ = 0;
                        if(_loc8_ != _loc9_)
                        {
                           continue;
                        }
                     }
                     else
                     {
                        addr1094:
                        si16(_loc15_ = (_loc15_ = li16(_loc13_ + 12)) | 64,_loc13_ + 12);
                        _loc14_ = -1;
                     }
                     §§goto(addr1111);
                  }
                  _loc11_ = li32(_loc12_);
                  _loc10_ = li32(_loc12_ - 4);
                  _loc12_ += 8;
               }
            }
            else
            {
               if((_loc15_ = (_loc15_ = _loc12_ & 65535) & 1) == 0)
               {
                  _loc12_ = _loc14_ + 12;
                  loop3:
                  while(true)
                  {
                     while(true)
                     {
                        if(_loc11_ == 0)
                        {
                           continue loop3;
                        }
                        if((_loc15_ = (_loc14_ = li16(_loc13_ + 12)) & 16896) == 16896)
                        {
                           if((uint(_loc15_ = li32(_loc13_ + 8))) < uint(_loc11_))
                           {
                              _loc1_ = li32(_loc13_ + 16);
                              si32(_loc15_ = _loc11_ + 128,_loc13_ + 8);
                              si32(_loc15_ = (_loc8_ = (_loc9_ = li32(_loc13_) - _loc1_) + _loc11_) + 128,_loc13_ + 20);
                              _loc5_ = _loc8_ + 129;
                              _loc2_ -= 16;
                              si32(_loc5_,_loc2_ + 4);
                              si32(_loc1_,_loc2_);
                              ESP = _loc2_;
                              F_realloc();
                              _loc2_ += 16;
                              if((_loc14_ = eax) == 0)
                              {
                                 if(_loc1_ != 0)
                                 {
                                    if(_loc5_ != 0)
                                    {
                                       _loc2_ -= 16;
                                       si32(_loc1_,_loc2_);
                                       ESP = _loc2_;
                                       F_idalloc();
                                       _loc2_ += 16;
                                    }
                                 }
                              }
                              si32(_loc14_,_loc13_ + 16);
                              if(_loc14_ != 0)
                              {
                                 si32(_loc15_ = _loc14_ + _loc9_,_loc13_);
                                 _loc14_ = li16(_loc13_ + 12);
                                 addr434:
                                 _loc9_ = li32(_loc13_ + 8);
                                 if((_loc15_ = _loc14_ & 512) != 0)
                                 {
                                    _loc14_ = _loc11_;
                                    if(uint(_loc9_) <= uint(_loc11_))
                                    {
                                       _loc14_ = _loc9_;
                                    }
                                    _loc9_ = _loc11_;
                                    if(_loc14_ >= 1)
                                    {
                                       _loc2_ -= 16;
                                       si32(_loc10_,_loc2_ + 4);
                                       si32(li32(_loc13_),_loc2_);
                                       si32(_loc14_,_loc2_ + 8);
                                       ESP = _loc2_;
                                       Fmemcpy();
                                       _loc2_ += 16;
                                       si32(_loc15_ = (_loc15_ = li32(_loc13_ + 8)) - _loc14_,_loc13_ + 8);
                                       si32(_loc15_ = (_loc15_ = li32(_loc13_)) + _loc14_,_loc13_);
                                       _loc9_ = _loc11_;
                                    }
                                 }
                                 else
                                 {
                                    _loc14_ = li32(_loc13_);
                                    if(uint(_loc14_) > uint(li32(_loc13_ + 16)))
                                    {
                                       if(uint(_loc9_) < uint(_loc11_))
                                       {
                                          _loc2_ -= 16;
                                          si32(_loc10_,_loc2_ + 4);
                                          si32(_loc14_,_loc2_);
                                          si32(_loc9_,_loc2_ + 8);
                                          ESP = _loc2_;
                                          Fmemcpy();
                                          _loc2_ += 16;
                                          si32(_loc15_ = (_loc15_ = li32(_loc13_)) + _loc9_,_loc13_);
                                          _loc2_ -= 16;
                                          si32(_loc13_,_loc2_);
                                          ESP = _loc2_;
                                          F___fflush();
                                          _loc2_ += 16;
                                          if((_loc15_ = eax) == 0)
                                          {
                                             addr715:
                                             si32(_loc15_ = (_loc8_ = li32(_loc3_ + 8)) - _loc9_,_loc3_ + 8);
                                             _loc11_ -= _loc9_;
                                             _loc10_ += _loc9_;
                                             _loc14_ = 0;
                                             if(_loc8_ == _loc9_)
                                             {
                                                break;
                                             }
                                             continue;
                                          }
                                          §§goto(addr1094);
                                       }
                                       §§goto(addr715);
                                    }
                                    if((uint(_loc9_ = li32(_loc13_ + 20))) <= uint(_loc11_))
                                    {
                                       _loc2_ -= 16;
                                       si32(_loc9_,_loc2_ + 8);
                                       si32(_loc10_,_loc2_ + 4);
                                       si32(_loc13_,_loc2_);
                                       ESP = _loc2_;
                                       F__swrite();
                                       _loc2_ += 16;
                                       if((_loc9_ = eax) < 1)
                                       {
                                          §§goto(addr1094);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ -= 16;
                                       si32(_loc10_,_loc2_ + 4);
                                       si32(_loc14_,_loc2_);
                                       si32(_loc11_,_loc2_ + 8);
                                       ESP = _loc2_;
                                       Fmemcpy();
                                       _loc2_ += 16;
                                       si32(_loc15_ = (_loc15_ = li32(_loc13_ + 8)) - _loc11_,_loc13_ + 8);
                                       si32(_loc15_ = (_loc15_ = li32(_loc13_)) + _loc11_,_loc13_);
                                       _loc9_ = _loc11_;
                                    }
                                 }
                                 §§goto(addr715);
                              }
                              §§goto(addr1094);
                           }
                        }
                        §§goto(addr434);
                     }
                     §§goto(addr1111);
                  }
               }
               else
               {
                  _loc12_ = _loc14_ + 12;
                  _loc9_ = 0;
                  loop0:
                  while(true)
                  {
                     _loc1_ = 0;
                     while(true)
                     {
                        if(_loc11_ == 0)
                        {
                           continue loop0;
                        }
                        _loc14_ = 0;
                        if(_loc1_ == 0)
                        {
                           do
                           {
                              if((_loc15_ = li8(_loc9_ = _loc10_ + _loc14_)) != 10)
                              {
                                 continue;
                              }
                              if(_loc9_ == 0)
                              {
                                 break;
                              }
                              _loc9_ = _loc14_ + 1;
                              _loc1_ = 1;
                           }
                           while(_loc14_ += 1, _loc11_ != _loc14_);
                           
                           _loc9_ = _loc11_ + 1;
                           _loc1_ = 1;
                        }
                        _loc14_ = _loc9_;
                        if(uint(_loc9_) > uint(_loc11_))
                        {
                           _loc14_ = _loc11_;
                        }
                        _loc6_ = li32(_loc13_ + 20);
                        _loc7_ = li32(_loc13_);
                        _loc15_ = li32(_loc13_ + 16);
                        if(uint(_loc7_) > uint(_loc15_))
                        {
                           _loc5_ = _loc6_ + li32(_loc13_ + 8);
                           if(_loc14_ > _loc5_)
                           {
                              _loc2_ -= 16;
                              si32(_loc10_,_loc2_ + 4);
                              si32(_loc7_,_loc2_);
                              si32(_loc5_,_loc2_ + 8);
                              ESP = _loc2_;
                              Fmemcpy();
                              _loc2_ += 16;
                              si32(_loc15_ = (_loc15_ = li32(_loc13_)) + _loc5_,_loc13_);
                              _loc2_ -= 16;
                              si32(_loc13_,_loc2_);
                              ESP = _loc2_;
                              F___fflush();
                              _loc2_ += 16;
                              if((_loc15_ = eax) != 0)
                              {
                                 break;
                              }
                           }
                           else
                           {
                              addr926:
                              if(_loc6_ <= _loc14_)
                              {
                                 _loc2_ -= 16;
                                 si32(_loc6_,_loc2_ + 8);
                                 si32(_loc10_,_loc2_ + 4);
                                 si32(_loc13_,_loc2_);
                                 ESP = _loc2_;
                                 F__swrite();
                                 _loc2_ += 16;
                                 if((_loc5_ = eax) >= 1)
                                 {
                                    §§goto(addr1025);
                                 }
                                 break;
                              }
                              _loc2_ -= 16;
                              si32(_loc10_,_loc2_ + 4);
                              si32(_loc7_,_loc2_);
                              si32(_loc14_,_loc2_ + 8);
                              ESP = _loc2_;
                              Fmemcpy();
                              _loc2_ += 16;
                              si32(_loc15_ = (_loc15_ = li32(_loc13_ + 8)) - _loc14_,_loc13_ + 8);
                              si32(_loc15_ = (_loc15_ = li32(_loc13_)) + _loc14_,_loc13_);
                              _loc5_ = _loc14_;
                           }
                           addr1025:
                           if(_loc9_ == _loc5_)
                           {
                              _loc2_ -= 16;
                              si32(_loc13_,_loc2_);
                              ESP = _loc2_;
                              F___fflush();
                              _loc1_ = 0;
                              _loc2_ += 16;
                              if((_loc15_ = eax) != 0)
                              {
                                 break;
                              }
                           }
                           _loc9_ -= _loc5_;
                           si32(_loc8_ = (_loc15_ = li32(_loc3_ + 8)) - _loc5_,_loc3_ + 8);
                           _loc11_ -= _loc5_;
                           _loc10_ += _loc5_;
                           _loc14_ = 0;
                           if(_loc15_ != _loc5_)
                           {
                              continue;
                           }
                           §§goto(addr1111);
                        }
                        §§goto(addr926);
                     }
                     §§goto(addr1094);
                  }
               }
               §§goto(addr1111);
            }
            addr1111:
            eax = _loc14_;
            _loc2_ = _loc4_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr83);
   }
}
