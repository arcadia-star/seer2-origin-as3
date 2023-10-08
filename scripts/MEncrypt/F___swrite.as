package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F___swrite() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc1_ = si16(li16(_loc1_ + 14));
      _loc2_ -= 16;
      var _loc4_:*;
      si32(_loc4_ = li32(_loc3_ + 8),_loc2_ + 8);
      si32(_loc4_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F__write();
      _loc2_ += 16;
      _loc1_ = eax;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
