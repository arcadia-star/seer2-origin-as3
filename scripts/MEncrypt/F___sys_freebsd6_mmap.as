package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___sys_freebsd6_mmap() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 28);
      si32(_loc1_,_loc2_ + 24);
      _loc1_ = li32(_loc3_ + 24);
      si32(_loc1_,_loc2_ + 20);
      _loc1_ = li32(_loc3_ + 16);
      si32(_loc1_,_loc2_ + 16);
      _loc1_ = li32(_loc3_ + 12);
      si32(_loc1_,_loc2_ + 12);
      _loc1_ = li32(_loc3_ + 8);
      si32(_loc1_,_loc2_ + 8);
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc1_,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F___sys_mmap();
      _loc2_ += 32;
      _loc1_ = eax;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
