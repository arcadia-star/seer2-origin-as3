package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pio2_lo1;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_acosf() : void
   {
      var _loc7_:int = 0;
      var _loc2_:* = NaN;
      var _loc6_:* = 0;
      var _loc20_:* = 0;
      var _loc4_:* = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 12;
      _loc2_ = lf32(_loc7_);
      sf32(_loc2_,_loc7_ - 4);
      if((uint(_loc20_ = (_loc6_ = li32(_loc7_ - 4)) & 2147483647)) >= 1065353216)
      {
         if(_loc20_ == 1065353216)
         {
            _loc4_ = 0;
            if(_loc6_ <= 0)
            {
               var _loc9_:* = lf32(_pio2_lo1);
               var _loc11_:*;
               var _loc18_:*;
               _loc4_ = _loc11_ = (_loc9_ = _loc18_ = _loc9_ += _loc9_) + 3.141592502593994;
            }
         }
         else
         {
            _loc11_ = _loc2_;
            _loc11_ = _loc11_ -= _loc11_;
            _loc4_ = _loc11_ /= _loc11_;
         }
      }
      else if(uint(_loc20_) <= 1056964607)
      {
         if(uint(_loc20_) <= 847249408)
         {
            _loc4_ = _loc11_ = (_loc9_ = lf32(_pio2_lo1)) + 1.570796251296997;
         }
         else
         {
            _loc11_ = _loc2_;
            var _loc12_:*;
            var _loc13_:*;
            var _loc14_:*;
            var _loc21_:*;
            var _loc15_:*;
            _loc4_ = _loc11_ = (_loc9_ = _loc18_ = 1.570796251296997) - (_loc11_ -= _loc18_ = _loc9_ = (_loc9_ = lf32(_pio2_lo1)) - (_loc18_ = _loc9_ = (_loc9_ = _loc18_ = _loc9_ = (_loc9_ = _loc18_ = _loc9_ = (_loc12_ = _loc13_ = _loc12_ = (_loc13_ = _loc12_ = (_loc12_ = _loc13_ = _loc12_ = (_loc13_ = _loc12_ = _loc9_ * (_loc13_ = -0.008656363002955914)) + (_loc14_ = -0.04274342209100723)) * _loc9_) + (_loc14_ = 0.16666586697101593)) * _loc9_) / (_loc21_ = _loc15_ = (_loc21_ = _loc15_ = (_loc9_ = _loc18_ = _loc9_ = _loc11_ * _loc11_) * -0.7066296339035034) + (_loc13_ = 1))) * _loc11_));
         }
      }
      else if(_loc6_ <= -1)
      {
         _loc9_ = _loc18_ = _loc9_ = (_loc18_ = _loc9_ = _loc2_ + (_loc11_ = 1)) * (_loc21_ = 0.5);
         _loc4_ = _loc11_ = (_loc11_ = (_loc11_ += _loc18_ = _loc9_ = (_loc18_ = _loc9_ = (_loc11_ = (_loc21_ = _loc15_ = (_loc15_ = _loc21_ = _loc15_ = (_loc21_ = _loc15_ = (_loc15_ = _loc21_ = _loc15_ = (_loc21_ = _loc15_ = _loc9_ * (_loc21_ = -0.008656363002955914)) + (_loc13_ = -0.04274342209100723)) * _loc9_) + (_loc13_ = 0.16666586697101593)) * _loc9_) / (_loc11_ = (_loc12_ = _loc13_ = _loc12_ = _loc9_ * (_loc13_ = -0.7066296339035034)) + _loc11_)) * (_loc11_ = _loc11_ = Math.sqrt(_loc9_))) - lf32(_pio2_lo1)) * (_loc18_ = -2)) + (_loc18_ = 3.141592502593994);
      }
      else
      {
         _loc12_ = _loc18_ = _loc9_ = (_loc18_ = _loc9_ = (_loc11_ = 1) - _loc2_) * (_loc21_ = 0.5);
         sf32(_loc18_ = _loc9_ = Math.sqrt(_loc12_),_loc7_ - 8);
         var _loc17_:*;
         si32(_loc17_ = (_loc17_ = li32(_loc7_ - 8)) & -4096,_loc7_ - 12);
         _loc15_ = _loc18_;
         _loc9_ = lf32(_loc7_ - 12);
         var _loc8_:*;
         var _loc16_:*;
         var _loc10_:Number;
         var _loc19_:Number;
         _loc11_ = _loc11_ = _loc9_ + (_loc11_ = (_loc11_ = _loc11_ = (_loc11_ = _loc11_ = (_loc8_ = _loc16_ = (_loc16_ = _loc8_ = _loc16_ = (_loc8_ = _loc16_ = (_loc16_ = _loc8_ = _loc16_ = (_loc8_ = _loc16_ = _loc12_ * (_loc8_ = -0.008656363002955914)) + (_loc10_ = -0.04274342209100723)) * _loc12_) + (_loc10_ = 0.16666586697101593)) * _loc12_) / (_loc11_ = (_loc12_ = _loc13_ = _loc12_ *= _loc10_ = -0.7066296339035034) + _loc11_)) * _loc15_) + (_loc14_ = _loc19_ = (_loc16_ = _loc8_ = _loc16_ = _loc12_ - (_loc8_ = _loc16_ = _loc9_ * _loc9_)) / (_loc14_ = _loc19_ = _loc15_ + _loc9_)));
         _loc4_ = _loc11_ += _loc11_;
      }
      st0 = _loc4_;
      ESP = _loc5_ = _loc7_;
   }
}
