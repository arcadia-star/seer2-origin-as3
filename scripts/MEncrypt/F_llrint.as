package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.sf64;
   
   public function F_llrint() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = NaN;
      var _loc1_:int = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc4_ = lf64(_loc3_),_loc2_);
      ESP = _loc2_;
      F_rint();
      _loc2_ += 16;
      _loc4_ = st0;
      _loc2_ -= 16;
      sf64(_loc4_,_loc2_);
      ESP = _loc2_;
      F___fixdfdi();
      _loc2_ += 16;
      _loc1_ = eax;
      _loc5_ = edx;
      eax = _loc1_;
      edx = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
