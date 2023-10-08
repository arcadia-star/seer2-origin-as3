package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sFreeHead;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageHash;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageHashPop;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageHashSize;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageSize;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_kpmalloc() : void
   {
      var _loc6_:* = 0;
      var _loc15_:* = 0;
      var _loc2_:* = 0;
      var _loc16_:* = 0;
      var _loc18_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc17_:* = 0;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc4_ = 4;
      _loc18_ = 0;
      if((uint(_loc17_ = li32(_loc6_))) >= 5)
      {
         do
         {
            _loc4_ <<= 1;
            _loc18_ += 1;
         }
         while(uint(_loc4_) < uint(_loc17_));
         
         _loc16_ = 0;
         if(uint(_loc18_) <= 11)
         {
            addr72:
            _loc15_ = 4 << _loc18_;
            var _loc14_:* = _loc18_ << 2;
            if((_loc17_ = li32(_loc4_ = _sFreeHead + _loc14_)) == 0)
            {
               _loc3_ -= 32;
               si32(_loc16_ = 0,_loc3_ + 24);
               si32(_loc16_,_loc3_ + 20);
               si32(4098,_loc3_ + 12);
               si32(3,_loc3_ + 8);
               si32(_loc16_,_loc3_);
               si32(_loc13_ = (_loc14_ = _loc15_ + 4095) & -4096,_loc3_ + 4);
               si32(-1,_loc3_ + 16);
               ESP = _loc3_;
               F_mmap();
               _loc3_ += 32;
               _loc12_ = eax;
               _loc17_ = _loc16_;
               if(_loc12_ != -1)
               {
                  _loc17_ = _loc12_;
               }
               if(_loc17_ != 0)
               {
                  _loc18_ = (_loc14_ = (_loc14_ = _loc13_ >>> _loc18_ + 2) + -1) * _loc15_;
                  _loc16_ = _loc17_;
                  if(_loc18_ >= 1)
                  {
                     _loc16_ = _loc17_ + _loc15_;
                     _loc12_ = 0;
                     do
                     {
                        _loc14_ = _loc16_ + _loc12_;
                        var _loc11_:* = _loc17_ + _loc12_;
                        si32(_loc14_,_loc11_);
                     }
                     while((_loc12_ += _loc15_) < _loc18_);
                     
                     _loc16_ = _loc17_ + _loc12_;
                  }
                  _loc1_ = 0;
                  si32(_loc1_,_loc16_);
                  si32(_loc14_ = (_loc14_ = li32(_sPageHashPop)) + 1,_sPageHashPop);
                  _loc16_ = (uint(_loc14_ *= 10)) / 9;
                  _loc18_ = 1024;
                  if(uint(_loc14_) >= 9225)
                  {
                     while((uint(_loc18_ <<= 1)) < uint(_loc16_))
                     {
                     }
                  }
                  _loc16_ = li32(_sPageHashSize);
                  if(_loc18_ != _loc16_)
                  {
                     _loc12_ = li32(_sPageSize);
                     _loc16_ = li32(_sPageHash);
                     _loc3_ -= 32;
                     si32(_loc1_,_loc3_ + 24);
                     si32(_loc1_,_loc3_ + 20);
                     si32(4098,_loc3_ + 12);
                     si32(3,_loc3_ + 8);
                     si32(_loc1_,_loc3_);
                     si32(_loc7_ = (_loc14_ = (_loc14_ = _loc18_ << 2) + 4095) & -4096,_loc3_ + 4);
                     si32(-1,_loc3_ + 16);
                     ESP = _loc3_;
                     F_mmap();
                     _loc3_ += 32;
                     if((_loc8_ = eax) != -1)
                     {
                        _loc1_ = _loc8_;
                     }
                     si32(_loc1_,_sPageHash);
                     if(_loc1_ != 0)
                     {
                        _loc3_ -= 32;
                        si32(_loc8_ = 0,_loc3_ + 24);
                        si32(_loc8_,_loc3_ + 20);
                        si32(4098,_loc3_ + 12);
                        si32(3,_loc3_ + 8);
                        si32(_loc7_,_loc3_ + 4);
                        si32(_loc8_,_loc3_);
                        si32(-1,_loc3_ + 16);
                        ESP = _loc3_;
                        F_mmap();
                        _loc3_ += 32;
                        _loc1_ = eax;
                        if(_loc1_ != -1)
                        {
                           _loc8_ = _loc1_;
                        }
                        si32(_loc8_,_sPageSize);
                        if(_loc8_ != 0)
                        {
                           _loc9_ = 0;
                           if((_loc7_ = li32(_sPageHashSize)) != 0)
                           {
                              _loc1_ = _loc18_ + -1;
                              _loc13_ = 0;
                              _loc9_ = _loc7_;
                              do
                              {
                                 _loc7_ = _loc13_ << 2;
                                 if((_loc8_ = li32(_loc14_ = _loc16_ + _loc7_)) != 0)
                                 {
                                    _loc2_ = li32(_sPageHash);
                                    if((_loc5_ = li32(_loc14_ = _loc2_ + ((_loc10_ = (_loc14_ = (_loc14_ = _loc8_ >>> 12) + (_loc8_ >>> 11)) & _loc1_) << 2))) != 0)
                                    {
                                       _loc9_ = 7;
                                       if(_loc5_ != _loc8_)
                                       {
                                          do
                                          {
                                             _loc14_ = (_loc10_ = (_loc14_ = _loc10_ + _loc9_) & _loc1_) << 2;
                                             if((_loc5_ = li32(_loc14_ = _loc2_ + _loc14_)) == 0)
                                             {
                                                break;
                                             }
                                             _loc9_ += 1;
                                          }
                                          while(_loc5_ != _loc8_);
                                          
                                       }
                                    }
                                    _loc14_ = _loc10_ << 2;
                                    _loc11_ = _loc2_ + _loc14_;
                                    si32(_loc8_,_loc11_);
                                    _loc14_ = (_loc11_ = li32(_sPageSize)) + _loc14_;
                                    si32(_loc11_ = li32(_loc11_ = _loc12_ + _loc7_),_loc14_);
                                    _loc9_ = li32(_sPageHashSize);
                                 }
                              }
                              while((uint(_loc13_ += 1)) < uint(_loc9_));
                              
                           }
                           if(_loc16_ != 0)
                           {
                              _loc3_ -= 16;
                              si32(_loc16_,_loc3_);
                              si32(_loc14_ = (_loc14_ = (_loc14_ = _loc9_ << 2) + 4095) & -4096,_loc3_ + 4);
                              ESP = _loc3_;
                              F_munmap();
                              _loc3_ += 16;
                           }
                           if(_loc12_ != 0)
                           {
                              _loc3_ -= 16;
                              si32(_loc12_,_loc3_);
                              si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_sPageHashSize) << 2) + 4095) & -4096,_loc3_ + 4);
                              ESP = _loc3_;
                              F_munmap();
                              _loc3_ += 16;
                           }
                           si32(_loc18_,_sPageHashSize);
                           _loc16_ = _loc18_;
                           addr706:
                           _loc11_ = _loc17_ >>> 11;
                           _loc14_ = (_loc14_ = _loc17_ >>> 12) + _loc11_;
                           _loc14_ = (_loc12_ = (_loc18_ = _loc16_ + -1) & _loc14_) << 2;
                           _loc1_ = li32(_loc14_ = (_loc16_ = li32(_sPageHash)) + _loc14_);
                           if(_loc1_ != 0)
                           {
                              _loc13_ = 7;
                              if(_loc1_ != _loc17_)
                              {
                                 do
                                 {
                                    _loc14_ = (_loc12_ = (_loc14_ = _loc12_ + _loc13_) & _loc18_) << 2;
                                    _loc1_ = li32(_loc14_ = _loc16_ + _loc14_);
                                    if(_loc1_ == 0)
                                    {
                                       break;
                                    }
                                    _loc13_ += 1;
                                 }
                                 while(_loc1_ != _loc17_);
                                 
                              }
                           }
                           _loc14_ = _loc12_ << 2;
                           _loc11_ = _loc16_ + _loc14_;
                           si32(_loc17_,_loc11_);
                           _loc14_ = (_loc11_ = li32(_sPageSize)) + _loc14_;
                           si32(_loc15_,_loc14_);
                           si32(_loc17_,_loc4_);
                           addr845:
                           si32(_loc14_ = li32(_loc17_),_loc4_);
                           _loc3_ -= 16;
                           si32(_loc15_,_loc3_ + 8);
                           si32(0,_loc3_ + 4);
                           si32(_loc17_,_loc3_);
                           ESP = _loc3_;
                           Fmemset();
                           _loc3_ += 16;
                           _loc16_ = _loc17_;
                           §§goto(addr883);
                        }
                        else
                        {
                           _loc3_ -= 16;
                           si32(_loc7_,_loc3_ + 4);
                           si32(li32(_sPageHash),_loc3_);
                           ESP = _loc3_;
                           F_munmap();
                           _loc3_ += 16;
                        }
                        §§goto(addr883);
                     }
                     _loc3_ -= 16;
                     si32(_loc13_,_loc3_ + 4);
                     si32(_loc17_,_loc3_);
                     ESP = _loc3_;
                     F_munmap();
                     _loc3_ += 16;
                     _loc16_ = 0;
                     addr883:
                     eax = _loc16_;
                     _loc3_ = _loc6_;
                     ESP = _loc3_;
                     return;
                  }
               }
               §§goto(addr706);
            }
            §§goto(addr845);
         }
         §§goto(addr706);
      }
      §§goto(addr72);
   }
}
