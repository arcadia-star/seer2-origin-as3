package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___vfprintf() : void
   {
      var _loc2_:* = 0;
      var _loc22_:* = 0;
      var _loc24_:* = 0;
      var _loc9_:* = 0;
      var _loc46_:* = 0;
      var _loc48_:* = 0;
      var _loc49_:int = 0;
      var _loc8_:* = 0;
      var _loc40_:int = 0;
      var _loc35_:int = 0;
      var _loc45_:int = 0;
      var _loc37_:int = 0;
      var _loc43_:int = 0;
      var _loc25_:* = 0;
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc23_:* = 0;
      var _loc17_:* = 0;
      var _loc27_:* = 0;
      var _loc30_:* = 0;
      var _loc36_:* = 0;
      var _loc33_:* = 0;
      var _loc29_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc16_:int = 0;
      var _loc14_:int = 0;
      var _loc12_:* = 0;
      var _loc42_:int = 0;
      var _loc44_:int = 0;
      var _loc41_:int = 0;
      var _loc38_:* = NaN;
      var _loc19_:* = 0;
      var _loc18_:* = 0;
      var _loc32_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc21_:* = 0;
      var _loc34_:* = 0;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc31_:* = 0;
      var _loc26_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 528;
      _loc9_ = li32(___use_xprintf);
      _loc26_ = li32(_loc2_ + 8);
      _loc24_ = li32(_loc2_ + 4);
      _loc22_ = li32(_loc2_);
      if(_loc9_ == 0)
      {
         _loc1_ -= 16;
         si32(L__2E_str293,_loc1_);
         ESP = _loc1_;
         F_getenv();
         _loc1_ += 16;
         var _loc20_:*;
         if((_loc20_ = eax) != 0)
         {
            si32(1,___use_xprintf);
            addr156:
            _loc1_ -= 16;
            si32(_loc26_,_loc1_ + 8);
            si32(_loc24_,_loc1_ + 4);
            si32(_loc22_,_loc1_);
            ESP = _loc1_;
            F___xvprintf();
            _loc1_ += 16;
            _loc18_ = eax;
         }
         else
         {
            addr190:
            if((_loc20_ = (_loc9_ = li16(_loc22_ + 12)) & 8) != 0)
            {
               if((_loc20_ = li32(_loc22_ + 16)) == 0)
               {
                  if((_loc20_ = _loc9_ & 512) == 0)
                  {
                     addr220:
                     _loc1_ -= 16;
                     si32(_loc22_,_loc1_);
                     ESP = _loc1_;
                     F___swsetup();
                     _loc18_ = -1;
                     _loc1_ += 16;
                     if((_loc20_ = eax) == 0)
                     {
                     }
                     §§goto(addr10557);
                  }
               }
               si32(0,_loc2_ - 320);
               si32(_loc26_,_loc2_ - 392);
               si32(_loc26_,_loc2_ - 388);
               _loc14_ = (_loc16_ = _loc2_ - 280) + 16;
               _loc12_ = _loc16_ | 4;
               si32(_loc14_,_loc12_);
               si32(0,_loc12_ + 8);
               si32(0,_loc2_ - 272);
               si32(_loc22_,_loc2_ - 280);
               ESP = _loc1_;
               F_localeconv();
               _loc20_ = li8((_loc9_ = li32(_ret_2E_1158)) + 1);
               _loc8_ = 1;
               if(_loc20_ != 0)
               {
                  var _loc47_:*;
                  if((_loc20_ = (_loc47_ = (_loc47_ &= -2139062144) ^ -2139062144) & (_loc47_ = li32(_loc46_ = _loc9_ & -4)) + -16843009) != 0)
                  {
                     _loc48_ = _loc46_ + 4;
                     _loc8_ = 0;
                     while(true)
                     {
                        if((uint(_loc49_ = _loc9_ + _loc8_)) < uint(_loc48_))
                        {
                           continue;
                        }
                     }
                     addr490:
                     _loc43_ = (_loc42_ = _loc2_ - 138) + 5;
                     _loc45_ = (_loc44_ = _loc2_ - 200) + 3;
                     _loc40_ = (_loc41_ = _loc2_ - 312) + 32;
                     _loc37_ = _loc41_ + 31;
                     _loc49_ = _loc42_ + 6;
                     _loc35_ = _loc44_ + 2;
                     _loc36_ = _loc24_;
                     _loc33_ = 0;
                     _loc34_ = 0;
                     _loc46_ = 1;
                     _loc31_ = 0;
                     loop2:
                     while(true)
                     {
                        _loc32_ = 0;
                        while((_loc30_ = li8(_loc29_ = _loc36_ - _loc32_)) != 0)
                        {
                           if(_loc30_ == 37)
                           {
                              break;
                           }
                           _loc32_ += -1;
                        }
                        _loc48_ = _loc33_;
                        if(_loc32_ != 0)
                        {
                           _loc48_ = _loc33_ - _loc32_;
                           _loc18_ = -1;
                           if(_loc48_ >= 0)
                           {
                              si32(_loc36_,_loc14_ + ((_loc47_ = li32(_loc2_ - 272)) << 3));
                              var _loc28_:*;
                              si32(0 - _loc32_,(_loc28_ = _loc14_ + ((_loc47_ = li32(_loc2_ - 272)) << 3)) | 4);
                              si32(_loc20_ = (_loc36_ = li32(_loc2_ - 268)) - _loc32_,_loc2_ - 268);
                              si32(_loc20_ = _loc47_ + 1,_loc2_ - 272);
                              if(_loc20_ >= 8)
                              {
                                 if(_loc36_ == _loc32_)
                                 {
                                    si32(0,_loc2_ - 272);
                                    addr709:
                                    if(_loc30_ != 0)
                                    {
                                       si32(_loc33_ = 0,_loc2_ - 160);
                                       si8(_loc33_,_loc2_ - 139);
                                       si8(_loc33_,_loc2_ - 313);
                                       _loc36_ = _loc29_ + 1;
                                       _loc30_ = -1;
                                       _loc29_ = _loc33_;
                                       loop4:
                                       while(true)
                                       {
                                          _loc32_ = _loc36_ + 1;
                                          _loc11_ = si8(li8(_loc36_));
                                          _loc10_ = _loc29_;
                                          loop5:
                                          while(true)
                                          {
                                             _loc29_ = _loc10_;
                                             while(true)
                                             {
                                                _loc36_ = _loc32_;
                                                _loc10_ = 0;
                                                if(_loc11_ <= 87)
                                                {
                                                   if(_loc11_ <= 64)
                                                   {
                                                      if(_loc11_ <= 42)
                                                      {
                                                         if(_loc11_ <= 38)
                                                         {
                                                            if(_loc11_ == 32)
                                                            {
                                                               if((_loc20_ = li8(_loc2_ - 139)) == 0)
                                                               {
                                                                  si8(32,_loc2_ - 139);
                                                               }
                                                               continue loop4;
                                                            }
                                                            if(_loc11_ == 35)
                                                            {
                                                               _loc33_ |= 1;
                                                               continue loop4;
                                                            }
                                                            addr7094:
                                                            if(_loc11_ == 0)
                                                            {
                                                               break loop2;
                                                            }
                                                            si8(_loc11_,_loc2_ - 312);
                                                            si8(_loc19_ = 0,_loc2_ - 139);
                                                            _loc13_ = 1;
                                                            _loc15_ = _loc2_ - 312;
                                                            _loc32_ = _loc33_;
                                                         }
                                                         else
                                                         {
                                                            if(_loc11_ == 39)
                                                            {
                                                               _loc33_ |= 512;
                                                               continue loop4;
                                                            }
                                                            if(_loc11_ != 42)
                                                            {
                                                               §§goto(addr7094);
                                                            }
                                                            else
                                                            {
                                                               _loc11_ = (_loc15_ = si8(li8(_loc36_))) + -48;
                                                               _loc32_ = 0;
                                                               _loc29_ = _loc36_;
                                                               if(uint(_loc11_) < 10)
                                                               {
                                                                  do
                                                                  {
                                                                     _loc32_ = (_loc20_ = _loc32_ * 10) + _loc11_;
                                                                     _loc20_ = _loc29_ + 1;
                                                                     _loc11_ = (_loc15_ = si8(li8(_loc29_ + 1))) + -48;
                                                                     _loc29_ = _loc20_;
                                                                  }
                                                                  while(uint(_loc11_) < 10);
                                                                  
                                                               }
                                                               _loc20_ = _loc15_ & 255;
                                                               _loc15_ = li32(_loc2_ - 320);
                                                               if(_loc20_ == 36)
                                                               {
                                                                  if(_loc15_ == 0)
                                                                  {
                                                                     si32(_loc20_ = _loc2_ - 384,_loc2_ - 320);
                                                                     _loc1_ -= 16;
                                                                     si32(_loc20_ = _loc2_ - 320,_loc1_ + 8);
                                                                     si32(li32(_loc2_ - 388),_loc1_ + 4);
                                                                     si32(_loc24_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F___find_arguments();
                                                                     _loc18_ = -1;
                                                                     _loc1_ += 16;
                                                                     if((_loc20_ = eax) != 0)
                                                                     {
                                                                        addr10346:
                                                                        addr10346:
                                                                        addr10346:
                                                                        if(_loc34_ != 0)
                                                                        {
                                                                           si32(_loc26_ = li32(_loc34_ - 4),_loc34_);
                                                                           si32(_loc20_ = 1 << _loc26_,_loc34_ + 4);
                                                                           if((_loc24_ = _loc34_ + -4) != 0)
                                                                           {
                                                                              if(_loc26_ >= 10)
                                                                              {
                                                                                 _loc1_ -= 16;
                                                                                 si32(_loc24_,_loc1_);
                                                                                 ESP = _loc1_;
                                                                                 F_idalloc();
                                                                                 _loc1_ += 16;
                                                                              }
                                                                              else
                                                                              {
                                                                                 if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(___gdtoa_locks,_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F__pthread_mutex_lock();
                                                                                    _loc1_ += 16;
                                                                                    _loc26_ = li32(_loc34_);
                                                                                 }
                                                                                 _loc20_ = _loc26_ << 2;
                                                                                 si32(_loc47_ = li32(_loc20_ = _freelist + _loc20_),_loc24_);
                                                                                 si32(_loc24_,_loc20_);
                                                                                 if((_loc20_ = li32(___isthreaded)) != 0)
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(___gdtoa_locks,_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F__pthread_mutex_unlock();
                                                                                    _loc1_ += 16;
                                                                                 }
                                                                              }
                                                                           }
                                                                        }
                                                                        if(_loc31_ != 0)
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(_loc31_,_loc1_);
                                                                           ESP = _loc1_;
                                                                           F_idalloc();
                                                                           _loc1_ += 16;
                                                                        }
                                                                        if((_loc20_ = (_loc20_ = li8(_loc22_ + 12)) & 64) != 0)
                                                                        {
                                                                           _loc18_ = -1;
                                                                        }
                                                                        if((_loc22_ = li32(_loc2_ - 320)) != 0)
                                                                        {
                                                                           if((_loc20_ = _loc2_ - 384) != _loc22_)
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(_loc22_,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F_idalloc();
                                                                              _loc1_ += 16;
                                                                           }
                                                                           §§goto(addr10557);
                                                                        }
                                                                     }
                                                                     if((_loc15_ = li32(_loc2_ - 320)) != 0)
                                                                     {
                                                                        addr1153:
                                                                        _loc20_ = _loc32_ << 3;
                                                                        _loc32_ = _loc15_ + _loc20_;
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc32_ = _loc26_;
                                                                        _loc26_ += 4;
                                                                     }
                                                                     _loc36_ = _loc29_ + 1;
                                                                     addr1207:
                                                                     if((_loc29_ = li32(_loc32_)) <= -1)
                                                                     {
                                                                        _loc29_ = 0 - _loc29_;
                                                                        addr1220:
                                                                        _loc33_ |= 4;
                                                                     }
                                                                     continue loop4;
                                                                     addr10557:
                                                                     eax = _loc18_;
                                                                     _loc1_ = _loc2_;
                                                                     ESP = _loc1_;
                                                                     return;
                                                                  }
                                                                  §§goto(addr1153);
                                                               }
                                                               else
                                                               {
                                                                  if(_loc15_ != 0)
                                                                  {
                                                                     _loc32_ = _loc15_ + (_loc46_ << 3);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc32_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc46_ += 1;
                                                               }
                                                               §§goto(addr1207);
                                                            }
                                                         }
                                                      }
                                                      else if(_loc11_ <= 45)
                                                      {
                                                         if(_loc11_ == 43)
                                                         {
                                                            si8(43,_loc2_ - 139);
                                                            continue loop4;
                                                         }
                                                         if(_loc11_ != 45)
                                                         {
                                                            §§goto(addr7094);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr1220);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if(_loc11_ != 46)
                                                         {
                                                            if(_loc11_ == 48)
                                                            {
                                                               break loop5;
                                                            }
                                                            if((uint(_loc20_ = _loc11_ + -49)) >= 9)
                                                            {
                                                               §§goto(addr7094);
                                                            }
                                                            else
                                                            {
                                                               do
                                                               {
                                                                  _loc20_ = _loc10_ * 10;
                                                                  _loc10_ = (_loc20_ = _loc11_ + _loc20_) + -48;
                                                                  _loc32_ = _loc36_ + 1;
                                                                  _loc20_ = (_loc11_ = si8(li8(_loc36_))) + -48;
                                                                  _loc36_ = _loc32_;
                                                               }
                                                               while(uint(_loc20_) < 10);
                                                               
                                                               if((_loc20_ = _loc11_ & 255) != 36)
                                                               {
                                                                  continue loop5;
                                                               }
                                                               _loc36_ = _loc32_;
                                                               _loc46_ = _loc10_;
                                                               if(li32(_loc2_ - 320) != 0)
                                                               {
                                                                  continue loop4;
                                                               }
                                                               si32(_loc20_ = _loc2_ - 384,_loc2_ - 320);
                                                               _loc1_ -= 16;
                                                               si32(_loc20_ = _loc2_ - 320,_loc1_ + 8);
                                                               si32(li32(_loc2_ - 388),_loc1_ + 4);
                                                               si32(_loc24_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___find_arguments();
                                                               _loc18_ = -1;
                                                               _loc1_ += 16;
                                                               _loc36_ = _loc32_;
                                                               _loc46_ = _loc10_;
                                                               if(eax == 0)
                                                               {
                                                                  continue loop4;
                                                               }
                                                               §§goto(addr10346);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc32_ = _loc36_ + 1;
                                                            if((_loc30_ = li8(_loc36_)) != 42)
                                                            {
                                                               _loc15_ = (_loc11_ = (_loc20_ = _loc30_ << 24) >> 24) + -48;
                                                               _loc30_ = 0;
                                                               if(uint(_loc15_) <= 9)
                                                               {
                                                                  _loc36_ += 1;
                                                                  _loc30_ = 0;
                                                                  do
                                                                  {
                                                                     _loc30_ = (_loc20_ = _loc30_ * 10) + _loc15_;
                                                                     _loc32_ = _loc36_ + 1;
                                                                     _loc15_ = (_loc11_ = si8(li8(_loc36_))) + -48;
                                                                     _loc36_ = _loc32_;
                                                                  }
                                                                  while(uint(_loc15_) < 10);
                                                                  
                                                               }
                                                               continue;
                                                            }
                                                            _loc13_ = (_loc11_ = si8(li8(_loc32_))) + -48;
                                                            _loc15_ = 0;
                                                            _loc30_ = _loc32_;
                                                            if(uint(_loc13_) <= 9)
                                                            {
                                                               do
                                                               {
                                                                  _loc15_ = (_loc20_ = _loc15_ * 10) + _loc13_;
                                                                  _loc30_ = _loc36_ + 1;
                                                                  _loc13_ = (_loc11_ = si8(li8(_loc36_ + 2))) + -48;
                                                                  _loc36_ = _loc30_;
                                                               }
                                                               while(uint(_loc13_) < 10);
                                                               
                                                               _loc30_ += 1;
                                                            }
                                                            _loc20_ = _loc11_ & 255;
                                                            _loc36_ = li32(_loc2_ - 320);
                                                            if(_loc20_ != 36)
                                                            {
                                                               if(_loc36_ != 0)
                                                               {
                                                                  _loc36_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc36_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc30_ = li32(_loc36_);
                                                               _loc46_ += 1;
                                                               _loc36_ = _loc32_;
                                                               continue loop4;
                                                            }
                                                            if(_loc36_ == 0)
                                                            {
                                                               si32(_loc20_ = _loc2_ - 384,_loc2_ - 320);
                                                               _loc1_ -= 16;
                                                               si32(_loc20_ = _loc2_ - 320,_loc1_ + 8);
                                                               si32(li32(_loc2_ - 388),_loc1_ + 4);
                                                               si32(_loc24_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___find_arguments();
                                                               _loc18_ = -1;
                                                               _loc1_ += 16;
                                                               if((_loc20_ = eax) == 0)
                                                               {
                                                                  if((_loc36_ = li32(_loc2_ - 320)) != 0)
                                                                  {
                                                                     addr1419:
                                                                     _loc20_ = _loc15_ << 3;
                                                                     _loc32_ = _loc36_ + _loc20_;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc32_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc36_ = _loc30_ + 1;
                                                                  _loc30_ = li32(_loc32_);
                                                                  continue loop4;
                                                               }
                                                               §§goto(addr10346);
                                                            }
                                                            §§goto(addr1419);
                                                         }
                                                         §§goto(addr10346);
                                                      }
                                                      §§goto(addr10346);
                                                   }
                                                   else if(_loc11_ <= 70)
                                                   {
                                                      if(_loc11_ <= 67)
                                                      {
                                                         if(_loc11_ != 65)
                                                         {
                                                            if(_loc11_ != 67)
                                                            {
                                                               §§goto(addr7094);
                                                            }
                                                            else
                                                            {
                                                               _loc33_ |= 16;
                                                               addr1717:
                                                               if((_loc20_ = _loc33_ & 16) != 0)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(128,_loc1_ + 8);
                                                                  si32(0,_loc1_ + 4);
                                                                  si32(_loc32_ = _loc2_ - 520,_loc1_);
                                                                  ESP = _loc1_;
                                                                  Fmemset();
                                                                  _loc1_ += 16;
                                                                  if((_loc15_ = li32(_loc2_ - 320)) != 0)
                                                                  {
                                                                     _loc15_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc15_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc20_ = li32(_loc15_);
                                                                  _loc47_ = li32(___wcrtomb);
                                                                  _loc1_ -= 16;
                                                                  si32(_loc32_,_loc1_ + 8);
                                                                  si32(_loc20_,_loc1_ + 4);
                                                                  si32(_loc41_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  ptr2fun[_loc47_]();
                                                                  _loc1_ += 16;
                                                                  if((_loc13_ = eax) == -1)
                                                                  {
                                                                     si16(_loc20_ = (_loc20_ = li16(_loc22_ + 12)) | 64,_loc22_ + 12);
                                                                     _loc18_ = _loc48_;
                                                                  }
                                                                  §§goto(addr10346);
                                                               }
                                                               else
                                                               {
                                                                  if((_loc32_ = li32(_loc2_ - 320)) != 0)
                                                                  {
                                                                     _loc32_ = li32(_loc20_ = _loc32_ + (_loc46_ << 3));
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc32_ = li32(_loc26_);
                                                                     _loc26_ += 4;
                                                                  }
                                                                  si8(_loc32_,_loc2_ - 312);
                                                                  _loc13_ = 1;
                                                               }
                                                               si8(_loc19_ = 0,_loc2_ - 139);
                                                               _loc46_ += 1;
                                                               _loc15_ = _loc41_;
                                                               _loc32_ = _loc33_;
                                                               addr7120:
                                                               _loc11_ = 1;
                                                               if((_loc5_ = li8(_loc2_ - 139)) == 0)
                                                               {
                                                                  _loc11_ = 0;
                                                               }
                                                               _loc33_ = _loc13_;
                                                               if(_loc13_ < _loc19_)
                                                               {
                                                                  _loc33_ = _loc19_;
                                                               }
                                                               _loc11_ = (_loc20_ = _loc11_ & 1) + _loc33_;
                                                               if((_loc20_ = li8(_loc2_ - 313)) != 0)
                                                               {
                                                                  _loc11_ += 2;
                                                               }
                                                               _loc33_ = _loc11_;
                                                               if(_loc11_ < _loc29_)
                                                               {
                                                                  _loc33_ = _loc29_;
                                                               }
                                                               _loc33_ += _loc48_;
                                                               _loc18_ = -1;
                                                               if(_loc33_ >= 0)
                                                               {
                                                                  if((_loc10_ = _loc32_ & 132) == 0)
                                                                  {
                                                                     _loc7_ = _loc29_ - _loc11_;
                                                                     while(true)
                                                                     {
                                                                        if(_loc7_ <= 0)
                                                                        {
                                                                           _loc5_ = li8(_loc2_ - 139);
                                                                        }
                                                                        else
                                                                        {
                                                                           si32(_blanks,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                           _loc5_ = 16;
                                                                           if(_loc7_ <= _loc5_)
                                                                           {
                                                                              _loc5_ = _loc7_;
                                                                           }
                                                                           _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                           _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                           si32(_loc5_,_loc47_);
                                                                           si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc5_,_loc2_ - 268);
                                                                           si32(_loc20_ += 1,_loc2_ - 272);
                                                                           if(_loc20_ < 8)
                                                                           {
                                                                              continue;
                                                                           }
                                                                           if(_loc18_ == 0)
                                                                           {
                                                                              si32(0,_loc2_ - 272);
                                                                              continue;
                                                                           }
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc48_;
                                                                           if(eax == 0)
                                                                           {
                                                                              continue;
                                                                           }
                                                                           §§goto(addr10346);
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  if((_loc20_ = _loc5_ & 255) != 0)
                                                                  {
                                                                     si32(_loc47_ = _loc2_ - 139,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                     si32(1,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                     si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + 1,_loc2_ - 268);
                                                                     si32(_loc20_ += 1,_loc2_ - 272);
                                                                     if(_loc20_ >= 8)
                                                                     {
                                                                        if(_loc18_ == 0)
                                                                        {
                                                                           si32(0,_loc2_ - 272);
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc48_;
                                                                           if(eax == 0)
                                                                           {
                                                                           }
                                                                           §§goto(addr10346);
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  if((_loc20_ = li8(_loc2_ - 313)) != 0)
                                                                  {
                                                                     si8(48,_loc2_ - 314);
                                                                     si32(_loc20_ = _loc2_ - 314,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                     si32(2,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                     si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + 2,_loc2_ - 268);
                                                                     si32(_loc20_ += 1,_loc2_ - 272);
                                                                     if(_loc20_ >= 8)
                                                                     {
                                                                        if(_loc18_ == 0)
                                                                        {
                                                                           si32(0,_loc2_ - 272);
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc48_;
                                                                           if(eax == 0)
                                                                           {
                                                                           }
                                                                           §§goto(addr10346);
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  if(_loc10_ == 128)
                                                                  {
                                                                     _loc5_ = _loc29_ - _loc11_;
                                                                     while(true)
                                                                     {
                                                                        if(_loc5_ > 0)
                                                                        {
                                                                           si32(_zeroes,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                           _loc10_ = 16;
                                                                           if(_loc5_ <= _loc10_)
                                                                           {
                                                                              _loc10_ = _loc5_;
                                                                           }
                                                                           _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                           _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                           si32(_loc10_,_loc47_);
                                                                           si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc10_,_loc2_ - 268);
                                                                           si32(_loc20_ += 1,_loc2_ - 272);
                                                                           if(_loc20_ < 8)
                                                                           {
                                                                              continue;
                                                                           }
                                                                           if(_loc18_ == 0)
                                                                           {
                                                                              si32(0,_loc2_ - 272);
                                                                              continue;
                                                                           }
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc48_;
                                                                           if(eax == 0)
                                                                           {
                                                                              continue;
                                                                           }
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  if((_loc20_ = _loc32_ & 256) == 0)
                                                                  {
                                                                     _loc30_ = _loc19_ - _loc13_;
                                                                     while(true)
                                                                     {
                                                                        if(_loc30_ <= 0)
                                                                        {
                                                                           if((_loc20_ = li32(_loc2_ - 160)) != 0)
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(_loc40_,_loc1_ + 12);
                                                                              si32(_loc15_,_loc1_ + 8);
                                                                              si32(_loc16_,_loc1_ + 4);
                                                                              si32(_loc20_ = _loc2_ - 168,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F_grouping_print();
                                                                              _loc1_ += 16;
                                                                              _loc18_ = _loc48_;
                                                                              if(eax >= 0)
                                                                              {
                                                                              }
                                                                              §§goto(addr10346);
                                                                           }
                                                                           else
                                                                           {
                                                                              si32(_loc15_,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                              si32(_loc13_,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                              si32(_loc30_ = (_loc47_ = li32(_loc2_ - 268)) + _loc13_,_loc2_ - 268);
                                                                              si32(_loc20_ += 1,_loc2_ - 272);
                                                                              if(_loc20_ >= 8)
                                                                              {
                                                                                 if(_loc30_ == 0)
                                                                                 {
                                                                                    si32(0,_loc2_ - 272);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(0,_loc2_ - 268);
                                                                                    si32(0,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax != 0)
                                                                                    {
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                              }
                                                                           }
                                                                           addr10074:
                                                                           if((_loc20_ = _loc32_ & 4) != 0)
                                                                           {
                                                                              _loc30_ = _loc29_ - _loc11_;
                                                                              while(true)
                                                                              {
                                                                                 if(_loc30_ > 0)
                                                                                 {
                                                                                    si32(_blanks,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                                    _loc29_ = 16;
                                                                                    if(_loc30_ <= _loc29_)
                                                                                    {
                                                                                       _loc29_ = _loc30_;
                                                                                    }
                                                                                    _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                    _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                    si32(_loc29_,_loc47_);
                                                                                    si32(_loc32_ = (_loc47_ = li32(_loc2_ - 268)) + _loc29_,_loc2_ - 268);
                                                                                    si32(_loc20_ += 1,_loc2_ - 272);
                                                                                    if(_loc20_ < 8)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    if(_loc32_ == 0)
                                                                                    {
                                                                                       si32(0,_loc2_ - 272);
                                                                                       continue;
                                                                                    }
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(0,_loc2_ - 268);
                                                                                    si32(0,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                           }
                                                                           if((_loc20_ = li32(_loc2_ - 268)) == 0)
                                                                           {
                                                                              si32(0,_loc2_ - 272);
                                                                              continue loop2;
                                                                           }
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc33_;
                                                                           if(eax == 0)
                                                                           {
                                                                              continue loop2;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           si32(_zeroes,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                           _loc19_ = 16;
                                                                           if(_loc30_ <= _loc19_)
                                                                           {
                                                                              _loc19_ = _loc30_;
                                                                           }
                                                                           _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                           _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                           si32(_loc19_,_loc47_);
                                                                           si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc19_,_loc2_ - 268);
                                                                           si32(_loc20_ += 1,_loc2_ - 272);
                                                                           if(_loc20_ < 8)
                                                                           {
                                                                              continue;
                                                                           }
                                                                           if(_loc18_ == 0)
                                                                           {
                                                                              si32(0,_loc2_ - 272);
                                                                              continue;
                                                                           }
                                                                           _loc1_ -= 16;
                                                                           si32(_loc12_,_loc1_ + 4);
                                                                           si32(li32(_loc2_ - 280),_loc1_);
                                                                           ESP = _loc1_;
                                                                           F___sfvwrite();
                                                                           _loc1_ += 16;
                                                                           si32(0,_loc2_ - 268);
                                                                           si32(0,_loc2_ - 272);
                                                                           _loc18_ = _loc48_;
                                                                           if(eax == 0)
                                                                           {
                                                                              continue;
                                                                           }
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     if((_loc20_ = _loc25_ & 255) == 0)
                                                                     {
                                                                        if((_loc13_ = li32(_loc2_ - 188)) <= 0)
                                                                        {
                                                                           si32(_zeroes,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                           si32(1,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                           si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + 1,_loc2_ - 268);
                                                                           si32(_loc19_ = _loc20_ + 1,_loc2_ - 272);
                                                                           if(_loc19_ >= 8)
                                                                           {
                                                                              if(_loc18_ == 0)
                                                                              {
                                                                                 si32(_loc19_ = 0,_loc2_ - 272);
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc1_ -= 16;
                                                                                 si32(_loc12_,_loc1_ + 4);
                                                                                 si32(li32(_loc2_ - 280),_loc1_);
                                                                                 ESP = _loc1_;
                                                                                 F___sfvwrite();
                                                                                 _loc1_ += 16;
                                                                                 si32(_loc19_ = 0,_loc2_ - 268);
                                                                                 si32(_loc19_,_loc2_ - 272);
                                                                                 _loc18_ = _loc48_;
                                                                                 if(eax == 0)
                                                                                 {
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                              §§goto(addr10346);
                                                                           }
                                                                           if(_loc30_ == 0)
                                                                           {
                                                                              if((_loc20_ = _loc32_ & 1) != 0)
                                                                              {
                                                                                 addr8238:
                                                                                 _loc20_ = _loc19_ << 3;
                                                                                 _loc20_ = _loc14_ + _loc20_;
                                                                                 si32(_loc9_,_loc20_);
                                                                                 _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                 _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                 si32(_loc8_,_loc47_);
                                                                                 si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc8_,_loc2_ - 268);
                                                                                 si32(_loc19_ = _loc20_ + 1,_loc2_ - 272);
                                                                                 if(_loc19_ >= 8)
                                                                                 {
                                                                                    if(_loc18_ == 0)
                                                                                    {
                                                                                       si32(_loc19_ = 0,_loc2_ - 272);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc12_,_loc1_ + 4);
                                                                                       si32(li32(_loc2_ - 280),_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___sfvwrite();
                                                                                       _loc1_ += 16;
                                                                                       si32(_loc19_ = 0,_loc2_ - 268);
                                                                                       si32(_loc19_,_loc2_ - 272);
                                                                                       _loc18_ = _loc48_;
                                                                                       if(eax == 0)
                                                                                       {
                                                                                       }
                                                                                       §§goto(addr10346);
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                              }
                                                                              _loc10_ = 0 - _loc13_;
                                                                              while(true)
                                                                              {
                                                                                 if(_loc10_ <= 0)
                                                                                 {
                                                                                    _loc13_ += _loc30_;
                                                                                    addr9006:
                                                                                    _loc18_ = (_loc20_ = li32(_loc2_ - 192)) - _loc15_;
                                                                                    _loc30_ = _loc13_;
                                                                                    if(_loc18_ <= _loc13_)
                                                                                    {
                                                                                       _loc30_ = _loc18_;
                                                                                    }
                                                                                    _loc19_ = 0;
                                                                                    if(_loc30_ >= 1)
                                                                                    {
                                                                                       si32(_loc15_,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                                       si32(_loc30_,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                                       si32(_loc15_ = (_loc47_ = li32(_loc2_ - 268)) + _loc30_,_loc2_ - 268);
                                                                                       si32(_loc20_ += 1,_loc2_ - 272);
                                                                                       _loc19_ = _loc30_;
                                                                                       if(_loc20_ >= 8)
                                                                                       {
                                                                                          if(_loc15_ == 0)
                                                                                          {
                                                                                             si32(0,_loc2_ - 272);
                                                                                             _loc19_ = _loc30_;
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc1_ -= 16;
                                                                                             si32(_loc12_,_loc1_ + 4);
                                                                                             si32(li32(_loc2_ - 280),_loc1_);
                                                                                             ESP = _loc1_;
                                                                                             F___sfvwrite();
                                                                                             _loc1_ += 16;
                                                                                             si32(0,_loc2_ - 268);
                                                                                             si32(0,_loc2_ - 272);
                                                                                             _loc19_ = _loc30_;
                                                                                             _loc18_ = _loc48_;
                                                                                             if(eax == 0)
                                                                                             {
                                                                                             }
                                                                                             §§goto(addr10346);
                                                                                          }
                                                                                          §§goto(addr10346);
                                                                                       }
                                                                                    }
                                                                                    _loc15_ = _loc13_ - _loc19_;
                                                                                    while(true)
                                                                                    {
                                                                                       if(_loc15_ <= 0)
                                                                                       {
                                                                                          §§goto(addr10074);
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          si32(_zeroes,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                                          _loc30_ = 16;
                                                                                          if(_loc15_ <= _loc30_)
                                                                                          {
                                                                                             _loc30_ = _loc15_;
                                                                                          }
                                                                                          _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                          _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                          si32(_loc30_,_loc47_);
                                                                                          si32(_loc13_ = (_loc47_ = li32(_loc2_ - 268)) + _loc30_,_loc2_ - 268);
                                                                                          si32(_loc20_ += 1,_loc2_ - 272);
                                                                                          if(_loc20_ < 8)
                                                                                          {
                                                                                             continue;
                                                                                          }
                                                                                          if(_loc13_ == 0)
                                                                                          {
                                                                                             si32(0,_loc2_ - 272);
                                                                                             continue;
                                                                                          }
                                                                                          _loc1_ -= 16;
                                                                                          si32(_loc12_,_loc1_ + 4);
                                                                                          si32(li32(_loc2_ - 280),_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___sfvwrite();
                                                                                          _loc1_ += 16;
                                                                                          si32(0,_loc2_ - 268);
                                                                                          si32(0,_loc2_ - 272);
                                                                                          _loc18_ = _loc48_;
                                                                                          if(eax == 0)
                                                                                          {
                                                                                             continue;
                                                                                          }
                                                                                          §§goto(addr10346);
                                                                                       }
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    si32(_zeroes,_loc14_ + (_loc19_ << 3));
                                                                                    _loc5_ = 16;
                                                                                    if(_loc10_ <= _loc5_)
                                                                                    {
                                                                                       _loc5_ = _loc10_;
                                                                                    }
                                                                                    _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                    _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                    si32(_loc5_,_loc47_);
                                                                                    si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc5_,_loc2_ - 268);
                                                                                    si32(_loc19_ = _loc20_ + 1,_loc2_ - 272);
                                                                                    if(_loc19_ < 8)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    if(_loc18_ == 0)
                                                                                    {
                                                                                       si32(_loc19_ = 0,_loc2_ - 272);
                                                                                       continue;
                                                                                    }
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc19_ = 0,_loc2_ - 268);
                                                                                    si32(_loc19_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                           }
                                                                           §§goto(addr8238);
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc18_ = li32(_loc2_ - 192);
                                                                           if((_loc20_ = li32(_loc2_ - 160)) != 0)
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(_loc18_,_loc1_ + 12);
                                                                              si32(_loc15_,_loc1_ + 8);
                                                                              si32(_loc16_,_loc1_ + 4);
                                                                              si32(_loc20_ = _loc2_ - 168,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F_grouping_print();
                                                                              _loc1_ += 16;
                                                                              _loc13_ = eax;
                                                                              _loc18_ = _loc48_;
                                                                              if(_loc13_ >= 0)
                                                                              {
                                                                              }
                                                                              §§goto(addr10346);
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc19_ = _loc18_ - _loc15_;
                                                                              _loc18_ = _loc13_;
                                                                              if(_loc19_ <= _loc13_)
                                                                              {
                                                                                 _loc18_ = _loc19_;
                                                                              }
                                                                              _loc19_ = 0;
                                                                              if(_loc18_ >= 1)
                                                                              {
                                                                                 si32(_loc15_,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                                 si32(_loc18_,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                                 si32(_loc10_ = (_loc47_ = li32(_loc2_ - 268)) + _loc18_,_loc2_ - 268);
                                                                                 si32(_loc20_ += 1,_loc2_ - 272);
                                                                                 _loc19_ = _loc18_;
                                                                                 if(_loc20_ >= 8)
                                                                                 {
                                                                                    if(_loc10_ == 0)
                                                                                    {
                                                                                       si32(0,_loc2_ - 272);
                                                                                       _loc19_ = _loc18_;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc12_,_loc1_ + 4);
                                                                                       si32(li32(_loc2_ - 280),_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___sfvwrite();
                                                                                       _loc1_ += 16;
                                                                                       si32(0,_loc2_ - 268);
                                                                                       si32(0,_loc2_ - 272);
                                                                                       _loc19_ = _loc18_;
                                                                                       _loc18_ = _loc48_;
                                                                                       if(eax == 0)
                                                                                       {
                                                                                       }
                                                                                       §§goto(addr10346);
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                              }
                                                                              _loc19_ = _loc13_ - _loc19_;
                                                                              while(true)
                                                                              {
                                                                                 if(_loc19_ > 0)
                                                                                 {
                                                                                    si32(_zeroes,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                                    _loc10_ = 16;
                                                                                    if(_loc19_ <= _loc10_)
                                                                                    {
                                                                                       _loc10_ = _loc19_;
                                                                                    }
                                                                                    _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                    _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                    si32(_loc10_,_loc47_);
                                                                                    si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc10_,_loc2_ - 268);
                                                                                    si32(_loc20_ += 1,_loc2_ - 272);
                                                                                    if(_loc20_ < 8)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    if(_loc18_ == 0)
                                                                                    {
                                                                                       si32(0,_loc2_ - 272);
                                                                                       continue;
                                                                                    }
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(0,_loc2_ - 268);
                                                                                    si32(0,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                           }
                                                                           _loc15_ += _loc13_;
                                                                           if(_loc30_ == 0)
                                                                           {
                                                                              _loc13_ = 0;
                                                                              if((_loc32_ & 1) != 0)
                                                                              {
                                                                                 addr8878:
                                                                                 _loc20_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                 _loc20_ = _loc14_ + _loc20_;
                                                                                 si32(_loc9_,_loc20_);
                                                                                 _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                 _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                 si32(_loc8_,_loc47_);
                                                                                 si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc8_,_loc2_ - 268);
                                                                                 si32(_loc20_ += 1,_loc2_ - 272);
                                                                                 _loc13_ = _loc30_;
                                                                                 if(_loc20_ >= 8)
                                                                                 {
                                                                                    if(_loc18_ == 0)
                                                                                    {
                                                                                       si32(0,_loc2_ - 272);
                                                                                       _loc13_ = _loc30_;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc1_ -= 16;
                                                                                       si32(_loc12_,_loc1_ + 4);
                                                                                       si32(li32(_loc2_ - 280),_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___sfvwrite();
                                                                                       _loc1_ += 16;
                                                                                       si32(0,_loc2_ - 268);
                                                                                       si32(0,_loc2_ - 272);
                                                                                       _loc13_ = _loc30_;
                                                                                       _loc18_ = _loc48_;
                                                                                       if(eax == 0)
                                                                                       {
                                                                                       }
                                                                                       §§goto(addr10346);
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                              }
                                                                              §§goto(addr9006);
                                                                           }
                                                                           §§goto(addr8878);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        if(_loc30_ <= 1)
                                                                        {
                                                                           if((_loc20_ = _loc32_ & 1) != 0)
                                                                           {
                                                                              addr9312:
                                                                              _loc20_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                              _loc20_ = _loc14_ + _loc20_;
                                                                              si32(_loc15_,_loc20_);
                                                                              _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                              _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                              si32(1,_loc47_);
                                                                              si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + 1,_loc2_ - 268);
                                                                              si32(_loc13_ = _loc20_ + 1,_loc2_ - 272);
                                                                              if(_loc13_ >= 8)
                                                                              {
                                                                                 if(_loc18_ == 0)
                                                                                 {
                                                                                    si32(_loc13_ = 0,_loc2_ - 272);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc13_ = 0,_loc2_ - 268);
                                                                                    si32(_loc13_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                              _loc20_ = _loc13_ << 3;
                                                                              _loc20_ = _loc14_ + _loc20_;
                                                                              si32(_loc9_,_loc20_);
                                                                              _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                              _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                              si32(_loc8_,_loc47_);
                                                                              si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc8_,_loc2_ - 268);
                                                                              si32(_loc13_ = _loc20_ + 1,_loc2_ - 272);
                                                                              if(_loc13_ >= 8)
                                                                              {
                                                                                 if(_loc18_ == 0)
                                                                                 {
                                                                                    si32(_loc13_ = 0,_loc2_ - 272);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc13_ = 0,_loc2_ - 268);
                                                                                    si32(_loc13_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                              _loc20_ = _loc15_ + 1;
                                                                              _loc47_ = _loc13_ << 3;
                                                                              _loc47_ = _loc14_ + _loc47_;
                                                                              si32(_loc20_,_loc47_);
                                                                              _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                              _loc28_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                              si32(_loc47_ = _loc4_ + -1,_loc28_);
                                                                              si32(_loc13_ = (_loc28_ = li32(_loc2_ - 268)) + _loc47_,_loc2_ - 268);
                                                                              si32(_loc15_ = _loc20_ + 1,_loc2_ - 272);
                                                                              if(_loc15_ >= 8)
                                                                              {
                                                                                 if(_loc13_ == 0)
                                                                                 {
                                                                                    si32(_loc15_ = 0,_loc2_ - 272);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc15_ = 0,_loc2_ - 268);
                                                                                    si32(_loc15_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                              _loc30_ -= _loc4_;
                                                                              while(true)
                                                                              {
                                                                                 if(_loc30_ > 0)
                                                                                 {
                                                                                    si32(_zeroes,_loc14_ + (_loc15_ << 3));
                                                                                    _loc13_ = 16;
                                                                                    if(_loc30_ <= _loc13_)
                                                                                    {
                                                                                       _loc13_ = _loc30_;
                                                                                    }
                                                                                    _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                                    _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                                    si32(_loc13_,_loc47_);
                                                                                    si32(_loc18_ = (_loc47_ = li32(_loc2_ - 268)) + _loc13_,_loc2_ - 268);
                                                                                    si32(_loc15_ = _loc20_ + 1,_loc2_ - 272);
                                                                                    if(_loc15_ < 8)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    if(_loc18_ == 0)
                                                                                    {
                                                                                       si32(_loc15_ = 0,_loc2_ - 272);
                                                                                       continue;
                                                                                    }
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc15_ = 0,_loc2_ - 268);
                                                                                    si32(_loc15_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              si32(_loc15_,_loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3));
                                                                              si32(1,(_loc47_ = _loc14_ + ((_loc20_ = li32(_loc2_ - 272)) << 3)) | 4);
                                                                              si32(_loc30_ = (_loc47_ = li32(_loc2_ - 268)) + 1,_loc2_ - 268);
                                                                              si32(_loc15_ = _loc20_ + 1,_loc2_ - 272);
                                                                              if(_loc15_ >= 8)
                                                                              {
                                                                                 if(_loc30_ == 0)
                                                                                 {
                                                                                    si32(_loc15_ = 0,_loc2_ - 272);
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc1_ -= 16;
                                                                                    si32(_loc12_,_loc1_ + 4);
                                                                                    si32(li32(_loc2_ - 280),_loc1_);
                                                                                    ESP = _loc1_;
                                                                                    F___sfvwrite();
                                                                                    _loc1_ += 16;
                                                                                    si32(_loc15_ = 0,_loc2_ - 268);
                                                                                    si32(_loc15_,_loc2_ - 272);
                                                                                    _loc18_ = _loc48_;
                                                                                    if(eax == 0)
                                                                                    {
                                                                                    }
                                                                                    §§goto(addr10346);
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                           }
                                                                           _loc20_ = _loc15_ << 3;
                                                                           _loc20_ = _loc14_ + _loc20_;
                                                                           si32(_loc44_,_loc20_);
                                                                           _loc47_ = (_loc20_ = li32(_loc2_ - 272)) << 3;
                                                                           _loc47_ = (_loc47_ = _loc14_ + _loc47_) | 4;
                                                                           si32(_loc3_,_loc47_);
                                                                           si32(_loc30_ = (_loc47_ = li32(_loc2_ - 268)) + _loc3_,_loc2_ - 268);
                                                                           si32(_loc20_ += 1,_loc2_ - 272);
                                                                           if(_loc20_ >= 8)
                                                                           {
                                                                              if(_loc30_ == 0)
                                                                              {
                                                                                 si32(0,_loc2_ - 272);
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc1_ -= 16;
                                                                                 si32(_loc12_,_loc1_ + 4);
                                                                                 si32(li32(_loc2_ - 280),_loc1_);
                                                                                 ESP = _loc1_;
                                                                                 F___sfvwrite();
                                                                                 _loc1_ += 16;
                                                                                 si32(0,_loc2_ - 268);
                                                                                 si32(0,_loc2_ - 272);
                                                                                 _loc18_ = _loc48_;
                                                                                 if(eax == 0)
                                                                                 {
                                                                                 }
                                                                                 §§goto(addr10346);
                                                                              }
                                                                              §§goto(addr10346);
                                                                           }
                                                                           §§goto(addr10074);
                                                                        }
                                                                        §§goto(addr9312);
                                                                     }
                                                                     §§goto(addr10346);
                                                                  }
                                                               }
                                                               §§goto(addr10346);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            addr2297:
                                                            _loc27_ = 120;
                                                            if(_loc11_ != 97)
                                                            {
                                                               _loc27_ = 88;
                                                            }
                                                            si8(_loc27_,_loc2_ - 313);
                                                            _loc27_ = _xdigs_lower_2E_4558;
                                                            if(_loc11_ != 97)
                                                            {
                                                               _loc27_ = _xdigs_upper_2E_4559;
                                                            }
                                                            _loc10_ = 112;
                                                            if(_loc11_ != 97)
                                                            {
                                                               _loc10_ = 80;
                                                            }
                                                            if(_loc34_ != 0)
                                                            {
                                                               si32(_loc25_ = li32(_loc34_ - 4),_loc34_);
                                                               si32(_loc20_ = 1 << _loc25_,_loc34_ + 4);
                                                               if((_loc32_ = _loc34_ + -4) != 0)
                                                               {
                                                                  if(_loc25_ >= 10)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(_loc32_,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F_idalloc();
                                                                     _loc1_ += 16;
                                                                  }
                                                                  else
                                                                  {
                                                                     if((_loc20_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(___gdtoa_locks,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F__pthread_mutex_lock();
                                                                        _loc1_ += 16;
                                                                        _loc25_ = li32(_loc34_);
                                                                     }
                                                                     _loc20_ = _loc25_ << 2;
                                                                     si32(_loc47_ = li32(_loc20_ = _freelist + _loc20_),_loc32_);
                                                                     si32(_loc32_,_loc20_);
                                                                     if((_loc20_ = li32(___isthreaded)) != 0)
                                                                     {
                                                                        _loc1_ -= 16;
                                                                        si32(___gdtoa_locks,_loc1_);
                                                                        ESP = _loc1_;
                                                                        F__pthread_mutex_unlock();
                                                                        _loc1_ += 16;
                                                                     }
                                                                  }
                                                               }
                                                            }
                                                            _loc18_ = (_loc20_ = (_loc20_ = _loc30_ >>> 31) ^ 1) + _loc30_;
                                                            _loc20_ = _loc33_ & 8;
                                                            _loc34_ = li32(_loc2_ - 320);
                                                            if(_loc20_ != 0)
                                                            {
                                                               if(_loc34_ != 0)
                                                               {
                                                                  _loc34_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc34_ = _loc26_;
                                                                  _loc26_ += 8;
                                                               }
                                                               var _loc39_:*;
                                                               sf64(_loc39_ = lf64(_loc34_),_loc2_ - 184);
                                                               _loc1_ -= 32;
                                                               si32(_loc47_ = _loc2_ - 192,_loc1_ + 24);
                                                               si32(_loc47_ = _loc2_ - 172,_loc1_ + 20);
                                                               si32(_loc47_ = _loc2_ - 188,_loc1_ + 16);
                                                               si32(_loc18_,_loc1_ + 12);
                                                               si32(_loc27_,_loc1_ + 8);
                                                               sf64(_loc39_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___hdtoa();
                                                               _loc1_ += 32;
                                                               _loc34_ = eax;
                                                            }
                                                            else
                                                            {
                                                               if(_loc34_ != 0)
                                                               {
                                                                  _loc34_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc34_ = _loc26_;
                                                                  _loc26_ += 8;
                                                               }
                                                               sf64(_loc39_ = lf64(_loc34_),_loc2_ - 184);
                                                               _loc1_ -= 32;
                                                               si32(_loc47_ = _loc2_ - 192,_loc1_ + 24);
                                                               si32(_loc47_ = _loc2_ - 172,_loc1_ + 20);
                                                               si32(_loc47_ = _loc2_ - 188,_loc1_ + 16);
                                                               si32(_loc18_,_loc1_ + 12);
                                                               si32(_loc27_,_loc1_ + 8);
                                                               sf64(_loc39_,_loc1_);
                                                               ESP = _loc1_;
                                                               F___hdtoa();
                                                               _loc1_ += 32;
                                                               _loc34_ = eax;
                                                            }
                                                            if(_loc18_ <= -1)
                                                            {
                                                               _loc18_ = (_loc20_ = li32(_loc2_ - 192)) - _loc34_;
                                                            }
                                                            _loc46_ += 1;
                                                            if((_loc20_ = li32(_loc2_ - 188)) == 2147483647)
                                                            {
                                                               si8(0,_loc2_ - 313);
                                                            }
                                                         }
                                                         §§goto(addr7120);
                                                      }
                                                      else
                                                      {
                                                         if(_loc11_ == 68)
                                                         {
                                                            _loc33_ |= 16;
                                                            break loop4;
                                                         }
                                                         if(_loc11_ != 69)
                                                         {
                                                            if(_loc11_ != 70)
                                                            {
                                                               §§goto(addr7094);
                                                            }
                                                            §§goto(addr7120);
                                                         }
                                                         else
                                                         {
                                                            addr2712:
                                                            _loc25_ = 7;
                                                            if(_loc30_ >= 0)
                                                            {
                                                               _loc25_ = _loc30_ + 1;
                                                            }
                                                            _loc30_ = _loc25_;
                                                            _loc10_ = _loc11_;
                                                         }
                                                         addr2741:
                                                         _loc18_ = 6;
                                                         if(_loc30_ >= 0)
                                                         {
                                                            _loc18_ = _loc30_;
                                                         }
                                                         if(_loc34_ != 0)
                                                         {
                                                            si32(_loc30_ = li32(_loc34_ - 4),_loc34_);
                                                            si32(_loc20_ = 1 << _loc30_,_loc34_ + 4);
                                                            if((_loc25_ = _loc34_ + -4) != 0)
                                                            {
                                                               if(_loc30_ >= 10)
                                                               {
                                                                  _loc1_ -= 16;
                                                                  si32(_loc25_,_loc1_);
                                                                  ESP = _loc1_;
                                                                  F_idalloc();
                                                                  _loc1_ += 16;
                                                               }
                                                               else
                                                               {
                                                                  if((_loc20_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_lock();
                                                                     _loc1_ += 16;
                                                                     _loc30_ = li32(_loc34_);
                                                                  }
                                                                  _loc20_ = _loc30_ << 2;
                                                                  si32(_loc47_ = li32(_loc20_ = _freelist + _loc20_),_loc25_);
                                                                  si32(_loc25_,_loc20_);
                                                                  if((_loc20_ = li32(___isthreaded)) != 0)
                                                                  {
                                                                     _loc1_ -= 16;
                                                                     si32(___gdtoa_locks,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F__pthread_mutex_unlock();
                                                                     _loc1_ += 16;
                                                                  }
                                                               }
                                                            }
                                                         }
                                                         _loc20_ = _loc33_ & 8;
                                                         _loc34_ = li32(_loc2_ - 320);
                                                         if(_loc20_ != 0)
                                                         {
                                                            if(_loc34_ != 0)
                                                            {
                                                               _loc34_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc34_ = _loc26_;
                                                               _loc26_ += 8;
                                                            }
                                                            sf64(_loc39_ = lf64(_loc34_),_loc2_ - 184);
                                                            _loc1_ -= 32;
                                                            si32(_loc20_ = _loc2_ - 192,_loc1_ + 20);
                                                            si32(_loc20_ = _loc2_ - 172,_loc1_ + 16);
                                                            si32(_loc20_ = _loc2_ - 188,_loc1_ + 12);
                                                            si32(_loc18_,_loc1_ + 8);
                                                            _loc20_ = _loc10_ & 255;
                                                            _loc34_ = 3;
                                                            if(_loc20_ != 0)
                                                            {
                                                               _loc34_ = 2;
                                                            }
                                                            si32(_loc34_,_loc1_ + 4);
                                                            si32(_loc20_ = _loc2_ - 184,_loc1_);
                                                            ESP = _loc1_;
                                                            F___ldtoa();
                                                            _loc46_ += 1;
                                                            _loc1_ += 32;
                                                            _loc34_ = eax;
                                                         }
                                                         else
                                                         {
                                                            if(_loc34_ != 0)
                                                            {
                                                               _loc34_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc34_ = _loc26_;
                                                               _loc26_ += 8;
                                                            }
                                                            sf64(_loc38_ = lf64(_loc34_),_loc2_ - 184);
                                                            _loc1_ -= 32;
                                                            si32(_loc20_ = _loc2_ - 192,_loc1_ + 24);
                                                            si32(_loc20_ = _loc2_ - 172,_loc1_ + 20);
                                                            si32(_loc20_ = _loc2_ - 188,_loc1_ + 16);
                                                            si32(_loc18_,_loc1_ + 12);
                                                            _loc20_ = _loc10_ & 255;
                                                            _loc25_ = 3;
                                                            if(_loc20_ != 0)
                                                            {
                                                               _loc25_ = 2;
                                                            }
                                                            si32(_loc25_,_loc1_ + 8);
                                                            sf64(_loc38_,_loc1_);
                                                            ESP = _loc1_;
                                                            F___dtoa();
                                                            _loc46_ += 1;
                                                            _loc1_ += 32;
                                                            _loc34_ = eax;
                                                            if((_loc20_ = li32(_loc2_ - 188)) == 9999)
                                                            {
                                                               si32(2147483647,_loc2_ - 188);
                                                            }
                                                         }
                                                      }
                                                      if((_loc20_ = li32(_loc2_ - 172)) != 0)
                                                      {
                                                         si8(45,_loc2_ - 139);
                                                      }
                                                      if((_loc5_ = li32(_loc2_ - 188)) == 2147483647)
                                                      {
                                                         if((_loc20_ = li8(_loc34_)) == 78)
                                                         {
                                                            si8(0,_loc2_ - 139);
                                                            _loc15_ = L__2E_str1294;
                                                            if(_loc11_ <= 96)
                                                            {
                                                               _loc15_ = L__2E_str2295;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc15_ = L__2E_str3296;
                                                            if(_loc11_ <= 96)
                                                            {
                                                               _loc15_ = L__2E_str4297;
                                                            }
                                                         }
                                                         _loc32_ = _loc33_ & -129;
                                                         _loc13_ = 3;
                                                         _loc19_ = 0;
                                                         _loc30_ = _loc18_;
                                                         _loc25_ = _loc10_;
                                                      }
                                                      else
                                                      {
                                                         _loc4_ = (_loc20_ = li32(_loc2_ - 192)) - _loc34_;
                                                         _loc32_ = _loc33_ | 256;
                                                         if((_loc20_ = _loc11_ | 32) == 103)
                                                         {
                                                            _loc30_ = _loc33_ & 1;
                                                            if(_loc5_ >= -3)
                                                            {
                                                               if(_loc5_ <= _loc18_)
                                                               {
                                                                  _loc25_ = 0;
                                                                  _loc15_ = _loc4_;
                                                                  if(_loc30_ != _loc25_)
                                                                  {
                                                                     _loc15_ = _loc18_;
                                                                  }
                                                                  if((_loc30_ = _loc15_ - _loc5_) >= _loc25_)
                                                                  {
                                                                     _loc25_ = _loc30_;
                                                                  }
                                                                  _loc18_ = _loc25_;
                                                               }
                                                               else
                                                               {
                                                                  addr3268:
                                                                  if(_loc30_ == 0)
                                                                  {
                                                                     _loc18_ = _loc4_;
                                                                     addr3275:
                                                                     if((_loc20_ = _loc10_ & 255) != 0)
                                                                     {
                                                                        si8(_loc10_,_loc2_ - 200);
                                                                        _loc30_ = _loc5_ + -1;
                                                                        _loc3_ = 0;
                                                                        _loc25_ = 45;
                                                                        if(_loc30_ >= _loc3_)
                                                                        {
                                                                           _loc25_ = 43;
                                                                        }
                                                                        si8(_loc25_,_loc2_ - 199);
                                                                        _loc25_ = 1 - _loc5_;
                                                                        if(_loc30_ >= _loc3_)
                                                                        {
                                                                           _loc25_ = _loc30_;
                                                                        }
                                                                        if(_loc25_ >= 10)
                                                                        {
                                                                           do
                                                                           {
                                                                              _loc20_ = _loc25_;
                                                                              _loc30_ = _loc42_ - _loc3_;
                                                                              si8(_loc47_ = (_loc47_ = _loc20_ % 10) + 48,_loc30_ + 5);
                                                                              _loc3_ += 1;
                                                                              _loc25_ = _loc20_ / 10;
                                                                           }
                                                                           while(_loc20_ > 99);
                                                                           
                                                                           si8(_loc20_ = _loc25_ + 48,_loc30_ + 4);
                                                                           _loc25_ = _loc35_;
                                                                           if(uint(_loc49_) > uint(_loc43_ - _loc3_))
                                                                           {
                                                                              _loc1_ -= 16;
                                                                              si32(_loc35_,_loc1_);
                                                                              si32(_loc20_ = _loc3_ + 1,_loc1_ + 8);
                                                                              si32(_loc20_ = _loc43_ - _loc3_,_loc1_ + 4);
                                                                              _loc25_ = _loc45_ + _loc3_;
                                                                              ESP = _loc1_;
                                                                              Fmemcpy();
                                                                              _loc1_ += 16;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc3_ = _loc35_;
                                                                           if(((_loc20_ = _loc10_ | 32) & 255) == 101)
                                                                           {
                                                                              si8(48,_loc2_ - 198);
                                                                              _loc3_ = _loc45_;
                                                                           }
                                                                           si8(_loc20_ = _loc25_ + 48,_loc3_);
                                                                           _loc25_ = _loc3_ + 1;
                                                                        }
                                                                        _loc3_ = _loc25_ - _loc44_;
                                                                        _loc13_ = _loc3_ + _loc18_;
                                                                        if(_loc18_ <= 1)
                                                                        {
                                                                           _loc19_ = 0;
                                                                           _loc15_ = _loc34_;
                                                                           _loc30_ = _loc18_;
                                                                           _loc25_ = _loc10_;
                                                                           if((_loc33_ & 1) != 0)
                                                                           {
                                                                           }
                                                                           §§goto(addr7120);
                                                                        }
                                                                        _loc13_ += _loc8_;
                                                                        _loc19_ = 0;
                                                                        _loc15_ = _loc34_;
                                                                        _loc30_ = _loc18_;
                                                                        _loc25_ = _loc10_;
                                                                     }
                                                                     §§goto(addr7120);
                                                                  }
                                                                  §§goto(addr3275);
                                                               }
                                                               _loc11_ = 1;
                                                               if(_loc5_ >= _loc11_)
                                                               {
                                                                  _loc11_ = _loc5_;
                                                               }
                                                               if(_loc18_ == 0)
                                                               {
                                                                  _loc30_ = 0;
                                                                  if((_loc33_ & 1) != 0)
                                                                  {
                                                                     addr3524:
                                                                     _loc11_ = (_loc20_ = _loc11_ + _loc8_) + _loc18_;
                                                                     _loc30_ = _loc18_;
                                                                  }
                                                                  _loc20_ = _loc33_ & 512;
                                                                  _loc25_ = 0;
                                                                  _loc15_ = _loc34_;
                                                                  _loc19_ = _loc25_;
                                                                  _loc13_ = _loc11_;
                                                                  if(_loc20_ != 0)
                                                                  {
                                                                     _loc15_ = _loc34_;
                                                                     _loc19_ = _loc25_;
                                                                     _loc13_ = _loc11_;
                                                                     if(_loc5_ >= 1)
                                                                     {
                                                                        ESP = _loc1_;
                                                                        F_localeconv();
                                                                        si32(_loc33_ = li32(_ret_2E_1158 + 8),_loc2_ - 160);
                                                                        si32(_loc25_ = li32(_ret_2E_1158 + 4),_loc2_ - 168);
                                                                        if((_loc20_ = (_loc47_ = (_loc47_ &= -2139062144) ^ -2139062144) & (_loc47_ = li32(_loc19_ = _loc25_ & -4)) + -16843009) != 0)
                                                                        {
                                                                           _loc13_ = _loc19_ + 4;
                                                                           _loc18_ = 0;
                                                                           while(true)
                                                                           {
                                                                              if((uint(_loc15_ = _loc25_ + _loc18_)) < uint(_loc13_))
                                                                              {
                                                                                 continue;
                                                                              }
                                                                           }
                                                                           addr3764:
                                                                           _loc20_ = (_loc20_ = _loc2_ - 168) | 4;
                                                                           si32(_loc18_,_loc20_);
                                                                           si32(_loc7_ = 0,_loc2_ - 148);
                                                                           si32(_loc7_,_loc2_ - 152);
                                                                           si32(_loc5_,_loc2_ - 156);
                                                                           _loc10_ = _loc7_;
                                                                           while(true)
                                                                           {
                                                                              _loc20_ = _loc10_ + _loc7_;
                                                                              _loc20_ = _loc18_ * _loc20_;
                                                                              _loc13_ = _loc11_ + _loc20_;
                                                                              _loc7_ += 1;
                                                                              while(true)
                                                                              {
                                                                                 _loc6_ = li8(_loc33_);
                                                                                 _loc25_ = 0;
                                                                                 _loc15_ = _loc34_;
                                                                                 _loc19_ = _loc25_;
                                                                                 if(_loc6_ != 127)
                                                                                 {
                                                                                    _loc6_ = (_loc20_ = _loc6_ << 24) >> 24;
                                                                                    _loc25_ = 0;
                                                                                    _loc15_ = _loc34_;
                                                                                    _loc19_ = _loc25_;
                                                                                    if(_loc5_ > _loc6_)
                                                                                    {
                                                                                       _loc25_ = _loc33_ + 1;
                                                                                       si32(_loc5_ -= _loc6_,_loc2_ - 156);
                                                                                       if((_loc20_ = li8(_loc25_)) == 0)
                                                                                       {
                                                                                          break;
                                                                                       }
                                                                                       si32(_loc10_ += 1,_loc2_ - 152);
                                                                                       si32(_loc25_,_loc2_ - 160);
                                                                                       _loc13_ += _loc18_;
                                                                                       _loc33_ = _loc25_;
                                                                                       continue;
                                                                                    }
                                                                                 }
                                                                                 §§goto(addr7120);
                                                                              }
                                                                              si32(_loc7_,_loc2_ - 148);
                                                                           }
                                                                        }
                                                                        _loc15_ = _loc19_ + 4;
                                                                        while(true)
                                                                        {
                                                                           _loc20_ = (_loc13_ = li32(_loc15_)) + -16843009;
                                                                           if((_loc20_ = (_loc47_ = (_loc47_ = _loc13_ & -2139062144) ^ -2139062144) & _loc20_) == 0)
                                                                           {
                                                                              continue;
                                                                           }
                                                                           if((_loc20_ = _loc13_ & 255) == 0)
                                                                           {
                                                                              _loc18_ = _loc15_ - _loc25_;
                                                                           }
                                                                           else if((_loc20_ = li8(_loc15_ + 1)) == 0)
                                                                           {
                                                                              _loc18_ = (_loc20_ = 1 - _loc25_) + _loc15_;
                                                                           }
                                                                           else if((_loc20_ = li8(_loc15_ + 2)) == 0)
                                                                           {
                                                                              _loc18_ = (_loc20_ = 2 - _loc25_) + _loc15_;
                                                                           }
                                                                           else
                                                                           {
                                                                              if((_loc20_ = li8(_loc15_ + 3)) != 0)
                                                                              {
                                                                                 continue;
                                                                              }
                                                                              _loc18_ = (_loc20_ = 3 - _loc25_) + _loc15_;
                                                                           }
                                                                           §§goto(addr3764);
                                                                        }
                                                                     }
                                                                  }
                                                                  §§goto(addr7120);
                                                               }
                                                               §§goto(addr3524);
                                                            }
                                                            §§goto(addr3268);
                                                         }
                                                         §§goto(addr3275);
                                                      }
                                                   }
                                                   else if(_loc11_ <= 78)
                                                   {
                                                      if(_loc11_ != 71)
                                                      {
                                                         if(_loc11_ == 76)
                                                         {
                                                            _loc33_ |= 8;
                                                            continue loop4;
                                                         }
                                                         §§goto(addr7094);
                                                      }
                                                      else
                                                      {
                                                         addr2729:
                                                         _loc10_ = _loc11_ + -2;
                                                         if(_loc30_ == 0)
                                                         {
                                                            _loc30_ = 1;
                                                         }
                                                         §§goto(addr2741);
                                                      }
                                                   }
                                                   else if(_loc11_ != 79)
                                                   {
                                                      if(_loc11_ != 83)
                                                      {
                                                         if(_loc11_ == 85)
                                                         {
                                                            _loc33_ |= 16;
                                                            break;
                                                         }
                                                         §§goto(addr7094);
                                                      }
                                                      else
                                                      {
                                                         _loc33_ |= 16;
                                                         addr4693:
                                                         if((_loc20_ = (_loc32_ = _loc33_) & 16) != 0)
                                                         {
                                                            if(_loc31_ != 0)
                                                            {
                                                               _loc1_ -= 16;
                                                               si32(_loc31_,_loc1_);
                                                               ESP = _loc1_;
                                                               F_idalloc();
                                                               _loc1_ += 16;
                                                            }
                                                            if((_loc33_ = li32(_loc2_ - 320)) != 0)
                                                            {
                                                               _loc33_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc33_ = _loc26_;
                                                               _loc26_ += 4;
                                                            }
                                                            _loc33_ = li32(_loc33_);
                                                            _loc46_ += 1;
                                                            _loc15_ = L__2E_str5298;
                                                            if(_loc33_ != 0)
                                                            {
                                                               if(_loc30_ <= -1)
                                                               {
                                                                  si32(_loc33_,_loc2_ - 132);
                                                                  _loc1_ -= 16;
                                                                  si32(128,_loc1_ + 8);
                                                                  si32(0,_loc1_ + 4);
                                                                  si32(_loc47_ = _loc2_ - 128,_loc1_);
                                                                  ESP = _loc1_;
                                                                  Fmemset();
                                                                  _loc1_ += 16;
                                                                  _loc20_ = li32(___wcsnrtombs);
                                                                  _loc1_ -= 32;
                                                                  si32(_loc47_,_loc1_ + 16);
                                                                  si32(0,_loc1_ + 12);
                                                                  si32(-1,_loc1_ + 8);
                                                                  si32(_loc47_ = _loc2_ - 132,_loc1_ + 4);
                                                                  si32(0,_loc1_);
                                                                  ESP = _loc1_;
                                                                  ptr2fun[_loc20_]();
                                                                  _loc1_ += 32;
                                                                  if((_loc31_ = eax) != -1)
                                                                  {
                                                                     addr5005:
                                                                     _loc1_ -= 16;
                                                                     si32(_loc20_ = _loc31_ + 1,_loc1_);
                                                                     ESP = _loc1_;
                                                                     F_malloc();
                                                                     _loc1_ += 16;
                                                                     if((_loc15_ = eax) != 0)
                                                                     {
                                                                        si32(_loc33_,_loc2_ - 132);
                                                                        _loc1_ -= 16;
                                                                        si32(128,_loc1_ + 8);
                                                                        si32(0,_loc1_ + 4);
                                                                        si32(_loc47_ = _loc2_ - 128,_loc1_);
                                                                        ESP = _loc1_;
                                                                        Fmemset();
                                                                        _loc1_ += 16;
                                                                        _loc20_ = li32(___wcsnrtombs);
                                                                        _loc1_ -= 32;
                                                                        si32(_loc47_,_loc1_ + 16);
                                                                        si32(_loc31_,_loc1_ + 12);
                                                                        si32(-1,_loc1_ + 8);
                                                                        si32(_loc47_ = _loc2_ - 132,_loc1_ + 4);
                                                                        si32(_loc15_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        ptr2fun[_loc20_]();
                                                                        _loc1_ += 32;
                                                                        if((_loc31_ = eax) == -1)
                                                                        {
                                                                           _loc1_ -= 16;
                                                                           si32(_loc15_,_loc1_);
                                                                           ESP = _loc1_;
                                                                           F_idalloc();
                                                                           _loc1_ += 16;
                                                                        }
                                                                        else
                                                                        {
                                                                           si8(0,_loc15_ + _loc31_);
                                                                           _loc31_ = _loc15_;
                                                                           addr5229:
                                                                           _loc13_ = 0;
                                                                           if(_loc30_ <= -1)
                                                                           {
                                                                              if((_loc20_ = (_loc47_ = (_loc47_ &= -2139062144) ^ -2139062144) & (_loc47_ = li32(_loc33_ = _loc15_ & -4)) + -16843009) != 0)
                                                                              {
                                                                                 _loc11_ = _loc33_ + 4;
                                                                                 _loc13_ = 0;
                                                                                 while(true)
                                                                                 {
                                                                                    if((uint(_loc18_ = _loc15_ + _loc13_)) < uint(_loc11_))
                                                                                    {
                                                                                       if((_loc20_ = li8(_loc18_)) != 0)
                                                                                       {
                                                                                          continue;
                                                                                       }
                                                                                       addr5436:
                                                                                       addr5436:
                                                                                       si8(_loc19_ = 0,_loc2_ - 139);
                                                                                       §§goto(addr7120);
                                                                                    }
                                                                                    §§goto(addr5436);
                                                                                 }
                                                                              }
                                                                              _loc11_ = _loc33_ + 4;
                                                                              while(true)
                                                                              {
                                                                                 _loc20_ = (_loc33_ = li32(_loc11_)) + -16843009;
                                                                                 if((_loc20_ = (_loc47_ = (_loc47_ = _loc33_ & -2139062144) ^ -2139062144) & _loc20_) == 0)
                                                                                 {
                                                                                    continue;
                                                                                 }
                                                                                 if((_loc20_ = _loc33_ & 255) == 0)
                                                                                 {
                                                                                    _loc13_ = _loc11_ - _loc15_;
                                                                                 }
                                                                                 else if((_loc20_ = li8(_loc11_ + 1)) == 0)
                                                                                 {
                                                                                    _loc13_ = (_loc20_ = 1 - _loc15_) + _loc11_;
                                                                                 }
                                                                                 else if((_loc20_ = li8(_loc11_ + 2)) == 0)
                                                                                 {
                                                                                    _loc13_ = (_loc20_ = 2 - _loc15_) + _loc11_;
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    if((_loc20_ = li8(_loc11_ + 3)) != 0)
                                                                                    {
                                                                                       continue;
                                                                                    }
                                                                                    _loc13_ = (_loc20_ = 3 - _loc15_) + _loc11_;
                                                                                 }
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              while(uint(_loc13_) < uint(_loc30_))
                                                                              {
                                                                                 if((_loc20_ = li8(_loc20_ = _loc15_ + _loc13_)) == 0)
                                                                                 {
                                                                                    break;
                                                                                 }
                                                                                 _loc13_ += 1;
                                                                              }
                                                                           }
                                                                           §§goto(addr5436);
                                                                        }
                                                                        §§goto(addr10346);
                                                                     }
                                                                  }
                                                                  si16(_loc20_ = (_loc20_ = li16(_loc22_ + 12)) | 64,_loc22_ + 12);
                                                                  _loc31_ = 0;
                                                                  _loc18_ = _loc48_;
                                                                  §§goto(addr10346);
                                                               }
                                                               else
                                                               {
                                                                  _loc31_ = _loc30_;
                                                                  if(_loc30_ >= 128)
                                                                  {
                                                                     si32(_loc33_,_loc2_ - 132);
                                                                     _loc1_ -= 16;
                                                                     si32(128,_loc1_ + 8);
                                                                     si32(_loc31_ = 0,_loc1_ + 4);
                                                                     si32(_loc15_ = _loc2_ - 128,_loc1_);
                                                                     ESP = _loc1_;
                                                                     Fmemset();
                                                                     _loc1_ += 16;
                                                                     _loc13_ = _loc33_;
                                                                     while(true)
                                                                     {
                                                                        _loc20_ = li32(_loc13_);
                                                                        si32(_loc47_ = _loc13_ + 4,_loc2_ - 132);
                                                                        _loc47_ = li32(___wcrtomb);
                                                                        _loc1_ -= 16;
                                                                        si32(_loc15_,_loc1_ + 8);
                                                                        si32(_loc20_,_loc1_ + 4);
                                                                        si32(_loc42_,_loc1_);
                                                                        ESP = _loc1_;
                                                                        ptr2fun[_loc47_]();
                                                                        _loc1_ += 16;
                                                                        if((uint(_loc20_ = (_loc11_ = eax) + -1)) > 4294967293)
                                                                        {
                                                                           break;
                                                                        }
                                                                        if((uint(_loc11_ += _loc31_)) > uint(_loc30_))
                                                                        {
                                                                           break;
                                                                        }
                                                                        _loc13_ = li32(_loc2_ - 132);
                                                                        _loc31_ = _loc11_;
                                                                     }
                                                                  }
                                                               }
                                                               §§goto(addr5005);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            if((_loc33_ = li32(_loc2_ - 320)) != 0)
                                                            {
                                                               _loc33_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc33_ = _loc26_;
                                                               _loc26_ += 4;
                                                            }
                                                            _loc15_ = li32(_loc33_);
                                                            _loc46_ += 1;
                                                            if(_loc15_ == 0)
                                                            {
                                                               _loc15_ = L__2E_str5298;
                                                            }
                                                         }
                                                         §§goto(addr5229);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc33_ |= 16;
                                                      addr4310:
                                                      if((_loc20_ = _loc33_ & 7200) != 0)
                                                      {
                                                         if((_loc20_ = _loc33_ & 4096) != 0)
                                                         {
                                                            if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                            {
                                                               _loc23_ = _loc17_ + (_loc46_ << 3);
                                                            }
                                                            else
                                                            {
                                                               _loc23_ = _loc26_;
                                                               _loc26_ += 8;
                                                            }
                                                            _loc17_ = li32(_loc23_ + 4);
                                                            _loc23_ = li32(_loc23_);
                                                            _loc11_ = 8;
                                                            addr6157:
                                                            si8(0,_loc2_ - 139);
                                                            _loc46_ += 1;
                                                            addr6168:
                                                            _loc32_ = _loc33_ & -129;
                                                            if(_loc30_ <= -1)
                                                            {
                                                               _loc32_ = _loc33_;
                                                            }
                                                            if((_loc20_ = _loc32_ & 7200) != 0)
                                                            {
                                                               _loc13_ = _loc32_ & 1;
                                                               if((_loc23_ | _loc17_) == 0)
                                                               {
                                                                  if(_loc30_ == 0)
                                                                  {
                                                                     _loc15_ = _loc40_;
                                                                     if(_loc13_ != 0)
                                                                     {
                                                                        _loc15_ = _loc40_;
                                                                        if(_loc11_ == 8)
                                                                        {
                                                                           addr6212:
                                                                           if(_loc17_ == 0)
                                                                           {
                                                                              _loc1_ -= 32;
                                                                              si32(_loc27_,_loc1_ + 16);
                                                                              si32(_loc13_,_loc1_ + 12);
                                                                              si32(_loc11_,_loc1_ + 8);
                                                                              si32(_loc40_,_loc1_ + 4);
                                                                              si32(_loc23_,_loc1_);
                                                                              ESP = _loc1_;
                                                                              F___ultoa();
                                                                              _loc1_ += 32;
                                                                              _loc15_ = eax;
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc15_ = _loc40_;
                                                                              _loc19_ = _loc37_;
                                                                              _loc33_ = _loc23_;
                                                                              _loc18_ = _loc17_;
                                                                              if(_loc11_ != 8)
                                                                              {
                                                                                 _loc15_ = _loc40_;
                                                                                 _loc13_ = _loc23_;
                                                                                 _loc33_ = _loc17_;
                                                                                 if(_loc11_ != 16)
                                                                                 {
                                                                                    if(_loc11_ == 10)
                                                                                    {
                                                                                       _loc15_ = _loc40_;
                                                                                       _loc7_ = _loc23_;
                                                                                       _loc5_ = _loc17_;
                                                                                       if(_loc17_ <= -1)
                                                                                       {
                                                                                          _loc1_ -= 16;
                                                                                          si32(0,_loc1_ + 12);
                                                                                          si32(10,_loc1_ + 8);
                                                                                          si32(_loc23_,_loc1_);
                                                                                          si32(_loc17_,_loc1_ + 4);
                                                                                          ESP = _loc1_;
                                                                                          F___udivdi3();
                                                                                          _loc1_ += 16;
                                                                                          _loc7_ = eax;
                                                                                          _loc5_ = edx;
                                                                                          _loc1_ -= 16;
                                                                                          si32(0,_loc1_ + 12);
                                                                                          si32(10,_loc1_ + 8);
                                                                                          si32(_loc17_,_loc1_ + 4);
                                                                                          si32(_loc23_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___umoddi3();
                                                                                          _loc1_ += 16;
                                                                                          si8(_loc20_ = (_loc20_ = eax) | 48,_loc2_ - 281);
                                                                                          _loc15_ = _loc37_;
                                                                                       }
                                                                                       do
                                                                                       {
                                                                                          _loc1_ -= 16;
                                                                                          si32(0,_loc1_ + 12);
                                                                                          si32(10,_loc1_ + 8);
                                                                                          si32(_loc7_,_loc1_);
                                                                                          si32(_loc5_,_loc1_ + 4);
                                                                                          ESP = _loc1_;
                                                                                          F___divdi3();
                                                                                          _loc1_ += 16;
                                                                                          _loc18_ = eax;
                                                                                          _loc13_ = edx;
                                                                                          _loc1_ -= 16;
                                                                                          si32(0,_loc1_ + 12);
                                                                                          si32(10,_loc1_ + 8);
                                                                                          si32(_loc5_,_loc1_ + 4);
                                                                                          si32(_loc7_,_loc1_);
                                                                                          ESP = _loc1_;
                                                                                          F___moddi3();
                                                                                          _loc1_ += 16;
                                                                                          si8(_loc20_ = (_loc20_ = eax) + 48,_loc15_ - 1);
                                                                                          _loc19_ = _loc7_ + 9;
                                                                                          _loc33_ = _loc11_ = 1;
                                                                                          if(uint(_loc19_) <= 18)
                                                                                          {
                                                                                             _loc33_ = 0;
                                                                                          }
                                                                                          _loc10_ = _loc11_;
                                                                                          if(uint(_loc19_) >= uint(_loc7_))
                                                                                          {
                                                                                             _loc10_ = 0;
                                                                                          }
                                                                                          _loc7_ = _loc11_;
                                                                                          if(uint(_loc19_) >= 9)
                                                                                          {
                                                                                             _loc7_ = _loc10_;
                                                                                          }
                                                                                          if((_loc19_ = _loc5_ + _loc7_) == 0)
                                                                                          {
                                                                                             _loc11_ = 0;
                                                                                          }
                                                                                          if(_loc19_ != 0)
                                                                                          {
                                                                                             _loc33_ = _loc11_;
                                                                                          }
                                                                                          _loc15_ += -1;
                                                                                          _loc7_ = _loc18_;
                                                                                          _loc5_ = _loc13_;
                                                                                       }
                                                                                       while(_loc33_ != 0);
                                                                                       
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       ESP = _loc1_;
                                                                                       F_abort();
                                                                                       addr6658:
                                                                                       _loc20_ = _loc21_ | _loc30_;
                                                                                       _loc33_ = _loc32_ & 1;
                                                                                       if(_loc20_ == 0)
                                                                                       {
                                                                                          _loc15_ = _loc40_;
                                                                                          if(_loc33_ != 0)
                                                                                          {
                                                                                             _loc15_ = _loc40_;
                                                                                             if(_loc11_ == 8)
                                                                                             {
                                                                                             }
                                                                                             addr6725:
                                                                                             if((_loc33_ = _loc40_ - _loc15_) >= 33)
                                                                                             {
                                                                                                ESP = _loc1_;
                                                                                                F_abort();
                                                                                             }
                                                                                             _loc20_ = _loc32_ & 512;
                                                                                             _loc19_ = _loc30_;
                                                                                             _loc13_ = _loc33_;
                                                                                             if(_loc20_ != 0)
                                                                                             {
                                                                                                _loc19_ = _loc30_;
                                                                                                _loc13_ = _loc33_;
                                                                                                if(_loc40_ != _loc15_)
                                                                                                {
                                                                                                   ESP = _loc1_;
                                                                                                   F_localeconv();
                                                                                                   si32(_loc11_ = li32(_ret_2E_1158 + 8),_loc2_ - 160);
                                                                                                   si32(_loc13_ = li32(_ret_2E_1158 + 4),_loc2_ - 168);
                                                                                                   if((_loc20_ = (_loc47_ = (_loc47_ &= -2139062144) ^ -2139062144) & (_loc47_ = li32(_loc10_ = _loc13_ & -4)) + -16843009) != 0)
                                                                                                   {
                                                                                                      _loc19_ = _loc10_ + 4;
                                                                                                      _loc18_ = 0;
                                                                                                      while(true)
                                                                                                      {
                                                                                                         if((uint(_loc5_ = _loc13_ + _loc18_)) < uint(_loc19_))
                                                                                                         {
                                                                                                            continue;
                                                                                                         }
                                                                                                      }
                                                                                                      addr6962:
                                                                                                      _loc20_ = (_loc20_ = _loc2_ - 168) | 4;
                                                                                                      si32(_loc18_,_loc20_);
                                                                                                      si32(_loc7_ = 0,_loc2_ - 148);
                                                                                                      si32(_loc7_,_loc2_ - 152);
                                                                                                      si32(_loc33_,_loc2_ - 156);
                                                                                                      _loc5_ = _loc33_;
                                                                                                      _loc10_ = _loc7_;
                                                                                                      loop12:
                                                                                                      while(true)
                                                                                                      {
                                                                                                         _loc20_ = _loc10_ + _loc7_;
                                                                                                         _loc20_ = _loc18_ * _loc20_;
                                                                                                         _loc13_ = _loc33_ + _loc20_;
                                                                                                         _loc7_ += 1;
                                                                                                         while(true)
                                                                                                         {
                                                                                                            _loc6_ = li8(_loc11_);
                                                                                                            _loc19_ = _loc30_;
                                                                                                            if(_loc6_ == 127)
                                                                                                            {
                                                                                                               break;
                                                                                                            }
                                                                                                            _loc6_ = (_loc20_ = _loc6_ << 24) >> 24;
                                                                                                            _loc19_ = _loc30_;
                                                                                                            if(_loc5_ <= _loc6_)
                                                                                                            {
                                                                                                               break;
                                                                                                            }
                                                                                                            _loc19_ = _loc11_ + 1;
                                                                                                            si32(_loc5_ -= _loc6_,_loc2_ - 156);
                                                                                                            if((_loc20_ = li8(_loc19_)) != 0)
                                                                                                            {
                                                                                                               si32(_loc10_ += 1,_loc2_ - 152);
                                                                                                               si32(_loc19_,_loc2_ - 160);
                                                                                                               _loc13_ += _loc18_;
                                                                                                               _loc11_ = _loc19_;
                                                                                                               continue;
                                                                                                            }
                                                                                                            continue loop12;
                                                                                                         }
                                                                                                         §§goto(addr7120);
                                                                                                      }
                                                                                                   }
                                                                                                   _loc18_ = _loc10_ + 4;
                                                                                                   while(true)
                                                                                                   {
                                                                                                      _loc20_ = (_loc19_ = li32(_loc18_)) + -16843009;
                                                                                                      if((_loc20_ = (_loc47_ = (_loc47_ = _loc19_ & -2139062144) ^ -2139062144) & _loc20_) == 0)
                                                                                                      {
                                                                                                         continue;
                                                                                                      }
                                                                                                      if((_loc20_ = _loc19_ & 255) == 0)
                                                                                                      {
                                                                                                         _loc18_ -= _loc13_;
                                                                                                      }
                                                                                                      else if((_loc20_ = li8(_loc18_ + 1)) == 0)
                                                                                                      {
                                                                                                         _loc18_ = (_loc20_ = 1 - _loc13_) + _loc18_;
                                                                                                      }
                                                                                                      else if((_loc20_ = li8(_loc18_ + 2)) == 0)
                                                                                                      {
                                                                                                         _loc18_ = (_loc20_ = 2 - _loc13_) + _loc18_;
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         if((_loc20_ = li8(_loc18_ + 3)) != 0)
                                                                                                         {
                                                                                                            continue;
                                                                                                         }
                                                                                                         _loc18_ = (_loc20_ = 3 - _loc13_) + _loc18_;
                                                                                                      }
                                                                                                      §§goto(addr6962);
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             §§goto(addr7120);
                                                                                          }
                                                                                          §§goto(addr6725);
                                                                                       }
                                                                                       _loc1_ -= 32;
                                                                                       si32(_loc27_,_loc1_ + 16);
                                                                                       si32(_loc33_,_loc1_ + 12);
                                                                                       si32(_loc11_,_loc1_ + 8);
                                                                                       si32(_loc40_,_loc1_ + 4);
                                                                                       si32(_loc21_,_loc1_);
                                                                                       ESP = _loc1_;
                                                                                       F___ultoa();
                                                                                       _loc1_ += 32;
                                                                                       _loc15_ = eax;
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    do
                                                                                    {
                                                                                       _loc20_ = _loc13_ & 15;
                                                                                       si8(_loc20_ = li8(_loc20_ = _loc27_ + _loc20_),_loc15_ - 1);
                                                                                       _loc47_ = _loc13_ >>> 4;
                                                                                       _loc20_ = _loc33_ << 28;
                                                                                       _loc13_ = _loc47_ | _loc20_;
                                                                                       _loc33_ >>>= 4;
                                                                                       _loc20_ = _loc13_ | _loc33_;
                                                                                       _loc15_ += -1;
                                                                                    }
                                                                                    while(_loc20_ != 0);
                                                                                    
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 do
                                                                                 {
                                                                                    si8(_loc11_ = (_loc20_ = _loc33_ & 7) | 48,_loc19_);
                                                                                    _loc47_ = _loc33_ >>> 3;
                                                                                    _loc20_ = _loc18_ << 29;
                                                                                    _loc33_ = _loc47_ | _loc20_;
                                                                                    _loc18_ >>>= 3;
                                                                                    _loc20_ = _loc33_ | _loc18_;
                                                                                    _loc15_ += -1;
                                                                                    _loc19_ += -1;
                                                                                 }
                                                                                 while(_loc20_ != 0);
                                                                                 
                                                                                 if(_loc13_ != 0)
                                                                                 {
                                                                                    if((_loc20_ = _loc11_ & 255) != 48)
                                                                                    {
                                                                                       si8(48,_loc19_);
                                                                                       _loc15_ = _loc19_;
                                                                                    }
                                                                                 }
                                                                              }
                                                                           }
                                                                        }
                                                                     }
                                                                     §§goto(addr6725);
                                                                  }
                                                               }
                                                               §§goto(addr6212);
                                                            }
                                                            §§goto(addr6658);
                                                         }
                                                         else
                                                         {
                                                            if((_loc20_ = _loc33_ & 1024) != 0)
                                                            {
                                                               if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc17_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc17_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc23_ = li32(_loc17_);
                                                               _loc17_ = 0;
                                                               _loc11_ = 8;
                                                            }
                                                            else
                                                            {
                                                               _loc17_ = li32(_loc2_ - 320);
                                                               if((_loc33_ & 2048) != 0)
                                                               {
                                                                  if(_loc17_ != 0)
                                                                  {
                                                                     _loc17_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc17_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc17_ = (_loc23_ = li32(_loc17_)) >> 31;
                                                                  _loc11_ = 8;
                                                               }
                                                               else
                                                               {
                                                                  if(_loc17_ != 0)
                                                                  {
                                                                     _loc23_ = _loc17_ + (_loc46_ << 3);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc23_ = _loc26_;
                                                                     _loc26_ += 8;
                                                                  }
                                                                  _loc17_ = li32(_loc23_ + 4);
                                                                  _loc23_ = li32(_loc23_);
                                                                  _loc11_ = 8;
                                                               }
                                                            }
                                                            §§goto(addr6157);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if((_loc20_ = _loc33_ & 16) != 0)
                                                         {
                                                            if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                            {
                                                               _loc21_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc21_ = _loc26_;
                                                               _loc26_ += 4;
                                                            }
                                                            _loc21_ = li32(_loc21_);
                                                            _loc11_ = 8;
                                                         }
                                                         else if((_loc20_ = _loc33_ & 64) != 0)
                                                         {
                                                            if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                            {
                                                               _loc21_ += _loc46_ << 3;
                                                            }
                                                            else
                                                            {
                                                               _loc21_ = _loc26_;
                                                               _loc26_ += 4;
                                                            }
                                                            _loc21_ = li16(_loc21_);
                                                            _loc11_ = 8;
                                                         }
                                                         else
                                                         {
                                                            _loc21_ = li32(_loc2_ - 320);
                                                            if((_loc33_ & 8192) != 0)
                                                            {
                                                               if(_loc21_ != 0)
                                                               {
                                                                  _loc21_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc21_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc21_ = li8(_loc21_);
                                                               _loc11_ = 8;
                                                            }
                                                            else
                                                            {
                                                               if(_loc21_ != 0)
                                                               {
                                                                  _loc21_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc21_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc21_ = li32(_loc21_);
                                                               _loc11_ = 8;
                                                            }
                                                         }
                                                         §§goto(addr6157);
                                                      }
                                                      §§goto(addr6157);
                                                   }
                                                   §§goto(addr7120);
                                                }
                                                else if(_loc11_ <= 107)
                                                {
                                                   if(_loc11_ <= 101)
                                                   {
                                                      if(_loc11_ <= 98)
                                                      {
                                                         if(_loc11_ != 88)
                                                         {
                                                            if(_loc11_ != 97)
                                                            {
                                                               §§goto(addr7094);
                                                            }
                                                            else
                                                            {
                                                               §§goto(addr2297);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc27_ = _xdigs_upper_2E_4559;
                                                            addr5789:
                                                            if((_loc32_ = _loc33_ & 7200) != 0)
                                                            {
                                                               if((_loc20_ = _loc33_ & 4096) != 0)
                                                               {
                                                                  if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                                  {
                                                                     _loc23_ = _loc17_ + (_loc46_ << 3);
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc23_ = _loc26_;
                                                                     _loc26_ += 8;
                                                                  }
                                                                  _loc17_ = li32(_loc23_ + 4);
                                                                  _loc23_ = li32(_loc23_);
                                                               }
                                                               else if((_loc20_ = _loc33_ & 1024) != 0)
                                                               {
                                                                  if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                                  {
                                                                     _loc17_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc17_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc23_ = li32(_loc17_);
                                                                  _loc17_ = 0;
                                                               }
                                                               else
                                                               {
                                                                  _loc17_ = li32(_loc2_ - 320);
                                                                  if((_loc33_ & 2048) != 0)
                                                                  {
                                                                     if(_loc17_ != 0)
                                                                     {
                                                                        _loc17_ += _loc46_ << 3;
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc17_ = _loc26_;
                                                                        _loc26_ += 4;
                                                                     }
                                                                     _loc17_ = (_loc23_ = li32(_loc17_)) >> 31;
                                                                  }
                                                                  else
                                                                  {
                                                                     if(_loc17_ != 0)
                                                                     {
                                                                        _loc23_ = _loc17_ + (_loc46_ << 3);
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc23_ = _loc26_;
                                                                        _loc26_ += 8;
                                                                     }
                                                                     _loc17_ = li32(_loc23_ + 4);
                                                                     _loc23_ = li32(_loc23_);
                                                                  }
                                                               }
                                                            }
                                                            else if((_loc20_ = _loc33_ & 16) != 0)
                                                            {
                                                               if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc21_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc21_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc21_ = li32(_loc21_);
                                                            }
                                                            else if((_loc20_ = _loc33_ & 64) != 0)
                                                            {
                                                               if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc21_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc21_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc21_ = li16(_loc21_);
                                                            }
                                                            else
                                                            {
                                                               _loc21_ = li32(_loc2_ - 320);
                                                               if((_loc33_ & 8192) != 0)
                                                               {
                                                                  if(_loc21_ != 0)
                                                                  {
                                                                     _loc21_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc21_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc21_ = li8(_loc21_);
                                                               }
                                                               else
                                                               {
                                                                  if(_loc21_ != 0)
                                                                  {
                                                                     _loc21_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc21_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc21_ = li32(_loc21_);
                                                               }
                                                            }
                                                            if((_loc20_ = _loc33_ & 1) != 0)
                                                            {
                                                               _loc15_ = _loc13_ = 1;
                                                               if(_loc21_ == 0)
                                                               {
                                                                  _loc15_ = 0;
                                                               }
                                                               if((_loc20_ = _loc23_ | _loc17_) == 0)
                                                               {
                                                                  _loc13_ = 0;
                                                               }
                                                               if(_loc32_ != 0)
                                                               {
                                                                  _loc15_ = _loc13_;
                                                               }
                                                               if((_loc20_ = _loc15_ & 1) != 0)
                                                               {
                                                                  si8(_loc11_,_loc2_ - 313);
                                                               }
                                                            }
                                                            _loc33_ &= -513;
                                                            _loc11_ = 16;
                                                            §§goto(addr6157);
                                                         }
                                                      }
                                                      else if(_loc11_ != 99)
                                                      {
                                                         if(_loc11_ == 100)
                                                         {
                                                            break loop4;
                                                         }
                                                         if(_loc11_ != 101)
                                                         {
                                                            §§goto(addr7094);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr2712);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         §§goto(addr1717);
                                                      }
                                                      §§goto(addr1717);
                                                   }
                                                   else if(_loc11_ <= 103)
                                                   {
                                                      if(_loc11_ != 102)
                                                      {
                                                         if(_loc11_ != 103)
                                                         {
                                                            §§goto(addr7094);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr2729);
                                                         }
                                                      }
                                                      §§goto(addr2741);
                                                   }
                                                   else
                                                   {
                                                      if(_loc11_ == 104)
                                                      {
                                                         if((_loc20_ = _loc33_ & 64) != 0)
                                                         {
                                                            _loc33_ = (_loc20_ = _loc33_ & -8257) | 8192;
                                                         }
                                                         else
                                                         {
                                                            _loc33_ |= 64;
                                                         }
                                                         continue loop4;
                                                      }
                                                      if(_loc11_ == 105)
                                                      {
                                                         break loop4;
                                                      }
                                                      if(_loc11_ == 106)
                                                      {
                                                         _loc33_ |= 4096;
                                                         continue loop4;
                                                      }
                                                   }
                                                   §§goto(addr7094);
                                                }
                                                else
                                                {
                                                   if(_loc11_ <= 114)
                                                   {
                                                      if(_loc11_ <= 110)
                                                      {
                                                         if(_loc11_ == 108)
                                                         {
                                                            if((_loc20_ = _loc33_ & 16) != 0)
                                                            {
                                                               _loc33_ = (_loc20_ = _loc33_ & -49) | 32;
                                                            }
                                                            else
                                                            {
                                                               _loc33_ |= 16;
                                                            }
                                                            continue loop4;
                                                         }
                                                         if(_loc11_ == 110)
                                                         {
                                                            if((_loc20_ = _loc33_ & 32) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc20_ = li32(_loc29_);
                                                               si32(_loc47_ = _loc48_ >> 31,_loc20_ + 4);
                                                               si32(_loc48_,_loc20_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else if((_loc20_ = _loc33_ & 1024) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc20_ = li32(_loc29_);
                                                               si32(_loc48_,_loc20_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else if((_loc20_ = _loc33_ & 2048) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc20_ = li32(_loc29_);
                                                               si32(_loc48_,_loc20_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else if((_loc20_ = _loc33_ & 4096) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc47_ = li32(_loc29_);
                                                               si32(_loc20_ = _loc48_ >> 31,_loc47_ + 4);
                                                               si32(_loc48_,_loc47_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else if((_loc20_ = _loc33_ & 16) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc20_ = li32(_loc29_);
                                                               si32(_loc48_,_loc20_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else if((_loc20_ = _loc33_ & 64) != 0)
                                                            {
                                                               if((_loc29_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc29_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc29_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc20_ = li32(_loc29_);
                                                               si16(_loc48_,_loc20_);
                                                               _loc46_ += 1;
                                                               _loc33_ = _loc48_;
                                                            }
                                                            else
                                                            {
                                                               _loc29_ = li32(_loc2_ - 320);
                                                               if((_loc33_ & 8192) != 0)
                                                               {
                                                                  if(_loc29_ != 0)
                                                                  {
                                                                     _loc29_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc29_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc20_ = li32(_loc29_);
                                                                  si8(_loc48_,_loc20_);
                                                                  _loc46_ += 1;
                                                                  _loc33_ = _loc48_;
                                                               }
                                                               else
                                                               {
                                                                  if(_loc29_ != 0)
                                                                  {
                                                                     _loc29_ += _loc46_ << 3;
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc29_ = _loc26_;
                                                                     _loc26_ += 4;
                                                                  }
                                                                  _loc20_ = li32(_loc29_);
                                                                  si32(_loc48_,_loc20_);
                                                                  _loc46_ += 1;
                                                                  _loc33_ = _loc48_;
                                                               }
                                                            }
                                                            continue loop2;
                                                         }
                                                         §§goto(addr7094);
                                                      }
                                                      else
                                                      {
                                                         if(_loc11_ != 111)
                                                         {
                                                            if(_loc11_ != 112)
                                                            {
                                                               if(_loc11_ == 113)
                                                               {
                                                                  _loc33_ |= 32;
                                                                  continue loop4;
                                                               }
                                                               §§goto(addr7094);
                                                            }
                                                            else
                                                            {
                                                               if((_loc27_ = li32(_loc2_ - 320)) != 0)
                                                               {
                                                                  _loc27_ += _loc46_ << 3;
                                                               }
                                                               else
                                                               {
                                                                  _loc27_ = _loc26_;
                                                                  _loc26_ += 4;
                                                               }
                                                               _loc23_ = li32(_loc27_);
                                                               si8(120,_loc2_ - 313);
                                                               _loc33_ |= 4096;
                                                               _loc17_ = 0;
                                                               _loc27_ = _xdigs_lower_2E_4558;
                                                               _loc11_ = 16;
                                                               §§goto(addr6157);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr4310);
                                                         }
                                                         §§goto(addr6157);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      if(_loc11_ <= 116)
                                                      {
                                                         if(_loc11_ != 115)
                                                         {
                                                            if(_loc11_ == 116)
                                                            {
                                                               _loc33_ |= 2048;
                                                               continue loop4;
                                                            }
                                                            §§goto(addr7094);
                                                         }
                                                         else
                                                         {
                                                            §§goto(addr4693);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         if(_loc11_ == 117)
                                                         {
                                                            break;
                                                         }
                                                         if(_loc11_ != 120)
                                                         {
                                                            if(_loc11_ == 122)
                                                            {
                                                               _loc33_ |= 1024;
                                                               continue loop4;
                                                            }
                                                            §§goto(addr7094);
                                                         }
                                                         else
                                                         {
                                                            _loc27_ = _xdigs_lower_2E_4558;
                                                            §§goto(addr5789);
                                                         }
                                                      }
                                                      §§goto(addr1717);
                                                   }
                                                   §§goto(addr6157);
                                                }
                                                §§goto(addr6157);
                                             }
                                             if((_loc20_ = _loc33_ & 7200) != 0)
                                             {
                                                if((_loc20_ = _loc33_ & 4096) != 0)
                                                {
                                                   if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                   {
                                                      _loc23_ = _loc17_ + (_loc46_ << 3);
                                                   }
                                                   else
                                                   {
                                                      _loc23_ = _loc26_;
                                                      _loc26_ += 8;
                                                   }
                                                   _loc17_ = li32(_loc23_ + 4);
                                                   _loc23_ = li32(_loc23_);
                                                   _loc11_ = 10;
                                                }
                                                else if((_loc20_ = _loc33_ & 1024) != 0)
                                                {
                                                   if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                                   {
                                                      _loc17_ += _loc46_ << 3;
                                                   }
                                                   else
                                                   {
                                                      _loc17_ = _loc26_;
                                                      _loc26_ += 4;
                                                   }
                                                   _loc23_ = li32(_loc17_);
                                                   _loc17_ = 0;
                                                   _loc11_ = 10;
                                                }
                                                else
                                                {
                                                   _loc17_ = li32(_loc2_ - 320);
                                                   if((_loc33_ & 2048) != 0)
                                                   {
                                                      if(_loc17_ != 0)
                                                      {
                                                         _loc17_ += _loc46_ << 3;
                                                      }
                                                      else
                                                      {
                                                         _loc17_ = _loc26_;
                                                         _loc26_ += 4;
                                                      }
                                                      _loc17_ = (_loc23_ = li32(_loc17_)) >> 31;
                                                      _loc11_ = 10;
                                                   }
                                                   else
                                                   {
                                                      if(_loc17_ != 0)
                                                      {
                                                         _loc23_ = _loc17_ + (_loc46_ << 3);
                                                      }
                                                      else
                                                      {
                                                         _loc23_ = _loc26_;
                                                         _loc26_ += 8;
                                                      }
                                                      _loc17_ = li32(_loc23_ + 4);
                                                      _loc23_ = li32(_loc23_);
                                                      _loc11_ = 10;
                                                   }
                                                }
                                             }
                                             else if((_loc20_ = _loc33_ & 16) != 0)
                                             {
                                                if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                {
                                                   _loc21_ += _loc46_ << 3;
                                                }
                                                else
                                                {
                                                   _loc21_ = _loc26_;
                                                   _loc26_ += 4;
                                                }
                                                _loc21_ = li32(_loc21_);
                                                _loc11_ = 10;
                                             }
                                             else if((_loc20_ = _loc33_ & 64) != 0)
                                             {
                                                if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                                {
                                                   _loc21_ += _loc46_ << 3;
                                                }
                                                else
                                                {
                                                   _loc21_ = _loc26_;
                                                   _loc26_ += 4;
                                                }
                                                _loc21_ = li16(_loc21_);
                                                _loc11_ = 10;
                                             }
                                             else
                                             {
                                                _loc21_ = li32(_loc2_ - 320);
                                                if((_loc33_ & 8192) != 0)
                                                {
                                                   if(_loc21_ != 0)
                                                   {
                                                      _loc21_ += _loc46_ << 3;
                                                   }
                                                   else
                                                   {
                                                      _loc21_ = _loc26_;
                                                      _loc26_ += 4;
                                                   }
                                                   _loc21_ = li8(_loc21_);
                                                   _loc11_ = 10;
                                                }
                                                else
                                                {
                                                   if(_loc21_ != 0)
                                                   {
                                                      _loc21_ += _loc46_ << 3;
                                                   }
                                                   else
                                                   {
                                                      _loc21_ = _loc26_;
                                                      _loc26_ += 4;
                                                   }
                                                   _loc21_ = li32(_loc21_);
                                                   _loc11_ = 10;
                                                }
                                             }
                                             §§goto(addr6157);
                                          }
                                          _loc33_ |= 128;
                                       }
                                       if((_loc20_ = _loc33_ & 7200) != 0)
                                       {
                                          if((_loc20_ = _loc33_ & 4096) != 0)
                                          {
                                             if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                             {
                                                _loc23_ = _loc17_ + (_loc46_ << 3);
                                             }
                                             else
                                             {
                                                _loc23_ = _loc26_;
                                                _loc26_ += 8;
                                             }
                                             _loc17_ = li32(_loc23_ + 4);
                                             _loc23_ = li32(_loc23_);
                                          }
                                          else if((_loc20_ = _loc33_ & 1024) != 0)
                                          {
                                             if((_loc17_ = li32(_loc2_ - 320)) != 0)
                                             {
                                                _loc17_ += _loc46_ << 3;
                                             }
                                             else
                                             {
                                                _loc17_ = _loc26_;
                                                _loc26_ += 4;
                                             }
                                             _loc17_ = (_loc23_ = li32(_loc17_)) >> 31;
                                          }
                                          else
                                          {
                                             _loc17_ = li32(_loc2_ - 320);
                                             if((_loc33_ & 2048) != 0)
                                             {
                                                if(_loc17_ != 0)
                                                {
                                                   _loc17_ += _loc46_ << 3;
                                                }
                                                else
                                                {
                                                   _loc17_ = _loc26_;
                                                   _loc26_ += 4;
                                                }
                                                _loc17_ = (_loc23_ = li32(_loc17_)) >> 31;
                                             }
                                             else
                                             {
                                                if(_loc17_ != 0)
                                                {
                                                   _loc23_ = _loc17_ + (_loc46_ << 3);
                                                }
                                                else
                                                {
                                                   _loc23_ = _loc26_;
                                                   _loc26_ += 8;
                                                }
                                                _loc17_ = li32(_loc23_ + 4);
                                                _loc23_ = li32(_loc23_);
                                             }
                                          }
                                          _loc46_ += 1;
                                          _loc11_ = 10;
                                          if(_loc17_ <= -1)
                                          {
                                             si8(45,_loc2_ - 139);
                                             _loc32_ = 1;
                                             if(_loc23_ == 0)
                                             {
                                                _loc32_ = 0;
                                             }
                                             _loc17_ = (_loc20_ = 0 - _loc17_) - _loc32_;
                                             _loc23_ = 0 - _loc23_;
                                             _loc11_ = 10;
                                          }
                                       }
                                       else
                                       {
                                          if((_loc20_ = _loc33_ & 16) != 0)
                                          {
                                             if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                             {
                                                _loc21_ += _loc46_ << 3;
                                             }
                                             else
                                             {
                                                _loc21_ = _loc26_;
                                                _loc26_ += 4;
                                             }
                                             _loc21_ = li32(_loc21_);
                                          }
                                          else if((_loc20_ = _loc33_ & 64) != 0)
                                          {
                                             if((_loc21_ = li32(_loc2_ - 320)) != 0)
                                             {
                                                _loc21_ += _loc46_ << 3;
                                             }
                                             else
                                             {
                                                _loc21_ = _loc26_;
                                                _loc26_ += 4;
                                             }
                                             _loc21_ = si16(li16(_loc21_));
                                          }
                                          else
                                          {
                                             _loc21_ = li32(_loc2_ - 320);
                                             if((_loc33_ & 8192) != 0)
                                             {
                                                if(_loc21_ != 0)
                                                {
                                                   _loc21_ += _loc46_ << 3;
                                                }
                                                else
                                                {
                                                   _loc21_ = _loc26_;
                                                   _loc26_ += 4;
                                                }
                                                _loc21_ = si8(li8(_loc21_));
                                             }
                                             else
                                             {
                                                if(_loc21_ != 0)
                                                {
                                                   _loc21_ += _loc46_ << 3;
                                                }
                                                else
                                                {
                                                   _loc21_ = _loc26_;
                                                   _loc26_ += 4;
                                                }
                                                _loc21_ = li32(_loc21_);
                                             }
                                          }
                                          _loc46_ += 1;
                                          _loc11_ = 10;
                                          if(_loc21_ <= -1)
                                          {
                                             si8(45,_loc2_ - 139);
                                             _loc21_ = 0 - _loc21_;
                                             _loc11_ = 10;
                                          }
                                       }
                                       §§goto(addr6168);
                                    }
                                    break;
                                 }
                                 _loc1_ -= 16;
                                 si32(_loc12_,_loc1_ + 4);
                                 si32(li32(_loc2_ - 280),_loc1_);
                                 ESP = _loc1_;
                                 F___sfvwrite();
                                 _loc1_ += 16;
                                 si32(0,_loc2_ - 268);
                                 si32(0,_loc2_ - 272);
                                 _loc18_ = _loc33_;
                                 if(eax == 0)
                                 {
                                    §§goto(addr709);
                                 }
                              }
                              §§goto(addr709);
                           }
                           §§goto(addr10346);
                        }
                        §§goto(addr709);
                     }
                     if((_loc20_ = li32(_loc2_ - 268)) == 0)
                     {
                        si32(0,_loc2_ - 272);
                        _loc18_ = _loc48_;
                     }
                     else
                     {
                        _loc1_ -= 16;
                        si32(_loc12_,_loc1_ + 4);
                        si32(li32(_loc2_ - 280),_loc1_);
                        ESP = _loc1_;
                        F___sfvwrite();
                        _loc1_ += 16;
                        si32(0,_loc2_ - 268);
                        si32(0,_loc2_ - 272);
                        _loc18_ = _loc48_;
                     }
                     §§goto(addr10346);
                  }
                  _loc46_ += 4;
                  while(true)
                  {
                     _loc20_ = (_loc8_ = li32(_loc46_)) + -16843009;
                     if((_loc20_ = (_loc47_ = (_loc47_ = _loc8_ & -2139062144) ^ -2139062144) & _loc20_) == 0)
                     {
                        continue;
                     }
                     if((_loc20_ = _loc8_ & 255) == 0)
                     {
                        _loc8_ = _loc46_ - _loc9_;
                     }
                     else if((_loc20_ = li8(_loc46_ + 1)) == 0)
                     {
                        _loc8_ = (_loc20_ = 1 - _loc9_) + _loc46_;
                     }
                     else if((_loc20_ = li8(_loc46_ + 2)) == 0)
                     {
                        _loc8_ = (_loc20_ = 2 - _loc9_) + _loc46_;
                     }
                     else
                     {
                        if((_loc20_ = li8(_loc46_ + 3)) != 0)
                        {
                           continue;
                        }
                        _loc8_ = (_loc20_ = 3 - _loc9_) + _loc46_;
                     }
                  }
               }
               §§goto(addr490);
            }
            §§goto(addr220);
         }
         §§goto(addr220);
      }
      else if(_loc9_ >= 1)
      {
         §§goto(addr156);
      }
      else
      {
         §§goto(addr190);
      }
      §§goto(addr190);
   }
}
