package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   
   public function F_fdimf() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = NaN;
      var _loc4_:* = NaN;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = lf32(_loc3_);
      _loc5_ = _loc1_;
      if(!(_loc5_ != _loc5_ | _loc5_ != _loc5_))
      {
         _loc1_ = lf32(_loc3_ + 4);
         _loc4_ = _loc1_;
         if(!(_loc4_ != _loc4_ | _loc4_ != _loc4_))
         {
            _loc1_ = 0;
            if(!(_loc5_ <= _loc4_ | _loc5_ != _loc5_ | _loc4_ != _loc4_))
            {
               var _loc6_:Number;
               _loc1_ = _loc6_ = _loc5_ - _loc4_;
            }
         }
      }
      st0 = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
