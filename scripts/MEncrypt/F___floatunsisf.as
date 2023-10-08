package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___floatunsisf() : void
   {
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 4;
      _loc2_ = 0;
      _loc1_ = li32(_loc4_);
      if(_loc1_ != 0)
      {
         var _loc10_:*;
         var _loc9_:*;
         if((_loc8_ = 31 - ((_loc10_ = (_loc10_ = (_loc10_ += (_loc10_ = ((_loc9_ = _loc10_ - ((_loc9_ = (_loc10_ = (_loc10_ = _loc9_ | (_loc9_ |= (_loc9_ |= (_loc9_ |= (_loc9_ = _loc1_ | _loc1_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24)) <= 23)
         {
            _loc7_ = (_loc10_ = _loc1_ << 23 - _loc8_) ^ 8388608;
         }
         else
         {
            _loc6_ = _loc1_ << 55 - _loc8_;
            _loc5_ = 1;
            if(uint(_loc6_) <= 2147483648)
            {
               _loc5_ = 0;
            }
            _loc10_ = _loc8_ + -23;
            _loc1_ >>>= _loc10_;
            _loc10_ = _loc1_ ^ 8388608;
            _loc7_ = (_loc5_ &= 1) + _loc10_;
            if(_loc6_ == -2147483648)
            {
               _loc7_ = (_loc10_ = (_loc10_ = _loc5_ + _loc1_) & 1) + _loc7_;
            }
         }
         si32(_loc10_ = (_loc10_ = (_loc10_ = _loc8_ << 23) + _loc7_) + 1065353216,_loc4_ - 4);
         _loc2_ = lf32(_loc4_ - 4);
      }
      st0 = _loc2_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
