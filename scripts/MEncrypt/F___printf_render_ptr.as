package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_render_ptr() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 128;
      _loc1_ = li32(_loc3_ + 8);
      _loc1_ = li32(_loc1_);
      _loc5_ = li32(_loc1_);
      _loc1_ = _loc3_ - 112;
      _loc4_ = _loc1_ | 4;
      si32(0,_loc4_);
      si32(_loc5_,_loc3_ - 112);
      _loc2_ -= 16;
      si32(104,_loc2_ + 8);
      si32(_loc5_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc5_ = _loc3_ - 104,_loc2_);
      ESP = _loc2_;
      Fmemcpy();
      _loc2_ += 16;
      si32(120,_loc3_ - 96);
      si32(1,_loc3_ - 76);
      si32(1,_loc3_ - 92);
      si32(_loc1_,_loc3_ - 116);
      _loc2_ -= 16;
      _loc1_ = _loc3_ - 116;
      si32(_loc1_,_loc2_ + 8);
      si32(_loc5_,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F___printf_render_int();
      _loc2_ += 16;
      _loc1_ = eax;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
