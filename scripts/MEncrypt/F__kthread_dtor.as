package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__kthread_dtor() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc4_ = li32(_loc1_ + 4);
      _loc2_ -= 16;
      si32(-1,_loc2_ + 4);
      si32(_loc4_,_loc2_);
      ESP = _loc2_;
      F_kfree();
      _loc2_ += 16;
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F_idalloc();
         _loc2_ += 16;
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
