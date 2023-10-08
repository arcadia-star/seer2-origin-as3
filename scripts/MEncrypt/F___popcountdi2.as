package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___popcountdi2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc10_:*;
      _loc9_ = (_loc10_ = _loc1_ >>> 1) & 1431655765;
      _loc7_ = _loc8_ = 1;
      if(uint(_loc1_) >= uint(_loc9_))
      {
         _loc7_ = 0;
      }
      _loc9_ = (_loc10_ = _loc1_ - _loc9_) & 858993459;
      _loc1_ = (_loc10_ = (_loc10_ >>>= 2) & 858993459) + _loc9_;
      _loc6_ = _loc8_;
      if(uint(_loc1_) >= uint(_loc10_))
      {
         _loc6_ = 0;
      }
      _loc5_ = _loc8_;
      if(uint(_loc1_) >= uint(_loc9_))
      {
         _loc5_ = _loc6_;
      }
      var _loc4_:* = (_loc4_ = (_loc10_ = li32(_loc10_ = (_loc10_ = _loc3_) | 4)) >>> 1) & 1431655765;
      _loc10_ = (_loc4_ = (_loc10_ -= _loc4_) - _loc7_) & 858993459;
      _loc4_ = (_loc9_ = (_loc10_ = (_loc4_ = (_loc4_ >>>= 2) & 858993459) + _loc10_) + _loc5_) << 28;
      _loc7_ = (_loc10_ = (_loc10_ = _loc1_ >>> 4) | _loc4_) + _loc1_;
      _loc5_ = _loc8_;
      if(uint(_loc7_) >= uint(_loc10_))
      {
         _loc5_ = 0;
      }
      if(uint(_loc7_) >= uint(_loc1_))
      {
         _loc8_ = _loc5_;
      }
      _loc4_ = (_loc10_ = (_loc10_ = (_loc10_ = _loc9_ >>> 4) + _loc9_) + _loc8_) & 252645135;
      _loc10_ = _loc7_ & 252645135;
      eax = _loc10_ = (_loc10_ = (_loc10_ = (_loc4_ = (_loc10_ = (_loc4_ += _loc10_) >>> 16) + _loc4_) >>> 8) + _loc4_) & 127;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
