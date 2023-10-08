package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.CModule;
   import MEncrypt.ESP;
   import MEncrypt.edx;
   import MEncrypt.st0;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___avm2_apply3() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:Number = NaN;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc7_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_ + 12);
      ESP = _loc2_;
      _loc1_ = CModule.callI(_loc1_,CModule.readIntVector(_loc7_,_loc6_));
      _loc7_ = edx;
      _loc4_ = st0;
      _loc5_ = li32(_loc3_);
      si32(_loc1_,_loc5_);
      si32(_loc7_,_loc5_ + 4);
      sf64(_loc4_,_loc5_ + 8);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
