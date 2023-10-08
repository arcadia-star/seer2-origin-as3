package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___i2b_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
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
      _loc5_ = li32(_loc3_);
      if((_loc4_ = li32(_freelist + 4)) != 0)
      {
         si32(li32(_loc4_),_freelist + 4);
      }
      else
      {
         if(uint(((_loc4_ = li32(_pmem_next)) - _private_mem >> 3) + 4) <= 288)
         {
            si32(_loc4_ + 32,_pmem_next);
         }
         else
         {
            _loc2_ -= 16;
            si32(32,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc2_ += 16;
            _loc4_ = eax;
         }
         si32(1,_loc4_ + 4);
         si32(2,_loc4_ + 8);
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
      si32(0,_loc4_ + 12);
      si32(_loc5_,_loc4_ + 20);
      si32(1,_loc4_ + 16);
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
