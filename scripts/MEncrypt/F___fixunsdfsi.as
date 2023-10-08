package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___fixunsdfsi() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc1_ = (_loc7_ = li32(_loc1_)) >>> 20;
      _loc1_ = (_loc6_ = _loc1_ & 2047) + -1023;
      _loc5_ = 0;
      if(_loc1_ >= 0)
      {
         _loc5_ = 0;
         if(_loc7_ >= 0)
         {
            _loc5_ = (li32(_loc3_) >>> 21 | _loc7_ << 11 | -2147483648) >>> 1054 - _loc6_;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
