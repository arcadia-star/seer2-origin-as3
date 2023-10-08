package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_asin() : void
   {
      var _loc5_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:Number = NaN;
      var _loc1_:Number = NaN;
      var _loc14_:Number = NaN;
      var _loc7_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 24;
      sf64(_loc7_ = lf64(_loc5_),_loc5_ - 8);
      var _loc4_:*;
      if((uint(_loc11_ = (_loc13_ = li32(_loc4_ = (_loc4_ = _loc5_ - 8) | 4)) & 2147483647)) >= 1072693248)
      {
         if((_loc4_ = (_loc4_ = _loc11_ + -1072693248) | li32(_loc5_ - 8)) == 0)
         {
            var _loc10_:Number;
            _loc7_ = (_loc10_ = _loc7_ * 1.5707963267948966) + _loc7_ * 6.123233995736766e-17;
         }
         else
         {
            var _loc6_:* = _loc7_ - _loc7_;
            _loc7_ = _loc6_ / _loc6_;
         }
      }
      else if(uint(_loc11_) <= 1071644671)
      {
         if(uint(_loc11_) <= 1044381695)
         {
            if((_loc6_ = _loc7_ + 1e+300) <= 1)
            {
            }
            §§goto(addr508);
         }
         _loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc6_ = _loc7_ * _loc7_) * 0.00003479331075960212) + 0.0007915349942898145) * _loc6_) + -0.04005553450067941) * _loc6_) + 0.20121253213486293) * _loc6_) + -0.3255658186224009) * _loc6_) + 0.16666666666666666) * _loc6_;
         var _loc8_:Number;
         _loc6_ = (_loc6_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc6_ * 0.07703815055590194) + -0.6882839716054533) * _loc6_) + 2.0209457602335057) * _loc6_) + -2.403394911734414) * _loc6_) + 1;
         _loc7_ = (_loc6_ = (_loc6_ = _loc10_ / _loc6_) * _loc7_) + _loc7_;
      }
      else
      {
         if(!(_loc7_ >= 0 | _loc7_ != _loc7_ | false))
         {
            _loc7_ = -_loc7_;
         }
         _loc12_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc14_ = (_loc6_ = 1 - _loc7_) * 0.5) * 0.00003479331075960212) + 0.0007915349942898145) * _loc14_) + -0.04005553450067941) * _loc14_) + 0.20121253213486293) * _loc14_) + -0.3255658186224009) * _loc14_) + 0.16666666666666666) * _loc14_;
         _loc7_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = _loc14_ * 0.07703815055590194) + -0.6882839716054533) * _loc14_) + 2.0209457602335057) * _loc14_) + -2.403394911734414) * _loc14_) + 1;
         _loc1_ = Math.sqrt(_loc14_);
         if(uint(_loc11_) >= 1072640819)
         {
            _loc6_ = (_loc6_ = _loc1_ * (_loc12_ / _loc7_)) + _loc1_;
            _loc7_ = 1.5707963267948966 - ((_loc6_ += _loc6_) + -6.123233995736766e-17);
         }
         else
         {
            sf64(_loc1_,_loc5_ - 16);
            var _loc9_:*;
            si32(_loc9_ = li32(_loc9_ = (_loc9_ = _loc5_ - 16) | 4),(_loc4_ = _loc5_ - 24) | 4);
            si32(0,_loc5_ - 24);
            _loc6_ = lf64(_loc5_ - 24);
            _loc7_ = 0.7853981633974483 - ((_loc8_ = (_loc8_ = _loc1_ + _loc1_) * (_loc12_ / _loc7_)) - ((_loc10_ = (_loc10_ = (_loc8_ = _loc14_ - _loc6_ * _loc6_) / (_loc1_ + _loc6_)) * -2) + 6.123233995736766e-17) - ((_loc6_ *= -2) + 0.7853981633974483));
         }
         if(_loc13_ <= 0)
         {
            _loc7_ = -_loc7_;
         }
      }
      addr508:
      st0 = _loc7_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
