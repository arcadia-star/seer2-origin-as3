package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___umoddi3() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 12);
      si32(_loc1_,_loc2_ + 12);
      _loc1_ = li32(_loc3_ + 8);
      si32(_loc1_,_loc2_ + 8);
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc1_,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      _loc1_ = _loc3_ - 8;
      si32(_loc1_,_loc2_ + 16);
      ESP = _loc2_;
      F___udivmoddi4();
      _loc2_ += 32;
      _loc1_ |= 4;
      _loc4_ = li32(_loc1_);
      _loc1_ = li32(_loc3_ - 8);
      eax = _loc1_;
      edx = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
