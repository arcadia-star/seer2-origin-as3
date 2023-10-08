package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F___addsf3() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = NaN;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc13_:* = 0;
      var _loc14_:* = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 28;
      _loc2_ = lf32(_loc5_ + 4);
      sf32(_loc2_,_loc5_ - 8);
      sf32(_loc4_ = lf32(_loc5_),_loc5_ - 4);
      _loc1_ = li32(_loc5_ - 8);
      _loc14_ = _loc1_ & 2147483647;
      var _loc11_:*;
      if((uint(_loc11_ = (_loc12_ = (_loc13_ = li32(_loc5_ - 4)) & 2147483647) + -1)) <= 2139095038)
      {
         if((uint(_loc11_ = _loc14_ + -1)) >= 2139095039)
         {
            §§goto(addr89);
         }
         §§goto(addr182);
      }
      addr89:
      if(uint(_loc12_) >= 2139095041)
      {
         si32(_loc11_ = _loc13_ | 4194304,_loc5_ - 28);
         _loc2_ = lf32(_loc5_ - 28);
      }
      else if(uint(_loc14_) >= 2139095041)
      {
         si32(_loc11_ = _loc1_ | 4194304,_loc5_ - 24);
         _loc2_ = lf32(_loc5_ - 24);
      }
      else if(_loc12_ == 2139095040)
      {
         _loc2_ = _loc4_;
         if((_loc1_ ^ _loc13_) == -2147483648)
         {
            _loc2_ = nan;
         }
      }
      else if(_loc14_ != 2139095040)
      {
         if(_loc12_ == 0)
         {
            if(_loc14_ == 0)
            {
               si32(_loc11_ = _loc1_ & _loc13_,_loc5_ - 20);
               _loc2_ = lf32(_loc5_ - 20);
            }
         }
         else
         {
            _loc2_ = _loc4_;
            if(_loc14_ != 0)
            {
               addr182:
               _loc10_ = _loc13_;
               if(uint(_loc14_) <= uint(_loc12_))
               {
                  _loc10_ = _loc1_;
               }
               if(uint(_loc14_) <= uint(_loc12_))
               {
                  _loc1_ = _loc13_;
               }
               _loc13_ = _loc1_ & 8388607;
               if((_loc14_ = (_loc11_ = _loc1_ >>> 23) & 255) == 0)
               {
                  var _loc9_:*;
                  _loc13_ <<= (_loc9_ = (_loc11_ = (_loc11_ = (_loc11_ += (_loc11_ = ((_loc9_ = _loc11_ - ((_loc9_ = (_loc11_ = (_loc11_ = _loc9_ | (_loc9_ |= (_loc9_ = _loc11_ | (_loc11_ = _loc9_ | (_loc9_ = _loc13_ | _loc13_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + -8;
                  _loc14_ = 9 - _loc9_;
               }
               _loc12_ = _loc10_ & 8388607;
               if((_loc8_ = (_loc11_ = _loc10_ >>> 23) & 255) == 0)
               {
                  _loc12_ <<= (_loc9_ = (_loc11_ = (_loc11_ = (_loc11_ += (_loc11_ = ((_loc9_ = _loc11_ - ((_loc9_ = (_loc11_ = (_loc11_ |= (_loc11_ |= (_loc11_ = _loc9_ | (_loc9_ |= (_loc9_ = _loc12_ | _loc12_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + -8;
                  _loc8_ = 9 - _loc9_;
               }
               _loc12_ = _loc7_ = (_loc11_ = _loc12_ << 3) | 67108864;
               if(_loc14_ != _loc8_)
               {
                  _loc8_ = _loc14_ - _loc8_;
                  _loc12_ = 1;
                  if(uint(_loc8_) <= 31)
                  {
                     _loc12_ = 1;
                     if(_loc7_ << 32 - _loc8_ == 0)
                     {
                        _loc12_ = 0;
                     }
                     _loc9_ = _loc7_ >>> _loc8_;
                     _loc12_ = (_loc11_ = _loc12_ & 1) | _loc9_;
                  }
               }
               _loc11_ = _loc1_ ^ _loc10_;
               _loc1_ &= -2147483648;
               _loc13_ = (_loc7_ = _loc13_ << 3) | 67108864;
               if(_loc11_ <= -1)
               {
                  _loc2_ = 0;
                  if(_loc13_ != _loc12_)
                  {
                     if((uint(_loc10_ = _loc13_ - _loc12_)) <= 67108863)
                     {
                        _loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ += (_loc11_ = ((_loc9_ = _loc11_ - ((_loc9_ = (_loc11_ = (_loc11_ |= (_loc11_ = _loc9_ | (_loc9_ = _loc11_ | (_loc11_ = _loc9_ | (_loc9_ = _loc10_ | _loc10_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc9_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + -5;
                        _loc14_ -= _loc11_;
                        _loc10_ <<= _loc11_;
                     }
                  }
                  §§goto(addr813);
               }
               else if((_loc11_ = (_loc10_ = _loc12_ + _loc13_) & 134217728) != 0)
               {
                  _loc10_ = (_loc11_ = _loc10_ >>> 1) | (_loc11_ = _loc12_ + _loc7_) & 1;
                  _loc14_ += 1;
               }
               if(_loc14_ >= 255)
               {
                  si32(_loc11_ = _loc1_ | 2139095040,_loc5_ - 16);
                  _loc2_ = lf32(_loc5_ - 16);
               }
               else
               {
                  if(_loc14_ <= 0)
                  {
                     _loc12_ = 1 - _loc14_;
                     _loc13_ = 1;
                     if(_loc10_ << 32 - _loc12_ == (_loc14_ = 0))
                     {
                        _loc13_ = _loc14_;
                     }
                     _loc11_ = _loc10_ >>> _loc12_;
                     _loc10_ = (_loc9_ = _loc13_ & 1) | _loc11_;
                  }
                  _loc12_ = _loc10_ & 7;
                  _loc13_ = 1;
                  if(uint(_loc12_) <= 4)
                  {
                     _loc13_ = 0;
                  }
                  _loc11_ = _loc13_ & 1;
                  var _loc6_:* = (_loc9_ = (_loc9_ = _loc10_ >>> 3) & 8388607) | _loc1_;
                  _loc9_ = _loc14_ << 23;
                  _loc14_ = (_loc9_ = _loc6_ | _loc9_) + _loc11_;
                  if(_loc12_ == 4)
                  {
                     _loc14_ = (_loc11_ = _loc14_ & 1) + _loc14_;
                  }
                  si32(_loc14_,_loc5_ - 12);
                  _loc2_ = lf32(_loc5_ - 12);
               }
            }
         }
      }
      addr813:
      st0 = _loc2_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
