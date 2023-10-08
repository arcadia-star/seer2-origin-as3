package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F__pthread_mutex_lock;
   import MEncrypt.F__pthread_mutex_trylock;
   import MEncrypt.F__pthread_mutex_unlock;
   import MEncrypt.F__spinlock;
   import MEncrypt.F__spinunlock;
   import MEncrypt.Fmemset;
   import MEncrypt.___isthreaded;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_idalloc() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc8_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_chunksize_mask);
      _loc1_ ^= -1;
      if((_loc11_ = (_loc12_ = li32(_loc3_)) & _loc1_) != _loc12_)
      {
         _loc9_ = li32(_loc11_);
         _loc8_ = li32(___isthreaded);
         if((li8((_loc10_ = _loc11_ + (_loc12_ - _loc11_ >>> 12) * 12) + 24) & 2) == 0)
         {
            if(_loc8_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_trylock();
               _loc2_ += 16;
               if(eax != 0)
               {
                  _loc8_ = 1;
                  if(uint(li32(_ncpus)) > 1)
                  {
                     while(true)
                     {
                        if(uint(_loc8_) < 12)
                        {
                           continue;
                        }
                     }
                     §§goto(addr224);
                  }
                  _loc2_ -= 16;
                  si32(_loc9_,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_lock();
                  _loc2_ += 16;
               }
            }
            addr224:
            _loc1_ = li32(_loc10_ + 24);
            _loc7_ = li32((_loc10_ = li32(_loc8_ = _loc1_ & -4096)) + 20);
            _loc1_ = li8(_opt_junk_2E_b);
            if(_loc1_ == 1)
            {
               _loc2_ -= 16;
               si32(_loc7_,_loc2_ + 8);
               si32(90,_loc2_ + 4);
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               Fmemset();
               _loc2_ += 16;
            }
            _loc1_ = _loc12_ - _loc8_;
            var _loc6_:* = li32(_loc10_ + 36);
            _loc5_ = _loc1_ - _loc6_;
            _loc1_ = (_loc12_ = _loc7_ + -1) & _loc7_;
            if(_loc1_ == 0)
            {
               if(uint(_loc7_) <= 128)
               {
                  _loc12_ = _loc5_ >>> li8(_log2_table_2E_10546 + _loc12_);
               }
               else if(uint(_loc7_) <= 32768)
               {
                  _loc12_ = _loc5_ >>> li8((_loc7_ >>> 8) + _log2_table_2E_10546 - 1) + 8;
               }
               else
               {
                  _loc12_ = uint(_loc5_) / uint(_loc7_);
               }
            }
            else if(uint(li32(_qspace_max)) > uint(_loc7_))
            {
               if(uint(_loc7_) <= 112)
               {
                  _loc12_ = li32(((_loc7_ & -16) >>> 2) + _qsize_invs_2E_10547 - 12) * _loc5_ >>> 21;
               }
               else
               {
                  _loc12_ = uint(_loc5_) / uint(_loc7_);
               }
            }
            else if(uint(li32(_cspace_max)) > uint(_loc7_))
            {
               if(uint(_loc7_) <= 448)
               {
                  _loc12_ = li32(((_loc7_ & -64) >>> 4) + _csize_invs_2E_10548 - 12) * _loc5_ >>> 21;
               }
               else
               {
                  _loc12_ = uint(_loc5_) / uint(_loc7_);
               }
            }
            else if(uint(_loc7_) <= 3839)
            {
               _loc12_ = li32(((_loc7_ & -256) >>> 6) + _ssize_invs_2E_10549 - 12) * _loc5_ >>> 21;
            }
            else
            {
               _loc12_ = uint(_loc5_) / uint(_loc7_);
            }
            _loc7_ = _loc12_ >>> 5;
            _loc1_ = li32(_loc8_ + 4);
            if(uint(_loc1_) > uint(_loc7_))
            {
               si32(_loc7_,_loc8_ + 4);
            }
            _loc1_ = _loc12_ & 31;
            _loc6_ = 1 << _loc1_;
            _loc1_ = _loc7_ << 2;
            _loc1_ = _loc8_ + _loc1_;
            var _loc4_:*;
            si32(_loc6_ = (_loc4_ = li32(_loc1_ + 12)) | _loc6_,_loc1_ + 12);
            _loc1_ = (_loc12_ = li32(_loc8_ + 8)) + 1;
            si32(_loc1_,_loc8_ + 8);
            _loc7_ = li32(_loc10_ + 28);
            if(_loc1_ == _loc7_)
            {
               if(li32(_loc10_) == _loc8_)
               {
                  si32(0,_loc10_);
               }
               else if(_loc7_ != 1)
               {
                  _loc2_ -= 16;
                  si32(_loc10_ + 4,_loc2_);
                  si32(_loc11_ + (_loc8_ - _loc11_ >>> 12) * 12 + 16,_loc2_ + 4);
                  ESP = _loc2_;
                  F_arena_run_tree_remove();
                  _loc2_ += 16;
               }
               _loc2_ -= 16;
               si32(1,_loc2_ + 8);
               si32(_loc8_,_loc2_ + 4);
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F_arena_run_dalloc();
               _loc2_ += 16;
            }
            else if(_loc12_ == 0)
            {
               if((_loc12_ = li32(_loc10_)) != _loc8_)
               {
                  if(_loc12_ == 0)
                  {
                     si32(_loc8_,_loc10_);
                  }
                  else if(uint(_loc8_) < uint(_loc12_))
                  {
                     if(li32(_loc12_ + 8) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc6_ = _loc10_ + 4,_loc2_);
                        _loc1_ = _loc12_ & (li32(_chunksize_mask) ^ -1);
                        si32(_loc1_ + (_loc6_ = (_loc6_ = _loc12_ - _loc1_) >>> 12) * 12 + 16,_loc2_ + 4);
                        ESP = _loc2_;
                        F_arena_run_tree_insert();
                        _loc2_ += 16;
                     }
                     si32(_loc8_,_loc10_);
                  }
                  else
                  {
                     _loc2_ -= 16;
                     si32(_loc10_ + 4,_loc2_);
                     si32(_loc11_ + (_loc8_ - _loc11_ >>> 12) * 12 + 16,_loc2_ + 4);
                     ESP = _loc2_;
                     F_arena_run_tree_insert();
                     _loc2_ += 16;
                  }
               }
            }
            _loc1_ = li32(___isthreaded);
            if(_loc1_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
         else
         {
            if(_loc8_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_trylock();
               _loc2_ += 16;
               if(eax != 0)
               {
                  _loc11_ = 1;
                  if(uint(li32(_ncpus)) > 1)
                  {
                     while(true)
                     {
                        if(uint(_loc11_) < 12)
                        {
                           continue;
                        }
                     }
                     §§goto(addr955);
                  }
                  _loc2_ -= 16;
                  si32(_loc9_,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_lock();
                  _loc2_ += 16;
               }
            }
            addr955:
            _loc1_ = li8(_opt_junk_2E_b);
            if(_loc1_ == 1)
            {
               _loc2_ -= 16;
               si32(li32(_loc10_ + 24) & -4096,_loc2_ + 8);
               si32(90,_loc2_ + 4);
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               Fmemset();
               _loc2_ += 16;
            }
            _loc2_ -= 16;
            si32(1,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_arena_run_dalloc();
            _loc2_ += 16;
            _loc1_ = li32(___isthreaded);
            if(_loc1_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
         §§goto(addr1372);
      }
      else
      {
         if(li32(___isthreaded) != 0)
         {
            _loc2_ -= 16;
            si32(_huge_mtx,_loc2_);
            ESP = _loc2_;
            F__spinlock();
            _loc2_ += 16;
         }
         _loc11_ = li32(_huge);
         _loc9_ = _huge + 4;
         while(_loc11_ != _loc9_)
         {
            if((_loc7_ = li32(_loc11_ + 16)) == _loc12_)
            {
               break;
            }
            _loc10_ = _loc8_ = 1;
            if(uint(_loc7_) <= uint(_loc12_))
            {
               _loc10_ = 0;
            }
            if(uint(_loc7_) >= uint(_loc12_))
            {
               _loc8_ = 0;
            }
            _loc6_ = _loc10_ & 1;
            _loc1_ = _loc8_ & 1;
            _loc1_ -= _loc6_;
            if(_loc1_ <= -1)
            {
               _loc11_ = li32(_loc11_ + 8);
            }
            else
            {
               _loc11_ = li32(_loc11_ + 12) & -2;
            }
         }
         _loc2_ -= 16;
         si32(_huge,_loc2_);
         _loc12_ = 0;
         if(_loc11_ != _loc9_)
         {
            _loc12_ = _loc11_;
         }
         si32(_loc12_,_loc2_ + 4);
         ESP = _loc2_;
         F_extent_tree_ad_remove();
         _loc2_ += 16;
         _loc1_ = li32(___isthreaded);
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(_huge_mtx,_loc2_);
            ESP = _loc2_;
            F__spinunlock();
            _loc2_ += 16;
         }
         _loc1_ = li8(_opt_junk_2E_b);
         if(_loc1_ == 1)
         {
            if((li8(_opt_dss_2E_b) ^ 1) != 0)
            {
               _loc2_ -= 16;
               si32(li32(_loc12_ + 20),_loc2_ + 8);
               si32(90,_loc2_ + 4);
               si32(li32(_loc12_ + 16),_loc2_);
               ESP = _loc2_;
               Fmemset();
               _loc2_ += 16;
            }
            else
            {
               addr1233:
            }
            _loc6_ = li32(_loc12_ + 16);
            _loc1_ = li32(_loc12_ + 20);
            _loc2_ -= 16;
            si32(_loc1_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_chunk_dealloc();
            _loc2_ += 16;
            _loc1_ = li32(___isthreaded);
            if(_loc1_ != 0)
            {
               _loc2_ -= 16;
               si32(_base_mtx,_loc2_);
               ESP = _loc2_;
               F__spinlock();
               _loc2_ += 16;
            }
            _loc1_ = li32(_base_nodes);
            si32(_loc1_,_loc12_);
            si32(_loc12_,_base_nodes);
            _loc1_ = li32(___isthreaded);
            if(_loc1_ != 0)
            {
               _loc2_ -= 16;
               si32(_base_mtx,_loc2_);
               ESP = _loc2_;
               F__spinunlock();
               _loc2_ += 16;
            }
            §§goto(addr1372);
         }
         §§goto(addr1233);
      }
   }
}
