package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F_fileno_unlocked() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc1_ = si16(li16(_loc1_ + 14));
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
