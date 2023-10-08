package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.sf64;
   
   public function F_nexttowardl() : void
   {
      var _loc2_:* = 0;
      var _loc3_:* = NaN;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 16;
      _loc3_ = lf64(_loc2_ + 8);
      sf64(_loc3_,_loc1_ + 8);
      _loc3_ = lf64(_loc2_);
      sf64(_loc3_,_loc1_);
      ESP = _loc1_;
      F_nextafter();
      _loc1_ += 16;
      _loc3_ = st0;
      st0 = _loc3_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
