package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_snprintf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 240;
      _loc2_ -= 16;
      si32(232,_loc2_ + 8);
      _loc1_ = _loc3_ - 240;
      si32(_loc1_,_loc2_);
      si32(0,_loc2_ + 4);
      ESP = _loc2_;
      Fmemset();
      _loc2_ += 16;
      si16(-1,_loc3_ - 226);
      si32(_loc7_ = _loc3_ + 12,_loc3_ - 4);
      si16(520,_loc3_ - 228);
      si32(_loc7_ = li32(_loc3_),_loc3_ - 240);
      si32(_loc7_,_loc3_ - 224);
      _loc6_ = 1;
      if((_loc5_ = li32(_loc3_ + 4)) == 0)
      {
         _loc6_ = 0;
      }
      _loc7_ = _loc6_ & 1;
      _loc4_ = _loc5_ - _loc7_;
      _loc6_ = 2147483647;
      if(_loc4_ >= 0)
      {
         _loc6_ = _loc4_;
      }
      si32(_loc6_,_loc3_ - 232);
      si32(_loc6_,_loc3_ - 220);
      _loc7_ = li32(_loc3_ - 4);
      _loc2_ -= 16;
      si32(_loc7_,_loc2_ + 8);
      si32(_loc7_ = li32(_loc3_ + 8),_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F___vfprintf();
      _loc2_ += 16;
      _loc1_ = eax;
      if(_loc5_ != 0)
      {
         si8(0,li32(_loc3_ - 240));
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
