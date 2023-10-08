package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pR2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pR3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pR5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pR8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pS2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pS3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pS5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pS8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qR2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qR3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qR5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qR8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qS2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qS3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qS5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qS8;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_j0() : void
   {
      var _loc16_:int = 0;
      var _loc26_:* = 0;
      var _loc19_:* = NaN;
      var _loc21_:Number = NaN;
      var _loc27_:* = NaN;
      var _loc1_:* = NaN;
      var _loc2_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = NaN;
      var _loc7_:* = NaN;
      var _loc6_:* = NaN;
      var _loc5_:* = NaN;
      var _loc11_:* = NaN;
      var _loc10_:* = NaN;
      var _loc9_:* = NaN;
      var _loc22_:int = 0;
      var _loc25_:int = 0;
      var _loc18_:int = 0;
      var _loc20_:int = 0;
      var _loc23_:Number = NaN;
      var _loc14_:* = (_loc16_ = ESP) - 16;
      sf64(_loc19_ = lf64(_loc16_),_loc16_ - 8);
      var _loc15_:*;
      if((uint(_loc26_ = (_loc15_ = li32(_loc15_ = (_loc15_ = _loc16_ - 8) | 4)) & 2147483647)) >= 2146435072)
      {
         _loc23_ = 1 / (_loc19_ * _loc19_);
      }
      else
      {
         if(!(_loc19_ >= 0 | _loc19_ != _loc19_ | false))
         {
            _loc19_ = -_loc19_;
         }
         if(uint(_loc26_) >= 1073741824)
         {
            _loc21_ = Math.sin(_loc19_);
            _loc27_ = Math.cos(_loc19_);
            _loc23_ = _loc21_ + _loc27_;
            if(uint(_loc26_) <= 2145386495)
            {
               var _loc17_:Number = _loc21_ * _loc27_;
               var _loc24_:Number;
               _loc1_ = -(_loc24_ = Math.cos(_loc19_ + _loc19_));
               if(!(_loc17_ >= 0 | _loc17_ != _loc17_ | false))
               {
                  _loc21_ -= _loc27_;
                  _loc23_ = _loc1_ / _loc21_;
               }
               else
               {
                  _loc21_ = _loc1_ / _loc23_;
               }
               if(uint(_loc26_) < 1207959553)
               {
                  sf64(_loc19_,_loc16_ - 16);
                  _loc26_ = (_loc15_ = li32(_loc15_ = (_loc15_ = _loc16_ - 16) | 4)) & 2147483647;
                  _loc25_ = _pS8;
                  _loc22_ = _pR8;
                  if(uint(_loc26_) <= 1075838975)
                  {
                     _loc25_ = _pS5;
                     _loc22_ = _pR5;
                     if(uint(_loc26_) <= 1074933386)
                     {
                        _loc25_ = _pS3;
                        _loc22_ = _pR3;
                        if(uint(_loc26_) <= 1074191212)
                        {
                           if(uint(_loc26_) >= 1073741824)
                           {
                              _loc25_ = _pS2;
                              _loc22_ = _pR2;
                           }
                        }
                     }
                  }
                  _loc1_ = lf64(_loc22_ + 40);
                  _loc27_ = lf64(_loc22_ + 32);
                  _loc2_ = lf64(_loc22_ + 24);
                  _loc3_ = lf64(_loc22_ + 16);
                  _loc4_ = lf64(_loc22_ + 8);
                  _loc7_ = lf64(_loc22_);
                  _loc6_ = lf64(_loc25_ + 32);
                  _loc5_ = lf64(_loc25_ + 24);
                  _loc11_ = lf64(_loc25_ + 16);
                  _loc10_ = lf64(_loc25_ + 8);
                  _loc9_ = lf64(_loc25_);
                  _loc20_ = _qS8;
                  _loc18_ = _qR8;
                  if(uint(_loc26_) <= 1075838975)
                  {
                     _loc20_ = _qS5;
                     _loc18_ = _qR5;
                     if(uint(_loc26_) <= 1074933386)
                     {
                        _loc20_ = _qS3;
                        _loc18_ = _qR3;
                        if(uint(_loc26_) <= 1074191212)
                        {
                           if(uint(_loc26_) >= 1073741824)
                           {
                              _loc20_ = _qS2;
                              _loc18_ = _qR2;
                           }
                        }
                     }
                  }
                  _loc17_ = _loc19_ * _loc19_;
                  _loc17_ = 1 / _loc17_;
                  _loc24_ = _loc1_ * _loc17_;
                  _loc24_ = (_loc24_ = _loc27_ + _loc24_) * _loc17_;
                  _loc24_ = (_loc24_ = _loc2_ + _loc24_) * _loc17_;
                  _loc24_ = (_loc24_ = _loc3_ + _loc24_) * _loc17_;
                  _loc24_ = (_loc24_ = _loc4_ + _loc24_) * _loc17_;
                  _loc24_ = _loc7_ + _loc24_;
                  var _loc8_:* = _loc6_ * _loc17_;
                  _loc8_ = (_loc8_ = _loc5_ + _loc8_) * _loc17_;
                  _loc8_ = (_loc8_ = _loc11_ + _loc8_) * _loc17_;
                  _loc8_ = (_loc8_ = _loc10_ + _loc8_) * _loc17_;
                  _loc8_ = (_loc8_ = (_loc8_ = _loc9_ + _loc8_) * _loc17_) + 1;
                  _loc24_ = (_loc24_ /= _loc8_) + 1;
                  var _loc13_:* = (_loc8_ = lf64(_loc18_ + 40)) * _loc17_;
                  _loc8_ = (_loc8_ = (_loc8_ = lf64(_loc18_ + 32)) + _loc13_) * _loc17_;
                  _loc13_ = (_loc8_ = (_loc13_ = lf64(_loc18_ + 24)) + _loc8_) * _loc17_;
                  _loc13_ = (_loc8_ = (_loc8_ = lf64(_loc18_ + 16)) + _loc13_) * _loc17_;
                  _loc13_ = (_loc8_ = (_loc8_ = lf64(_loc18_ + 8)) + _loc13_) * _loc17_;
                  _loc8_ = (_loc8_ = lf64(_loc18_)) + _loc13_;
                  _loc13_ = (_loc13_ = lf64(_loc20_ + 40)) * _loc17_;
                  var _loc12_:*;
                  _loc13_ = (_loc13_ = (_loc12_ = lf64(_loc20_ + 32)) + _loc13_) * _loc17_;
                  _loc12_ = (_loc13_ = (_loc12_ = lf64(_loc20_ + 24)) + _loc13_) * _loc17_;
                  _loc12_ = (_loc13_ = (_loc13_ = lf64(_loc20_ + 16)) + _loc12_) * _loc17_;
                  _loc12_ = (_loc13_ = (_loc13_ = lf64(_loc20_ + 8)) + _loc12_) * _loc17_;
                  _loc17_ = (_loc17_ = (_loc13_ = (_loc13_ = lf64(_loc20_)) + _loc12_) * _loc17_) + 1;
                  _loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = _loc8_ / _loc17_) + -0.125) / _loc19_) * _loc21_;
                  _loc17_ = (_loc17_ = (_loc24_ *= _loc23_) - _loc17_) * 0.5641895835477563;
                  _loc24_ = Math.sqrt(_loc19_);
                  _loc23_ = _loc17_ / _loc24_;
               }
               §§goto(addr890);
            }
            _loc17_ = Math.sqrt(_loc19_);
            _loc23_ = (_loc24_ = _loc23_ * 0.5641895835477563) / _loc17_;
         }
         else
         {
            if(uint(_loc26_) <= 1059061759)
            {
               _loc17_ = _loc19_ + 1e+300;
               _loc23_ = 1;
               if(!(_loc17_ <= _loc23_ | _loc17_ != _loc17_ | _loc23_ != _loc23_))
               {
                  if(uint(_loc26_) >= 1044381696)
                  {
                     _loc23_ = (_loc17_ = (_loc17_ = _loc19_ * -0.25) * _loc19_) + 1;
                  }
               }
               §§goto(addr890);
            }
            _loc21_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc23_ = _loc19_ * _loc19_) * -4.618326885321032e-9) + 0.0000018295404953270067) * _loc23_) + -0.00018997929423885472) * _loc23_) + 0.015624999999999995) * _loc23_;
            _loc1_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = (_loc17_ = _loc23_ * 1.1661400333379e-9) + 5.135465502073181e-7) * _loc23_) + 0.00011692678466333745) * _loc23_) + 0.015619102946489001) * _loc23_) + 1;
            if(uint(_loc26_) <= 1072693247)
            {
               _loc23_ = (_loc17_ = (_loc17_ = (_loc17_ = _loc21_ / _loc1_) + -0.25) * _loc23_) + 1;
            }
            else
            {
               _loc8_ = _loc19_ * 0.5;
               _loc23_ = (_loc24_ = (_loc8_ += 1) * (1 - _loc8_)) + (_loc17_ = _loc21_ / _loc1_) * _loc23_;
            }
         }
      }
      addr890:
      st0 = _loc23_;
      ESP = _loc14_ = _loc16_;
   }
}
