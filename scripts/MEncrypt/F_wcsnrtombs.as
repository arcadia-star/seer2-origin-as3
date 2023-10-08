package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_wcsnrtombs() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _mbs_2E_2135;
      if((_loc6_ = li32(_loc3_ + 16)) != 0)
      {
         _loc1_ = _loc6_;
      }
      var _loc5_:* = li32(___wcsnrtombs);
      _loc2_ -= 32;
      si32(_loc1_,_loc2_ + 16);
      var _loc4_:*;
      si32(_loc4_ = li32(_loc3_ + 12),_loc2_ + 12);
      si32(_loc4_ = li32(_loc3_ + 8),_loc2_ + 8);
      si32(_loc4_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc4_ = li32(_loc3_),_loc2_);
      ESP = _loc2_;
      ptr2fun[_loc5_]();
      _loc2_ += 32;
      eax = _loc5_ = eax;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
