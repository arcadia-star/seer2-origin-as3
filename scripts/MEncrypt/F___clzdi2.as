package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___clzdi2() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc7_ = li32(_loc1_);
      _loc6_ = li32(_loc3_);
      if(_loc7_ != 0)
      {
         _loc6_ = _loc7_;
      }
      _loc5_ = -1;
      if(_loc7_ != 0)
      {
         _loc5_ = 0;
      }
      _loc1_ = _loc6_ >>> 1;
      var _loc4_:*;
      _loc1_ = (_loc4_ = _loc6_ | _loc1_) >>> 2;
      _loc1_ = (_loc4_ |= _loc1_) >>> 4;
      _loc1_ = (_loc4_ |= _loc1_) >>> 8;
      _loc1_ = (_loc4_ |= _loc1_) >>> 16;
      _loc1_ = _loc4_ | _loc1_;
      _loc1_ ^= -1;
      _loc4_ = (_loc4_ = _loc1_ >>> 1) & 1431655765;
      _loc1_ = (_loc4_ = _loc1_ - _loc4_) & 858993459;
      _loc4_ = (_loc4_ >>>= 2) & 858993459;
      _loc1_ += _loc4_;
      _loc4_ = _loc1_ >>> 4;
      _loc1_ += _loc4_;
      _loc1_ &= 252645135;
      _loc1_ *= 16843009;
      _loc4_ = _loc1_ >>> 24;
      _loc1_ = _loc5_ & 32;
      _loc1_ = _loc4_ + _loc1_;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
