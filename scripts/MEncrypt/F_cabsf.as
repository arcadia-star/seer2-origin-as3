package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_cabsf() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc1_:Number = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = li32(_loc4_);
      si32(_loc2_,_loc3_);
      _loc2_ = _loc4_;
      _loc2_ |= 4;
      _loc2_ = li32(_loc2_);
      si32(_loc2_,_loc3_ + 4);
      ESP = _loc3_;
      F_hypotf();
      _loc3_ += 16;
      _loc1_ = st0;
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
