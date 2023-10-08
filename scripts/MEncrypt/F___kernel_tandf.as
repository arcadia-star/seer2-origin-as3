package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   
   public function F___kernel_tandf() : void
   {
      var _loc5_:* = 0;
      var _loc6_:Number = NaN;
      var _loc8_:Number = NaN;
      var _loc11_:Number = NaN;
      var _loc10_:Number = NaN;
      var _loc9_:Number = NaN;
      var _loc7_:* = NaN;
      var _loc2_:* = 0;
      var _loc3_:Number = NaN;
      var _loc4_:*;
      _loc7_ = lf64(_loc5_ = _loc4_ = ESP);
      _loc9_ = (_loc6_ = _loc7_ * _loc7_) * _loc7_;
      _loc8_ = _loc6_ * _loc6_;
      _loc11_ = _loc9_ * _loc8_;
      _loc10_ = (_loc10_ = _loc6_ * 0.009465647849436732) + 0.002974357433599673;
      _loc8_ *= _loc10_;
      _loc10_ = (_loc10_ = _loc6_ * 0.024528318116654728) + 0.05338123784456704;
      _loc8_ += _loc10_;
      _loc11_ *= _loc8_;
      _loc6_ = (_loc6_ *= 0.13339200271297674) + 0.3333313950307914;
      _loc3_ = (_loc7_ = (_loc9_ *= _loc6_) + _loc7_) + _loc11_;
      _loc2_ = li32(_loc5_ + 8);
      if(_loc2_ != 1)
      {
         _loc3_ = -1 / _loc3_;
      }
      var _loc1_:* = _loc3_;
      st0 = _loc1_;
      ESP = _loc4_ = _loc5_;
   }
}
