package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._TWO23;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_nearbyintf() : void
   {
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:int = 0;
      var _loc10_:int = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 12;
      _loc2_ = lf32(_loc5_);
      sf32(_loc2_,_loc5_ - 4);
      _loc1_ = li32(_loc5_ - 4);
      var _loc11_:*;
      if((_loc10_ = (_loc11_ = (_loc11_ = _loc1_ >>> 23) & 255) + -127) <= 22)
      {
         _loc9_ = _loc1_ >>> 31;
         if(_loc10_ <= -1)
         {
            if((_loc11_ = _loc1_ & 2147483647) != 0)
            {
               var _loc7_:* = lf32(_loc11_ = _TWO23 + (_loc9_ << 2));
               var _loc6_:*;
               var _loc4_:*;
               sf32(_loc7_ = (_loc6_ = _loc4_ = _loc6_ = _loc7_ + _loc2_) - _loc7_,_loc5_ - 8);
               var _loc8_:*;
               si32(_loc11_ = (_loc8_ = (_loc8_ = li32(_loc5_ - 8)) & 2147483647) | _loc1_ & -2147483648,_loc5_ - 12);
               _loc2_ = lf32(_loc5_ - 12);
            }
         }
         else
         {
            _loc7_ = lf32(_loc11_ = _TWO23 + (_loc9_ << 2));
            _loc2_ = _loc7_ = (_loc6_ = _loc4_ = _loc6_ = _loc7_ + _loc2_) - _loc7_;
         }
      }
      else if(_loc10_ == 128)
      {
         _loc7_ = _loc2_;
         _loc2_ = _loc7_ += _loc7_;
      }
      st0 = _loc2_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
