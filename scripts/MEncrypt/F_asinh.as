package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_asinh() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = NaN;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      if((uint(_loc8_ = (_loc9_ = li32(_loc1_)) & 2147483647)) >= 2146435072)
      {
         _loc5_ += _loc5_;
      }
      else
      {
         if(uint(_loc8_) <= 1043333119)
         {
            var _loc4_:Number;
            if((_loc4_ = _loc5_ + 1e+300) <= 1)
            {
            }
            §§goto(addr290);
         }
         if(uint(_loc8_) >= 1102053377)
         {
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc5_ = -_loc5_;
            }
            _loc2_ -= 16;
            sf64(_loc5_,_loc2_);
            ESP = _loc2_;
            F_log();
            _loc2_ += 16;
            _loc5_ = (_loc4_ = st0) + 0.6931471805599453;
         }
         else if(uint(_loc8_) >= 1073741825)
         {
            _loc7_ = _loc5_;
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc7_ = -_loc5_;
            }
            _loc4_ = (_loc4_ = _loc5_ * _loc5_) + 1;
            _loc4_ = (_loc4_ = Math.sqrt(_loc4_)) + _loc7_;
            var _loc6_:Number = 1 / _loc4_;
            _loc4_ = (_loc4_ = _loc7_ + _loc7_) + _loc6_;
            _loc2_ -= 16;
            sf64(_loc4_,_loc2_);
            ESP = _loc2_;
            F_log();
            _loc2_ += 16;
            _loc5_ = st0;
         }
         else
         {
            _loc7_ = _loc5_;
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc7_ = -_loc5_;
            }
            _loc6_ = (_loc4_ = _loc5_ * _loc5_) + 1;
            _loc6_ = (_loc6_ = Math.sqrt(_loc6_)) + 1;
            _loc4_ /= _loc6_;
            _loc4_ = _loc7_ + _loc4_;
            _loc2_ -= 16;
            sf64(_loc4_,_loc2_);
            ESP = _loc2_;
            F_log1p();
            _loc2_ += 16;
            _loc5_ = st0;
         }
         if(_loc9_ <= 0)
         {
            _loc5_ = -_loc5_;
         }
      }
      addr290:
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
