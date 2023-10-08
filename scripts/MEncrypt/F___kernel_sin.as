package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   
   public function F___kernel_sin() : void
   {
      var _loc4_:* = 0;
      var _loc5_:Number = NaN;
      var _loc10_:Number = NaN;
      var _loc9_:Number = NaN;
      var _loc7_:Number = NaN;
      var _loc2_:* = 0;
      var _loc8_:* = NaN;
      var _loc6_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = lf64(_loc4_ = _loc3_);
      _loc5_ = _loc6_ * _loc6_;
      _loc8_ = _loc5_ * _loc5_;
      _loc8_ = _loc5_ * _loc8_;
      _loc7_ = (_loc7_ = _loc5_ * 1.58969099521155e-10) + -2.5050760253406863e-8;
      _loc8_ *= _loc7_;
      _loc10_ = (_loc7_ = (_loc7_ = (_loc7_ = (_loc7_ = _loc5_ * 0.0000027557313707070068) + -0.0001984126982985795) * _loc5_) + 0.00833333333332249) + _loc8_;
      _loc9_ = _loc5_ * _loc6_;
      _loc2_ = li32(_loc4_ + 16);
      if(_loc2_ == 0)
      {
         _loc6_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc5_ * _loc10_) + -0.16666666666666632) * _loc9_) + _loc6_;
      }
      else
      {
         _loc8_ = lf64(_loc4_ + 8);
         _loc6_ -= (_loc7_ = (_loc7_ = (_loc7_ = _loc8_ * 0.5) - _loc9_ * _loc10_) * _loc5_) - _loc8_ + _loc9_ * 0.16666666666666632;
      }
      st0 = _loc6_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
