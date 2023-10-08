package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sigemptyset() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      si32(0,_loc1_ + 12);
      si32(0,_loc1_ + 8);
      si32(0,_loc1_ + 4);
      si32(0,_loc1_);
      eax = 0;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
