package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_chunk_dealloc() : void
   {
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc3_:* = 0;
      var _loc15_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 64;
      _loc3_ = li32(_loc4_ + 4);
      _loc15_ = li32(_loc4_);
      var _loc14_:*;
      if((_loc14_ = li8(_opt_dss_2E_b)) == 0)
      {
         if((_loc14_ = li32(___isthreaded)) != 0)
         {
            _loc2_ -= 16;
            si32(_dss_mtx,_loc2_);
            ESP = _loc2_;
            F__spinlock();
            _loc2_ += 16;
         }
         if((uint(_loc14_ = li32(_dss_base))) <= uint(_loc15_))
         {
            if((uint(_loc14_ = li32(_dss_max))) > uint(_loc15_))
            {
               _loc13_ = _loc15_ + _loc3_;
               _loc12_ = 0;
               _loc11_ = _dss_chunks_ad;
               loop0:
               while(true)
               {
                  _loc10_ = li32(_loc11_);
                  while(true)
                  {
                     _loc14_ = _dss_chunks_ad + 4;
                     _loc11_ = _loc12_;
                     if(_loc10_ == _loc14_)
                     {
                        break;
                     }
                     _loc11_ = li32(_loc10_ + 16);
                     _loc8_ = _loc9_ = 1;
                     if(uint(_loc13_) >= uint(_loc11_))
                     {
                        _loc8_ = 0;
                     }
                     if(uint(_loc13_) <= uint(_loc11_))
                     {
                        _loc9_ = 0;
                     }
                     _loc14_ = _loc8_ & 1;
                     var _loc1_:* = _loc9_ & 1;
                     if((_loc8_ = _loc1_ - _loc14_) <= -1)
                     {
                        continue loop0;
                     }
                     _loc11_ = _loc10_;
                     if(_loc8_ < 1)
                     {
                        break;
                     }
                     _loc10_ = (_loc14_ = li32(_loc10_ + 12)) & -2;
                  }
                  if(_loc11_ != 0)
                  {
                     if((_loc14_ = li32(_loc11_ + 16)) == _loc13_)
                     {
                        _loc2_ -= 16;
                        si32(_loc11_,_loc2_);
                        ESP = _loc2_;
                        F_extent_tree_szad_remove();
                        _loc2_ += 16;
                        si32(_loc15_,_loc11_ + 16);
                        si32(_loc14_ = (_loc14_ = li32(_loc11_ + 20)) + _loc3_,_loc11_ + 20);
                        _loc2_ -= 16;
                        si32(_loc11_,_loc2_);
                        ESP = _loc2_;
                        F_extent_tree_szad_insert();
                        _loc2_ += 16;
                        addr632:
                        _loc12_ = li32(_loc11_ + 8);
                        _loc13_ = _dss_chunks_ad + 4;
                        if(_loc12_ != _loc13_)
                        {
                           while(true)
                           {
                              if((_loc12_ = (_loc14_ = li32((_loc10_ = _loc12_) + 12)) & -2) != _loc13_)
                              {
                                 continue;
                              }
                           }
                        }
                        else
                        {
                           _loc12_ = li32(_loc11_ + 16);
                           _loc8_ = li32(_dss_chunks_ad);
                           _loc10_ = _loc13_;
                           while(true)
                           {
                              _loc9_ = li32(_loc8_ + 16);
                              _loc6_ = _loc5_ = 1;
                              if(uint(_loc12_) >= uint(_loc9_))
                              {
                                 _loc6_ = 0;
                              }
                              if(uint(_loc12_) <= uint(_loc9_))
                              {
                                 _loc5_ = 0;
                              }
                              _loc14_ = _loc6_ & 1;
                              _loc1_ = _loc5_ & 1;
                              if((_loc9_ = _loc1_ - _loc14_) <= -1)
                              {
                                 do
                                 {
                                    _loc9_ = li32((_loc8_ = li32(_loc8_ + 8)) + 16);
                                    _loc5_ = _loc6_ = 1;
                                    if(uint(_loc12_) >= uint(_loc9_))
                                    {
                                       _loc5_ = 0;
                                    }
                                    if(uint(_loc12_) <= uint(_loc9_))
                                    {
                                       _loc6_ = 0;
                                    }
                                    _loc14_ = _loc5_ & 1;
                                    _loc1_ = _loc6_ & 1;
                                 }
                                 while((_loc9_ = _loc1_ - _loc14_) < 0);
                                 
                              }
                              if(_loc9_ < 1)
                              {
                                 break;
                              }
                              _loc10_ = _loc8_;
                              _loc8_ = (_loc14_ = li32(_loc8_ + 12)) & -2;
                           }
                        }
                        _loc12_ = 0;
                        if(_loc10_ != _loc13_)
                        {
                           _loc12_ = _loc10_;
                        }
                        if(_loc12_ != 0)
                        {
                           if((_loc14_ = li32(_loc12_ + 16) + li32(_loc12_ + 20)) == _loc15_)
                           {
                              _loc2_ -= 16;
                              si32(_loc12_,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_szad_remove();
                              _loc2_ += 16;
                              _loc2_ -= 16;
                              si32(_loc12_,_loc2_ + 4);
                              si32(_dss_chunks_ad,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_ad_remove();
                              _loc2_ += 16;
                              _loc2_ -= 16;
                              si32(_loc11_,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_szad_remove();
                              _loc2_ += 16;
                              si32(_loc14_ = li32(_loc12_ + 16),_loc11_ + 16);
                              si32(_loc14_ = (_loc14_ = li32(_loc12_ + 20)) + li32(_loc11_ + 20),_loc11_ + 20);
                              _loc2_ -= 16;
                              si32(_loc11_,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_szad_insert();
                              _loc2_ += 16;
                              if((_loc14_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_base_mtx,_loc2_);
                                 ESP = _loc2_;
                                 F__spinlock();
                                 _loc2_ += 16;
                              }
                              si32(_loc14_ = li32(_base_nodes),_loc12_);
                              si32(_loc12_,_base_nodes);
                              if((_loc14_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_base_mtx,_loc2_);
                                 ESP = _loc2_;
                                 F__spinunlock();
                                 _loc2_ += 16;
                              }
                           }
                        }
                        _loc13_ = 0;
                        _loc10_ = 1;
                        if(_loc11_ != 0)
                        {
                           _loc3_ = li32(_loc11_ + 20);
                           _loc15_ = li32(_loc11_ + 16);
                           _loc10_ = 0;
                           _loc13_ = _loc11_;
                        }
                     }
                     else
                     {
                        addr264:
                        if((_loc14_ = li32(___isthreaded)) != 0)
                        {
                           _loc2_ -= 16;
                           si32(_dss_mtx,_loc2_);
                           ESP = _loc2_;
                           F__spinunlock();
                           _loc2_ += 16;
                           if((_loc14_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_base_mtx,_loc2_);
                              ESP = _loc2_;
                              F__spinlock();
                              _loc2_ += 16;
                           }
                        }
                        if((_loc11_ = li32(_base_nodes)) != 0)
                        {
                           si32(_loc14_ = li32(_loc11_),_base_nodes);
                           if((_loc14_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_base_mtx,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                              §§goto(addr541);
                           }
                           si32(_loc15_,_loc11_ + 16);
                           si32(_loc3_,_loc11_ + 20);
                           _loc2_ -= 16;
                           si32(_loc11_,_loc2_ + 4);
                           si32(_dss_chunks_ad,_loc2_);
                           ESP = _loc2_;
                           F_extent_tree_ad_insert();
                           _loc2_ += 16;
                           _loc2_ -= 16;
                           si32(_loc11_,_loc2_);
                           ESP = _loc2_;
                           F_extent_tree_szad_insert();
                           _loc2_ += 16;
                           §§goto(addr632);
                        }
                        else
                        {
                           if((_loc14_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_base_mtx,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                              if((_loc14_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_base_mtx,_loc2_);
                                 ESP = _loc2_;
                                 F__spinlock();
                                 _loc2_ += 16;
                              }
                           }
                           _loc14_ = (_loc11_ = li32(_base_next_addr)) + 64;
                           _loc1_ = li32(_base_past_addr);
                           if(uint(_loc14_) > uint(_loc1_))
                           {
                              _loc2_ -= 16;
                              si32(64,_loc2_);
                              ESP = _loc2_;
                              F_base_pages_alloc();
                              _loc2_ += 16;
                              if((_loc14_ = eax) == 0)
                              {
                                 _loc11_ = li32(_base_next_addr);
                                 addr503:
                                 si32(_loc14_ = _loc11_ + 64,_base_next_addr);
                                 if((_loc14_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc2_ -= 16;
                                    si32(_base_mtx,_loc2_);
                                    ESP = _loc2_;
                                    F__spinunlock();
                                    _loc2_ += 16;
                                 }
                              }
                              else
                              {
                                 _loc11_ = 0;
                                 if((_loc14_ = li32(___isthreaded)) != 0)
                                 {
                                    _loc2_ -= 16;
                                    si32(_base_mtx,_loc2_);
                                    ESP = _loc2_;
                                    F__spinunlock();
                                    _loc2_ += 16;
                                    _loc11_ = 0;
                                 }
                              }
                              §§goto(addr541);
                           }
                           §§goto(addr503);
                        }
                        _loc10_ = 1;
                        if(_loc11_ != 0)
                        {
                        }
                        §§goto(addr1007);
                     }
                     addr1007:
                     if((_loc11_ = ram.length) == -1)
                     {
                        ESP = _loc2_;
                        F___error();
                        si32(12,eax);
                     }
                     si32(_loc11_,_dss_max);
                     if((_loc14_ = _loc15_ + _loc3_) == _loc11_)
                     {
                        if(_loc3_ == 0)
                        {
                           _loc15_ = ram.length;
                        }
                        else
                        {
                           _loc15_ = int(sbrk((_loc14_ = 4095 - _loc3_) & -4096,4096));
                        }
                        if(_loc15_ == -1)
                        {
                           ESP = _loc2_;
                           F___error();
                           si32(12,eax);
                        }
                        si32(_loc15_,_dss_prev);
                        _loc14_ = li32(_dss_max);
                        if(_loc15_ == _loc14_)
                        {
                           si32(_loc14_ = _loc15_ - _loc3_,_dss_max);
                           if(_loc10_ == 0)
                           {
                              _loc2_ -= 16;
                              si32(_loc13_,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_szad_remove();
                              _loc2_ += 16;
                              _loc2_ -= 16;
                              si32(_loc13_,_loc2_ + 4);
                              si32(_dss_chunks_ad,_loc2_);
                              ESP = _loc2_;
                              F_extent_tree_ad_remove();
                              _loc2_ += 16;
                              if((_loc14_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_base_mtx,_loc2_);
                                 ESP = _loc2_;
                                 F__spinlock();
                                 _loc2_ += 16;
                              }
                              si32(_loc14_ = li32(_base_nodes),_loc13_);
                              si32(_loc13_,_base_nodes);
                              if((_loc14_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_base_mtx,_loc2_);
                                 ESP = _loc2_;
                                 F__spinunlock();
                                 _loc2_ += 16;
                              }
                              §§goto(addr1454);
                           }
                           if((_loc14_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_dss_mtx,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                           }
                        }
                        §§goto(addr1454);
                     }
                     if((_loc14_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_dss_mtx,_loc2_);
                        ESP = _loc2_;
                        F__spinunlock();
                        _loc2_ += 16;
                     }
                     §§goto(addr1454);
                  }
                  §§goto(addr264);
               }
            }
            §§goto(addr1454);
         }
         if((_loc14_ = li32(___isthreaded)) != 0)
         {
            _loc2_ -= 16;
            si32(_dss_mtx,_loc2_);
            ESP = _loc2_;
            F__spinunlock();
            _loc2_ += 16;
         }
         if((_loc14_ = li8(_opt_mmap_2E_b)) == 0)
         {
            addr1320:
            _loc2_ -= 16;
            si32(_loc3_,_loc2_ + 4);
            si32(_loc15_,_loc2_);
            ESP = _loc2_;
            F_munmap();
            _loc2_ += 16;
            if((_loc14_ = eax) == -1)
            {
               ESP = _loc2_;
               F___error();
               _loc2_ -= 16;
               si32(64,_loc2_ + 8);
               si32(_loc14_ = _loc4_ - 64,_loc2_ + 4);
               si32(li32(_loc14_ = eax),_loc2_);
               ESP = _loc2_;
               F_strerror_r();
               _loc2_ += 16;
               _loc1_ = li32(__malloc_message);
               _loc2_ -= 16;
               si32(L__2E_str545,_loc2_ + 12);
               si32(_loc14_,_loc2_ + 8);
               si32(L__2E_str39,_loc2_ + 4);
               si32(li32(___progname),_loc2_);
               ESP = _loc2_;
               ptr2fun[_loc1_]();
               _loc2_ += 16;
               if((_loc14_ = li8(_opt_abort_2E_b)) == 1)
               {
                  ESP = _loc2_;
                  F_abort();
               }
            }
         }
      }
      else if((_loc14_ = li8(_opt_mmap_2E_b)) == 0)
      {
         §§goto(addr1320);
      }
      addr1454:
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
