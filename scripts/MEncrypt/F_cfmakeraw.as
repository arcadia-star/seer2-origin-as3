package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_cfmakeraw() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc4_:*;
      si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc1_)) & -10240) | 1,_loc1_);
      si32(_loc4_ = (_loc4_ = li32(_loc1_ + 4)) & -2,_loc1_ + 4);
      si32(_loc4_ = (_loc4_ = li32(_loc1_ + 12)) & 1606416993,_loc1_ + 12);
      si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc1_ + 8)) & -6913) | 2816,_loc1_ + 8);
      si8(1,_loc1_ + 32);
      si8(0,_loc1_ + 33);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
