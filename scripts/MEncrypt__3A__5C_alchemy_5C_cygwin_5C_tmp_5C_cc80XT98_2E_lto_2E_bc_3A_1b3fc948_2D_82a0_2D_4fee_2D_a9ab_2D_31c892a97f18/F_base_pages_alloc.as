package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_base_pages_alloc() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc8_:*;
      if((_loc8_ = li8(_opt_mmap_2E_b)) == 0)
      {
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(_loc7_ = 0,_loc2_);
            si32(_loc6_ = (_loc8_ = _loc1_ + 4095) & -4096,_loc2_ + 4);
            ESP = _loc2_;
            F_pages_map();
            _loc2_ += 16;
            if((_loc5_ = eax) != 0)
            {
               si32(_loc5_,_base_next_addr);
               si32(_loc8_ = _loc5_ + _loc6_,_base_past_addr);
            }
            else
            {
               addr87:
               _loc7_ = 1;
               if((_loc8_ = li8(_opt_dss_2E_b)) == 0)
               {
                  if((_loc8_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_dss_mtx,_loc2_);
                     ESP = _loc2_;
                     F__spinlock();
                     _loc2_ += 16;
                  }
                  if((_loc8_ = li32(_dss_prev)) != -1)
                  {
                     var _loc4_:*;
                     _loc7_ = (_loc4_ = li32(_chunksize_mask)) + _loc1_ & (_loc4_ ^ -1);
                     while(true)
                     {
                        if((_loc5_ = ram.length) == -1)
                        {
                           ESP = _loc2_;
                           F___error();
                           si32(12,eax);
                        }
                        si32(_loc5_,_dss_max);
                        _loc8_ = (_loc8_ = li32(_chunksize_mask)) & _loc5_;
                        _loc5_ = (_loc4_ = li32(_chunksize)) - _loc8_;
                        _loc6_ = _loc7_;
                        if(uint(_loc5_) >= uint(_loc1_))
                        {
                           _loc6_ = 0;
                        }
                        if((_loc5_ = _loc6_ + _loc5_) == 0)
                        {
                           _loc6_ = ram.length;
                        }
                        else
                        {
                           _loc6_ = int(sbrk((_loc8_ = _loc5_ + 4095) & -4096,4096));
                        }
                        if(_loc6_ == -1)
                        {
                           ESP = _loc2_;
                           F___error();
                           si32(12,eax);
                        }
                        si32(_loc6_,_dss_prev);
                        _loc8_ = li32(_dss_max);
                        if(_loc6_ == _loc8_)
                        {
                           si32(_loc8_ = _loc6_ + _loc5_,_dss_max);
                           si32(_loc6_,_base_next_addr);
                           si32(_loc8_,_base_past_addr);
                           _loc7_ = 0;
                           if((_loc8_ = li32(___isthreaded)) != 0)
                           {
                              _loc2_ -= 16;
                              si32(_dss_mtx,_loc2_);
                              ESP = _loc2_;
                              F__spinunlock();
                              _loc2_ += 16;
                              _loc7_ = 0;
                              break;
                           }
                           break;
                        }
                        if(_loc6_ != -1)
                        {
                           continue;
                        }
                     }
                     §§goto(addr338);
                  }
                  _loc7_ = 1;
                  if((_loc8_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_dss_mtx,_loc2_);
                     ESP = _loc2_;
                     F__spinunlock();
                     _loc2_ += 16;
                     _loc7_ = 1;
                  }
               }
            }
            addr338:
            eax = _loc7_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr87);
   }
}
