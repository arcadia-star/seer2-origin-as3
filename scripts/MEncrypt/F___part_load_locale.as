package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1450;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str449;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___part_load_locale() : void
   {
      var _loc7_:* = 0;
      var _loc13_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc17_:* = 0;
      var _loc18_:* = 0;
      var _loc19_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:int = 0;
      var _loc16_:* = 0;
      var _loc3_:* = ESP;
      _loc7_ = _loc3_;
      _loc3_ -= 1120;
      _loc4_ = 0;
      _loc19_ = li32(_loc7_ + 24);
      _loc18_ = li32(_loc7_ + 20);
      _loc17_ = li32(_loc7_ + 16);
      _loc16_ = li32(_loc7_ + 12);
      _loc15_ = li32(_loc7_ + 8);
      _loc14_ = li32(_loc7_ + 4);
      _loc13_ = li32(_loc7_);
      _loc12_ = _loc4_;
      loop0:
      do
      {
         var _loc8_:*;
         _loc1_ = li8(_loc8_ = _loc13_ + _loc12_);
         _loc8_ = li8(_loc8_ = L__2E_str449 + _loc12_);
         if(_loc1_ != _loc8_)
         {
            loop1:
            while(true)
            {
               _loc1_ = li8(_loc8_ = _loc13_ + _loc4_);
               _loc8_ = li8(_loc8_ = L__2E_str1450 + _loc4_);
               if(_loc1_ == _loc8_)
               {
                  _loc4_ += 1;
                  if(_loc1_ == 0)
                  {
                     break loop0;
                  }
                  continue;
               }
               _loc1_ = li32(_loc15_);
               _loc4_ = _loc13_;
               if(_loc1_ != 0)
               {
                  while(true)
                  {
                     _loc12_ = li8(_loc4_);
                     _loc8_ = li8(_loc1_);
                     if(_loc12_ == _loc8_)
                     {
                        _loc1_ += 1;
                        _loc4_ += 1;
                        if(_loc12_ == 0)
                        {
                           si32(_loc16_ = 1,_loc14_);
                           break loop1;
                        }
                        continue;
                     }
                  }
               }
               _loc1_ = _loc13_ & -4;
               var _loc9_:*;
               _loc8_ = (_loc9_ = li32(_loc1_)) + -16843009;
               if((_loc8_ = (_loc9_ = (_loc9_ &= -2139062144) ^ -2139062144) & _loc8_) != 0)
               {
                  _loc12_ = _loc1_ + 4;
                  _loc4_ = 0;
                  while(true)
                  {
                     if((uint(_loc10_ = _loc13_ + _loc4_)) < uint(_loc12_))
                     {
                        continue;
                     }
                  }
                  addr367:
                  si8(_loc8_ = li8(_loc12_ = li32(__PathLocale)),_loc7_ - 1024);
                  if(_loc8_ != 0)
                  {
                     _loc1_ = (_loc8_ = _loc7_ - 1024) + 1;
                     _loc12_ += 1;
                     do
                     {
                        si8(_loc8_ = li8(_loc12_),_loc1_);
                        _loc1_ += 1;
                        _loc12_ += 1;
                     }
                     while(_loc8_ != 0);
                     
                  }
                  _loc1_ = _loc4_ + 1;
                  _loc8_ = (_loc9_ = li32(_loc12_ = (_loc10_ = _loc7_ - 1024) & -4)) + -16843009;
                  if((_loc8_ = (_loc9_ = (_loc9_ &= -2139062144) ^ -2139062144) & _loc8_) != 0)
                  {
                     _loc11_ = _loc12_ + 4;
                     _loc2_ = 0;
                     while(true)
                     {
                        if((uint(_loc5_ = _loc10_ + _loc2_)) < uint(_loc11_))
                        {
                           continue;
                        }
                     }
                     addr620:
                     _loc8_ = _loc10_ + _loc2_;
                     si16(47,_loc8_);
                     _loc8_ = li8(_loc7_ - 1024);
                     _loc5_ = _loc10_;
                     if(_loc8_ != 0)
                     {
                        do
                        {
                           _loc5_ = _loc10_ + 1;
                           _loc8_ = li8(_loc10_ + 1);
                           _loc10_ = _loc5_;
                        }
                        while(_loc8_ != 0);
                        
                     }
                     _loc10_ = 0;
                     do
                     {
                        _loc8_ = _loc5_ + _loc10_;
                        si8(_loc9_ = li8(_loc9_ = _loc13_ + _loc10_),_loc8_);
                        _loc10_ += 1;
                     }
                     while(_loc9_ != 0);
                     
                     if((_loc8_ = (_loc9_ = (_loc9_ &= -2139062144) ^ -2139062144) & (_loc9_ = li32(_loc12_)) + -16843009) != 0)
                     {
                        _loc5_ = _loc12_ + 4;
                        _loc10_ = 0;
                        while(true)
                        {
                           if((uint(_loc11_ = (_loc8_ = _loc7_ - 1024) + _loc10_)) < uint(_loc5_))
                           {
                              continue;
                           }
                        }
                        addr875:
                        _loc8_ = (_loc12_ = _loc7_ - 1024) + _loc10_;
                        si16(47,_loc8_);
                        _loc8_ = li8(_loc7_ - 1024);
                        _loc10_ = _loc12_;
                        if(_loc8_ != 0)
                        {
                           do
                           {
                              _loc10_ = _loc12_ + 1;
                              _loc8_ = li8(_loc12_ + 1);
                              _loc12_ = _loc10_;
                           }
                           while(_loc8_ != 0);
                           
                        }
                        do
                        {
                           si8(_loc8_ = li8(_loc16_),_loc10_);
                           _loc16_ += 1;
                           _loc10_ += 1;
                        }
                        while(_loc8_ != 0);
                        
                        _loc3_ -= 16;
                        si32(0,_loc3_ + 4);
                        si32(_loc8_ = _loc7_ - 1024,_loc3_);
                        ESP = _loc3_;
                        F__open();
                        _loc16_ = -1;
                        _loc3_ += 16;
                        if((_loc12_ = eax) >= 0)
                        {
                           _loc3_ -= 16;
                           si32(_loc8_ = _loc7_ - 1120,_loc3_ + 4);
                           si32(_loc12_,_loc3_);
                           ESP = _loc3_;
                           F__fstat();
                           _loc3_ += 16;
                           if((_loc8_ = eax) == 0)
                           {
                              _loc16_ = 1;
                              _loc11_ = li32(_loc7_ - 1068);
                              _loc10_ = _loc16_;
                              if(_loc11_ <= 0)
                              {
                                 _loc10_ = 0;
                              }
                              if((_loc5_ = li32(_loc7_ - 1072)) == 0)
                              {
                                 _loc16_ = 0;
                              }
                              if(_loc11_ != 0)
                              {
                                 _loc16_ = _loc10_;
                              }
                              if(_loc16_ == 0)
                              {
                                 ESP = _loc3_;
                                 F___error();
                                 si32(79,eax);
                              }
                              else
                              {
                                 _loc3_ -= 16;
                                 si32(_loc5_ + _loc1_,_loc3_);
                                 ESP = _loc3_;
                                 F_malloc();
                                 _loc3_ += 16;
                                 if((_loc16_ = eax) == 0)
                                 {
                                    ESP = _loc3_;
                                    F___error();
                                    si32(12,eax);
                                 }
                                 else
                                 {
                                    si8(_loc8_ = li8(_loc13_),_loc16_);
                                    if(_loc8_ != 0)
                                    {
                                       _loc10_ = _loc16_ + 1;
                                       _loc13_ += 1;
                                       do
                                       {
                                          si8(_loc8_ = li8(_loc13_),_loc10_);
                                          _loc10_ += 1;
                                          _loc13_ += 1;
                                       }
                                       while(_loc8_ != 0);
                                       
                                    }
                                    _loc10_ = li32(_loc7_ - 1072);
                                    _loc3_ -= 16;
                                    si32(_loc10_,_loc3_ + 8);
                                    si32(_loc13_ = _loc16_ + _loc1_,_loc3_ + 4);
                                    si32(_loc12_,_loc3_);
                                    ESP = _loc3_;
                                    F__read();
                                    _loc3_ += 16;
                                    _loc9_ = (_loc8_ = eax) >> 31;
                                    var _loc6_:* = li32(_loc7_ - 1068);
                                    _loc9_ ^= _loc6_;
                                    _loc6_ = li32(_loc7_ - 1072);
                                    if((_loc8_ = (_loc8_ ^= _loc6_) | _loc9_) == 0)
                                    {
                                       if((_loc8_ = li8(_loc8_ = _loc16_ + (_loc10_ + _loc4_))) == 10)
                                       {
                                          _loc5_ = _loc10_ + _loc1_;
                                          _loc10_ = 0;
                                          if(_loc1_ < _loc5_)
                                          {
                                             _loc13_ = _loc16_ + (_loc5_ - _loc13_);
                                             _loc4_ = (_loc8_ = _loc4_ + _loc16_) + 1;
                                             _loc10_ = 0;
                                             do
                                             {
                                                if((_loc8_ = li8(_loc4_)) == 10)
                                                {
                                                   si8(0,_loc4_);
                                                   _loc10_ += 1;
                                                }
                                                _loc4_ += 1;
                                             }
                                             while((_loc13_ += -1) != 0);
                                             
                                          }
                                          _loc13_ = _loc17_;
                                          if(_loc10_ < _loc17_)
                                          {
                                             _loc13_ = _loc18_;
                                             if(_loc10_ < _loc18_)
                                             {
                                                ESP = _loc3_;
                                                F___error();
                                                si32(79,eax);
                                                addr1664:
                                                ESP = _loc3_;
                                                F___error();
                                                _loc14_ = li32(_loc8_ = eax);
                                                if(_loc16_ != 0)
                                                {
                                                   _loc3_ -= 16;
                                                   si32(_loc16_,_loc3_);
                                                   ESP = _loc3_;
                                                   F_idalloc();
                                                   _loc3_ += 16;
                                                }
                                                ESP = _loc3_;
                                                F___error();
                                                _loc8_ = eax;
                                                si32(_loc14_,_loc8_);
                                                ESP = _loc3_;
                                                F___error();
                                                _loc9_ = li32(_loc8_ = eax);
                                                _loc3_ -= 16;
                                                si32(_loc12_,_loc3_);
                                                ESP = _loc3_;
                                                F__close();
                                                _loc3_ += 16;
                                                ESP = _loc3_;
                                                F___error();
                                                _loc8_ = eax;
                                                si32(_loc9_,_loc8_);
                                                _loc16_ = -1;
                                                break;
                                             }
                                          }
                                          _loc3_ -= 16;
                                          si32(_loc12_,_loc3_);
                                          ESP = _loc3_;
                                          F__close();
                                          _loc3_ += 16;
                                          if((_loc18_ = li32(_loc15_)) != 0)
                                          {
                                             _loc3_ -= 16;
                                             si32(_loc18_,_loc3_);
                                             ESP = _loc3_;
                                             F_idalloc();
                                             _loc3_ += 16;
                                          }
                                          si32(_loc16_,_loc15_);
                                          _loc15_ = _loc19_;
                                          _loc18_ = _loc13_;
                                          if(_loc13_ >= 1)
                                          {
                                             loop13:
                                             do
                                             {
                                                _loc1_ = _loc16_ & -4;
                                                _loc8_ = (_loc9_ = li32(_loc1_)) + -16843009;
                                                if((_loc8_ = (_loc9_ = (_loc9_ &= -2139062144) ^ -2139062144) & _loc8_) != 0)
                                                {
                                                   _loc12_ = _loc1_ + 4;
                                                   _loc4_ = 0;
                                                   while(true)
                                                   {
                                                      if((uint(_loc10_ = _loc16_ + _loc4_)) < uint(_loc12_))
                                                      {
                                                         continue;
                                                      }
                                                   }
                                                   continue;
                                                }
                                                _loc4_ = _loc1_ + 4;
                                                while(true)
                                                {
                                                   _loc1_ = li32(_loc4_);
                                                   _loc8_ = _loc1_ + -16843009;
                                                   if((_loc8_ = (_loc9_ = (_loc9_ = _loc1_ & -2139062144) ^ -2139062144) & _loc8_) != 0)
                                                   {
                                                      if((_loc8_ = _loc1_ & 255) == 0)
                                                      {
                                                         _loc4_ -= _loc16_;
                                                         continue loop13;
                                                      }
                                                      if((_loc8_ = li8(_loc4_ + 1)) == 0)
                                                      {
                                                         _loc4_ = (_loc8_ = 1 - _loc16_) + _loc4_;
                                                         continue loop13;
                                                      }
                                                      if((_loc8_ = li8(_loc4_ + 2)) == 0)
                                                      {
                                                         _loc4_ = (_loc8_ = 2 - _loc16_) + _loc4_;
                                                         continue loop13;
                                                      }
                                                      if((_loc8_ = li8(_loc4_ + 3)) == 0)
                                                      {
                                                         _loc4_ = (_loc8_ = 3 - _loc16_) + _loc4_;
                                                         continue loop13;
                                                      }
                                                   }
                                                   _loc4_ += 4;
                                                }
                                             }
                                             while(si32(_loc16_ = (_loc8_ = _loc4_ + _loc16_) + 1,_loc15_), _loc15_ += 4, (_loc18_ += -1) != 0);
                                             
                                          }
                                          if(_loc13_ < _loc17_)
                                          {
                                             _loc3_ -= 16;
                                             si32(0,_loc3_ + 4);
                                             si32(_loc8_ = (_loc8_ = _loc17_ - _loc13_) << 2,_loc3_ + 8);
                                             si32(_loc8_ = _loc19_ + (_loc13_ << 2),_loc3_);
                                             ESP = _loc3_;
                                             Fmemset();
                                             _loc3_ += 16;
                                          }
                                          si32(1,_loc14_);
                                          _loc16_ = 0;
                                          break;
                                       }
                                       ESP = _loc3_;
                                       F___error();
                                       si32(79,eax);
                                    }
                                    §§goto(addr1664);
                                 }
                              }
                           }
                           §§goto(addr1664);
                        }
                        break;
                     }
                     _loc10_ = _loc12_ + 4;
                     while(true)
                     {
                        _loc8_ = (_loc12_ = li32(_loc10_)) + -16843009;
                        if((_loc8_ = (_loc9_ = (_loc9_ = _loc12_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                        {
                           continue;
                        }
                        if((_loc8_ = _loc12_ & 255) == 0)
                        {
                           _loc10_ -= _loc7_ - 1024;
                        }
                        else if((_loc8_ = li8(_loc10_ + 1)) == 0)
                        {
                           _loc10_ = (_loc8_ = 1 - (_loc7_ - 1024)) + _loc10_;
                        }
                        else if((_loc8_ = li8(_loc10_ + 2)) == 0)
                        {
                           _loc10_ = (_loc8_ = 2 - (_loc7_ - 1024)) + _loc10_;
                        }
                        else
                        {
                           if((_loc8_ = li8(_loc10_ + 3)) != 0)
                           {
                              continue;
                           }
                           _loc10_ = (_loc8_ = 3 - (_loc7_ - 1024)) + _loc10_;
                        }
                        §§goto(addr875);
                     }
                  }
                  _loc11_ = _loc12_ + 4;
                  while(true)
                  {
                     _loc8_ = (_loc5_ = li32(_loc11_)) + -16843009;
                     if((_loc8_ = (_loc9_ = (_loc9_ = _loc5_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                     {
                        continue;
                     }
                     if((_loc8_ = _loc5_ & 255) == 0)
                     {
                        _loc2_ = _loc11_ - (_loc7_ - 1024);
                     }
                     else if((_loc8_ = li8(_loc11_ + 1)) == 0)
                     {
                        _loc2_ = (_loc8_ = 1 - (_loc7_ - 1024)) + _loc11_;
                     }
                     else if((_loc8_ = li8(_loc11_ + 2)) == 0)
                     {
                        _loc2_ = (_loc8_ = 2 - (_loc7_ - 1024)) + _loc11_;
                     }
                     else
                     {
                        if((_loc8_ = li8(_loc11_ + 3)) != 0)
                        {
                           continue;
                        }
                        _loc2_ = (_loc8_ = 3 - (_loc7_ - 1024)) + _loc11_;
                     }
                     §§goto(addr620);
                  }
               }
               _loc1_ += 4;
               while(true)
               {
                  _loc8_ = (_loc4_ = li32(_loc1_)) + -16843009;
                  if((_loc8_ = (_loc9_ = (_loc9_ = _loc4_ & -2139062144) ^ -2139062144) & _loc8_) == 0)
                  {
                     continue;
                  }
                  if((_loc8_ = _loc4_ & 255) == 0)
                  {
                     _loc4_ = _loc1_ - _loc13_;
                  }
                  else if((_loc8_ = li8(_loc1_ + 1)) == 0)
                  {
                     _loc4_ = (_loc8_ = 1 - _loc13_) + _loc1_;
                  }
                  else if((_loc8_ = li8(_loc1_ + 2)) == 0)
                  {
                     _loc4_ = (_loc8_ = 2 - _loc13_) + _loc1_;
                  }
                  else
                  {
                     if((_loc8_ = li8(_loc1_ + 3)) != 0)
                     {
                        continue;
                     }
                     _loc4_ = (_loc8_ = 3 - _loc13_) + _loc1_;
                  }
                  §§goto(addr367);
               }
            }
            §§goto(addr1769);
         }
         _loc12_ += 1;
      }
      while(_loc1_ != 0);
      
      si32(0,_loc14_);
      _loc16_ = 1;
      addr1769:
      eax = _loc16_;
      _loc3_ = _loc7_;
      ESP = _loc3_;
   }
}
