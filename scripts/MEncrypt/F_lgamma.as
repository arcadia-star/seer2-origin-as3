package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_lgamma() : void
   {
      var _loc2_:* = 0;
      var _loc3_:* = NaN;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 16;
      si32(_signgam,_loc1_ + 8);
      _loc3_ = lf64(_loc2_);
      sf64(_loc3_,_loc1_);
      ESP = _loc1_;
      F_lgamma_r();
      _loc1_ += 16;
      _loc3_ = st0;
      st0 = _loc3_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
