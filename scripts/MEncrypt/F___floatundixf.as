package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___floatundixf() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:int = 0;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_ + 4);
      _loc8_ = (_loc9_ = li32(_loc3_)) | _loc1_;
      _loc5_ = 0;
      if(_loc8_ != 0)
      {
         _loc2_ -= 16;
         si32(_loc9_,_loc2_);
         si32(_loc1_,_loc2_ + 4);
         var _loc7_:*;
         _loc6_ = (_loc8_ = (_loc8_ = (_loc8_ += (_loc8_ = ((_loc7_ = _loc8_ - ((_loc7_ = (_loc8_ = (_loc8_ |= (_loc8_ |= (_loc8_ = _loc7_ | (_loc7_ = _loc8_ | (_loc8_ = _loc1_ | _loc1_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc7_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
         if(_loc1_ == 0)
         {
            _loc7_ = ((_loc7_ = _loc8_ - ((_loc7_ = (_loc8_ = (_loc8_ |= (_loc8_ |= (_loc8_ |= (_loc8_ |= (_loc8_ = _loc9_ | _loc9_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc7_ >>>= 2) & 858993459);
            _loc6_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc7_ + (_loc7_ >>> 4)) & 252645135) * 16843009) >>> 24) + 32;
         }
         si32(_loc6_,_loc2_ + 8);
         ESP = _loc2_;
         F___ashldi3();
         var _loc4_:* = (_loc8_ = _loc3_ - 8) | 4;
         _loc2_ += 16;
         _loc7_ = eax;
         si32(_loc8_ = edx,_loc4_);
         si32(_loc7_,_loc3_ - 8);
         _loc5_ = lf64(_loc3_ - 8);
      }
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
