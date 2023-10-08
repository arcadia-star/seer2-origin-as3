package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___absvsi2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if(_loc1_ == -2147483648)
      {
         ESP = _loc2_;
         F_abort();
      }
      var _loc5_:*;
      var _loc4_:*;
      eax = _loc5_ = (_loc4_ = (_loc5_ = _loc1_ >> 31) ^ _loc1_) - _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
