package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_tanh() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:Number = NaN;
      var _loc1_:* = 0;
      var _loc7_:Number = NaN;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      if((uint(_loc8_ = (_loc10_ = li32(_loc1_)) & 2147483647)) >= 2146435072)
      {
         _loc4_ = 1 / _loc5_;
         if(_loc10_ >= 0)
         {
            _loc5_ = _loc4_ + 1;
         }
         else
         {
            _loc5_ = _loc4_ + -1;
         }
      }
      else
      {
         _loc7_ = 1;
         if(uint(_loc8_) <= 1077280767)
         {
            if(uint(_loc8_) <= 1043333119)
            {
               var _loc6_:Number;
               if((_loc6_ = _loc5_ + 1e+300) <= 1)
               {
               }
               §§goto(addr217);
            }
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc5_ = -_loc5_;
            }
            if(uint(_loc8_) >= 1072693248)
            {
               _loc2_ -= 16;
               sf64(_loc6_ = _loc5_ + _loc5_,_loc2_);
               ESP = _loc2_;
               F_expm1();
               _loc2_ += 16;
               _loc7_ = (_loc6_ = -2 / ((_loc6_ = st0) + 2)) + 1;
            }
            else
            {
               _loc2_ -= 16;
               sf64(_loc6_ = _loc5_ * -2,_loc2_);
               ESP = _loc2_;
               F_expm1();
               _loc2_ += 16;
               var _loc9_:Number;
               _loc7_ = (_loc9_ = -_loc9_) / ((_loc9_ = st0) + 2);
            }
         }
         _loc5_ = _loc7_;
         if(_loc10_ <= -1)
         {
            _loc5_ = -_loc7_;
         }
      }
      addr217:
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
