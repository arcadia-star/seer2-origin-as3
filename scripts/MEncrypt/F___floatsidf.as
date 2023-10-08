package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___floatsidf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc4_ = 0;
      _loc1_ = li32(_loc3_);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 4);
         var _loc7_:* = _loc1_ >> 31;
         var _loc6_:*;
         si32(_loc7_ = (_loc6_ = _loc1_ + _loc7_) ^ _loc7_,_loc2_);
         _loc6_ = (_loc6_ = (_loc6_ = (_loc6_ += (_loc6_ = ((_loc7_ = _loc6_ - ((_loc7_ = (_loc6_ = (_loc6_ |= (_loc6_ |= (_loc6_ |= (_loc6_ = _loc7_ | (_loc7_ |= _loc7_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc7_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
         si32(_loc7_ = 52 - (31 - _loc6_),_loc2_ + 8);
         ESP = _loc2_;
         F___ashldi3();
         _loc2_ += 16;
         var _loc5_:int = edx;
         si32(eax,_loc3_ - 8);
         si32((_loc7_ = _loc5_ ^ 1048576) + ((_loc6_ = 1054 - _loc6_) << 20) | _loc1_ & -2147483648,(_loc7_ = _loc3_ - 8) | 4);
         _loc4_ = lf64(_loc3_ - 8);
      }
      st0 = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
