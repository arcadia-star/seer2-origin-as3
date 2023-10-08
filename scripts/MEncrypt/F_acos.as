package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pio2_lo;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_acos() : void
   {
      var _loc4_:* = 0;
      var _loc6_:* = NaN;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc3_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 24;
      sf64(_loc6_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      if((uint(_loc13_ = (_loc15_ = li32(_loc3_)) & 2147483647)) >= 1072693248)
      {
         if((_loc13_ + -1072693248 | li32(_loc4_ - 8)) == 0)
         {
            _loc6_ = 0;
            if(_loc15_ <= 0)
            {
               var _loc5_:* = lf64(_pio2_lo);
               _loc6_ = (_loc5_ += _loc5_) + 3.141592653589793;
            }
         }
         else
         {
            _loc5_ = _loc6_ - _loc6_;
            _loc6_ = _loc5_ / _loc5_;
         }
      }
      else if(uint(_loc13_) <= 1071644671)
      {
         if(uint(_loc13_) <= 1012924416)
         {
            _loc6_ = (_loc5_ = lf64(_pio2_lo)) + 1.5707963267948966;
         }
         else
         {
            var _loc11_:*;
            var _loc8_:*;
            _loc6_ = 1.5707963267948966 - (_loc6_ - ((_loc11_ = lf64(_pio2_lo)) - (_loc5_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc5_ = _loc6_ * _loc6_) * 0.00003479331075960212) + 0.0007915349942898145) * _loc5_) + -0.04005553450067941) * _loc5_) + 0.20121253213486293) * _loc5_) + -0.3255658186224009) * _loc5_) + 0.16666666666666666) * _loc5_ / ((_loc5_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc5_ * 0.07703815055590194) + -0.6882839716054533) * _loc5_) + 2.0209457602335057) * _loc5_) + -2.403394911734414) * _loc5_) + 1)) * _loc6_));
         }
      }
      else if(_loc15_ <= -1)
      {
         _loc6_ = (_loc5_ = (_loc5_ += (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc11_ = (_loc5_ = (_loc5_ = _loc6_ + 1) * 0.5) * 0.00003479331075960212) + 0.0007915349942898145) * _loc5_) + -0.04005553450067941) * _loc5_) + 0.20121253213486293) * _loc5_) + -0.3255658186224009) * _loc5_) + 0.16666666666666666) * _loc5_ / ((_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc5_ * 0.07703815055590194) + -0.6882839716054533) * _loc5_) + 2.0209457602335057) * _loc5_) + -2.403394911734414) * _loc5_) + 1) * (_loc5_ = Math.sqrt(_loc5_)) - lf64(_pio2_lo)) * -2) + 3.141592653589793;
      }
      else
      {
         _loc11_ = (_loc5_ = 1 - _loc6_) * 0.5;
         sf64(_loc5_ = Math.sqrt(_loc11_),_loc4_ - 16);
         var _loc9_:int;
         var _loc7_:*;
         si32(_loc7_ = li32(_loc7_ = (_loc7_ = _loc4_ - 16) | 4),(_loc9_ = _loc4_ - 24) | 4);
         si32(0,_loc4_ - 24);
         _loc8_ = lf64(_loc4_ - 24);
         var _loc12_:Number;
         _loc5_ = _loc8_ + ((_loc5_ = (_loc11_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = (_loc12_ = _loc11_ * 0.00003479331075960212) + 0.0007915349942898145) * _loc11_) + -0.04005553450067941) * _loc11_) + 0.20121253213486293) * _loc11_) + -0.3255658186224009) * _loc11_) + 0.16666666666666666) * _loc11_ / ((_loc11_ = (((_loc11_ * 0.07703815055590194 + -0.6882839716054533) * _loc11_ + 2.0209457602335057) * _loc11_ + -2.403394911734414) * _loc11_) + 1)) * _loc5_) + (_loc12_ = _loc11_ - _loc8_ * _loc8_) / (_loc5_ + _loc8_));
         _loc6_ = _loc5_ + _loc5_;
      }
      st0 = _loc6_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
