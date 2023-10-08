package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.sf32;
   
   public function F_lroundf() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = NaN;
      var _loc1_:int = 0;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = lf32(_loc4_);
      sf32(_loc2_,_loc3_);
      ESP = _loc3_;
      F_roundf();
      _loc3_ += 16;
      _loc2_ = st0;
      _loc1_ = _loc2_;
      eax = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
