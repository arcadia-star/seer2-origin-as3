package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F_setjmp() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      ESP = _loc2_ & -16;
      _loc1_ = setjmp(_loc1_,sjid,_loc3_);
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
