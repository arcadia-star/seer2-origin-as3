package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_malloc_init() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 1072;
      _loc1_ = 0;
      var _loc13_:*;
      if((_loc13_ = li8(_malloc_initialized_2E_b)) == 0)
      {
         if((_loc13_ = li32(___isthreaded)) != 0)
         {
            _loc2_ -= 16;
            si32(_init_lock,_loc2_);
            ESP = _loc2_;
            F__spinlock();
            _loc2_ += 16;
            if((_loc13_ = li8(_malloc_initialized_2E_b)) == 1)
            {
               _loc1_ = 0;
               if((_loc13_ = li32(___isthreaded)) != 0)
               {
                  _loc2_ -= 16;
                  si32(_init_lock,_loc2_);
                  ESP = _loc2_;
                  F__spinunlock();
                  _loc2_ += 16;
                  _loc1_ = 0;
               }
            }
            §§goto(addr2558);
         }
         si32(6,_loc3_ - 1052);
         si32(3,_loc3_ - 1048);
         si32(4,_loc3_ - 1056);
         _loc2_ -= 32;
         si32(_loc1_,_loc2_ + 20);
         si32(0,_loc2_ + 16);
         si32(_loc13_ = _loc3_ - 1056,_loc2_ + 12);
         si32(_ncpus,_loc2_ + 8);
         si32(2,_loc2_ + 4);
         si32(_loc13_ = _loc3_ - 1052,_loc2_);
         ESP = _loc2_;
         F_sysctl();
         _loc2_ += 32;
         if((_loc13_ = eax) == -1)
         {
            si32(1,_ncpus);
         }
         _loc2_ -= 16;
         si32(2,_loc2_ + 4);
         _loc1_ = _loc3_ - 1064;
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F_getpagesizes();
         _loc2_ += 16;
         if((_loc12_ = eax) >= 1)
         {
            _loc11_ = li32(_opt_chunk_2pow);
            do
            {
               if((uint(_loc10_ = li32(_loc1_))) <= 4194304)
               {
                  if((uint(_loc13_ = 1 << _loc11_)) < uint(_loc10_))
                  {
                     do
                     {
                        _loc11_ += 1;
                     }
                     while((uint(_loc13_ = 1 << _loc11_)) < uint(_loc10_));
                     
                  }
               }
               _loc1_ += 4;
            }
            while((_loc12_ += -1) != 0);
            
            si32(_loc11_,_opt_chunk_2pow);
         }
         _loc10_ = 0;
         do
         {
            if(_loc10_ != 2)
            {
               if(_loc10_ != 1)
               {
                  if(_loc10_ == 0)
                  {
                     si8(0,_loc3_ - 1041);
                     _loc9_ = _loc3_ - 1041;
                  }
               }
               else
               {
                  _loc2_ -= 16;
                  si32(L__2E_str42,_loc2_);
                  ESP = _loc2_;
                  F_getenv();
                  _loc2_ += 16;
                  if((_loc9_ = eax) == 0)
                  {
                     si8(0,_loc3_ - 1041);
                     _loc9_ = _loc3_ - 1041;
                  }
               }
            }
            else if((_loc9_ = li32(__malloc_options)) == 0)
            {
               si8(0,_loc3_ - 1041);
               _loc9_ = _loc3_ - 1041;
            }
            _loc8_ = li8(_loc9_);
            _loc11_ = 0;
            if(_loc8_ != 0)
            {
               do
               {
                  _loc12_ = _loc9_ + _loc11_;
                  _loc13_ = (_loc6_ = (_loc13_ = _loc8_ << 24) >> 24) + -48;
                  _loc7_ = 0;
                  _loc1_ = 1;
                  if(uint(_loc13_) < 10)
                  {
                     do
                     {
                        _loc13_ = _loc7_ * 10;
                        _loc7_ = (_loc13_ = _loc6_ + _loc13_) + -48;
                        _loc13_ = (_loc6_ = si8(li8((_loc13_ = _loc9_ + _loc11_) + 1))) + -48;
                        _loc11_ += 1;
                     }
                     while(uint(_loc13_) < 10);
                     
                     _loc12_ = _loc9_ + _loc11_;
                     _loc1_ = _loc7_;
                     _loc8_ = _loc6_;
                     if(_loc7_ == 0)
                     {
                        continue;
                     }
                  }
                  while(true)
                  {
                     if((_loc6_ = (_loc13_ = _loc8_ << 24) >> 24) <= 96)
                     {
                        if(_loc6_ <= 76)
                        {
                           if(_loc6_ <= 67)
                           {
                              if(_loc6_ == 65)
                              {
                                 si8(1,_opt_abort_2E_b);
                                 continue;
                              }
                              if(_loc6_ == 66)
                              {
                                 continue;
                              }
                              if(_loc6_ == 67)
                              {
                                 if((uint(_loc8_ = li32(_opt_cspace_max_2pow))) <= 10)
                                 {
                                    si32(_loc13_ = _loc8_ + 1,_opt_cspace_max_2pow);
                                 }
                                 continue;
                              }
                           }
                           else if(_loc6_ <= 73)
                           {
                              if(_loc6_ == 68)
                              {
                                 si8(0,_opt_dss_2E_b);
                                 continue;
                              }
                              if(_loc6_ == 70)
                              {
                                 if((_loc8_ = li32(_opt_dirty_max)) == 0)
                                 {
                                    si32(1,_opt_dirty_max);
                                 }
                                 else if((_loc13_ = _loc8_ & 2147483647) != 0)
                                 {
                                    si32(_loc13_ = _loc8_ << 1,_opt_dirty_max);
                                 }
                                 continue;
                              }
                           }
                           else
                           {
                              if(_loc6_ == 74)
                              {
                                 si8(1,_opt_junk_2E_b);
                                 continue;
                              }
                              if(_loc6_ == 75)
                              {
                                 if((uint(_loc8_ = (_loc13_ = li32(_opt_chunk_2pow)) + 1)) <= 31)
                                 {
                                    si32(_loc8_,_opt_chunk_2pow);
                                 }
                                 continue;
                              }
                           }
                        }
                        else if(_loc6_ <= 84)
                        {
                           if(_loc6_ <= 79)
                           {
                              if(_loc6_ == 77)
                              {
                                 si8(0,_opt_mmap_2E_b);
                                 continue;
                              }
                              if(_loc6_ == 78)
                              {
                                 si32(_loc13_ = (_loc13_ = li32(_opt_narenas_lshift)) + 1,_opt_narenas_lshift);
                                 continue;
                              }
                           }
                           else
                           {
                              if(_loc6_ == 80)
                              {
                                 si8(1,_opt_print_stats_2E_b);
                                 continue;
                              }
                              if(_loc6_ == 81)
                              {
                                 _loc8_ = (_loc13_ = li32(_opt_qspace_max_2pow)) + 1;
                                 if(uint(_loc8_) < uint(li32(_opt_cspace_max_2pow)))
                                 {
                                    si32(_loc8_,_opt_qspace_max_2pow);
                                 }
                                 continue;
                              }
                           }
                        }
                        else if(_loc6_ <= 87)
                        {
                           if(_loc6_ == 85)
                           {
                              si8(1,_opt_utrace_2E_b);
                              continue;
                           }
                           if(_loc6_ == 86)
                           {
                              si8(1,_opt_sysv_2E_b);
                              continue;
                           }
                        }
                        else
                        {
                           if(_loc6_ == 88)
                           {
                              si8(1,_opt_xmalloc_2E_b);
                              continue;
                           }
                           if(_loc6_ == 90)
                           {
                              si8(1,_opt_zero_2E_b);
                              continue;
                           }
                        }
                     }
                     else if(_loc6_ <= 108)
                     {
                        if(_loc6_ <= 99)
                        {
                           if(_loc6_ == 97)
                           {
                              si8(0,_opt_abort_2E_b);
                              continue;
                           }
                           if(_loc6_ == 98)
                           {
                              continue;
                           }
                           if(_loc6_ == 99)
                           {
                              _loc6_ = (_loc8_ = li32(_opt_cspace_max_2pow)) + -1;
                              if(uint(_loc6_) > uint(li32(_opt_qspace_max_2pow)))
                              {
                                 if(uint(_loc8_) >= 7)
                                 {
                                    si32(_loc6_,_opt_cspace_max_2pow);
                                 }
                              }
                              continue;
                           }
                        }
                        else if(_loc6_ <= 105)
                        {
                           if(_loc6_ == 100)
                           {
                              si8(1,_opt_dss_2E_b);
                              continue;
                           }
                           if(_loc6_ == 102)
                           {
                              si32(_loc13_ = (_loc13_ = li32(_opt_dirty_max)) >>> 1,_opt_dirty_max);
                              continue;
                           }
                        }
                        else
                        {
                           if(_loc6_ == 106)
                           {
                              si8(0,_opt_junk_2E_b);
                              continue;
                           }
                           if(_loc6_ == 107)
                           {
                              if((uint(_loc8_ = li32(_opt_chunk_2pow))) >= 14)
                              {
                                 si32(_loc13_ = _loc8_ + -1,_opt_chunk_2pow);
                              }
                              continue;
                           }
                        }
                     }
                     else if(_loc6_ <= 116)
                     {
                        if(_loc6_ <= 111)
                        {
                           if(_loc6_ == 109)
                           {
                              si8(1,_opt_mmap_2E_b);
                              continue;
                           }
                           if(_loc6_ == 110)
                           {
                              si32(_loc13_ = (_loc13_ = li32(_opt_narenas_lshift)) + -1,_opt_narenas_lshift);
                              continue;
                           }
                        }
                        else
                        {
                           if(_loc6_ == 112)
                           {
                              si8(0,_opt_print_stats_2E_b);
                              continue;
                           }
                           if(_loc6_ == 113)
                           {
                              if((uint(_loc8_ = li32(_opt_qspace_max_2pow))) >= 5)
                              {
                                 si32(_loc13_ = _loc8_ + -1,_opt_qspace_max_2pow);
                              }
                              continue;
                           }
                        }
                     }
                     else if(_loc6_ <= 119)
                     {
                        if(_loc6_ == 117)
                        {
                           si8(0,_opt_utrace_2E_b);
                           continue;
                        }
                        if(_loc6_ == 118)
                        {
                           si8(0,_opt_sysv_2E_b);
                           continue;
                        }
                     }
                     else
                     {
                        if(_loc6_ == 120)
                        {
                           si8(0,_opt_xmalloc_2E_b);
                           continue;
                        }
                        if(_loc6_ == 122)
                        {
                           si8(0,_opt_zero_2E_b);
                           continue;
                        }
                     }
                     si8(_loc8_,_loc3_ - 1066);
                     si8(0,_loc3_ - 1065);
                     _loc13_ = li32(__malloc_message);
                     var _loc5_:* = li32(___progname);
                     _loc2_ -= 16;
                     si32(L__2E_str44,_loc2_ + 12);
                     var _loc4_:*;
                     si32(_loc4_ = _loc3_ - 1066,_loc2_ + 8);
                     si32(L__2E_str43,_loc2_ + 4);
                     si32(_loc5_,_loc2_);
                     ESP = _loc2_;
                     ptr2fun[_loc13_]();
                     _loc2_ += 16;
                  }
               }
               while(_loc11_ += 1, (_loc8_ = li8(_loc13_ = _loc9_ + _loc11_)) != 0);
               
            }
         }
         while((_loc10_ += 1) != 3);
         
         if((_loc13_ = li8(_opt_dss_2E_b)) == 1)
         {
            if((_loc13_ = li8(_opt_mmap_2E_b)) == 1)
            {
               si8(0,_opt_mmap_2E_b);
            }
         }
         if((_loc13_ = li8(_opt_print_stats_2E_b)) == 1)
         {
            si32(1,_loc3_ - 16);
            si32(_malloc_print_stats,(_loc5_ = _loc3_ - 16) | 4);
            si32(0,_loc3_ - 8);
            si32(0,_loc3_ - 4);
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F_atexit_register();
            _loc2_ += 16;
         }
         _loc10_ = li32(_opt_qspace_max_2pow);
         _loc1_ = 1;
         si32(_loc11_ = _loc1_ << _loc10_,_qspace_max);
         _loc12_ = (_loc9_ = (_loc13_ = _loc11_ + 63) & -64) + 64;
         if(_loc9_ != _loc11_)
         {
            _loc12_ = _loc9_;
         }
         si32(_loc12_,_cspace_min);
         _loc9_ = li32(_opt_cspace_max_2pow);
         si32(_loc7_ = _loc1_ << _loc9_,_cspace_max);
         _loc8_ = (_loc6_ = (_loc13_ = _loc7_ + 255) & -256) + 256;
         if(_loc6_ != _loc7_)
         {
            _loc8_ = _loc6_;
         }
         si32(_loc8_,_sspace_min);
         si8(_loc1_,_sspace_max_2E_b);
         _loc4_ = (_loc13_ = (_loc13_ = _loc7_ - _loc12_) >>> 6) + 1;
         si32(_loc5_ = _loc11_ >>> 4,_nqbins);
         si32(_loc4_,_ncbins);
         _loc5_ += _loc13_;
         _loc13_ = (_loc13_ = 3840 - _loc8_) >>> 8;
         si32(_loc13_ = (_loc13_ = _loc5_ + _loc13_) + 5,_nbins);
         if(_loc10_ == 7)
         {
            _loc12_ = _const_size2bin;
            if(_loc9_ != 9)
            {
               addr1235:
               if((_loc13_ = li32(___isthreaded)) != 0)
               {
                  _loc2_ -= 16;
                  si32(_base_mtx,_loc2_);
                  ESP = _loc2_;
                  F__spinlock();
                  _loc2_ += 16;
               }
               _loc13_ = (_loc12_ = li32(_base_next_addr)) + 3904;
               _loc5_ = li32(_base_past_addr);
               if(uint(_loc13_) > uint(_loc5_))
               {
                  _loc2_ -= 16;
                  si32(3904,_loc2_);
                  ESP = _loc2_;
                  F_base_pages_alloc();
                  _loc2_ += 16;
                  if((_loc13_ = eax) == 0)
                  {
                     _loc12_ = li32(_base_next_addr);
                  }
                  else
                  {
                     _loc1_ = 1;
                     if((_loc13_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_base_mtx,_loc2_);
                        ESP = _loc2_;
                        F__spinunlock();
                        _loc2_ += 16;
                        addr1756:
                        _loc1_ = 1;
                        if((_loc13_ = li32(___isthreaded)) != 0)
                        {
                           _loc2_ -= 16;
                           si32(_init_lock,_loc2_);
                           ESP = _loc2_;
                           F__spinunlock();
                           _loc2_ += 16;
                           _loc1_ = 1;
                        }
                     }
                     §§goto(addr2558);
                  }
                  §§goto(addr2558);
               }
               si32(_loc13_ = _loc12_ + 3904,_base_next_addr);
               if((_loc13_ = li32(___isthreaded)) != 0)
               {
                  _loc2_ -= 16;
                  si32(_base_mtx,_loc2_);
                  ESP = _loc2_;
                  F__spinunlock();
                  _loc2_ += 16;
               }
               if(_loc12_ != 0)
               {
                  si8(-1,_loc12_);
                  si8(0,_loc12_ + 1);
                  _loc8_ = _loc12_ + 1;
                  _loc9_ = 0;
                  do
                  {
                     _loc6_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc5_ = (_loc5_ = (_loc13_ = (_loc5_ = (_loc13_ = (_loc5_ = (_loc13_ = (_loc13_ = (_loc11_ = _loc9_ + 1) >>> 1) | _loc11_) >>> 2) | _loc13_) >>> 4) | _loc13_) >>> 8) | _loc13_) >>> 16) | _loc5_) + 1) >>> 2;
                     _loc10_ = 0;
                     if(_loc6_ != 0)
                     {
                        _loc10_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ += (_loc13_ = ((_loc5_ = _loc13_ - ((_loc5_ = (_loc13_ = (_loc5_ = _loc6_ ^ -1) & _loc6_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 1;
                     }
                     _loc13_ = _loc8_ + _loc9_;
                     si8(_loc10_,_loc13_ + 1);
                     _loc9_ = _loc11_;
                  }
                  while(_loc11_ != 14);
                  
                  _loc10_ = 31;
                  _loc11_ = 16;
                  if((uint(_loc13_ = li32(_qspace_max))) >= 16)
                  {
                     do
                     {
                        _loc13_ = _loc12_ + _loc11_;
                        si8(_loc5_ = (_loc5_ = _loc10_ >>> 4) + 2,_loc13_);
                        _loc10_ += 1;
                        _loc11_ += 1;
                        _loc13_ = li32(_qspace_max);
                     }
                     while(uint(_loc11_) <= uint(_loc13_));
                     
                  }
                  _loc13_ = li32(_cspace_max);
                  if(uint(_loc11_) <= uint(_loc13_))
                  {
                     do
                     {
                        _loc13_ = _loc12_ + _loc11_;
                        _loc4_ = (_loc5_ = _loc11_ + 63) & 16320;
                        _loc5_ = li32(_cspace_min);
                        _loc5_ = (_loc5_ = _loc4_ - _loc5_) >>> 6;
                        si8(_loc5_ = (_loc5_ = (_loc4_ = li32(_nqbins)) + _loc5_) + 3,_loc13_);
                        _loc11_ += 1;
                        _loc13_ = li32(_cspace_max);
                     }
                     while(uint(_loc11_) <= uint(_loc13_));
                     
                  }
                  _loc10_ = 3840;
                  if((_loc13_ = li8(_sspace_max_2E_b)) == 0)
                  {
                     _loc10_ = 0;
                  }
                  if(uint(_loc11_) <= uint(_loc10_))
                  {
                     do
                     {
                        _loc5_ = li32(_ncbins);
                        _loc13_ = (_loc13_ = li32(_nqbins)) + _loc5_;
                        _loc4_ = (_loc5_ = _loc11_ + 255) & 65280;
                        _loc5_ = li32(_sspace_min);
                        _loc5_ = (_loc5_ = _loc4_ - _loc5_) >>> 8;
                        _loc13_ = (_loc13_ += _loc5_) + 3;
                        _loc5_ = _loc12_ + _loc11_;
                        si8(_loc13_,_loc5_);
                        _loc10_ = 3840;
                        if((_loc13_ = li8(_sspace_max_2E_b)) == 0)
                        {
                           _loc10_ = 0;
                        }
                     }
                     while((uint(_loc11_ += 1)) <= uint(_loc10_));
                     
                  }
               }
               else
               {
                  §§goto(addr1756);
               }
               §§goto(addr2558);
            }
            si32(_loc12_,_size2bin);
            _loc13_ = li32(_opt_chunk_2pow);
            si32(_loc11_ = _loc1_ << _loc13_,_chunksize);
            si32(_loc13_ = _loc11_ + -1,_chunksize_mask);
            si32(_loc13_ = _loc11_ >>> 12,_chunk_npages);
            if((_loc13_ = (_loc12_ = (_loc13_ *= 12) + 16) & 4092) == 0)
            {
               _loc1_ = 0;
            }
            _loc5_ = _loc12_ >>> 12;
            si32(_loc13_ = (_loc13_ = _loc1_ & 1) + _loc5_,_arena_chunk_header_npages);
            _loc13_ <<= 12;
            si32(_loc13_ = _loc11_ - _loc13_,_arena_maxclass);
            si32(0,_huge_mtx);
            si32(0,_huge_mtx + 4);
            si32(0,_huge_mtx + 8);
            si32(0,_huge_mtx + 12);
            si32(_loc13_ = _huge + 4,_huge);
            si32(_loc13_,_huge + 12);
            si32(_loc13_ &= -2,_huge + 16);
            si32(0,_dss_mtx);
            si32(0,_dss_mtx + 4);
            si32(0,_dss_mtx + 8);
            si32(0,_dss_mtx + 12);
            _loc1_ = ram.length;
            if(_loc1_ == -1)
            {
               ESP = _loc2_;
               F___error();
               si32(12,eax);
            }
            si32(_loc1_,_dss_base);
            si32(_loc1_,_dss_prev);
            si32(_loc1_,_dss_max);
            si32(_loc13_ = _dss_chunks_szad + 4,_dss_chunks_szad);
            si32(_loc13_,_dss_chunks_szad + 4);
            si32(_loc13_ &= -2,_dss_chunks_szad + 8);
            si32(_loc13_ = _dss_chunks_ad + 4,_dss_chunks_ad);
            si32(_loc13_,_dss_chunks_ad + 12);
            si32(_loc13_ &= -2,_dss_chunks_ad + 16);
            if((_loc13_ = li8(_opt_dss_2E_b)) == 0)
            {
               _loc2_ -= 16;
               si32(0,_loc2_);
               ESP = _loc2_;
               F_base_pages_alloc();
               _loc2_ += 16;
            }
            _loc1_ = 0;
            si32(_loc1_,_base_nodes);
            si32(_loc1_,_base_mtx);
            si32(_loc1_,_base_mtx + 4);
            si32(_loc1_,_base_mtx + 8);
            si32(_loc1_,_base_mtx + 12);
            _loc11_ = li32(_opt_narenas_lshift);
            if((uint(_loc12_ = li32(_ncpus))) >= 2)
            {
               si32(_loc11_ += 1,_opt_narenas_lshift);
            }
            si32(_loc12_,_narenas);
            if(_loc11_ >= 1)
            {
               if((uint(_loc11_ = _loc12_ << _loc11_)) > uint(_loc12_))
               {
                  si32(_loc11_,_narenas);
                  _loc12_ = _loc11_;
               }
               _loc13_ = _loc12_ << 2;
               _loc11_ = li32(_chunksize);
               if(uint(_loc13_) > uint(_loc11_))
               {
                  si32(_loc12_ = _loc11_ >>> 2,_narenas);
               }
            }
            else if(_loc11_ <= -1)
            {
               if((uint(_loc11_ = _loc12_ >>> 0 - _loc11_)) < uint(_loc12_))
               {
                  si32(_loc11_,_narenas);
                  _loc12_ = _loc11_;
               }
               if(_loc12_ == 0)
               {
                  si32(_loc12_ = 1,_narenas);
               }
               else
               {
                  addr2153:
                  _loc10_ = 1;
                  if(uint(_loc12_) > 1)
                  {
                     while(true)
                     {
                        _loc11_ = 263;
                        if(uint(_loc10_) >= 56)
                        {
                           break;
                        }
                        if((uint(_loc11_ = li32(_loc13_ = _primes_2E_11878 + (_loc10_ << 2)))) > uint(_loc12_))
                        {
                           break;
                        }
                        _loc10_ += 1;
                     }
                     si32(_loc11_,_narenas);
                     _loc12_ = _loc11_;
                  }
               }
               if((_loc13_ = li32(___isthreaded)) != 0)
               {
                  _loc2_ -= 16;
                  si32(_base_mtx,_loc2_);
                  ESP = _loc2_;
                  F__spinlock();
                  _loc2_ += 16;
               }
               _loc11_ = (_loc13_ = (_loc13_ = _loc12_ << 2) + 63) & -64;
               _loc13_ = (_loc12_ = li32(_base_next_addr)) + _loc11_;
               _loc5_ = li32(_base_past_addr);
               if(uint(_loc13_) > uint(_loc5_))
               {
                  _loc2_ -= 16;
                  si32(_loc11_,_loc2_);
                  ESP = _loc2_;
                  F_base_pages_alloc();
                  _loc2_ += 16;
                  if((_loc13_ = eax) == 0)
                  {
                     _loc12_ = li32(_base_next_addr);
                     addr2317:
                     si32(_loc13_ = _loc12_ + _loc11_,_base_next_addr);
                     if((_loc13_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_base_mtx,_loc2_);
                        ESP = _loc2_;
                        F__spinunlock();
                        _loc2_ += 16;
                     }
                     si32(_loc12_,_arenas);
                     if(_loc12_ != 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc13_ = li32(_narenas) << 2,_loc2_ + 8);
                        si32(_loc1_,_loc2_ + 4);
                        si32(_loc12_,_loc2_);
                        ESP = _loc2_;
                        Fmemset();
                        _loc2_ += 16;
                        _loc2_ -= 16;
                        si32(_loc1_,_loc2_);
                        ESP = _loc2_;
                        F_arenas_extend();
                        _loc2_ += 16;
                        if((_loc13_ = li32(_loc13_ = li32(_arenas))) == 0)
                        {
                           _loc1_ = 1;
                           if((_loc13_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_init_lock,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                              _loc1_ = 1;
                           }
                        }
                        else
                        {
                           _loc2_ -= 16;
                           si32(_base_calloc,_loc2_ + 4);
                           si32(_arenas_lock,_loc2_);
                           ESP = _loc2_;
                           F__pthread_mutex_init_calloc_cb();
                           _loc2_ += 16;
                           si8(1,_malloc_initialized_2E_b);
                           if((_loc13_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_init_lock,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                              _loc1_ = 0;
                           }
                        }
                     }
                     §§goto(addr2558);
                  }
                  else
                  {
                     if((_loc13_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_base_mtx,_loc2_);
                        ESP = _loc2_;
                        F__spinunlock();
                        _loc2_ += 16;
                     }
                     si32(0,_arenas);
                  }
                  _loc1_ = 1;
                  if((_loc13_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_init_lock,_loc2_);
                     ESP = _loc2_;
                     F__spinunlock();
                     _loc2_ += 16;
                     _loc1_ = 1;
                  }
                  §§goto(addr2558);
               }
               §§goto(addr2317);
            }
            §§goto(addr2153);
         }
         §§goto(addr1235);
      }
      addr2558:
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
