package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_abort() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(___cleanup);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         ptr2fun[_loc1_]();
      }
      si32(-1,_loc3_ - 4);
      si32(-1,_loc3_ - 8);
      si32(-1,_loc3_ - 12);
      si32(-1,_loc3_ - 16);
      si32(-33,_loc3_ - 16);
      _loc2_ -= 16;
      si32(0,_loc2_ + 8);
      var _loc5_:int;
      var _loc6_:int;
      si32(_loc5_ = (_loc6_ = _loc3_ - 24) + 8,_loc2_ + 4);
      si32(3,_loc2_);
      ESP = _loc2_;
      F__sigprocmask();
      _loc2_ += 16;
      _loc2_ -= 16;
      si32(6,_loc2_);
      ESP = _loc2_;
      F_raise();
      _loc2_ += 16;
      si32(0,_loc3_ - 24);
      var _loc4_:* = _loc6_ | 4;
      si32(0,_loc4_);
      si32(-1,_loc3_ - 4);
      si32(-1,_loc3_ - 8);
      si32(-1,_loc3_ - 12);
      si32(-1,_loc3_ - 16);
      _loc2_ -= 16;
      si32(0,_loc2_ + 8);
      si32(_loc6_,_loc2_ + 4);
      si32(6,_loc2_);
      ESP = _loc2_;
      F__sigaction();
      _loc2_ += 16;
      si32(_loc4_ = (_loc4_ = li32(_loc3_ - 16)) & -33,_loc3_ - 16);
      _loc2_ -= 16;
      si32(0,_loc2_ + 8);
      si32(_loc5_,_loc2_ + 4);
      si32(3,_loc2_);
      ESP = _loc2_;
      F__sigprocmask();
      _loc2_ += 16;
      _loc2_ -= 16;
      si32(6,_loc2_);
      ESP = _loc2_;
      F_raise();
      _loc2_ += 16;
      _loc2_ -= 16;
      si32(1,_loc2_);
      ESP = _loc2_;
      F_exit();
      _loc2_ += 16;
   }
}
