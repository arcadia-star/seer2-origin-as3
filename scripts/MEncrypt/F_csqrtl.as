package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_csqrtl() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = NaN;
      var _loc4_:* = NaN;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 16);
      si32(_loc1_,_loc2_ + 16);
      _loc1_ = li32(_loc3_ + 12);
      si32(_loc1_,_loc2_ + 12);
      _loc1_ = li32(_loc3_ + 8);
      si32(_loc1_,_loc2_ + 8);
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc1_,_loc2_ + 4);
      _loc1_ = _loc3_ - 16;
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F_csqrt();
      _loc2_ += 32;
      _loc5_ = lf64(_loc3_ - 8);
      _loc4_ = lf64(_loc3_ - 16);
      _loc6_ = li32(_loc3_);
      sf64(_loc4_,_loc6_);
      sf64(_loc5_,_loc6_ + 8);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
