package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_tgammaf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      var _loc4_:*;
      sf64(_loc4_ = lf32(_loc3_),_loc2_);
      ESP = _loc2_;
      F_tgamma();
      _loc2_ += 16;
      _loc1_ = _loc4_ = st0;
      st0 = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
