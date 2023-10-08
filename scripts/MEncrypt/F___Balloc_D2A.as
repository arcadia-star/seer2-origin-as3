package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___Balloc_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc7_:int = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(___gdtoa_locks,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_lock();
         _loc2_ += 16;
      }
      if((_loc9_ = li32(_loc3_)) >= 10)
      {
         _loc7_ = ((_loc8_ = 1 << _loc9_) << 2) + 27;
      }
      else
      {
         if((_loc6_ = li32(_loc7_ = _freelist + (_loc9_ << 2))) != 0)
         {
            si32(li32(_loc6_),_loc7_);
         }
         else
         {
            var _loc5_:*;
            if(uint(((_loc6_ = li32(_pmem_next)) - _private_mem >> 3) + (_loc4_ = (_loc7_ = (_loc5_ = (_loc8_ = 1 << _loc9_) << 2) + 27) >>> 3)) <= 288)
            {
               si32(_loc6_ + (_loc4_ << 3),_pmem_next);
            }
            else
            {
               addr137:
               _loc2_ -= 16;
               _loc1_ = _loc7_ & -8;
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               F_malloc();
               _loc2_ += 16;
               _loc6_ = eax;
            }
            si32(_loc9_,_loc6_ + 4);
            si32(_loc8_,_loc6_ + 8);
         }
         _loc1_ = li32(___isthreaded);
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(___gdtoa_locks,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_unlock();
            _loc2_ += 16;
         }
         si32(0,_loc6_ + 16);
         si32(0,_loc6_ + 12);
         eax = _loc6_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr137);
   }
}
