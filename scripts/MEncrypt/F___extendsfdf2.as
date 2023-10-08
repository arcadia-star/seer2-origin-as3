package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___extendsfdf2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_);
      _loc9_ = _loc1_ & -2147483648;
      var _loc7_:*;
      if((uint(_loc7_ = (_loc8_ = _loc1_ & 2147483647) + -8388608)) <= 2130706431)
      {
         _loc6_ = _loc8_ << 29;
         _loc1_ = (_loc7_ = _loc8_ >>> 3) + 939524096;
      }
      else if(uint(_loc8_) >= 2139095040)
      {
         _loc6_ = _loc1_ & 4194303;
         _loc1_ = (_loc7_ = (_loc7_ = _loc1_ >>> 3) & 524288) | 2146435072;
      }
      else
      {
         _loc1_ = _loc6_ = 0;
         if(_loc8_ != 0)
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            var _loc5_:*;
            si32(_loc5_ = (_loc7_ = (_loc7_ = (_loc7_ = (_loc7_ += (_loc7_ = ((_loc5_ = _loc7_ - ((_loc5_ = (_loc7_ = (_loc7_ = _loc5_ | (_loc5_ |= (_loc5_ |= (_loc5_ |= (_loc5_ = _loc8_ | _loc8_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc5_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 21,_loc2_ + 8);
            ESP = _loc2_;
            F___ashldi3();
            _loc2_ += 16;
            _loc6_ = eax;
            _loc1_ = (_loc5_ = (_loc5_ = edx) ^ 1048576) | (_loc7_ = 905 - _loc7_) << 20;
         }
      }
      _loc7_ = _loc1_ | _loc9_;
      _loc5_ = (_loc5_ = _loc3_ - 8) | 4;
      si32(_loc7_,_loc5_);
      si32(_loc6_,_loc3_ - 8);
      var _loc4_:*;
      st0 = _loc4_ = lf64(_loc3_ - 8);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
