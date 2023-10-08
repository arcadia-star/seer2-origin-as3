package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_fminl() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:int = 0;
      var _loc5_:* = NaN;
      var _loc4_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_ + 8),_loc3_ - 16);
      sf64(_loc4_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 16;
      _loc1_ |= 4;
      _loc8_ = li32(_loc1_);
      _loc6_ = _loc7_ = 1;
      if(_loc8_ >= 0)
      {
         _loc6_ = 0;
      }
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = li32(_loc1_);
      if(_loc1_ >= 0)
      {
         _loc7_ = 0;
      }
      _loc1_ = _loc7_ ^ _loc6_;
      _loc1_ &= 1;
      if(_loc1_ != 0)
      {
         if(_loc8_ >= 0)
         {
            _loc5_ = _loc4_;
         }
      }
      else
      {
         if(_loc4_ >= _loc5_)
         {
            _loc4_ = _loc5_;
         }
         _loc5_ = _loc4_;
      }
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
