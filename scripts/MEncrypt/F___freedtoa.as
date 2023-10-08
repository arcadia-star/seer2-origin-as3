package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___freedtoa() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      si32(_loc7_ = li32(_loc1_ - 4),_loc1_);
      var _loc6_:*;
      si32(_loc6_ = 1 << _loc7_,_loc1_ + 4);
      if((_loc5_ = _loc1_ + -4) != 0)
      {
         if(_loc7_ >= 10)
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F_idalloc();
            _loc2_ += 16;
         }
         else
         {
            if((_loc6_ = li32(___isthreaded)) != 0)
            {
               _loc2_ -= 16;
               si32(___gdtoa_locks,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_lock();
               _loc2_ += 16;
               _loc7_ = li32(_loc1_);
            }
            _loc6_ = _loc7_ << 2;
            var _loc4_:*;
            si32(_loc4_ = li32(_loc6_ = _freelist + _loc6_),_loc5_);
            si32(_loc5_,_loc6_);
            if((_loc6_ = li32(___isthreaded)) != 0)
            {
               _loc2_ -= 16;
               si32(___gdtoa_locks,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
