package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.sf32;
   
   public function F_dremf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = lf32(_loc3_ + 4);
      sf32(_loc1_,_loc2_ + 4);
      _loc1_ = lf32(_loc3_);
      sf32(_loc1_,_loc2_);
      ESP = _loc2_;
      F_remainderf();
      _loc2_ += 16;
      _loc1_ = st0;
      st0 = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
