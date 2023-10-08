package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_frexp() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 8);
      si32(0,_loc1_);
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      var _loc9_:*;
      if((uint(_loc7_ = (_loc8_ = li32(_loc9_ = (_loc9_ = _loc3_ - 8) | 4)) & 2147483647)) <= 2146435071)
      {
         if((_loc9_ = _loc7_ | li32(_loc3_ - 8)) != 0)
         {
            _loc6_ = -1022;
            if(uint(_loc7_) <= 1048575)
            {
               si32(-54,_loc1_);
               sf64(_loc5_ *= 18014398509481984,_loc3_ - 16);
               _loc7_ = (_loc8_ = li32(_loc9_ = (_loc9_ = _loc3_ - 16) | 4)) & 2147483647;
               _loc6_ = -1076;
            }
            _loc9_ = (_loc9_ = _loc3_ - 32) | 4;
            var _loc4_:*;
            si32(_loc4_ = (_loc4_ = _loc8_ & -2146435073) | 1071644672,_loc9_);
            si32(_loc9_ = (_loc9_ = _loc7_ >>> 20) + _loc6_,_loc1_);
            sf64(_loc5_,_loc3_ - 24);
            si32(_loc9_ = li32(_loc3_ - 24),_loc3_ - 32);
            _loc5_ = lf64(_loc3_ - 32);
         }
      }
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
