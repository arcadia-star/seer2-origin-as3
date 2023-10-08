package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_posix_memalign() : void
   {
      var _loc5_:* = 0;
      var _loc16_:* = 0;
      var _loc17_:* = 0;
      var _loc15_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:int = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 16;
      ESP = _loc3_;
      F_malloc_init();
      var _loc4_:*;
      if((_loc4_ = eax) == 0)
      {
         if((_loc4_ = (_loc16_ = (_loc17_ = li32(_loc5_ + 4)) + -1) & _loc17_) == 0)
         {
            if(uint(_loc17_) <= 3)
            {
               §§goto(addr73);
            }
            §§goto(addr132);
         }
         addr73:
         _loc15_ = 22;
         if((_loc4_ = li8(_opt_xmalloc_2E_b)) == 1)
         {
            _loc4_ = li32(__malloc_message);
            _loc3_ -= 16;
            si32(L__2E_str242,_loc3_ + 12);
            si32(L__2E_str242,_loc3_ + 8);
            si32(L__2E_str47,_loc3_ + 4);
            si32(li32(___progname),_loc3_);
            ESP = _loc3_;
            ptr2fun[_loc4_]();
            _loc3_ += 16;
            ESP = _loc3_;
            F_abort();
            addr132:
            if((_loc13_ = li32(_loc5_ + 8)) == 0)
            {
               _loc13_ = 1;
               _loc15_ = 0;
               if((_loc4_ = li8(_opt_sysv_2E_b)) == 0)
               {
               }
               §§goto(addr2300);
            }
            _loc4_ = _loc13_ + _loc16_;
            var _loc14_:* = 0 - _loc17_;
            if((uint(_loc15_ = _loc4_ & _loc14_)) >= uint(_loc13_))
            {
               _loc16_ = li32(_loc5_);
               if(uint(_loc15_) >= 4097)
               {
                  _loc12_ = li32(_arena_maxclass);
                  if(uint(_loc17_) <= 4096)
                  {
                     if(uint(_loc15_) <= uint(_loc12_))
                     {
                        addr194:
                        if((_loc4_ = li32(___isthreaded)) != 0)
                        {
                           if((uint(_loc4_ = li32(_narenas))) >= 2)
                           {
                              ESP = _loc3_;
                              F__pthread_self();
                              _loc4_ = li32(_narenas);
                              _loc10_ = (_loc11_ = uint(eax) % uint(_loc4_)) << 2;
                              if((_loc13_ = li32(_loc4_ = (_loc4_ = li32(_arenas)) + _loc10_)) == 0)
                              {
                                 if((_loc4_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_arenas_lock,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_trylock();
                                    _loc3_ += 16;
                                    if((_loc4_ = eax) != 0)
                                    {
                                       _loc12_ = 1;
                                       if((uint(_loc4_ = li32(_ncpus))) > 1)
                                       {
                                          while(true)
                                          {
                                             if(uint(_loc12_) < 12)
                                             {
                                                continue;
                                             }
                                          }
                                          §§goto(addr399);
                                       }
                                       _loc3_ -= 16;
                                       si32(_arenas_lock,_loc3_);
                                       ESP = _loc3_;
                                       F__pthread_mutex_lock();
                                       _loc3_ += 16;
                                    }
                                 }
                                 addr399:
                                 if((_loc13_ = li32(_loc4_ = (_loc4_ = li32(_arenas)) + _loc10_)) == 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_loc11_,_loc3_);
                                    ESP = _loc3_;
                                    F_arenas_extend();
                                    _loc3_ += 16;
                                    _loc13_ = eax;
                                 }
                                 if((_loc4_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_arenas_lock,_loc3_);
                                    ESP = _loc3_;
                                    F__pthread_mutex_unlock();
                                    _loc3_ += 16;
                                 }
                                 §§goto(addr474);
                              }
                           }
                           else
                           {
                              addr467:
                              _loc13_ = li32(_loc4_ = li32(_arenas));
                           }
                           addr474:
                           _loc3_ -= 16;
                           si32(0,_loc3_ + 8);
                           si32(_loc15_,_loc3_ + 4);
                           si32(_loc13_,_loc3_);
                           ESP = _loc3_;
                           F_arena_malloc();
                           _loc3_ += 16;
                           _loc12_ = eax;
                           §§goto(addr2231);
                        }
                        §§goto(addr467);
                     }
                     §§goto(addr2235);
                  }
                  if((uint(_loc11_ = (_loc10_ = _loc13_ + 4095) & -4096)) >= uint(_loc13_))
                  {
                     _loc15_ = (_loc4_ = _loc17_ + 4095) & -4096;
                     _loc13_ = _loc11_ + _loc15_;
                     _loc17_ = 1;
                     if(uint(_loc13_) >= uint(_loc11_))
                     {
                        _loc17_ = 0;
                     }
                     if(_loc17_ == 0)
                     {
                        _loc1_ = _loc17_ = _loc15_ << 1;
                        if(uint(_loc11_) >= uint(_loc15_))
                        {
                           _loc1_ = _loc13_;
                        }
                        if((uint(_loc13_ = _loc1_ + -4096)) <= uint(_loc12_))
                        {
                           if((_loc4_ = li32(___isthreaded)) != 0)
                           {
                              if((uint(_loc4_ = li32(_narenas))) >= 2)
                              {
                                 ESP = _loc3_;
                                 F__pthread_self();
                                 _loc4_ = li32(_narenas);
                                 _loc1_ = (_loc12_ = uint(eax) % uint(_loc4_)) << 2;
                                 if((_loc17_ = li32(_loc4_ = (_loc4_ = li32(_arenas)) + _loc1_)) == 0)
                                 {
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_arenas_lock,_loc3_);
                                       ESP = _loc3_;
                                       F__pthread_mutex_trylock();
                                       _loc3_ += 16;
                                       if((_loc4_ = eax) != 0)
                                       {
                                          _loc17_ = 1;
                                          if((uint(_loc4_ = li32(_ncpus))) > 1)
                                          {
                                             while(true)
                                             {
                                                if(uint(_loc17_) < 12)
                                                {
                                                   continue;
                                                }
                                             }
                                             addr781:
                                             _loc1_ = li32(_loc4_ = (_loc4_ = li32(_arenas)) + _loc1_);
                                             if(_loc1_ == 0)
                                             {
                                                _loc3_ -= 16;
                                                si32(_loc12_,_loc3_);
                                                ESP = _loc3_;
                                                F_arenas_extend();
                                                _loc3_ += 16;
                                                _loc1_ = eax;
                                             }
                                             if((_loc4_ = li32(___isthreaded)) == 0)
                                             {
                                                _loc17_ = _loc1_;
                                             }
                                             else
                                             {
                                                _loc3_ -= 16;
                                                si32(_arenas_lock,_loc3_);
                                                ESP = _loc3_;
                                                F__pthread_mutex_unlock();
                                                _loc3_ += 16;
                                                _loc17_ = _loc1_;
                                                addr862:
                                                _loc4_ = li32(___isthreaded);
                                                _loc1_ = _loc17_;
                                                if(_loc4_ != 0)
                                                {
                                                   _loc3_ -= 16;
                                                   si32(_loc17_,_loc3_);
                                                   ESP = _loc3_;
                                                   F__pthread_mutex_trylock();
                                                   _loc3_ += 16;
                                                   _loc1_ = _loc17_;
                                                   if(eax != 0)
                                                   {
                                                      _loc12_ = 1;
                                                      if((uint(_loc4_ = li32(_ncpus))) > 1)
                                                      {
                                                         while(true)
                                                         {
                                                            if(uint(_loc12_) < 12)
                                                            {
                                                               continue;
                                                            }
                                                         }
                                                         addr1020:
                                                         _loc3_ -= 16;
                                                         si32(0,_loc3_ + 12);
                                                         si32(1,_loc3_ + 8);
                                                         si32(_loc13_,_loc3_ + 4);
                                                         si32(_loc17_,_loc3_);
                                                         ESP = _loc3_;
                                                         F_arena_run_alloc();
                                                         _loc3_ += 16;
                                                         if((_loc12_ = eax) == 0)
                                                         {
                                                            if((_loc4_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc3_ -= 16;
                                                               si32(_loc1_,_loc3_);
                                                               ESP = _loc3_;
                                                               F__pthread_mutex_unlock();
                                                               _loc3_ += 16;
                                                            }
                                                            §§goto(addr2235);
                                                         }
                                                         else
                                                         {
                                                            _loc6_ = _loc12_ & _loc15_ + -1;
                                                            _loc7_ = _loc12_ & ((_loc4_ = li32(_chunksize_mask)) ^ -1);
                                                            if(_loc6_ == 0)
                                                            {
                                                               var _loc8_:*;
                                                               si32(_loc8_ = _loc11_ | 3,(_loc4_ = _loc7_ + 16) + (_loc14_ = (_loc4_ = _loc12_ - _loc7_) >>> 12) * 12 + 8);
                                                               si32(_loc14_ = (_loc14_ = _loc13_ - _loc11_) | 3,_loc4_ + (_loc14_ += _loc10_ >>> 12) * 12 + 8);
                                                               _loc3_ -= 16;
                                                               si32(0,_loc3_ + 8);
                                                               si32(_loc4_ = _loc12_ + _loc11_,_loc3_ + 4);
                                                               si32(_loc17_,_loc3_);
                                                               ESP = _loc3_;
                                                               F_arena_run_dalloc();
                                                               _loc3_ += 16;
                                                            }
                                                            else
                                                            {
                                                               _loc2_ = _loc15_ - _loc6_;
                                                               _loc13_ -= _loc2_;
                                                               if(_loc6_ != _loc15_)
                                                               {
                                                                  var _loc9_:*;
                                                                  si32(_loc9_ = _loc2_ | 3,(_loc4_ = _loc7_ + 16) + (_loc14_ = (_loc4_ = _loc12_ - _loc7_) >>> 12) * 12 + 8);
                                                                  si32(_loc4_ = _loc13_ | 3,_loc4_ + (_loc14_ += _loc2_ >>> 12) * 12 + 8);
                                                                  _loc3_ -= 16;
                                                                  si32(0,_loc3_ + 8);
                                                                  si32(_loc12_,_loc3_ + 4);
                                                                  si32(_loc17_,_loc3_);
                                                                  _loc12_ = _loc2_ + _loc12_;
                                                                  ESP = _loc3_;
                                                                  F_arena_run_dalloc();
                                                                  _loc3_ += 16;
                                                               }
                                                               if(_loc13_ != _loc11_)
                                                               {
                                                                  si32(_loc9_ = _loc11_ | 3,(_loc4_ = _loc7_ + 16) + (_loc14_ = (_loc4_ = _loc12_ - _loc7_) >>> 12) * 12 + 8);
                                                                  si32(_loc14_ = (_loc14_ = _loc13_ - _loc11_) | 3,_loc4_ + (_loc14_ += _loc10_ >>> 12) * 12 + 8);
                                                                  _loc3_ -= 16;
                                                                  si32(0,_loc3_ + 8);
                                                                  si32(_loc4_ = _loc12_ + _loc11_,_loc3_ + 4);
                                                                  si32(_loc17_,_loc3_);
                                                                  ESP = _loc3_;
                                                                  F_arena_run_dalloc();
                                                                  _loc3_ += 16;
                                                               }
                                                            }
                                                            if((_loc4_ = li32(___isthreaded)) != 0)
                                                            {
                                                               _loc3_ -= 16;
                                                               si32(_loc1_,_loc3_);
                                                               ESP = _loc3_;
                                                               F__pthread_mutex_unlock();
                                                               _loc3_ += 16;
                                                            }
                                                            if((_loc4_ = li8(_opt_junk_2E_b)) == 1)
                                                            {
                                                               _loc3_ -= 16;
                                                               si32(_loc11_,_loc3_ + 8);
                                                               si32(165,_loc3_ + 4);
                                                               si32(_loc12_,_loc3_);
                                                               ESP = _loc3_;
                                                               Fmemset();
                                                               _loc3_ += 16;
                                                            }
                                                            else if((_loc4_ = li8(_opt_zero_2E_b)) == 1)
                                                            {
                                                               _loc3_ -= 16;
                                                               si32(_loc11_,_loc3_ + 8);
                                                               si32(0,_loc3_ + 4);
                                                               si32(_loc12_,_loc3_);
                                                               ESP = _loc3_;
                                                               Fmemset();
                                                               _loc3_ += 16;
                                                            }
                                                            addr2231:
                                                            if(_loc12_ == 0)
                                                            {
                                                               addr2235:
                                                               _loc15_ = 12;
                                                               if((_loc4_ = li8(_opt_xmalloc_2E_b)) == 1)
                                                               {
                                                                  _loc4_ = li32(__malloc_message);
                                                                  _loc3_ -= 16;
                                                                  si32(L__2E_str242,_loc3_ + 12);
                                                                  si32(L__2E_str242,_loc3_ + 8);
                                                                  si32(L__2E_str48,_loc3_ + 4);
                                                                  si32(li32(___progname),_loc3_);
                                                                  ESP = _loc3_;
                                                                  ptr2fun[_loc4_]();
                                                                  _loc3_ += 16;
                                                                  ESP = _loc3_;
                                                                  F_abort();
                                                               }
                                                               §§goto(addr2300);
                                                            }
                                                            si32(_loc12_,_loc16_);
                                                            _loc15_ = 0;
                                                            §§goto(addr2300);
                                                         }
                                                      }
                                                      _loc3_ -= 16;
                                                      si32(_loc17_,_loc3_);
                                                      ESP = _loc3_;
                                                      F__pthread_mutex_lock();
                                                      _loc3_ += 16;
                                                      _loc1_ = _loc17_;
                                                   }
                                                }
                                             }
                                             §§goto(addr1020);
                                          }
                                          _loc3_ -= 16;
                                          si32(_arenas_lock,_loc3_);
                                          ESP = _loc3_;
                                          F__pthread_mutex_lock();
                                          _loc3_ += 16;
                                       }
                                    }
                                    §§goto(addr781);
                                 }
                              }
                              else
                              {
                                 addr855:
                                 _loc17_ = li32(_loc4_ = li32(_arenas));
                              }
                              §§goto(addr862);
                           }
                           §§goto(addr855);
                        }
                        else
                        {
                           _loc13_ = li32(_chunksize);
                           if(uint(_loc15_) <= uint(_loc13_))
                           {
                              _loc3_ -= 16;
                              si32(0,_loc3_ + 4);
                              si32(_loc11_,_loc3_);
                              ESP = _loc3_;
                              F_huge_malloc();
                              _loc3_ += 16;
                              _loc12_ = eax;
                              §§goto(addr474);
                           }
                           else
                           {
                              _loc10_ = (_loc14_ = li32(_chunksize_mask)) + _loc11_ & (_loc14_ ^ -1);
                              if(uint(_loc11_) >= uint(_loc15_))
                              {
                                 _loc17_ = _loc10_ + _loc15_;
                              }
                              if((_loc4_ = li32(___isthreaded)) != 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_base_mtx,_loc3_);
                                 ESP = _loc3_;
                                 F__spinlock();
                                 _loc3_ += 16;
                              }
                              _loc17_ -= _loc13_;
                              if((_loc11_ = li32(_base_nodes)) != 0)
                              {
                                 si32(_loc4_ = li32(_loc11_),_base_nodes);
                                 if((_loc4_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_base_mtx,_loc3_);
                                    ESP = _loc3_;
                                    F__spinunlock();
                                    _loc3_ += 16;
                                 }
                                 addr1840:
                                 _loc3_ -= 16;
                                 si32(0,_loc3_ + 4);
                                 si32(_loc17_,_loc3_);
                                 ESP = _loc3_;
                                 F_chunk_alloc();
                                 _loc3_ += 16;
                                 if((_loc12_ = eax) == 0)
                                 {
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_base_mtx,_loc3_);
                                       ESP = _loc3_;
                                       F__spinlock();
                                       _loc3_ += 16;
                                    }
                                    si32(_loc4_ = li32(_base_nodes),_loc11_);
                                    si32(_loc11_,_base_nodes);
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_base_mtx,_loc3_);
                                       ESP = _loc3_;
                                       F__spinunlock();
                                       _loc3_ += 16;
                                    }
                                    §§goto(addr2235);
                                 }
                                 else
                                 {
                                    if((_loc13_ = _loc12_ & _loc15_ + -1) == 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_loc17_ - _loc10_,_loc3_ + 4);
                                       si32(_loc4_ = _loc12_ + _loc10_,_loc3_);
                                       ESP = _loc3_;
                                       F_chunk_dealloc();
                                       _loc3_ += 16;
                                    }
                                    else
                                    {
                                       _loc17_ = (_loc4_ = _loc13_ - _loc15_) + _loc17_;
                                       _loc3_ -= 16;
                                       si32(_loc15_ - _loc13_,_loc3_ + 4);
                                       si32(_loc12_,_loc3_);
                                       _loc12_ = _loc15_ - _loc13_ + _loc12_;
                                       ESP = _loc3_;
                                       F_chunk_dealloc();
                                       _loc3_ += 16;
                                       if(_loc17_ != _loc10_)
                                       {
                                          _loc3_ -= 16;
                                          si32(_loc17_ - _loc10_,_loc3_ + 4);
                                          si32(_loc4_ = _loc12_ + _loc10_,_loc3_);
                                          ESP = _loc3_;
                                          F_chunk_dealloc();
                                          _loc3_ += 16;
                                       }
                                    }
                                    si32(_loc12_,_loc11_ + 16);
                                    si32(_loc10_,_loc11_ + 20);
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_huge_mtx,_loc3_);
                                       ESP = _loc3_;
                                       F__spinlock();
                                       _loc3_ += 16;
                                    }
                                    _loc3_ -= 16;
                                    si32(_loc11_,_loc3_ + 4);
                                    si32(_huge,_loc3_);
                                    ESP = _loc3_;
                                    F_extent_tree_ad_insert();
                                    _loc3_ += 16;
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_huge_mtx,_loc3_);
                                       ESP = _loc3_;
                                       F__spinunlock();
                                       _loc3_ += 16;
                                    }
                                    if((_loc4_ = li8(_opt_junk_2E_b)) == 1)
                                    {
                                       _loc3_ -= 16;
                                       si32(_loc10_,_loc3_ + 8);
                                       si32(165,_loc3_ + 4);
                                       si32(_loc12_,_loc3_);
                                       ESP = _loc3_;
                                       Fmemset();
                                       _loc3_ += 16;
                                    }
                                    else if((_loc4_ = li8(_opt_zero_2E_b)) == 1)
                                    {
                                       _loc3_ -= 16;
                                       si32(_loc10_,_loc3_ + 8);
                                       si32(0,_loc3_ + 4);
                                       si32(_loc12_,_loc3_);
                                       ESP = _loc3_;
                                       Fmemset();
                                       _loc3_ += 16;
                                    }
                                    §§goto(addr474);
                                 }
                              }
                              else
                              {
                                 if((_loc4_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_base_mtx,_loc3_);
                                    ESP = _loc3_;
                                    F__spinunlock();
                                    _loc3_ += 16;
                                    if((_loc4_ = li32(___isthreaded)) != 0)
                                    {
                                       _loc3_ -= 16;
                                       si32(_base_mtx,_loc3_);
                                       ESP = _loc3_;
                                       F__spinlock();
                                       _loc3_ += 16;
                                    }
                                 }
                                 _loc4_ = (_loc11_ = li32(_base_next_addr)) + 64;
                                 _loc14_ = li32(_base_past_addr);
                                 if(uint(_loc4_) > uint(_loc14_))
                                 {
                                    _loc3_ -= 16;
                                    si32(64,_loc3_);
                                    ESP = _loc3_;
                                    F_base_pages_alloc();
                                    _loc3_ += 16;
                                    if((_loc4_ = eax) == 0)
                                    {
                                       _loc11_ = li32(_base_next_addr);
                                    }
                                    else
                                    {
                                       if((_loc4_ = li32(___isthreaded)) != 0)
                                       {
                                          _loc3_ -= 16;
                                          si32(_base_mtx,_loc3_);
                                          ESP = _loc3_;
                                          F__spinunlock();
                                          _loc3_ += 16;
                                       }
                                       §§goto(addr2235);
                                    }
                                    §§goto(addr2235);
                                 }
                                 si32(_loc4_ = _loc11_ + 64,_base_next_addr);
                                 if((_loc4_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc3_ -= 16;
                                    si32(_base_mtx,_loc3_);
                                    ESP = _loc3_;
                                    F__spinunlock();
                                    _loc3_ += 16;
                                 }
                                 if(_loc11_ != 0)
                                 {
                                    §§goto(addr1840);
                                 }
                                 §§goto(addr2235);
                              }
                              §§goto(addr2235);
                           }
                        }
                     }
                  }
                  §§goto(addr2235);
               }
               §§goto(addr194);
            }
            §§goto(addr2235);
         }
         addr2300:
         eax = _loc15_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr2235);
   }
}
