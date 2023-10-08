package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F__fseeko() : void
   {
      var _loc10_:int = 0;
      var _loc6_:* = 0;
      var _loc18_:* = 0;
      var _loc17_:* = 0;
      var _loc22_:* = 0;
      var _loc1_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc19_:* = 0;
      var _loc20_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc14_:int = 0;
      var _loc7_:* = 0;
      var _loc5_:* = (_loc10_ = ESP) - 112;
      if((_loc22_ = li32((_loc6_ = li32(_loc10_)) + 40)) == 0)
      {
         ESP = _loc5_;
         F___error();
         si32(29,eax);
         _loc20_ = -1;
      }
      else
      {
         _loc19_ = li32(_loc10_ + 8);
         _loc18_ = li32(_loc10_ + 4);
         _loc17_ = li32(_loc10_ + 16);
         if((_loc16_ = li32(_loc10_ + 12)) != 0)
         {
            if(_loc16_ != 2)
            {
               if(_loc16_ == 1)
               {
                  _loc5_ -= 16;
                  si32(_loc15_ = _loc10_ - 8,_loc5_ + 4);
                  si32(_loc6_,_loc5_);
                  ESP = _loc5_;
                  F__ftello();
                  _loc20_ = -1;
                  _loc5_ += 16;
                  var _loc21_:*;
                  if((_loc21_ = eax) == 0)
                  {
                     if((_loc16_ = li32(_loc21_ = _loc15_ | 4)) <= -1)
                     {
                        ESP = _loc5_;
                        F___error();
                        si32(29,eax);
                        _loc20_ = -1;
                     }
                     else
                     {
                        _loc1_ = li32(_loc10_ - 8);
                        _loc20_ = _loc15_ = 1;
                        if(_loc18_ != 0)
                        {
                           _loc20_ = 0;
                        }
                        if(_loc19_ >= 0)
                        {
                           _loc15_ = 0;
                        }
                        if(_loc19_ != 0)
                        {
                           _loc20_ = _loc15_;
                        }
                        if(_loc20_ == 0)
                        {
                           _loc11_ = _loc20_ = 1;
                           if((uint(_loc18_ ^ -1)) < uint(_loc1_))
                           {
                              _loc11_ = 0;
                           }
                           if((_loc15_ = 2147483647 - _loc19_) < _loc16_)
                           {
                              _loc20_ = 0;
                           }
                           if(_loc15_ != _loc16_)
                           {
                              _loc11_ = _loc20_;
                           }
                           if(_loc11_ == 0)
                           {
                              ESP = _loc5_;
                              F___error();
                              si32(84,eax);
                              _loc20_ = -1;
                           }
                           §§goto(addr1877);
                        }
                        _loc15_ = _loc1_ + _loc18_;
                        _loc20_ = _loc11_ = 1;
                        if(uint(_loc15_) >= uint(_loc1_))
                        {
                           _loc20_ = 0;
                        }
                        if(uint(_loc15_) >= uint(_loc18_))
                        {
                           _loc11_ = _loc20_;
                        }
                        if((_loc19_ = (_loc21_ = _loc16_ + _loc19_) + _loc11_) <= -1)
                        {
                           ESP = _loc5_;
                           F___error();
                           si32(22,eax);
                           _loc20_ = -1;
                           §§goto(addr1877);
                        }
                        else
                        {
                           _loc1_ = 1;
                           _loc16_ = 0;
                           if(_loc17_ != 0)
                           {
                              _loc18_ = 1;
                              _loc20_ = -1;
                              _loc11_ = _loc18_;
                              if(_loc15_ <= _loc20_)
                              {
                                 _loc11_ = 0;
                              }
                              if(_loc19_ >= 0)
                              {
                                 _loc18_ = 0;
                              }
                              if(_loc19_ != 0)
                              {
                                 _loc11_ = _loc18_;
                              }
                              if(_loc11_ == 0)
                              {
                                 ESP = _loc5_;
                                 F___error();
                                 si32(84,eax);
                              }
                              §§goto(addr1877);
                           }
                        }
                     }
                  }
               }
               else
               {
                  ESP = _loc5_;
                  F___error();
                  si32(22,eax);
                  _loc20_ = -1;
               }
               §§goto(addr1877);
            }
            else
            {
               addr387:
               _loc21_ = (_loc21_ = _loc10_ - 8) | 4;
               _loc1_ = 0;
               si32(_loc1_,_loc21_);
               si32(_loc1_,_loc10_ - 8);
               _loc15_ = _loc18_;
            }
            if((_loc21_ = li32(_loc6_ + 16)) == 0)
            {
               _loc5_ -= 16;
               si32(_loc6_,_loc5_);
               ESP = _loc5_;
               F___smakebuf();
               _loc5_ += 16;
            }
            if((_loc21_ = (_loc18_ = li16(_loc6_ + 12)) & 2074) == 0)
            {
               if((_loc21_ = _loc18_ & 1024) == 0)
               {
                  if(_loc22_ == ___sseek)
                  {
                     if((_loc22_ = si16(li16(_loc6_ + 14))) >= 0)
                     {
                        _loc5_ -= 16;
                        si32(_loc21_ = _loc10_ - 104,_loc5_ + 4);
                        si32(_loc22_,_loc5_);
                        ESP = _loc5_;
                        F__fstat();
                        _loc5_ += 16;
                        if((_loc21_ = eax) == 0)
                        {
                           if((_loc21_ = (_loc21_ = li16(_loc10_ - 96)) & 61440) == 32768)
                           {
                              si32(_loc21_ = li32(_loc10_ - 40),_loc6_ + 76);
                              si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) | 1024,_loc6_ + 12);
                              addr583:
                              _loc22_ = _loc15_;
                              _loc18_ = _loc19_;
                              if(_loc16_ != 0)
                              {
                                 _loc5_ -= 16;
                                 si32(_loc21_ = _loc10_ - 104,_loc5_ + 4);
                                 si32(si16(li16(_loc6_ + 14)),_loc5_);
                                 ESP = _loc5_;
                                 F__fstat();
                                 _loc5_ += 16;
                                 if((_loc21_ = eax) == 0)
                                 {
                                    _loc22_ = _loc18_ = 1;
                                    if(_loc15_ != 0)
                                    {
                                       _loc22_ = 0;
                                    }
                                    if(_loc19_ >= 0)
                                    {
                                       _loc18_ = 0;
                                    }
                                    if(_loc19_ != 0)
                                    {
                                       _loc22_ = _loc18_;
                                    }
                                    _loc20_ = li32(_loc10_ - 52);
                                    _loc18_ = li32(_loc10_ - 56);
                                    if(_loc22_ == 0)
                                    {
                                       _loc22_ = _loc11_ = 1;
                                       if(uint(_loc18_) > (uint(_loc15_ ^ -1)))
                                       {
                                          _loc22_ = 0;
                                       }
                                       _loc13_ = 2147483647 - _loc19_;
                                       if(_loc20_ > _loc13_)
                                       {
                                          _loc11_ = 0;
                                       }
                                       if(_loc20_ != _loc13_)
                                       {
                                          _loc22_ = _loc11_;
                                       }
                                       if(_loc22_ == 0)
                                       {
                                          ESP = _loc5_;
                                          F___error();
                                          si32(84,eax);
                                          _loc20_ = -1;
                                       }
                                       §§goto(addr1877);
                                    }
                                    _loc22_ = _loc18_ + _loc15_;
                                    _loc11_ = _loc13_ = 1;
                                    if(uint(_loc22_) >= uint(_loc18_))
                                    {
                                       _loc11_ = 0;
                                    }
                                    if(uint(_loc22_) >= uint(_loc15_))
                                    {
                                       _loc13_ = _loc11_;
                                    }
                                    if((_loc18_ = (_loc21_ = _loc20_ + _loc19_) + _loc13_) <= -1)
                                    {
                                       ESP = _loc5_;
                                       F___error();
                                       si32(22,eax);
                                       _loc20_ = -1;
                                       §§goto(addr1877);
                                    }
                                    else if(_loc17_ != 0)
                                    {
                                       _loc11_ = 1;
                                       _loc20_ = -1;
                                       _loc13_ = _loc11_;
                                       if(_loc22_ <= _loc20_)
                                       {
                                          _loc13_ = 0;
                                       }
                                       if(_loc18_ >= 0)
                                       {
                                          _loc11_ = 0;
                                       }
                                       if(_loc18_ != 0)
                                       {
                                          _loc13_ = _loc11_;
                                       }
                                       if(_loc13_ == 0)
                                       {
                                          ESP = _loc5_;
                                          F___error();
                                          si32(84,eax);
                                       }
                                       §§goto(addr1877);
                                    }
                                    §§goto(addr1877);
                                 }
                                 §§goto(addr1534);
                              }
                              if(_loc1_ == 0)
                              {
                                 _loc5_ -= 16;
                                 si32(_loc21_ = _loc10_ - 8,_loc5_ + 4);
                                 si32(_loc6_,_loc5_);
                                 ESP = _loc5_;
                                 F__ftello();
                                 _loc5_ += 16;
                                 if((_loc21_ = eax) == 0)
                                 {
                                 }
                                 addr1534:
                                 _loc1_ = si16(li16(_loc6_ + 12));
                                 if((_loc21_ = _loc1_ & 8) != 0)
                                 {
                                    if((_loc22_ = li32(_loc6_ + 16)) != 0)
                                    {
                                       _loc18_ = li32(_loc6_);
                                       si32(_loc22_,_loc6_);
                                       _loc1_ = 0;
                                       if((_loc1_ & 3) == 0)
                                       {
                                          _loc1_ = li32(_loc6_ + 20);
                                       }
                                       _loc18_ -= _loc22_;
                                       si32(_loc1_,_loc6_ + 8);
                                       while(true)
                                       {
                                          if(_loc18_ > 0)
                                          {
                                             _loc5_ -= 16;
                                             si32(_loc18_,_loc5_ + 8);
                                             si32(_loc22_,_loc5_ + 4);
                                             si32(_loc6_,_loc5_);
                                             ESP = _loc5_;
                                             F__swrite();
                                             _loc5_ += 16;
                                             _loc1_ = eax;
                                             if(_loc1_ < 1)
                                             {
                                                si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) | 64,_loc6_ + 12);
                                                _loc20_ = -1;
                                                break;
                                             }
                                             continue;
                                          }
                                       }
                                       §§goto(addr1877);
                                    }
                                 }
                                 _loc5_ -= 16;
                                 si32(_loc16_,_loc5_ + 12);
                                 si32(_loc15_,_loc5_ + 4);
                                 si32(_loc6_,_loc5_);
                                 si32(_loc19_,_loc5_ + 8);
                                 ESP = _loc5_;
                                 F__sseek();
                                 _loc5_ += 16;
                                 _loc19_ = eax;
                                 _loc15_ = edx;
                                 _loc21_ = _loc19_ & _loc15_;
                                 _loc20_ = -1;
                                 if(_loc21_ != -1)
                                 {
                                    if(_loc17_ != 0)
                                    {
                                       _loc17_ = 1;
                                       _loc20_ = -1;
                                       _loc16_ = _loc17_;
                                       if(_loc19_ <= _loc20_)
                                       {
                                          _loc16_ = 0;
                                       }
                                       if(_loc15_ >= 0)
                                       {
                                          _loc17_ = 0;
                                       }
                                       if(_loc15_ != 0)
                                       {
                                          _loc16_ = _loc17_;
                                       }
                                       if(_loc16_ == 0)
                                       {
                                          si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) | 64,_loc6_ + 12);
                                          ESP = _loc5_;
                                          F___error();
                                          si32(84,eax);
                                       }
                                       §§goto(addr1877);
                                    }
                                    if((_loc17_ = li32(_loc6_ + 48)) != 0)
                                    {
                                       if(_loc17_ != _loc6_ + 64)
                                       {
                                          _loc5_ -= 16;
                                          si32(_loc17_,_loc5_);
                                          ESP = _loc5_;
                                          F_idalloc();
                                          _loc5_ += 16;
                                       }
                                       si32(0,_loc6_ + 48);
                                    }
                                    si32(_loc21_ = li32(_loc6_ + 16),_loc6_);
                                    si32(_loc20_ = 0,_loc6_ + 4);
                                    si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) & 65503,_loc6_ + 12);
                                    _loc5_ -= 16;
                                    si32(128,_loc5_ + 8);
                                    si32(_loc20_,_loc5_ + 4);
                                    si32(_loc21_ = _loc6_ + 104,_loc5_);
                                    ESP = _loc5_;
                                    Fmemset();
                                    _loc5_ += 16;
                                 }
                                 §§goto(addr1877);
                              }
                              if((_loc21_ = (_loc11_ = li16(_loc6_ + 12)) & 8192) == 0)
                              {
                                 if((_loc20_ = li32(_loc6_ + 48)) != 0)
                                 {
                                    _loc1_ = li32(_loc6_ + 16);
                                    _loc14_ = (_loc21_ = li32(_loc6_ + 56)) - _loc1_;
                                    _loc4_ = li32(_loc6_ + 4);
                                    _loc7_ = li32(_loc10_ - 8);
                                    _loc13_ = _loc4_ + _loc7_;
                                    _loc9_ = _loc8_ = 1;
                                    if(uint(_loc13_) >= uint(_loc14_))
                                    {
                                       _loc9_ = 0;
                                    }
                                    _loc3_ = _loc8_;
                                    if(uint(_loc13_) >= uint(_loc4_))
                                    {
                                       _loc3_ = 0;
                                    }
                                    if(uint(_loc13_) >= uint(_loc7_))
                                    {
                                       _loc8_ = _loc3_;
                                    }
                                    var _loc2_:* = li32(_loc21_ = (_loc21_ = _loc10_ - 8) | 4);
                                    var _loc12_:*;
                                    si32(_loc4_ = (_loc12_ = (_loc12_ = (_loc12_ = _loc4_ >> 31) + _loc2_) + _loc8_) - _loc9_,_loc21_);
                                    si32(_loc13_ -= _loc14_,_loc10_ - 8);
                                    _loc21_ = li32(_loc6_ + 60);
                                    _loc14_ += _loc21_;
                                 }
                                 else
                                 {
                                    _loc1_ = li32(_loc6_ + 16);
                                    _loc14_ = (_loc21_ = li32(_loc6_)) - _loc1_;
                                    _loc4_ = 1;
                                    if((uint(_loc13_ = li32(_loc10_ - 8))) >= uint(_loc14_))
                                    {
                                       _loc4_ = 0;
                                    }
                                    _loc21_ = (_loc21_ = _loc10_ - 8) | 4;
                                    si32(_loc4_ = (_loc12_ = li32(_loc21_)) - _loc4_,_loc21_);
                                    si32(_loc13_ -= _loc14_,_loc10_ - 8);
                                    _loc14_ = (_loc21_ = li32(_loc6_ + 4)) + _loc14_;
                                 }
                                 _loc7_ = _loc9_ = 1;
                                 if(uint(_loc22_) >= uint(_loc13_))
                                 {
                                    _loc7_ = 0;
                                 }
                                 if(_loc18_ >= _loc4_)
                                 {
                                    _loc9_ = 0;
                                 }
                                 if(_loc18_ != _loc4_)
                                 {
                                    _loc7_ = _loc9_;
                                 }
                                 if(_loc7_ == 0)
                                 {
                                    _loc9_ = _loc14_ + _loc13_;
                                    _loc3_ = _loc7_ = 1;
                                    if(uint(_loc9_) >= uint(_loc14_))
                                    {
                                       _loc3_ = 0;
                                    }
                                    _loc8_ = _loc7_;
                                    if(uint(_loc9_) >= uint(_loc13_))
                                    {
                                       _loc8_ = _loc3_;
                                    }
                                    _loc8_ = _loc4_ + _loc8_;
                                    _loc4_ = _loc7_;
                                    if(_loc8_ > _loc18_)
                                    {
                                       _loc4_ = 0;
                                    }
                                    if(uint(_loc9_) > uint(_loc22_))
                                    {
                                       _loc7_ = 0;
                                    }
                                    if(_loc8_ != _loc18_)
                                    {
                                       _loc7_ = _loc4_;
                                    }
                                    if(_loc7_ == 0)
                                    {
                                       _loc21_ = _loc22_ - _loc13_;
                                       si32(_loc12_ = _loc1_ + _loc21_,_loc6_);
                                       si32(_loc21_ = _loc14_ - _loc21_,_loc6_ + 4);
                                       if(_loc20_ != 0)
                                       {
                                          if(_loc20_ != _loc6_ + 64)
                                          {
                                             _loc5_ -= 16;
                                             si32(_loc20_,_loc5_);
                                             ESP = _loc5_;
                                             F_idalloc();
                                             _loc5_ += 16;
                                             _loc11_ = li16(_loc6_ + 12);
                                          }
                                          si32(0,_loc6_ + 48);
                                       }
                                       si16(_loc21_ = _loc11_ & 65503,_loc6_ + 12);
                                       _loc5_ -= 16;
                                       si32(128,_loc5_ + 8);
                                       si32(_loc20_ = 0,_loc5_ + 4);
                                       si32(_loc21_ = _loc6_ + 104,_loc5_);
                                       ESP = _loc5_;
                                       Fmemset();
                                       _loc5_ += 16;
                                    }
                                    §§goto(addr1877);
                                 }
                              }
                              _loc21_ = li32(_loc6_ + 76);
                              _loc12_ = (_loc12_ = (_loc21_ = 0 - _loc21_) >> 31) & _loc18_;
                              _loc2_ = _loc10_ - 8;
                              _loc2_ |= 4;
                              si32(_loc12_,_loc2_);
                              si32(_loc18_ = _loc21_ & _loc22_,_loc10_ - 8);
                              _loc5_ -= 16;
                              si32(_loc20_ = 0,_loc5_ + 12);
                              si32(_loc12_,_loc5_ + 8);
                              si32(_loc18_,_loc5_ + 4);
                              si32(_loc6_,_loc5_);
                              ESP = _loc5_;
                              F__sseek();
                              _loc5_ += 16;
                              _loc12_ = eax;
                              _loc21_ = edx;
                              if((_loc21_ = _loc12_ & _loc21_) != -1)
                              {
                                 si32(_loc20_,_loc6_ + 4);
                                 si32(_loc21_ = li32(_loc6_ + 16),_loc6_);
                                 _loc1_ = li32(_loc6_ + 48);
                                 if(_loc1_ != 0)
                                 {
                                    if(_loc1_ != _loc6_ + 64)
                                    {
                                       _loc5_ -= 16;
                                       si32(_loc1_,_loc5_);
                                       ESP = _loc5_;
                                       F_idalloc();
                                       _loc5_ += 16;
                                    }
                                    si32(_loc20_,_loc6_ + 48);
                                 }
                                 if(_loc22_ != _loc18_)
                                 {
                                    _loc5_ -= 16;
                                    si32(_loc6_,_loc5_);
                                    ESP = _loc5_;
                                    F___srefill();
                                    _loc5_ += 16;
                                    if((_loc21_ = eax) == 0)
                                    {
                                       _loc18_ = _loc22_ - _loc18_;
                                       if((uint(_loc22_ = li32(_loc6_ + 4))) >= uint(_loc18_))
                                       {
                                          si32(_loc21_ = (_loc21_ = li32(_loc6_)) + _loc18_,_loc6_);
                                          si32(_loc21_ = _loc22_ - _loc18_,_loc6_ + 4);
                                       }
                                       else
                                       {
                                          §§goto(addr1534);
                                       }
                                       §§goto(addr1877);
                                    }
                                    §§goto(addr1534);
                                 }
                                 si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) & 65503,_loc6_ + 12);
                                 _loc5_ -= 16;
                                 si32(128,_loc5_ + 8);
                                 si32(_loc20_,_loc5_ + 4);
                                 si32(_loc21_ = _loc6_ + 104,_loc5_);
                                 ESP = _loc5_;
                                 Fmemset();
                                 _loc5_ += 16;
                                 §§goto(addr1877);
                              }
                           }
                           §§goto(addr1534);
                        }
                     }
                  }
                  si16(_loc21_ = (_loc21_ = li16(_loc6_ + 12)) | 2048,_loc6_ + 12);
                  §§goto(addr1534);
               }
               §§goto(addr583);
            }
            §§goto(addr1534);
         }
         else
         {
            if(_loc19_ <= -1)
            {
               ESP = _loc5_;
               F___error();
               si32(22,eax);
               _loc20_ = -1;
            }
            §§goto(addr1877);
         }
      }
      addr1877:
      eax = _loc20_;
      ESP = _loc5_ = _loc10_;
   }
}
