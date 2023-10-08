package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.sf64;
   
   public function F_lrintl() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      var _loc4_:*;
      sf64(_loc4_ = lf64(_loc3_),_loc2_);
      ESP = _loc2_;
      F_rint();
      _loc2_ += 16;
      _loc1_ = _loc4_ = st0;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
