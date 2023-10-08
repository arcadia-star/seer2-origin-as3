package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_fabsl() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 8;
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      var _loc5_:*;
      si32(_loc5_ = (_loc5_ = li32(_loc5_ = (_loc5_ = _loc3_) | 4)) & 2147483647,_loc1_);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc3_ - 8);
      var _loc4_:*;
      st0 = _loc4_ = lf64(_loc3_ - 8);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
