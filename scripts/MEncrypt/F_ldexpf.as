package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_ldexpf() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = li32(_loc4_ + 4);
      si32(_loc2_,_loc3_ + 4);
      _loc1_ = lf32(_loc4_);
      sf32(_loc1_,_loc3_);
      ESP = _loc3_;
      F_scalbnf();
      _loc3_ += 16;
      _loc1_ = st0;
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
