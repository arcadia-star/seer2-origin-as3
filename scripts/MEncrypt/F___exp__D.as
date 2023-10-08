package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___exp__D() : void
   {
      var _loc4_:* = 0;
      var _loc6_:* = NaN;
      var _loc5_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 32;
      _loc5_ = _loc6_ = lf64(_loc4_);
      if(!(_loc6_ != _loc6_ | _loc6_ != _loc6_))
      {
         if(!(_loc6_ > 716.0210375184236 | _loc6_ != _loc6_ | false))
         {
            _loc5_ = 0;
            if(!(_loc6_ < -751.3715437269807 | _loc6_ != _loc6_ | false))
            {
               sf64(_loc6_,_loc4_ - 8);
               var _loc12_:*;
               si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc12_ = (_loc12_ = _loc4_ - 8) | 4)) & -2147483648) | 1071644672,_loc4_ - 16 | 4);
               si32(0,_loc4_ - 16);
               var _loc11_:* = int(_loc11_ = (_loc11_ = lf64(_loc4_ - 16)) + _loc6_ * 1.4426950408889634);
               _loc3_ -= 16;
               sf64(_loc11_,_loc3_ + 8);
               var _loc7_:Number;
               var _loc8_:Number = (_loc7_ = _loc11_ * 1.9082149292705877e-10) - lf64(_loc4_ + 8);
               _loc7_ = (_loc11_ = (_loc11_ *= -0.6931471803691238) + _loc6_) - _loc8_;
               var _loc10_:Number = _loc7_ - (((((_loc10_ = _loc7_ * _loc7_) * 4.1381367970572385e-8 + -0.0000016533902205465252) * _loc10_ + 0.00006613756321437934) * _loc10_ + -0.0027777777777015593) * _loc10_ + 0.16666666666666602) * _loc10_;
               sf64(_loc8_ = (_loc8_ = _loc11_ - (_loc8_ - _loc7_ * _loc10_ / (2 - _loc10_))) + 1,_loc3_);
               ESP = _loc3_;
               F_scalb();
               _loc3_ += 16;
               _loc5_ = st0;
            }
         }
         else
         {
            sf64(_loc6_,_loc4_ - 24);
            _loc5_ = _loc6_;
            var _loc9_:*;
            if((_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc4_ - 24) | 4)) & 2147483647) + -2146435072 <= -1)
            {
               _loc5_ = inf;
            }
         }
      }
      st0 = _loc5_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
