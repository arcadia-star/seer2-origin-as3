package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F__pthread_mutex_lock;
   import MEncrypt.F__pthread_mutex_trylock;
   import MEncrypt.F__pthread_mutex_unlock;
   import MEncrypt.Fmemset;
   import MEncrypt.___isthreaded;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_arena_malloc() : void
   {
      var _loc7_:* = 0;
      var _loc16_:* = 0;
      var _loc17_:* = 0;
      var _loc18_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:int = 0;
      var _loc6_:* = 0;
      var _loc3_:int = ESP;
      _loc7_ = _loc3_;
      _loc3_ -= 16;
      _loc4_ = 3840;
      var _loc19_:*;
      if((_loc19_ = li8(_sspace_max_2E_b)) == 0)
      {
         _loc4_ = 0;
      }
      _loc18_ = li32(_loc7_ + 8);
      _loc17_ = li32(_loc7_ + 4);
      _loc16_ = li32(_loc7_);
      if(uint(_loc4_) >= uint(_loc17_))
      {
         _loc17_ = li32((_loc4_ = _loc16_ + (_loc19_ = li8(_loc19_ = (_loc19_ = li32(_size2bin)) + _loc17_)) * 40) + 80);
         if((_loc19_ = li32(___isthreaded)) != 0)
         {
            _loc3_ -= 16;
            si32(_loc16_,_loc3_);
            ESP = _loc3_;
            F__pthread_mutex_trylock();
            _loc3_ += 16;
            if((_loc19_ = eax) != 0)
            {
               _loc15_ = 1;
               if((uint(_loc19_ = li32(_ncpus))) > 1)
               {
                  while(true)
                  {
                     if(uint(_loc15_) < 12)
                     {
                        continue;
                     }
                  }
                  addr248:
                  if((_loc15_ = li32(_loc4_ + 60)) != 0)
                  {
                     if((_loc19_ = li32(_loc15_ + 8)) != 0)
                     {
                        if((_loc12_ = li32((_loc14_ = _loc15_ + ((_loc13_ = li32(_loc15_ + 4)) << 2)) + 12)) == 0)
                        {
                           _loc12_ = li32(_loc4_ + 92);
                           _loc14_ = 0;
                           _loc1_ = _loc13_;
                           _loc8_ = _loc14_;
                           while(true)
                           {
                              _loc6_ = _loc1_ + 1;
                              if(uint(_loc12_) <= uint(_loc6_))
                              {
                                 break;
                              }
                              _loc2_ = _loc15_ + (_loc1_ << 2);
                              _loc5_ = li32(_loc2_ + 16);
                              _loc8_ += 1;
                              _loc1_ = _loc6_;
                              if(_loc5_ != 0)
                              {
                                 var _loc9_:* = ((_loc9_ = _loc19_ - ((_loc9_ = (_loc19_ = (_loc19_ = _loc5_ ^ -1) & _loc5_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459);
                                 var _loc11_:* = (_loc19_ = (_loc19_ = (_loc19_ = _loc9_ + (_loc9_ >>> 4)) & 252645135) * 16843009) >>> 24;
                                 _loc9_ = li32(_loc4_ + 96);
                                 _loc19_ = li32(_loc4_ + 80);
                                 si32((_loc19_ = 1 << _loc11_) ^ _loc5_,_loc2_ + 16);
                                 si32(_loc6_,_loc15_ + 4);
                                 _loc14_ = (_loc19_ = (_loc19_ *= _loc8_) << 5) + ((_loc9_ = _loc15_ + _loc9_) + _loc19_ * (_loc11_ + (_loc13_ << 5)));
                                 break;
                              }
                           }
                        }
                        else
                        {
                           _loc9_ = (_loc19_ = (_loc19_ = (_loc19_ += (_loc19_ = ((_loc9_ = _loc19_ - ((_loc9_ = (_loc19_ = (_loc9_ = _loc12_ ^ -1) & _loc12_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
                           _loc19_ = li32(_loc4_ + 96);
                           _loc11_ = li32(_loc4_ + 80);
                           si32((_loc19_ = 1 << _loc9_) ^ _loc12_,_loc14_ + 12);
                           _loc14_ = (_loc19_ += _loc15_) + _loc11_ * (_loc9_ + (_loc13_ << 5));
                        }
                        si32(_loc19_ = (_loc19_ = li32(_loc15_ + 8)) + -1,_loc15_ + 8);
                     }
                     else
                     {
                        addr583:
                        _loc14_ = _loc4_ + 60;
                        _loc12_ = li32(_loc4_ + 64);
                        _loc13_ = _loc4_ + 68;
                        while((_loc12_ = li32(_loc15_ = _loc12_)) != _loc13_)
                        {
                        }
                        _loc12_ = 0;
                        if(_loc13_ != _loc15_)
                        {
                           _loc12_ = _loc15_;
                        }
                        if(_loc12_ != 0)
                        {
                           _loc3_ -= 16;
                           si32(_loc4_ + 64,_loc3_);
                           si32(_loc12_,_loc3_ + 4);
                           ESP = _loc3_;
                           F_arena_run_tree_remove();
                           _loc3_ += 16;
                           _loc15_ = (_loc19_ = li32(_loc12_ + 8)) & -4096;
                        }
                        else
                        {
                           _loc3_ -= 16;
                           si32(_loc13_ = 0,_loc3_ + 12);
                           si32(_loc13_,_loc3_ + 8);
                           si32(li32(_loc4_ + 84),_loc3_ + 4);
                           si32(_loc16_,_loc3_);
                           ESP = _loc3_;
                           F_arena_run_alloc();
                           _loc3_ += 16;
                           if((_loc15_ = eax) == 0)
                           {
                              si32(_loc14_ = 0,_loc4_ + 60);
                              §§goto(addr1152);
                           }
                           else
                           {
                              si32(_loc14_,_loc15_);
                              if((_loc19_ = li32(_loc4_ + 92)) != 1)
                              {
                                 _loc13_ = 0;
                                 do
                                 {
                                    _loc19_ = _loc13_ << 2;
                                    _loc19_ = _loc15_ + _loc19_;
                                    si32(-1,_loc19_ + 12);
                                    _loc19_ = (_loc19_ = li32(_loc4_ + 92)) + -1;
                                    _loc13_ += 1;
                                 }
                                 while(uint(_loc19_) > uint(_loc13_));
                                 
                              }
                              if((_loc14_ = (_loc19_ = li32(_loc4_ + 88)) & 31) == 0)
                              {
                                 si32(-1,_loc15_ + (_loc13_ << 2) + 12);
                              }
                              else
                              {
                                 si32(-1 >>> 32 - _loc14_,_loc15_ + (_loc13_ << 2) + 12);
                              }
                              si32(0,_loc15_ + 4);
                              si32(_loc19_ = li32(_loc4_ + 88),_loc15_ + 8);
                           }
                           §§goto(addr1152);
                        }
                        si32(_loc15_,_loc4_ + 60);
                        _loc14_ = 0;
                        if(_loc15_ != 0)
                        {
                           if((_loc14_ = li32((_loc12_ = _loc15_ + ((_loc13_ = li32(_loc15_ + 4)) << 2)) + 12)) == 0)
                           {
                              _loc1_ = li32(_loc4_ + 92);
                              _loc14_ = 0;
                              _loc5_ = _loc13_;
                              _loc6_ = _loc14_;
                              while(true)
                              {
                                 _loc8_ = _loc5_ + 1;
                                 if(uint(_loc1_) <= uint(_loc8_))
                                 {
                                    break;
                                 }
                                 _loc2_ = _loc15_ + (_loc5_ << 2);
                                 _loc12_ = li32(_loc2_ + 16);
                                 _loc6_ += 1;
                                 _loc5_ = _loc8_;
                                 if(_loc12_ != 0)
                                 {
                                    _loc9_ = ((_loc9_ = _loc19_ - ((_loc9_ = (_loc19_ = (_loc19_ = _loc12_ ^ -1) & _loc12_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459);
                                    _loc11_ = (_loc19_ = (_loc19_ = (_loc19_ = _loc9_ + (_loc9_ >>> 4)) & 252645135) * 16843009) >>> 24;
                                    _loc9_ = li32(_loc4_ + 96);
                                    _loc19_ = li32(_loc4_ + 80);
                                    si32((_loc19_ = 1 << _loc11_) ^ _loc12_,_loc2_ + 16);
                                    si32(_loc8_,_loc15_ + 4);
                                    _loc14_ = (_loc19_ = (_loc19_ *= _loc6_) << 5) + ((_loc9_ = _loc15_ + _loc9_) + _loc19_ * (_loc11_ + (_loc13_ << 5)));
                                    break;
                                 }
                              }
                           }
                           else
                           {
                              _loc9_ = ((_loc9_ = _loc19_ - ((_loc9_ = (_loc19_ = (_loc9_ = _loc14_ ^ -1) & _loc14_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459);
                              _loc9_ = (_loc19_ = (_loc19_ = (_loc19_ = _loc9_ + (_loc9_ >>> 4)) & 252645135) * 16843009) >>> 24;
                              _loc19_ = li32(_loc4_ + 96);
                              _loc11_ = li32(_loc4_ + 80);
                              si32((_loc19_ = 1 << _loc9_) ^ _loc14_,_loc12_ + 12);
                              _loc14_ = (_loc19_ += _loc15_) + _loc11_ * (_loc9_ + (_loc13_ << 5));
                           }
                           si32(_loc19_ = (_loc19_ = li32(_loc15_ + 8)) + -1,_loc15_ + 8);
                        }
                     }
                     addr1152:
                     if((_loc19_ = li32(___isthreaded)) != 0)
                     {
                        _loc3_ -= 16;
                        si32(_loc16_,_loc3_);
                        ESP = _loc3_;
                        F__pthread_mutex_unlock();
                        _loc3_ += 16;
                     }
                     _loc16_ = 0;
                     if(_loc14_ != 0)
                     {
                        if(_loc18_ == 0)
                        {
                           if((_loc19_ = li8(_opt_junk_2E_b)) == 1)
                           {
                              _loc3_ -= 16;
                              si32(_loc17_,_loc3_ + 8);
                              si32(165,_loc3_ + 4);
                              si32(_loc14_,_loc3_);
                              ESP = _loc3_;
                              Fmemset();
                              _loc3_ += 16;
                              _loc16_ = _loc14_;
                           }
                           else
                           {
                              _loc16_ = _loc14_;
                              if(li8(_opt_zero_2E_b) == 1)
                              {
                                 _loc3_ -= 16;
                                 si32(_loc17_,_loc3_ + 8);
                                 si32(0,_loc3_ + 4);
                                 si32(_loc14_,_loc3_);
                                 ESP = _loc3_;
                                 Fmemset();
                                 _loc3_ += 16;
                                 _loc16_ = _loc14_;
                              }
                           }
                        }
                        else
                        {
                           _loc3_ -= 16;
                           si32(_loc17_,_loc3_ + 8);
                           si32(0,_loc3_ + 4);
                           si32(_loc14_,_loc3_);
                           ESP = _loc3_;
                           Fmemset();
                           _loc3_ += 16;
                           _loc16_ = _loc14_;
                        }
                     }
                     §§goto(addr1622);
                  }
                  §§goto(addr583);
               }
               _loc3_ -= 16;
               si32(_loc16_,_loc3_);
               ESP = _loc3_;
               F__pthread_mutex_lock();
               _loc3_ += 16;
            }
         }
         §§goto(addr248);
      }
      else
      {
         if((_loc19_ = li32(___isthreaded)) != 0)
         {
            _loc3_ -= 16;
            si32(_loc16_,_loc3_);
            ESP = _loc3_;
            F__pthread_mutex_trylock();
            _loc3_ += 16;
            if((_loc19_ = eax) != 0)
            {
               _loc14_ = 1;
               if((uint(_loc19_ = li32(_ncpus))) > 1)
               {
                  while(true)
                  {
                     if(uint(_loc14_) < 12)
                     {
                        continue;
                     }
                  }
                  §§goto(addr1456);
               }
               _loc3_ -= 16;
               si32(_loc16_,_loc3_);
               ESP = _loc3_;
               F__pthread_mutex_lock();
               _loc3_ += 16;
            }
         }
         addr1456:
         _loc4_ = (_loc19_ = _loc17_ + 4095) & -4096;
         _loc3_ -= 16;
         si32(_loc18_,_loc3_ + 12);
         si32(1,_loc3_ + 8);
         si32(_loc4_,_loc3_ + 4);
         si32(_loc16_,_loc3_);
         ESP = _loc3_;
         F_arena_run_alloc();
         _loc3_ += 16;
         _loc17_ = eax;
         if((_loc19_ = li32(___isthreaded)) != 0)
         {
            _loc3_ -= 16;
            si32(_loc16_,_loc3_);
            ESP = _loc3_;
            F__pthread_mutex_unlock();
            _loc3_ += 16;
         }
         _loc16_ = 0;
         if(_loc17_ != 0)
         {
            _loc16_ = _loc17_;
            if(_loc18_ == 0)
            {
               if((_loc19_ = li8(_opt_junk_2E_b)) == 1)
               {
                  _loc3_ -= 16;
                  si32(_loc4_,_loc3_ + 8);
                  si32(165,_loc3_ + 4);
                  si32(_loc17_,_loc3_);
                  ESP = _loc3_;
                  Fmemset();
                  _loc3_ += 16;
                  _loc16_ = _loc17_;
               }
               else
               {
                  _loc16_ = _loc17_;
                  if(li8(_opt_zero_2E_b) == 1)
                  {
                     _loc3_ -= 16;
                     si32(_loc4_,_loc3_ + 8);
                     si32(0,_loc3_ + 4);
                     si32(_loc17_,_loc3_);
                     ESP = _loc3_;
                     Fmemset();
                     _loc3_ += 16;
                     _loc16_ = _loc17_;
                  }
               }
            }
         }
         §§goto(addr1622);
      }
      ESP = _loc3_;
   }
}
