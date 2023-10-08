package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_vsprintf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 240;
      _loc2_ -= 16;
      si32(232,_loc2_ + 8);
      si32(0,_loc2_ + 4);
      _loc1_ = _loc3_ - 232;
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      Fmemset();
      _loc2_ += 16;
      si16(-1,_loc3_ - 218);
      si16(520,_loc3_ - 220);
      si32(_loc4_ = li32(_loc3_),_loc3_ - 232);
      si32(_loc4_,_loc3_ - 216);
      si32(2147483647,_loc3_ - 224);
      si32(2147483647,_loc3_ - 212);
      _loc2_ -= 16;
      si32(_loc4_ = li32(_loc3_ + 8),_loc2_ + 8);
      si32(_loc4_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F___vfprintf();
      _loc2_ += 16;
      _loc1_ = eax;
      _loc4_ = li32(_loc3_ - 232);
      si8(0,_loc4_);
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
