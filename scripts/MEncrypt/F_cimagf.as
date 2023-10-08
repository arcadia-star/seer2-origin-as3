package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   
   public function F_cimagf() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc2_ = _loc4_ = _loc3_;
      _loc2_ |= 4;
      _loc1_ = lf32(_loc2_);
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
