package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___ashrdi3() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc7_ = _loc1_ & 32;
      _loc6_ = li32(_loc3_ + 4);
      if(_loc7_ != 0)
      {
         _loc5_ = _loc6_ >> _loc1_ + -32;
         _loc6_ >>= 31;
      }
      else
      {
         _loc5_ = li32(_loc3_);
         if(_loc1_ != 0)
         {
            var _loc4_:*;
            _loc5_ = (_loc4_ = _loc6_ << 32 - _loc1_) | _loc5_ >>> _loc1_;
            _loc6_ >>= _loc1_;
         }
      }
      eax = _loc5_;
      edx = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
