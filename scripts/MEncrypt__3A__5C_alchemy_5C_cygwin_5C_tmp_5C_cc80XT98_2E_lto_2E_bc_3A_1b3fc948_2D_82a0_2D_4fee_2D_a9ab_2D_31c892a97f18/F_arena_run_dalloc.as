package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_arena_run_dalloc() : void
   {
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc13_:* = 0;
      var _loc19_:* = 0;
      var _loc18_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc12_:* = 0;
      var _loc4_:* = 0;
      var _loc16_:* = 0;
      var _loc17_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc14_:* = 0;
      var _loc20_:* = 0;
      var _loc3_:* = ESP;
      _loc8_ = _loc3_;
      _loc3_ -= 32;
      _loc4_ = (_loc4_ = li32(_chunksize_mask)) ^ -1;
      _loc19_ = (_loc20_ = li32(_loc8_ + 4)) & _loc4_;
      _loc16_ = (_loc17_ = (_loc18_ = _loc20_ - _loc19_) >>> 12) * 12;
      _loc4_ = (_loc14_ = li32((_loc15_ = _loc19_ + _loc16_) + 24)) & 2;
      _loc13_ = li32(_loc8_ + 8);
      _loc1_ = li32(_loc8_);
      if(_loc4_ != 0)
      {
         _loc14_ &= -4096;
      }
      else
      {
         _loc14_ = li32((_loc4_ = li32(_loc20_)) + 24);
      }
      _loc20_ = _loc14_ >>> 12;
      if(_loc13_ == 0)
      {
         if(_loc20_ != 0)
         {
            _loc18_ = (_loc4_ = (_loc4_ = (_loc4_ = _loc18_ >>> 12) * 12) + _loc19_) + 24;
            _loc13_ = _loc14_ >>> 12;
            do
            {
               si32(_loc4_ = (_loc4_ = li32(_loc18_)) & -4,_loc18_);
               _loc18_ += 12;
            }
            while((_loc13_ += -1) != 0);
            
         }
      }
      else
      {
         if(_loc20_ != 0)
         {
            _loc13_ = (_loc4_ = (_loc4_ = (_loc4_ = _loc18_ >>> 12) * 12) + _loc19_) + 24;
            _loc18_ = _loc20_;
            do
            {
               si32(8,_loc13_);
               _loc13_ += 12;
            }
            while((_loc18_ += -1) != 0);
            
         }
         if((_loc18_ = li32(_loc19_ + 12)) == 0)
         {
            _loc9_ = li32(_loc1_ + 4);
            si32(_loc9_,(_loc10_ = _loc8_ - 32) | 4);
            si32(_loc4_ = (_loc18_ = _loc1_ + 8) & -2,_loc8_ - 24);
            _loc11_ = 0;
            _loc13_ = _loc18_;
            while(true)
            {
               _loc12_ = _loc9_;
               _loc5_ = _loc10_;
               while(true)
               {
                  if(_loc18_ != _loc12_)
                  {
                     if((_loc4_ = (_loc10_ = li32((_loc11_ = li32(_loc12_ + 4)) + 8)) & 1) == 0)
                     {
                        break;
                     }
                     if((_loc4_ = (_loc4_ = li8((_loc4_ = li32(_loc11_ + 4)) + 8)) & 1) == 0)
                     {
                        break;
                     }
                     si32(_loc4_ = _loc10_ & -2,_loc12_ + 4);
                     si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc11_ + 8)) & 1) | _loc12_,_loc11_ + 8);
                     _loc4_ = li32(_loc11_ + 4);
                     si32(li32(_loc4_ + 8) & -2,_loc4_ + 8);
                     if((_loc4_ = li32(_loc5_ + 4)) == _loc12_)
                     {
                        si32(_loc11_,_loc5_ + 4);
                        _loc12_ = _loc11_;
                        break;
                     }
                     si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc5_ + 8)) & 1) | _loc11_,_loc5_ + 8);
                     si32(_loc4_ = _loc4_ & 1 | li32((_loc10_ = _loc11_ & -2) + 4),_loc5_ + 8);
                     si32(_loc5_,_loc10_ + 4);
                     si32(_loc4_ = li32(_loc10_ + 8) & -2 | (_loc4_ = li32(_loc5_ + 8)) & 1,_loc10_ + 8);
                     si32(_loc4_ = (_loc4_ = li32(_loc5_ + 8)) | 1,_loc5_ + 8);
                     if((_loc4_ = li32(_loc13_ + 4)) == _loc5_)
                     {
                        si32(_loc10_,_loc13_ + 4);
                     }
                     else
                     {
                        si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc13_ + 8)) & 1) | _loc10_,_loc13_ + 8);
                     }
                     _loc5_ = _loc12_ = 1;
                     if(uint(_loc10_) <= uint(_loc19_))
                     {
                        _loc5_ = 0;
                     }
                     if(uint(_loc10_) >= uint(_loc19_))
                     {
                        _loc12_ = 0;
                     }
                     var _loc2_:* = _loc5_ & 1;
                     if((_loc11_ = (_loc4_ = _loc12_ & 1) - _loc2_) <= -1)
                     {
                        _loc12_ = li32(_loc10_ + 4);
                        _loc5_ = _loc10_;
                     }
                     else
                     {
                        _loc12_ = (_loc4_ = li32(_loc10_ + 8)) & -2;
                        _loc5_ = _loc10_;
                     }
                     continue;
                  }
                  si32(_loc18_,_loc19_ + 4);
                  si32(_loc4_ = _loc18_ | 1,_loc19_ + 8);
                  if(_loc11_ >= 1)
                  {
                     si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc5_ + 8)) & 1) | _loc19_,_loc5_ + 8);
                     si32(_loc4_ = _loc4_ & 1 | li32((_loc12_ = _loc19_ & -2) + 4),_loc5_ + 8);
                     si32(_loc5_,_loc12_ + 4);
                     si32(_loc4_ = li32(_loc12_ + 8) & -2 | (_loc4_ = li32(_loc5_ + 8)) & 1,_loc12_ + 8);
                     si32(_loc4_ = (_loc4_ = li32(_loc5_ + 8)) | 1,_loc5_ + 8);
                     if((_loc4_ = li32(_loc13_ + 4)) == _loc5_)
                     {
                        si32(_loc12_,_loc13_ + 4);
                     }
                     else if((_loc4_ = (_loc18_ = li32(_loc13_ + 8)) & -2) == _loc5_)
                     {
                        si32(_loc4_ = (_loc4_ = _loc18_ & 1) | _loc12_,_loc13_ + 8);
                     }
                  }
                  else
                  {
                     si32(_loc19_,_loc5_ + 4);
                  }
                  si32(_loc4_ = li32(_loc4_ = (_loc4_ = _loc8_ - 32) | 4),_loc1_ + 4);
                  _loc2_ = li32(_loc4_ + 8);
                  _loc2_ &= -2;
                  si32(_loc2_,_loc4_ + 8);
                  _loc18_ = li32(_loc19_ + 12);
               }
               _loc13_ = _loc10_ = 1;
               if(uint(_loc12_) <= uint(_loc19_))
               {
                  _loc13_ = 0;
               }
               if(uint(_loc12_) >= uint(_loc19_))
               {
                  _loc10_ = 0;
               }
               _loc4_ = _loc13_ & 1;
               _loc2_ = _loc10_ & 1;
               if((_loc11_ = _loc2_ - _loc4_) <= -1)
               {
                  _loc9_ = li32(_loc12_ + 4);
                  _loc10_ = _loc12_;
                  _loc13_ = _loc5_;
               }
               else
               {
                  _loc9_ = (_loc4_ = li32(_loc12_ + 8)) & -2;
                  _loc10_ = _loc12_;
                  _loc13_ = _loc5_;
               }
            }
         }
         si32(_loc4_ = _loc18_ + _loc20_,_loc19_ + 12);
         si32(_loc4_ = (_loc4_ = li32(_loc1_ + 40)) + _loc20_,_loc1_ + 40);
      }
      si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc15_ + 24)) & 4095) | _loc14_,_loc15_ + 24);
      _loc2_ = (_loc20_ = (_loc4_ = _loc20_ + _loc17_) * 12) + _loc19_;
      var _loc6_:*;
      si32(_loc6_ = (_loc6_ = (_loc6_ = li32(_loc2_ + 12)) & 4095) | _loc14_,_loc2_ + 12);
      _loc2_ = li32(_chunk_npages);
      if(uint(_loc4_) < uint(_loc2_))
      {
         if((_loc4_ = (_loc18_ = li32((_loc4_ = _loc19_ + _loc20_) + 24)) & 1) == 0)
         {
            _loc3_ -= 16;
            si32(_loc4_ = _loc1_ + 44,_loc3_);
            si32((_loc4_ = _loc19_ + 16) + _loc20_,_loc3_ + 4);
            _loc14_ = (_loc18_ & -4096) + _loc14_;
            ESP = _loc3_;
            F_arena_avail_tree_remove();
            _loc3_ += 16;
            si32(li32(_loc15_ + 24) & 4095 | _loc14_,_loc15_ + 24);
            _loc4_ = (_loc17_ + (_loc14_ >>> 12)) * 12 + _loc4_;
            si32(li32(_loc4_ - 4) & 4095 | _loc14_,_loc4_ - 4);
         }
      }
      _loc4_ = li32(_arena_chunk_header_npages);
      if(uint(_loc17_) > uint(_loc4_))
      {
         if((_loc4_ = (_loc16_ = li32((_loc4_ = _loc16_ + _loc19_) + 12)) & 1) == 0)
         {
            _loc3_ -= 16;
            si32(_loc4_ = _loc1_ + 44,_loc3_);
            _loc2_ = _loc19_ + 16;
            si32(_loc6_ = _loc2_ + (_loc17_ -= _loc16_ >>> 12) * 12,_loc3_ + 4);
            _loc4_ = (_loc4_ = _loc16_ & -4096) + _loc14_;
            ESP = _loc3_;
            F_arena_avail_tree_remove();
            _loc3_ += 16;
            var _loc7_:*;
            si32(_loc7_ = (_loc7_ = (_loc7_ = li32(_loc6_ + 8)) & 4095) | _loc4_,_loc6_ + 8);
            _loc2_ = (_loc6_ = (_loc6_ = _loc17_ + (_loc4_ >>> 12)) * 12) + _loc2_;
            si32(_loc4_ = (_loc6_ = (_loc6_ = li32(_loc2_ - 4)) & 4095) | _loc4_,_loc2_ - 4);
         }
      }
      _loc3_ -= 16;
      si32(_loc16_ = _loc1_ + 44,_loc3_);
      _loc2_ = _loc17_ * 12;
      _loc2_ = (_loc4_ = _loc19_ + 16) + _loc2_;
      si32(_loc2_,_loc3_ + 4);
      ESP = _loc3_;
      F_arena_avail_tree_insert();
      _loc3_ += 16;
      _loc2_ = (_loc17_ = li32(_arena_chunk_header_npages)) * 12;
      _loc4_ = (_loc4_ = li32((_loc4_ += _loc2_) + 8)) & -4095;
      _loc2_ = li32(_arena_maxclass);
      if(_loc4_ == _loc2_)
      {
         if((_loc15_ = li32(_loc1_ + 36)) != 0)
         {
            if((_loc4_ = li32(_loc15_ + 12)) != 0)
            {
               _loc3_ -= 16;
               si32(_loc15_,_loc3_ + 4);
               si32(_loc4_ = li32(_loc19_) + 4,_loc3_);
               ESP = _loc3_;
               F_arena_chunk_tree_dirty_remove();
               _loc3_ += 16;
               si32(_loc4_ = li32(_loc1_ + 40) - li32((_loc15_ = li32(_loc1_ + 36)) + 12),_loc1_ + 40);
            }
            _loc4_ = li32(_chunksize);
            _loc3_ -= 16;
            si32(_loc4_,_loc3_ + 4);
            si32(_loc15_,_loc3_);
            ESP = _loc3_;
            F_chunk_dealloc();
            _loc3_ += 16;
            _loc17_ = li32(_arena_chunk_header_npages);
         }
         _loc3_ -= 16;
         si32(_loc16_,_loc3_);
         _loc4_ = _loc17_ * 12;
         si32(_loc4_ = (_loc4_ = _loc19_ + _loc4_) + 16,_loc3_ + 4);
         ESP = _loc3_;
         F_arena_avail_tree_remove();
         _loc3_ += 16;
         si32(_loc19_,_loc1_ + 36);
      }
      _loc19_ = li32(_opt_dirty_max);
      if((uint(_loc17_ = li32(_loc1_ + 40))) > uint(_loc19_))
      {
         if(uint(_loc17_) > uint(_loc19_ >>> 1))
         {
            _loc19_ = _loc1_ + 8;
            _loc17_ = _loc1_ + 4;
            loop4:
            do
            {
               _loc16_ = li32(_loc1_ + 4);
               while((_loc16_ = (_loc4_ = li32((_loc15_ = _loc16_) + 8)) & -2) != _loc19_)
               {
               }
               _loc16_ = 0;
               if(_loc19_ != _loc15_)
               {
                  _loc16_ = _loc15_;
               }
               _loc15_ = li32(_chunk_npages);
               while(true)
               {
                  _loc20_ = _loc15_;
                  if((_loc4_ = li32(_loc16_ + 12)) == 0)
                  {
                     break;
                  }
                  _loc15_ = _loc20_ + -1;
                  if((_loc4_ = (_loc18_ = li32((_loc14_ = _loc16_ + _loc20_ * 12) + 12)) & 8) != 0)
                  {
                     si32(_loc4_ = _loc18_ ^ 8,_loc14_ + 12);
                     _loc15_ = _loc20_ + -1;
                     _loc18_ = -1;
                     while(true)
                     {
                        _loc4_ = li32(_arena_chunk_header_npages);
                        if(uint(_loc15_) <= uint(_loc4_))
                        {
                           break;
                        }
                        if((_loc4_ = (_loc20_ = li32((_loc14_ = _loc16_ + ((_loc4_ = _loc15_ * 3) << 2)) + 12)) & 8) == 0)
                        {
                           break;
                        }
                        si32(_loc4_ = _loc20_ ^ 8,_loc14_ + 12);
                        _loc18_ += -1;
                        _loc15_ += -1;
                     }
                     si32(_loc4_ = (_loc4_ = li32(_loc16_ + 12)) + _loc18_,_loc16_ + 12);
                     si32(_loc20_ = (_loc4_ = li32(_loc1_ + 40)) + _loc18_,_loc1_ + 40);
                     _loc4_ = (_loc14_ = li32(_opt_dirty_max)) >>> 1;
                     if(uint(_loc20_) > uint(_loc4_))
                     {
                        continue;
                     }
                     if((_loc4_ = li32(_loc16_ + 12)) == 0)
                     {
                        break;
                     }
                     continue loop4;
                  }
               }
               _loc3_ -= 16;
               si32(_loc16_,_loc3_ + 4);
               si32(_loc17_,_loc3_);
               ESP = _loc3_;
               F_arena_chunk_tree_dirty_remove();
               _loc3_ += 16;
               _loc20_ = li32(_loc1_ + 40);
               _loc14_ = li32(_opt_dirty_max);
            }
            while(_loc4_ = _loc14_ >>> 1, uint(_loc20_) > uint(_loc4_));
            
         }
      }
      _loc3_ = _loc8_;
      ESP = _loc3_;
   }
}
