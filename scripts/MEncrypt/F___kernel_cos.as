package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   
   public function F___kernel_cos() : void
   {
      var _loc2_:* = 0;
      var _loc4_:* = NaN;
      var _loc3_:Number = NaN;
      var _loc6_:Number = NaN;
      var _loc5_:* = NaN;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc4_ = lf64(_loc2_);
      _loc3_ = _loc4_ * _loc4_;
      _loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = _loc3_ * -1.1359647557788195e-11) + 2.087572321298175e-9) * _loc3_) + -2.7557314351390663e-7;
      _loc5_ = _loc3_ * _loc3_;
      _loc6_ = (_loc5_ *= _loc5_) * _loc6_;
      _loc6_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = _loc3_ * 0.00002480158728947673) + -0.001388888888887411) * _loc3_) + 0.0416666666666666) * _loc3_) + _loc6_;
      _loc6_ = _loc3_ * _loc6_;
      _loc5_ = lf64(_loc2_ + 8);
      _loc4_ *= _loc5_;
      _loc4_ = _loc6_ - _loc4_;
      _loc5_ = _loc3_ * 0.5;
      _loc3_ = 1 - _loc5_;
      _loc3_ = (_loc4_ = (_loc6_ = (_loc6_ = 1 - _loc3_) - _loc5_) + _loc4_) + _loc3_;
      st0 = _loc3_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
