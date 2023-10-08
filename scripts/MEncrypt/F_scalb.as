package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_scalb() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = NaN;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc5_ = lf64(_loc3_ + 8);
      _loc4_ = lf64(_loc3_);
      if(!(_loc4_ == _loc4_ & _loc5_ == _loc5_))
      {
         _loc4_ *= _loc5_;
      }
      else
      {
         sf64(_loc5_,_loc3_ - 8);
         if((li32(_loc3_ - 8 | 4) & 2147483647) + -2146435072 >= 0)
         {
            if(!(_loc5_ <= 0 | _loc5_ != _loc5_ | false))
            {
               _loc4_ *= _loc5_;
            }
            else
            {
               _loc4_ /= -_loc5_;
            }
         }
         else
         {
            _loc2_ -= 16;
            sf64(_loc5_,_loc2_);
            ESP = _loc2_;
            F_rint();
            _loc2_ += 16;
            var _loc6_:Number;
            if((_loc6_ = st0) != _loc5_)
            {
               _loc6_ = _loc5_ - _loc5_;
               _loc4_ = _loc6_ / _loc6_;
            }
            else if(!(_loc5_ <= 65000 | _loc5_ != _loc5_ | false))
            {
               _loc2_ -= 16;
               si32(65000,_loc2_ + 8);
               sf64(_loc4_,_loc2_);
               ESP = _loc2_;
               F_scalbn();
               _loc2_ += 16;
               _loc4_ = st0;
            }
            else if(!(_loc5_ >= -65000 | _loc5_ != _loc5_ | false))
            {
               _loc2_ -= 16;
               si32(-65000,_loc2_ + 8);
               sf64(_loc4_,_loc2_);
               ESP = _loc2_;
               F_scalbn();
               _loc2_ += 16;
               _loc4_ = st0;
            }
            else
            {
               _loc2_ -= 16;
               sf64(_loc4_,_loc2_);
               si32(int(_loc5_),_loc2_ + 8);
               ESP = _loc2_;
               F_scalbn();
               _loc2_ += 16;
               _loc4_ = st0;
            }
         }
      }
      st0 = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
