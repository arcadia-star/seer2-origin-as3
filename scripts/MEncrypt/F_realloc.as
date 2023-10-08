package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_realloc() : void
   {
      var _loc5_:* = 0;
      var _loc17_:* = 0;
      var _loc4_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc1_:int = 0;
      var _loc8_:int = 0;
      var _loc9_:* = 0;
      var _loc2_:int = 0;
      var _loc13_:* = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 16;
      _loc4_ = li32(_loc5_ + 4);
      _loc17_ = li32(_loc5_);
      if(_loc4_ == 0)
      {
         _loc4_ = 1;
         var _loc16_:*;
         if((_loc16_ = li8(_opt_sysv_2E_b)) == 1)
         {
            _loc15_ = 0;
            if(_loc17_ != 0)
            {
               _loc3_ -= 16;
               si32(_loc17_,_loc3_);
               ESP = _loc3_;
               F_idalloc();
               _loc3_ += 16;
               _loc15_ = 0;
            }
         }
         else
         {
            addr87:
            if(_loc17_ != 0)
            {
               if((_loc14_ = _loc17_ & ((_loc16_ = li32(_chunksize_mask)) ^ -1)) != _loc17_)
               {
                  _loc14_ = (_loc16_ = li32((_loc16_ = _loc14_ + (_loc16_ = (_loc16_ = _loc17_ - _loc14_) >>> 12) * 12) + 24)) & -4096;
                  if((_loc16_ &= 2) == 0)
                  {
                     _loc14_ = li32((_loc16_ = li32(_loc14_)) + 20);
                  }
               }
               else
               {
                  if((_loc16_ = li32(___isthreaded)) != 0)
                  {
                     _loc3_ -= 16;
                     si32(_huge_mtx,_loc3_);
                     ESP = _loc3_;
                     F__spinlock();
                     _loc3_ += 16;
                  }
                  _loc13_ = li32(_huge);
                  _loc14_ = _huge + 4;
                  while(_loc13_ != _loc14_)
                  {
                     if((_loc15_ = li32(_loc13_ + 16)) == _loc17_)
                     {
                        break;
                     }
                     _loc11_ = _loc12_ = 1;
                     if(uint(_loc15_) <= uint(_loc17_))
                     {
                        _loc11_ = 0;
                     }
                     if(uint(_loc15_) >= uint(_loc17_))
                     {
                        _loc12_ = 0;
                     }
                     _loc16_ = _loc11_ & 1;
                     var _loc10_:*;
                     if((_loc16_ = (_loc10_ = _loc12_ & 1) - _loc16_) <= -1)
                     {
                        _loc13_ = li32(_loc13_ + 8);
                     }
                     else
                     {
                        _loc13_ = (_loc16_ = li32(_loc13_ + 12)) & -2;
                     }
                  }
                  _loc15_ = 0;
                  if(_loc13_ != _loc14_)
                  {
                     _loc15_ = _loc13_;
                  }
                  _loc14_ = li32(_loc15_ + 20);
                  if((_loc16_ = li32(___isthreaded)) != 0)
                  {
                     _loc3_ -= 16;
                     si32(_huge_mtx,_loc3_);
                     ESP = _loc3_;
                     F__spinunlock();
                     _loc3_ += 16;
                  }
               }
               if((uint(_loc15_ = li32(_arena_maxclass))) >= uint(_loc4_))
               {
                  _loc12_ = 3840;
                  if((_loc16_ = li8(_sspace_max_2E_b)) == 0)
                  {
                     _loc12_ = 0;
                  }
                  if(uint(_loc12_) >= uint(_loc4_))
                  {
                     if(uint(_loc12_) >= uint(_loc14_))
                     {
                        if((_loc10_ = li8(_loc10_ += _loc4_)) == li8(_loc16_ = (_loc10_ = li32(_size2bin)) + _loc14_))
                        {
                           if((_loc16_ = li8(_opt_junk_2E_b)) == 1)
                           {
                              if(uint(_loc14_) > uint(_loc4_))
                              {
                                 _loc3_ -= 16;
                                 si32(90,_loc3_ + 4);
                                 si32(_loc16_ = _loc14_ - _loc4_,_loc3_ + 8);
                                 si32(_loc16_ = _loc4_ + _loc17_,_loc3_);
                                 ESP = _loc3_;
                                 Fmemset();
                                 _loc3_ += 16;
                                 _loc15_ = _loc17_;
                              }
                              §§goto(addr2441);
                           }
                           _loc16_ = li8(_opt_zero_2E_b);
                           _loc15_ = _loc17_;
                           if(_loc16_ == 1)
                           {
                              _loc15_ = _loc17_;
                              if(uint(_loc14_) < uint(_loc4_))
                              {
                                 _loc3_ -= 16;
                                 si32(0,_loc3_ + 4);
                                 si32(_loc16_ = _loc4_ - _loc14_,_loc3_ + 8);
                                 si32(_loc16_ = _loc14_ + _loc17_,_loc3_);
                                 ESP = _loc3_;
                                 Fmemset();
                                 _loc3_ += 16;
                                 _loc15_ = _loc17_;
                              }
                           }
                        }
                        §§goto(addr2441);
                     }
                  }
                  else
                  {
                     _loc13_ = 1;
                     if(uint(_loc12_) < uint(_loc14_))
                     {
                        _loc13_ = 0;
                     }
                     if(uint(_loc15_) >= uint(_loc14_))
                     {
                        if(_loc13_ == 0)
                        {
                           if((_loc12_ = (_loc11_ = _loc4_ + 4095) & -4096) == _loc14_)
                           {
                              _loc15_ = _loc17_;
                              if(li8(_opt_junk_2E_b) == 1)
                              {
                                 _loc15_ = _loc17_;
                                 if(uint(_loc14_) > uint(_loc4_))
                                 {
                                    _loc3_ -= 16;
                                    si32(90,_loc3_ + 4);
                                    si32(_loc16_ = _loc14_ - _loc4_,_loc3_ + 8);
                                    si32(_loc16_ = _loc4_ + _loc17_,_loc3_);
                                    ESP = _loc3_;
                                    Fmemset();
                                    _loc3_ += 16;
                                    _loc15_ = _loc17_;
                                 }
                              }
                              §§goto(addr2441);
                           }
                           else
                           {
                              _loc13_ = li32(_loc15_ = _loc17_ & ((_loc16_ = li32(_chunksize_mask)) ^ -1));
                              if(uint(_loc12_) < uint(_loc14_))
                              {
                                 if((_loc16_ = li8(_opt_junk_2E_b)) == 1)
                                 {
                                    _loc3_ -= 16;
                                    si32(90,_loc3_ + 4);
                                    si32(_loc16_ = _loc14_ - _loc4_,_loc3_ + 8);
                                    si32(_loc16_ = _loc4_ + _loc17_,_loc3_);
                                    ESP = _loc3_;
                                    Fmemset();
                                    _loc3_ += 16;
                                 }
                                 if((_loc16_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_loc13_,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_trylock();
                                    _loc3_ += 16;
                                    if((_loc16_ = eax) != 0)
                                    {
                                       _loc1_ = 1;
                                       if((uint(_loc16_ = li32(_ncpus))) > 1)
                                       {
                                          while(true)
                                          {
                                             if(uint(_loc1_) < 12)
                                             {
                                                continue;
                                             }
                                          }
                                          §§goto(addr663);
                                       }
                                       _loc3_ -= 16;
                                       si32(_loc13_,_loc3_);
                                       ESP = _loc3_;
                                       F__pthread_mutex_lock();
                                       _loc3_ += 16;
                                    }
                                 }
                                 addr663:
                                 var _loc6_:* = (_loc10_ = (_loc16_ = _loc17_ - _loc15_) >>> 12) * 12;
                                 var _loc7_:int = (_loc16_ = _loc15_ + 16) + _loc6_;
                                 si32(_loc6_ = _loc12_ | 3,_loc7_ + 8);
                                 _loc6_ = _loc11_ >>> 12;
                                 _loc10_ = (_loc10_ += _loc6_) * 12;
                                 _loc16_ += _loc10_;
                                 si32(_loc10_ = (_loc10_ = _loc14_ - _loc12_) | 3,_loc16_ + 8);
                                 _loc3_ -= 16;
                                 si32(1,_loc3_ + 8);
                                 si32(_loc16_ = _loc12_ + _loc17_,_loc3_ + 4);
                                 si32(_loc13_,_loc3_);
                                 ESP = _loc3_;
                                 F_arena_run_dalloc();
                                 _loc3_ += 16;
                                 _loc16_ = li32(___isthreaded);
                                 _loc15_ = _loc17_;
                                 if(_loc16_ != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_loc13_,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_unlock();
                                    _loc3_ += 16;
                                    _loc15_ = _loc17_;
                                 }
                                 §§goto(addr2441);
                              }
                              else
                              {
                                 if((_loc16_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_loc13_,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_trylock();
                                    _loc3_ += 16;
                                    if((_loc16_ = eax) != 0)
                                    {
                                       _loc11_ = 1;
                                       if((uint(_loc16_ = li32(_ncpus))) > 1)
                                       {
                                          while(true)
                                          {
                                             if(uint(_loc11_) < 12)
                                             {
                                                continue;
                                             }
                                          }
                                          addr951:
                                          _loc1_ = (_loc16_ = _loc17_ - _loc15_) >>> 12;
                                          _loc16_ = _loc14_ >>> 12;
                                          _loc8_ = _loc1_ + _loc16_;
                                          _loc16_ = li32(_chunk_npages);
                                          if(uint(_loc8_) < uint(_loc16_))
                                          {
                                             if((_loc16_ = (_loc9_ = li32((_loc11_ = _loc15_ + _loc8_ * 12) + 24)) & 1) == 0)
                                             {
                                                _loc2_ = _loc12_ - _loc14_;
                                                if((uint(_loc16_ = _loc9_ & -4096)) >= uint(_loc2_))
                                                {
                                                   _loc3_ -= 32;
                                                   si32(0,_loc3_ + 16);
                                                   si32(1,_loc3_ + 12);
                                                   si32(_loc2_,_loc3_ + 8);
                                                   si32(_loc13_,_loc3_);
                                                   si32(_loc16_ = (_loc16_ = _loc8_ << 12) + _loc15_,_loc3_ + 4);
                                                   ESP = _loc3_;
                                                   F_arena_run_split();
                                                   _loc3_ += 32;
                                                   si32(_loc16_ = _loc12_ | 3,_loc15_ + _loc1_ * 12 + 24);
                                                   si32(3,_loc11_ + 24);
                                                   if((_loc16_ = li32(___isthreaded)) != 0)
                                                   {
                                                      _loc3_ -= 16;
                                                      si32(_loc13_,_loc3_);
                                                      ESP = _loc3_;
                                                      F__pthread_mutex_unlock();
                                                      _loc3_ += 16;
                                                   }
                                                   _loc16_ = li8(_opt_zero_2E_b);
                                                   _loc15_ = _loc17_;
                                                   if(_loc16_ == 1)
                                                   {
                                                      _loc3_ -= 16;
                                                      si32(0,_loc3_ + 4);
                                                      si32(_loc16_ = _loc4_ - _loc14_,_loc3_ + 8);
                                                      si32(_loc16_ = _loc14_ + _loc17_,_loc3_);
                                                      ESP = _loc3_;
                                                      Fmemset();
                                                      _loc3_ += 16;
                                                      _loc15_ = _loc17_;
                                                   }
                                                }
                                                §§goto(addr2441);
                                             }
                                          }
                                          if((_loc16_ = li32(___isthreaded)) != 0)
                                          {
                                             _loc3_ -= 16;
                                             si32(_loc13_,_loc3_);
                                             ESP = _loc3_;
                                             F__pthread_mutex_unlock();
                                             _loc3_ += 16;
                                             addr1199:
                                             if((_loc16_ = li32(___isthreaded)) != 0)
                                             {
                                                if((uint(_loc16_ = li32(_narenas))) >= 2)
                                                {
                                                   ESP = _loc3_;
                                                   F__pthread_self();
                                                   _loc16_ = li32(_narenas);
                                                   _loc13_ = (_loc15_ = uint(eax) % uint(_loc16_)) << 2;
                                                   if((_loc12_ = li32(_loc16_ = (_loc16_ = li32(_arenas)) + _loc13_)) == 0)
                                                   {
                                                      if((_loc16_ = li32(___isthreaded)) != 0)
                                                      {
                                                         _loc3_ -= 16;
                                                         si32(_arenas_lock,_loc3_);
                                                         ESP = _loc3_;
                                                         F__pthread_mutex_trylock();
                                                         _loc3_ += 16;
                                                         if((_loc16_ = eax) != 0)
                                                         {
                                                            _loc12_ = 1;
                                                            if((uint(_loc16_ = li32(_ncpus))) > 1)
                                                            {
                                                               while(true)
                                                               {
                                                                  if(uint(_loc12_) < 12)
                                                                  {
                                                                     continue;
                                                                  }
                                                               }
                                                               §§goto(addr1404);
                                                            }
                                                            _loc3_ -= 16;
                                                            si32(_arenas_lock,_loc3_);
                                                            ESP = _loc3_;
                                                            F__pthread_mutex_lock();
                                                            _loc3_ += 16;
                                                         }
                                                      }
                                                      addr1404:
                                                      if((_loc12_ = li32(_loc16_ = (_loc16_ = li32(_arenas)) + _loc13_)) == 0)
                                                      {
                                                         _loc3_ -= 16;
                                                         si32(_loc15_,_loc3_);
                                                         ESP = _loc3_;
                                                         F_arenas_extend();
                                                         _loc3_ += 16;
                                                         _loc12_ = eax;
                                                      }
                                                      if((_loc16_ = li32(___isthreaded)) != 0)
                                                      {
                                                         _loc3_ -= 16;
                                                         si32(_arenas_lock,_loc3_);
                                                         ESP = _loc3_;
                                                         F__pthread_mutex_unlock();
                                                         _loc3_ += 16;
                                                      }
                                                      §§goto(addr1479);
                                                   }
                                                }
                                                else
                                                {
                                                   addr1472:
                                                   _loc12_ = li32(_loc16_ = li32(_arenas));
                                                }
                                                addr1479:
                                                _loc3_ -= 16;
                                                si32(0,_loc3_ + 8);
                                                si32(_loc4_,_loc3_ + 4);
                                                si32(_loc12_,_loc3_);
                                                ESP = _loc3_;
                                                F_arena_malloc();
                                                _loc3_ += 16;
                                                if((_loc15_ = eax) != 0)
                                                {
                                                   _loc3_ -= 16;
                                                   si32(_loc17_,_loc3_ + 4);
                                                   si32(_loc15_,_loc3_);
                                                   if(uint(_loc14_) > uint(_loc4_))
                                                   {
                                                      _loc14_ = _loc4_;
                                                   }
                                                   si32(_loc14_,_loc3_ + 8);
                                                   ESP = _loc3_;
                                                   Fmemcpy();
                                                   _loc3_ += 16;
                                                   _loc3_ -= 16;
                                                   si32(_loc17_,_loc3_);
                                                   ESP = _loc3_;
                                                   F_idalloc();
                                                   _loc3_ += 16;
                                                }
                                                else
                                                {
                                                   addr1924:
                                                   if((_loc16_ = li8(_opt_xmalloc_2E_b)) == 1)
                                                   {
                                                      _loc10_ = li32(__malloc_message);
                                                      _loc3_ -= 16;
                                                      si32(L__2E_str242,_loc3_ + 12);
                                                      si32(L__2E_str242,_loc3_ + 8);
                                                      si32(L__2E_str45,_loc3_ + 4);
                                                      si32(li32(___progname),_loc3_);
                                                      ESP = _loc3_;
                                                      ptr2fun[_loc10_]();
                                                      _loc3_ += 16;
                                                      ESP = _loc3_;
                                                      F_abort();
                                                   }
                                                   ESP = _loc3_;
                                                   F___error();
                                                   _loc16_ = eax;
                                                   si32(12,_loc16_);
                                                   _loc15_ = 0;
                                                }
                                                §§goto(addr2441);
                                             }
                                             §§goto(addr1472);
                                          }
                                          §§goto(addr1199);
                                       }
                                       _loc3_ -= 16;
                                       si32(_loc13_,_loc3_);
                                       ESP = _loc3_;
                                       F__pthread_mutex_lock();
                                       _loc3_ += 16;
                                    }
                                 }
                                 §§goto(addr951);
                              }
                           }
                           §§goto(addr2441);
                        }
                     }
                  }
                  §§goto(addr1199);
               }
               else
               {
                  if(uint(_loc15_) < uint(_loc14_))
                  {
                     if((_loc16_ = ((_loc6_ = _loc16_ + _loc4_) ^ (_loc16_ = li32(_chunksize_mask)) + _loc14_) & (_loc16_ ^ -1)) == 0)
                     {
                        if((_loc16_ = li8(_opt_junk_2E_b)) == 1)
                        {
                           if(uint(_loc14_) > uint(_loc4_))
                           {
                              _loc3_ -= 16;
                              si32(90,_loc3_ + 4);
                              si32(_loc16_ = _loc14_ - _loc4_,_loc3_ + 8);
                              si32(_loc16_ = _loc4_ + _loc17_,_loc3_);
                              ESP = _loc3_;
                              Fmemset();
                              _loc3_ += 16;
                              _loc15_ = _loc17_;
                           }
                           §§goto(addr2441);
                        }
                        _loc16_ = li8(_opt_zero_2E_b);
                        _loc15_ = _loc17_;
                        if(_loc16_ == 1)
                        {
                           _loc15_ = _loc17_;
                           if(uint(_loc14_) < uint(_loc4_))
                           {
                              _loc3_ -= 16;
                              si32(0,_loc3_ + 4);
                              si32(_loc16_ = _loc4_ - _loc14_,_loc3_ + 8);
                              si32(_loc16_ = _loc14_ + _loc17_,_loc3_);
                              ESP = _loc3_;
                              Fmemset();
                              _loc3_ += 16;
                              _loc15_ = _loc17_;
                           }
                        }
                     }
                     §§goto(addr2441);
                  }
                  _loc3_ -= 16;
                  si32(0,_loc3_ + 4);
                  si32(_loc4_,_loc3_);
                  ESP = _loc3_;
                  F_huge_malloc();
                  _loc3_ += 16;
                  if((_loc15_ = eax) != 0)
                  {
                     _loc3_ -= 16;
                     si32(_loc17_,_loc3_ + 4);
                     si32(_loc15_,_loc3_);
                     if(uint(_loc14_) > uint(_loc4_))
                     {
                        _loc14_ = _loc4_;
                     }
                     si32(_loc14_,_loc3_ + 8);
                     ESP = _loc3_;
                     Fmemcpy();
                     _loc3_ += 16;
                     _loc3_ -= 16;
                     si32(_loc17_,_loc3_);
                     ESP = _loc3_;
                     F_idalloc();
                     _loc3_ += 16;
                  }
                  §§goto(addr2441);
               }
            }
            else
            {
               ESP = _loc3_;
               F_malloc_init();
               if((_loc16_ = eax) == 0)
               {
                  if((uint(_loc16_ = li32(_arena_maxclass))) >= uint(_loc4_))
                  {
                     if((_loc16_ = li32(___isthreaded)) != 0)
                     {
                        if((uint(_loc16_ = li32(_narenas))) >= 2)
                        {
                           ESP = _loc3_;
                           F__pthread_self();
                           _loc16_ = li32(_narenas);
                           _loc17_ = (_loc14_ = uint(eax) % uint(_loc16_)) << 2;
                           if((_loc13_ = li32(_loc16_ = (_loc16_ = li32(_arenas)) + _loc17_)) == 0)
                           {
                              if((_loc16_ = li32(___isthreaded)) != 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_arenas_lock,_loc3_);
                                 ESP = _loc3_;
                                 F__pthread_mutex_trylock();
                                 _loc3_ += 16;
                                 if((_loc16_ = eax) != 0)
                                 {
                                    _loc15_ = 1;
                                    if((uint(_loc16_ = li32(_ncpus))) > 1)
                                    {
                                       while(true)
                                       {
                                          if(uint(_loc15_) < 12)
                                          {
                                             continue;
                                          }
                                       }
                                       §§goto(addr2226);
                                    }
                                    _loc3_ -= 16;
                                    si32(_arenas_lock,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_lock();
                                    _loc3_ += 16;
                                 }
                              }
                              addr2226:
                              if((_loc13_ = li32(_loc16_ = (_loc16_ = li32(_arenas)) + _loc17_)) == 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_loc14_,_loc3_);
                                 ESP = _loc3_;
                                 F_arenas_extend();
                                 _loc3_ += 16;
                                 _loc13_ = eax;
                              }
                              if((_loc16_ = li32(___isthreaded)) != 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_arenas_lock,_loc3_);
                                 ESP = _loc3_;
                                 F__pthread_mutex_unlock();
                                 _loc3_ += 16;
                              }
                              §§goto(addr2301);
                           }
                        }
                        else
                        {
                           addr2294:
                           _loc13_ = li32(_loc16_ = li32(_arenas));
                        }
                        §§goto(addr2301);
                     }
                     §§goto(addr2294);
                  }
                  else
                  {
                     _loc3_ -= 16;
                     si32(0,_loc3_ + 4);
                     si32(_loc4_,_loc3_);
                     ESP = _loc3_;
                     F_huge_malloc();
                     _loc3_ += 16;
                     _loc15_ = eax;
                  }
                  addr2301:
                  _loc3_ -= 16;
                  si32(0,_loc3_ + 8);
                  si32(_loc4_,_loc3_ + 4);
                  si32(_loc13_,_loc3_);
                  ESP = _loc3_;
                  F_arena_malloc();
                  _loc3_ += 16;
                  _loc15_ = eax;
                  if(_loc15_ == 0)
                  {
                     addr2367:
                     if((_loc16_ = li8(_opt_xmalloc_2E_b)) == 1)
                     {
                        _loc16_ = li32(__malloc_message);
                        _loc3_ -= 16;
                        si32(L__2E_str242,_loc3_ + 12);
                        si32(L__2E_str242,_loc3_ + 8);
                        si32(L__2E_str45,_loc3_ + 4);
                        si32(li32(___progname),_loc3_);
                        ESP = _loc3_;
                        ptr2fun[_loc16_]();
                        _loc3_ += 16;
                        ESP = _loc3_;
                        F_abort();
                     }
                     ESP = _loc3_;
                     F___error();
                     _loc16_ = eax;
                     si32(12,_loc16_);
                     _loc15_ = 0;
                  }
                  §§goto(addr2441);
               }
               §§goto(addr2367);
            }
         }
         addr2441:
         eax = _loc15_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr87);
   }
}
