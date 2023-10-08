package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_umtx_thread_exit() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if((_loc5_ = li32(_loc1_ + 4)) != 0)
      {
         _loc2_ -= 16;
         var _loc4_:*;
         si32(_loc4_ = int(threadId) + 8,_loc2_ + 4);
         si32(_umtx_lock,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
         si8(-1,_loc5_ + 44);
         si32(_loc4_ = (_loc4_ = li32(_loc1_ + 8)) & -513,_loc1_ + 8);
         _loc2_ -= 16;
         si32(_umtx_lock,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
