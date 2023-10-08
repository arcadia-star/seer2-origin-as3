package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   
   public function F_crealf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = lf32(_loc3_);
      st0 = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
