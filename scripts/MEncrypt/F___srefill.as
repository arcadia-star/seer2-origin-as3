package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___srefill() : void
   {
      var _loc4_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc3_ = li32(___sdidinit);
      if(_loc3_ == 0)
      {
         si32(__cleanup,___cleanup);
         si32(1,___sdidinit);
      }
      _loc3_ = li32((_loc15_ = li32(_loc4_)) + 100);
      if(_loc3_ == 0)
      {
         si32(-1,_loc15_ + 100);
      }
      si32(0,_loc15_ + 4);
      _loc3_ = (_loc14_ = li16(_loc15_ + 12)) & 32;
      _loc13_ = -1;
      if(_loc3_ == 0)
      {
         if((_loc14_ & 4) == 0)
         {
            if((_loc14_ & 16) == 0)
            {
               ESP = _loc2_;
               F___error();
               si32(9,eax);
               si16(li16(_loc15_ + 12) | 64,_loc15_ + 12);
               _loc13_ = -1;
               §§goto(addr1132);
            }
            else
            {
               if((_loc14_ & 8) != 0)
               {
                  if(((_loc13_ = _loc14_ << 16 >> 16) & 8) != 0)
                  {
                     if((_loc12_ = li32(_loc15_ + 16)) != 0)
                     {
                        _loc14_ = li32(_loc15_);
                        si32(_loc12_,_loc15_);
                        _loc13_ = 0;
                        if((_loc13_ & 3) == 0)
                        {
                           _loc13_ = li32(_loc15_ + 20);
                        }
                        _loc14_ -= _loc12_;
                        si32(_loc13_,_loc15_ + 8);
                        while(true)
                        {
                           if(_loc14_ > 0)
                           {
                              _loc2_ -= 16;
                              si32(_loc14_,_loc2_ + 8);
                              si32(_loc12_,_loc2_ + 4);
                              si32(_loc15_,_loc2_);
                              ESP = _loc2_;
                              F__swrite();
                              _loc2_ += 16;
                              if((_loc13_ = eax) < 1)
                              {
                                 si16(li16(_loc15_ + 12) | 64,_loc15_ + 12);
                                 _loc13_ = -1;
                                 break;
                              }
                              continue;
                           }
                           _loc14_ = li16(_loc15_ + 12);
                        }
                        §§goto(addr1132);
                     }
                  }
                  si16(_loc14_ &= 65527,_loc15_ + 12);
                  si32(0,_loc15_ + 8);
                  si32(0,_loc15_ + 24);
               }
               _loc3_ = _loc14_ | 4;
               si16(_loc3_,_loc15_ + 12);
            }
            §§goto(addr1132);
         }
         else if((_loc12_ = li32(_loc15_ + 48)) != 0)
         {
            if(_loc12_ != _loc15_ + 64)
            {
               _loc2_ -= 16;
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               F_idalloc();
               _loc2_ += 16;
            }
            si32(0,_loc15_ + 48);
            _loc3_ = li32(_loc15_ + 60);
            si32(_loc3_,_loc15_ + 4);
            if(_loc3_ != 0)
            {
               si32(li32(_loc15_ + 56),_loc15_);
               _loc13_ = 0;
            }
            §§goto(addr1132);
         }
         _loc3_ = li32(_loc15_ + 16);
         if(_loc3_ == 0)
         {
            _loc2_ -= 16;
            si32(_loc15_,_loc2_);
            ESP = _loc2_;
            F___smakebuf();
            _loc2_ += 16;
         }
         _loc3_ = (_loc12_ = li16(_loc15_ + 12)) & 3;
         if(_loc3_ != 0)
         {
            si16(_loc12_ | 32768,_loc15_ + 12);
            _loc13_ = ___sglue;
            _loc12_ = 0;
            do
            {
               if((_loc14_ = li32(_loc13_ + 4)) >= 1)
               {
                  _loc11_ = li32(_loc13_ + 8);
                  do
                  {
                     if((_loc10_ = si16(li16(_loc11_ + 12))) >= 1)
                     {
                        if((_loc10_ & 65535 & 9) == 9)
                        {
                           _loc10_ = _loc11_ + 88;
                           if(li32(___isthreaded) != 0)
                           {
                              ESP = _loc2_;
                              F__pthread_self();
                              _loc9_ = eax;
                              if(li32(_loc11_ + 92) == _loc9_)
                              {
                                 si32(li32(_loc11_ + 96) + 1,_loc11_ + 96);
                              }
                              else
                              {
                                 _loc2_ -= 16;
                                 si32(_loc10_,_loc2_);
                                 ESP = _loc2_;
                                 F__pthread_mutex_lock();
                                 _loc2_ += 16;
                                 si32(_loc9_,_loc11_ + 92);
                                 si32(1,_loc11_ + 96);
                              }
                           }
                           _loc3_ = (_loc8_ = si16(li16(_loc11_ + 12))) & 8;
                           if(_loc3_ != 0)
                           {
                              if((_loc9_ = li32(_loc11_ + 16)) != 0)
                              {
                                 _loc1_ = li32(_loc11_);
                                 si32(_loc9_,_loc11_);
                                 _loc8_ = 0;
                                 if((_loc8_ & 3) == 0)
                                 {
                                    _loc8_ = li32(_loc11_ + 20);
                                 }
                                 _loc1_ -= _loc9_;
                                 si32(_loc8_,_loc11_ + 8);
                                 while(_loc1_ > 0)
                                 {
                                    _loc2_ -= 16;
                                    si32(_loc1_,_loc2_ + 8);
                                    si32(_loc9_,_loc2_ + 4);
                                    si32(_loc11_,_loc2_);
                                    ESP = _loc2_;
                                    F__swrite();
                                    _loc2_ += 16;
                                    if((_loc8_ = eax) <= 0)
                                    {
                                       si16(li16(_loc11_ + 12) | 64,_loc11_ + 12);
                                       break;
                                    }
                                    _loc9_ += _loc8_;
                                    _loc1_ -= _loc8_;
                                 }
                              }
                           }
                           _loc3_ = li32(___isthreaded);
                           if(_loc3_ != 0)
                           {
                              ESP = _loc2_;
                              F__pthread_self();
                              var _loc5_:*;
                              if((_loc5_ = li32(_loc11_ + 92)) == eax)
                              {
                                 if((_loc9_ = li32(_loc11_ + 96)) >= 2)
                                 {
                                    si32(_loc9_ + -1,_loc11_ + 96);
                                 }
                                 else
                                 {
                                    si32(_loc12_,_loc11_ + 96);
                                    si32(_loc12_,_loc11_ + 92);
                                    _loc2_ -= 16;
                                    si32(_loc10_,_loc2_);
                                    ESP = _loc2_;
                                    F__pthread_mutex_unlock();
                                    _loc2_ += 16;
                                 }
                              }
                           }
                        }
                     }
                     _loc11_ += 232;
                  }
                  while((_loc14_ += -1) != 0);
                  
               }
            }
            while((_loc13_ = li32(_loc13_)) != 0);
            
            si16(_loc14_ = li16(_loc15_ + 12) & 32767,_loc15_ + 12);
            if((li16(_loc15_ + 12) & 9) == 9)
            {
               if((_loc14_ & 8) != 0)
               {
                  if((_loc13_ = li32(_loc15_ + 16)) != 0)
                  {
                     _loc14_ = li32(_loc15_);
                     si32(_loc13_,_loc15_);
                     if((_loc14_ & 65535 & 3) == 0)
                     {
                        _loc12_ = li32(_loc15_ + 20);
                     }
                     _loc14_ -= _loc13_;
                     si32(_loc12_,_loc15_ + 8);
                     while(_loc14_ > 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc14_,_loc2_ + 8);
                        si32(_loc13_,_loc2_ + 4);
                        si32(_loc15_,_loc2_);
                        ESP = _loc2_;
                        F__swrite();
                        _loc2_ += 16;
                        if((_loc12_ = eax) <= 0)
                        {
                           si16(li16(_loc15_ + 12) | 64,_loc15_ + 12);
                           break;
                        }
                        _loc13_ += _loc12_;
                        _loc14_ -= _loc12_;
                     }
                  }
               }
            }
         }
         _loc3_ = li32(_loc15_ + 16);
         si32(_loc3_,_loc15_);
         var _loc6_:* = li32(_loc15_ + 36);
         var _loc7_:* = li32(_loc15_ + 28);
         _loc5_ = li32(_loc15_ + 20);
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 8);
         si32(_loc3_,_loc2_ + 4);
         si32(_loc7_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc6_]();
         _loc2_ += 16;
         if((_loc12_ = eax) >= 1)
         {
            if(((_loc10_ = li16(_loc15_ + 12)) & 4096) != 0)
            {
               _loc11_ = li32(_loc15_ + 80);
               _loc1_ = _loc9_ = 1;
               if(uint(_loc11_) <= (uint(_loc12_ ^ -1)))
               {
                  _loc1_ = 0;
               }
               _loc14_ = li32(_loc15_ + 84);
               _loc13_ = _loc12_ >> 31;
               _loc8_ = 2147483647 - _loc13_;
               if(_loc14_ <= _loc8_)
               {
                  _loc9_ = 0;
               }
               if(_loc14_ != _loc8_)
               {
                  _loc1_ = _loc9_;
               }
               if(_loc1_ == 0)
               {
                  si32(_loc9_ = _loc11_ + _loc12_,_loc15_ + 80);
                  _loc1_ = _loc8_ = 1;
                  if(uint(_loc9_) >= uint(_loc11_))
                  {
                     _loc1_ = 0;
                  }
                  if(uint(_loc9_) >= uint(_loc12_))
                  {
                     _loc8_ = _loc1_;
                  }
                  _loc3_ = _loc14_ + _loc13_;
                  _loc3_ += _loc8_;
                  si32(_loc3_,_loc15_ + 84);
                  addr1080:
                  si32(_loc12_,_loc15_ + 4);
                  si16(_loc14_ = _loc10_ & 57343,_loc15_ + 12);
                  _loc13_ = 0;
                  if(_loc12_ <= 0)
                  {
                     if(_loc12_ == 0)
                     {
                        si16(_loc14_ | 32,_loc15_ + 12);
                        _loc13_ = -1;
                     }
                     else
                     {
                        addr1115:
                        si32(0,_loc15_ + 4);
                        _loc3_ = _loc14_ | 64;
                        si16(_loc3_,_loc15_ + 12);
                        _loc13_ = -1;
                     }
                  }
                  §§goto(addr1132);
               }
               else
               {
                  si16(_loc10_ &= 61439,_loc15_ + 12);
               }
               §§goto(addr1132);
            }
            si32(_loc12_,_loc15_ + 4);
            _loc3_ = _loc10_ & 57343;
            si16(_loc3_,_loc15_ + 12);
            _loc13_ = 0;
         }
         else
         {
            _loc10_ = li16(_loc15_ + 12);
            if(_loc12_ <= -1)
            {
               si32(_loc12_,_loc15_ + 4);
               si16(_loc14_ = _loc10_ & 53247,_loc15_ + 12);
               §§goto(addr1115);
            }
         }
         §§goto(addr1132);
      }
      addr1132:
      eax = _loc13_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
