package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___muldi3() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc1_ = li32(_loc1_);
      _loc8_ = li32(_loc3_ + 8);
      _loc1_ *= _loc8_;
      _loc7_ = li32(_loc7_ = (_loc7_ = _loc3_ + 8) | 4);
      _loc6_ = li32(_loc3_);
      _loc7_ = (_loc7_ *= _loc6_) + _loc1_;
      _loc5_ = _loc6_ >>> 16;
      _loc1_ = _loc8_ >>> 16;
      _loc4_ = _loc1_ * _loc5_;
      _loc7_ += _loc4_;
      _loc4_ = (_loc8_ &= 65535) * _loc5_;
      _loc5_ = _loc6_ & 65535;
      _loc4_ = (_loc6_ = (_loc6_ = (_loc8_ *= _loc5_) >>> 16) + _loc4_) >>> 16;
      _loc7_ += _loc4_;
      _loc4_ = _loc6_ & 65535;
      _loc5_ = _loc1_ * _loc5_;
      _loc1_ = _loc4_ + _loc5_;
      _loc1_ >>>= 16;
      _loc1_ = _loc7_ + _loc1_;
      _loc7_ = (_loc7_ = _loc6_ + _loc5_) << 16;
      _loc8_ &= 65535;
      eax = _loc8_ = _loc7_ | _loc8_;
      edx = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
