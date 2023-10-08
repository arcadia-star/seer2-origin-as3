package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___subvsi3() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      var _loc4_:*;
      _loc1_ = (_loc4_ = li32(_loc3_)) - _loc1_;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
