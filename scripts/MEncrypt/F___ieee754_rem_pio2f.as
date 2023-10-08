package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___ieee754_rem_pio2f() : void
   {
      var _loc5_:* = 0;
      var _loc1_:* = NaN;
      var _loc13_:* = 0;
      var _loc4_:* = 0;
      var _loc14_:* = 0;
      var _loc9_:* = NaN;
      var _loc12_:int = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 32;
      _loc1_ = lf32(_loc5_);
      sf32(_loc1_,_loc5_ - 20);
      _loc14_ = (_loc4_ = li32(_loc5_ - 20)) & 2147483647;
      _loc13_ = li32(_loc5_ + 4);
      if(uint(_loc14_) <= 1305022426)
      {
         var _loc8_:*;
         var _loc6_:*;
         sf64(_loc8_ = _loc8_ + (_loc6_ = (_loc6_ = (_loc6_ = (_loc8_ = _loc1_) * 0.6366197723675814) + 6755399441055744) + -6755399441055744) * -1.5707963109016418 + _loc6_ * -1.5893254773528196e-8,_loc13_);
         _loc12_ = _loc6_;
      }
      else if(uint(_loc14_) >= 2139095040)
      {
         _loc6_ = _loc1_;
         sf64(_loc6_ = _loc6_ -= _loc6_,_loc13_);
         _loc12_ = 0;
      }
      else
      {
         var _loc7_:int;
         var _loc10_:int;
         si32(_loc7_ = _loc14_ - ((_loc10_ = (_loc10_ = _loc14_ >>> 23) + -150) << 23),_loc5_ - 24);
         sf64(_loc8_ = lf32(_loc5_ - 24),_loc5_ - 8);
         _loc3_ -= 32;
         si32(0,_loc3_ + 16);
         si32(1,_loc3_ + 12);
         si32(_loc10_,_loc3_ + 8);
         si32(_loc10_ = _loc5_ - 16,_loc3_ + 4);
         si32(_loc10_ = _loc5_ - 8,_loc3_);
         ESP = _loc3_;
         F___kernel_rem_pio2();
         _loc3_ += 32;
         _loc12_ = eax;
         _loc9_ = lf64(_loc5_ - 16);
         if(_loc4_ <= -1)
         {
            sf64(_loc6_ = -_loc9_,_loc13_);
            _loc12_ = 0 - _loc12_;
         }
         else
         {
            sf64(_loc9_,_loc13_);
         }
      }
      eax = _loc12_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
