package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_acosh() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = NaN;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:Number = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      if((_loc10_ = li32(_loc1_)) <= 1072693247)
      {
         var _loc4_:Number = _loc5_ - _loc5_;
         _loc7_ = _loc4_ / _loc4_;
      }
      else if(_loc10_ >= 1102053376)
      {
         if(_loc10_ >= 2146435072)
         {
            _loc7_ = _loc5_ + _loc5_;
         }
         else
         {
            _loc2_ -= 16;
            sf64(_loc5_,_loc2_);
            ESP = _loc2_;
            F_log();
            _loc2_ += 16;
            _loc7_ = (_loc4_ = st0) + 0.6931471805599453;
         }
      }
      else
      {
         _loc7_ = 0;
         var _loc8_:int;
         if(((_loc8_ = _loc10_ + -1072693248) | li32(_loc3_ - 8)) != 0)
         {
            if(_loc10_ >= 1073741825)
            {
               _loc2_ -= 16;
               var _loc6_:Number;
               sf64((_loc6_ = _loc5_ + _loc5_) + -1 / ((_loc4_ = Math.sqrt((_loc4_ = _loc5_ * _loc5_) + -1)) + _loc5_),_loc2_);
               ESP = _loc2_;
               F_log();
               _loc2_ += 16;
               _loc7_ = st0;
            }
            else
            {
               _loc4_ = _loc5_ + -1;
               _loc2_ -= 16;
               var _loc9_:Number;
               sf64((_loc6_ = Math.sqrt((_loc9_ = _loc4_ + _loc4_) + _loc4_ * _loc4_)) + _loc4_,_loc2_);
               ESP = _loc2_;
               F_log1p();
               _loc2_ += 16;
               _loc7_ = st0;
            }
         }
      }
      st0 = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
