package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_gettimeofday() : void
   {
      var _loc4_:* = 0;
      var _loc1_:int = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      var _loc3_:* = new Date();
      _loc1_ = _loc3_.time / 1000;
      _loc6_ = _loc3_.getMilliseconds() * 1000;
      _loc5_ = li32(_loc4_);
      si32(_loc1_,_loc5_);
      si32(_loc6_,_loc5_ + 4);
      eax = 0;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
