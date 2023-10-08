package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___umodsi3() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:int = 0;
      var _loc7_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      _loc12_ = li32(_loc3_ + 4);
      _loc11_ = li32(_loc3_);
      if(_loc12_ != 0)
      {
         if(_loc11_ != 0)
         {
            var _loc10_:*;
            var _loc9_:*;
            _loc8_ = (_loc10_ = (_loc10_ = (_loc10_ += (_loc10_ = ((_loc9_ = _loc10_ - ((_loc9_ = (_loc10_ = (_loc10_ |= (_loc10_ |= (_loc10_ |= (_loc10_ |= (_loc10_ = _loc11_ | _loc11_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24;
            _loc9_ = ((_loc9_ = _loc10_ - ((_loc9_ = (_loc10_ = (_loc10_ |= (_loc10_ |= (_loc10_ = _loc9_ | (_loc9_ = _loc10_ | (_loc10_ = _loc12_ | _loc12_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459);
            _loc6_ = (_loc7_ = (_loc10_ = (_loc10_ = (_loc10_ = _loc9_ + (_loc9_ >>> 4)) & 252645135) * 16843009) >>> 24) - _loc8_;
            _loc1_ = 0;
            if(uint(_loc6_) <= 31)
            {
               _loc1_ = _loc11_;
               if(_loc6_ != 31)
               {
                  _loc1_ = _loc11_ << 31 - _loc6_;
                  _loc5_ = _loc6_ + 1;
                  _loc6_ = 0;
                  if(_loc5_ != 0)
                  {
                     _loc5_ = _loc11_ >>> _loc5_;
                     _loc7_ = (_loc10_ = _loc7_ + 1) - _loc8_;
                     _loc8_ = _loc12_ + -1;
                     _loc6_ = 0;
                     do
                     {
                        _loc9_ = _loc5_ << 1;
                        _loc9_ = (_loc10_ = _loc1_ >>> 31) | _loc9_;
                        var _loc4_:* = (_loc10_ = (_loc10_ = _loc8_ - _loc9_) >> 31) & _loc12_;
                        _loc5_ = _loc9_ - _loc4_;
                        _loc1_ = (_loc9_ = _loc1_ << 1) | _loc6_;
                        _loc6_ = _loc10_ & 1;
                     }
                     while((_loc7_ += -1) != 0);
                     
                  }
                  _loc1_ = (_loc10_ = _loc1_ << 1) | _loc6_;
               }
            }
         }
      }
      _loc10_ = _loc1_ * _loc12_;
      eax = _loc10_ = _loc11_ - _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
