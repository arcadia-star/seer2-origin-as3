package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_catgets() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc13_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:int = 0;
      var _loc15_:* = 0;
      var _loc5_:int = 0;
      var _loc14_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32(_loc4_ = _loc2_);
      _loc15_ = _loc3_ + -1;
      _loc14_ = li32(_loc4_ + 12);
      if(uint(_loc15_) >= 4294967294)
      {
         ESP = _loc2_;
         F___error();
         si32(9,eax);
      }
      else
      {
         _loc13_ = li32(_loc4_ + 8);
         _loc12_ = li32(_loc4_ + 4);
         _loc3_ = li32(_loc3_);
         var _loc11_:*;
         var _loc10_:*;
         _loc9_ = (_loc15_ = (_loc11_ = _loc11_ << 24 | (_loc11_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc11_ >>> 8) & 65280) | (_loc11_ = li32(_loc3_ + 4)) >>> 24)) + -1;
         _loc8_ = 0;
         loop0:
         while(true)
         {
            loop1:
            while(_loc8_ <= _loc9_)
            {
               _loc1_ = (_loc15_ += (_loc15_ = _loc9_ + _loc8_) >>> 31) >> 1;
               if((_loc6_ = (_loc11_ = _loc11_ << 24 | (_loc11_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc11_ >>> 8) & 65280) | (_loc11_ = li32((_loc5_ = _loc3_ + _loc1_ * 12) + 20)) >>> 24)) != _loc12_)
               {
                  if((_loc15_ = _loc12_ - _loc6_) <= -1)
                  {
                     _loc9_ = _loc1_ + -1;
                     continue;
                  }
                  continue loop0;
               }
               var _loc7_:*;
               _loc9_ = (_loc15_ = (_loc8_ = (_loc11_ = _loc11_ << 24 | (_loc11_ <<= 8) & 16711680) | ((_loc7_ = (_loc7_ = _loc11_ >>> 8) & 65280) | (_loc11_ = li32(_loc5_ + 28)) >>> 24)) + ((_loc15_ = _loc15_ << 24 | (_loc15_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc15_ >>> 8) & 65280) | (_loc15_ = li32(_loc5_ + 24)) >>> 24))) + -1;
               _loc12_ = (_loc15_ = (_loc15_ = (_loc15_ = _loc15_ << 24 | (_loc15_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc15_ >>> 8) & 65280) | (_loc15_ = li32(_loc3_ + 12)) >>> 24)) + _loc3_) + 20;
               loop2:
               while(true)
               {
                  while(true)
                  {
                     if(_loc8_ > _loc9_)
                     {
                        break loop1;
                     }
                     _loc1_ = (_loc15_ += (_loc15_ = _loc9_ + _loc8_) >>> 31) >> 1;
                     if((_loc6_ = (_loc11_ = _loc11_ << 24 | (_loc11_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc11_ >>> 8) & 65280) | (_loc11_ = li32(_loc5_ = _loc12_ + _loc1_ * 12)) >>> 24)) == _loc13_)
                     {
                        break;
                     }
                     if((_loc15_ = _loc13_ - _loc6_) <= -1)
                     {
                        _loc9_ = _loc1_ + -1;
                        continue;
                     }
                     continue loop2;
                  }
                  _loc14_ = (_loc15_ = (_loc15_ = (_loc11_ = (_loc10_ = _loc10_ << 24 | (_loc10_ <<= 8) & 16711680) | ((_loc7_ = (_loc7_ = _loc10_ >>> 8) & 65280) | (_loc10_ = li32(_loc3_ + 16)) >>> 24)) + ((_loc11_ = _loc11_ << 24 | (_loc11_ <<= 8) & 16711680) | ((_loc10_ = (_loc10_ = _loc11_ >>> 8) & 65280) | (_loc11_ = li32(_loc5_ + 8)) >>> 24))) + _loc3_) + 20;
                  §§goto(addr548);
               }
            }
            ESP = _loc2_;
            F___error();
            _loc15_ = eax;
            si32(83,_loc15_);
         }
      }
      addr548:
      eax = _loc14_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
