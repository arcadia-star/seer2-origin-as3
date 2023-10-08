package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___negvsi2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if(_loc1_ == -2147483648)
      {
         ESP = _loc2_;
         F_abort();
      }
      var _loc4_:int;
      eax = _loc4_ = 0 - _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
