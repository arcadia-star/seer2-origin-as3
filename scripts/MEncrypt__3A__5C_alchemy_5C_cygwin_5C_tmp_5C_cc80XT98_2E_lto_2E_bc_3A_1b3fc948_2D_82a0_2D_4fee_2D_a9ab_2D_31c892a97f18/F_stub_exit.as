package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F_exit;
   import avm2.intrinsics.memory.si32;
   
   public function F_stub_exit() : void
   {
      var _loc1_:int = ESP;
      var _loc2_:* = _loc1_;
      _loc1_ -= 16;
      si32(0,_loc1_);
      ESP = _loc1_;
      F_exit();
      _loc1_ += 16;
   }
}
