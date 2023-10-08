package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   
   public function F___kernel_sindf() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = NaN;
      var _loc4_:Number = NaN;
      var _loc7_:Number = NaN;
      var _loc6_:Number = NaN;
      var _loc8_:Number = NaN;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc5_ = lf64(_loc3_);
      _loc7_ = (_loc4_ = _loc5_ * _loc5_) * _loc5_;
      _loc6_ = _loc4_ * _loc4_;
      _loc6_ = _loc7_ * _loc6_;
      _loc8_ = (_loc8_ = _loc4_ * 0.000002718311493989822) + -0.00019839334836096632;
      _loc6_ *= _loc8_;
      _loc1_ = _loc5_ = (_loc5_ = (_loc7_ = (_loc4_ = (_loc4_ *= 0.008333329385889463) + -0.16666666641626524) * _loc7_) + _loc5_) + _loc6_;
      st0 = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
