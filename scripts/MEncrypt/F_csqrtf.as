package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_csqrtf() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = NaN;
      var _loc2_:* = NaN;
      var _loc7_:* = NaN;
      var _loc6_:* = NaN;
      var _loc12_:* = 0;
      var _loc13_:* = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 48;
      si32(_loc4_ = li32(_loc5_),_loc5_ - 4);
      si32(_loc13_ = li32(_loc5_ + 4),_loc5_ - 8);
      _loc1_ = 0;
      _loc7_ = _loc1_;
      _loc1_ = lf32(_loc5_ - 4);
      _loc6_ = _loc1_;
      _loc2_ = lf32(_loc5_ - 8);
      if(!(_loc6_ != _loc7_ | _loc6_ != _loc6_ | _loc7_ != _loc7_))
      {
         _loc12_ = 0;
         var _loc10_:*;
         if((_loc10_ = _loc2_) != _loc7_)
         {
            addr87:
            var _loc11_:*;
            if((_loc11_ = (_loc11_ = _loc13_ >>> 23) & 255) == 255)
            {
               _loc12_ = 2139095040;
               if((_loc11_ = _loc13_ & 8388607) != 0)
               {
               }
               §§goto(addr403);
            }
            if(!(_loc6_ == _loc6_ & _loc6_ == _loc6_))
            {
               _loc10_ = _loc2_;
               _loc10_ = _loc10_ -= _loc10_;
               sf32(_loc10_ /= _loc10_,_loc5_ - 36);
               _loc13_ = li32(_loc5_ - 36);
               _loc12_ = _loc4_;
            }
            else
            {
               if((_loc11_ = (_loc11_ = _loc4_ >>> 23) & 255) == 255)
               {
                  if((_loc11_ = _loc4_ & 8388607) == 0)
                  {
                     _loc10_ = _loc2_;
                     sf32(_loc10_ -= _loc10_,_loc5_ - 32);
                     _loc12_ = (_loc11_ = li32(_loc5_ - 32)) & 2147483647;
                     if(_loc4_ <= -1)
                     {
                        _loc13_ = (_loc11_ = _loc13_ & -2147483648) | _loc4_ & 2147483647;
                     }
                     else
                     {
                        _loc13_ = _loc12_ | _loc13_ & -2147483648;
                        _loc12_ = _loc4_;
                     }
                  }
                  §§goto(addr403);
               }
               if(!(_loc6_ < _loc7_ | _loc6_ != _loc6_ | _loc7_ != _loc7_))
               {
                  _loc3_ -= 16;
                  sf64(_loc10_ = _loc2_,_loc3_ + 8);
                  sf64(_loc6_,_loc3_);
                  ESP = _loc3_;
                  F_hypot();
                  _loc3_ += 16;
                  var _loc8_:*;
                  sf32(_loc8_ = Math.sqrt((_loc8_ = _loc6_ + st0) * 0.5),_loc5_ - 12);
                  sf32(_loc10_ /= _loc8_ + _loc8_,_loc5_ - 16);
                  _loc12_ = li32(_loc5_ - 12);
                  _loc13_ = li32(_loc5_ - 16);
               }
               else
               {
                  _loc3_ -= 16;
                  sf64(_loc10_ = _loc2_,_loc3_ + 8);
                  si32(_loc11_ = _loc13_ & 2147483647,_loc5_ - 20);
                  sf64(_loc6_,_loc3_);
                  ESP = _loc3_;
                  F_hypot();
                  _loc3_ += 16;
                  sf32(_loc10_ = Math.sqrt((_loc10_ = (_loc10_ = st0) - _loc6_) * 0.5),_loc5_ - 24);
                  sf32(_loc10_ = (_loc8_ = lf32(_loc5_ - 20)) / (_loc10_ + _loc10_),_loc5_ - 28);
                  var _loc9_:*;
                  _loc13_ = (_loc9_ = (_loc9_ = li32(_loc5_ - 24)) & 2147483647) | _loc13_ & -2147483648;
                  _loc12_ = li32(_loc5_ - 28);
               }
            }
         }
         addr403:
         eax = _loc12_;
         edx = _loc13_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr87);
   }
}
