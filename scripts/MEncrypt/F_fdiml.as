package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   
   public function F_fdiml() : void
   {
      var _loc2_:* = 0;
      var _loc4_:* = NaN;
      var _loc5_:* = NaN;
      var _loc3_:* = NaN;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc3_ = _loc4_ = lf64(_loc2_);
      if(!(_loc4_ != _loc4_ | _loc4_ != _loc4_))
      {
         _loc3_ = _loc5_ = lf64(_loc2_ + 8);
         if(!(_loc5_ != _loc5_ | _loc5_ != _loc5_))
         {
            _loc3_ = 0;
            if(!(_loc4_ <= _loc5_ | _loc4_ != _loc4_ | _loc5_ != _loc5_))
            {
               _loc3_ = _loc4_ - _loc5_;
            }
         }
      }
      st0 = _loc3_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
