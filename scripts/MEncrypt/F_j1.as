package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pr2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pr3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pr5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pr8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ps2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ps3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ps5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ps8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qr2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qr3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qr5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qr8;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qs2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qs3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qs5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._qs8;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_j1() : void
   {
      var _loc15_:int = 0;
      var _loc17_:* = NaN;
      var _loc28_:* = 0;
      var _loc27_:* = 0;
      var _loc19_:* = NaN;
      var _loc18_:Number = NaN;
      var _loc26_:* = 0;
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
      var _loc16_:* = NaN;
      var _loc24_:int = 0;
      var _loc25_:int = 0;
      var _loc23_:int = 0;
      var _loc14_:* = (_loc15_ = ESP) - 16;
      sf64(_loc17_ = lf64(_loc15_),_loc15_ - 8);
      var _loc22_:*;
      if((uint(_loc27_ = (_loc28_ = li32(_loc22_ = (_loc22_ = _loc15_ - 8) | 4)) & 2147483647)) >= 2146435072)
      {
         _loc16_ = 1 / _loc17_;
      }
      else
      {
         _loc16_ = _loc17_;
         if(!(_loc17_ >= 0 | _loc17_ != _loc17_ | false))
         {
            _loc16_ = -_loc17_;
         }
         if(uint(_loc27_) >= 1073741824)
         {
            _loc19_ = Math.sin(_loc16_);
            _loc18_ = Math.cos(_loc16_);
            _loc17_ = _loc19_ - _loc18_;
            if(uint(_loc27_) <= 2145386495)
            {
               var _loc21_:Number = _loc19_ * _loc18_;
               _loc1_ = Math.cos(_loc16_ + _loc16_);
               if(!(_loc21_ <= 0 | _loc21_ != _loc21_ | false))
               {
                  var _loc20_:Number;
                  _loc18_ = (_loc20_ = -_loc19_) - _loc18_;
                  _loc17_ = _loc1_ / _loc18_;
               }
               else
               {
                  _loc18_ = _loc1_ / _loc17_;
               }
               if(uint(_loc27_) >= 1207959553)
               {
                  addr188:
                  _loc20_ = Math.sqrt(_loc16_);
                  _loc16_ = (_loc21_ = _loc17_ * 0.5641895835477563) / _loc20_;
               }
               else
               {
                  sf64(_loc16_,_loc15_ - 16);
                  _loc26_ = (_loc22_ = li32(_loc22_ = (_loc22_ = _loc15_ - 16) | 4)) & 2147483647;
                  _loc25_ = _ps8;
                  _loc24_ = _pr8;
                  if(uint(_loc26_) <= 1075838975)
                  {
                     _loc25_ = _ps5;
                     _loc24_ = _pr5;
                     if(uint(_loc26_) <= 1074933386)
                     {
                        _loc25_ = _ps3;
                        _loc24_ = _pr3;
                        if(uint(_loc26_) <= 1074191212)
                        {
                           if(uint(_loc26_) >= 1073741824)
                           {
                              _loc25_ = _ps2;
                              _loc24_ = _pr2;
                           }
                        }
                     }
                  }
                  _loc2_ = lf64(_loc24_ + 40);
                  _loc3_ = lf64(_loc24_ + 32);
                  _loc19_ = lf64(_loc24_ + 24);
                  _loc4_ = lf64(_loc24_ + 16);
                  _loc1_ = lf64(_loc24_ + 8);
                  _loc7_ = lf64(_loc24_);
                  _loc6_ = lf64(_loc25_ + 32);
                  _loc5_ = lf64(_loc25_ + 24);
                  _loc11_ = lf64(_loc25_ + 16);
                  _loc10_ = lf64(_loc25_ + 8);
                  _loc9_ = lf64(_loc25_);
                  _loc25_ = _qs8;
                  _loc23_ = _qr8;
                  if(uint(_loc26_) <= 1075838975)
                  {
                     _loc25_ = _qs5;
                     _loc23_ = _qr5;
                     if(uint(_loc26_) <= 1074933386)
                     {
                        _loc25_ = _qs3;
                        _loc23_ = _qr3;
                        if(uint(_loc26_) <= 1074191212)
                        {
                           if(uint(_loc26_) >= 1073741824)
                           {
                              _loc25_ = _qs2;
                              _loc23_ = _qr2;
                           }
                        }
                     }
                  }
                  _loc20_ = _loc16_ * _loc16_;
                  _loc20_ = 1 / _loc20_;
                  _loc21_ = _loc2_ * _loc20_;
                  _loc21_ = (_loc21_ = _loc3_ + _loc21_) * _loc20_;
                  _loc21_ = (_loc21_ = _loc19_ + _loc21_) * _loc20_;
                  _loc21_ = (_loc21_ = _loc4_ + _loc21_) * _loc20_;
                  _loc21_ = (_loc21_ = _loc1_ + _loc21_) * _loc20_;
                  _loc21_ = _loc7_ + _loc21_;
                  var _loc8_:* = _loc6_ * _loc20_;
                  _loc8_ = (_loc8_ = _loc5_ + _loc8_) * _loc20_;
                  _loc8_ = (_loc8_ = _loc11_ + _loc8_) * _loc20_;
                  _loc8_ = (_loc8_ = _loc10_ + _loc8_) * _loc20_;
                  _loc8_ = (_loc8_ = (_loc8_ = _loc9_ + _loc8_) * _loc20_) + 1;
                  _loc21_ = (_loc21_ /= _loc8_) + 1;
                  _loc8_ = (_loc8_ = lf64(_loc23_ + 40)) * _loc20_;
                  var _loc13_:* = (_loc8_ = (_loc13_ = lf64(_loc23_ + 32)) + _loc8_) * _loc20_;
                  _loc13_ = (_loc8_ = (_loc8_ = lf64(_loc23_ + 24)) + _loc13_) * _loc20_;
                  _loc8_ = (_loc8_ = (_loc8_ = lf64(_loc23_ + 16)) + _loc13_) * _loc20_;
                  _loc8_ = (_loc8_ = (_loc13_ = lf64(_loc23_ + 8)) + _loc8_) * _loc20_;
                  _loc8_ = (_loc13_ = lf64(_loc23_)) + _loc8_;
                  _loc13_ = (_loc13_ = lf64(_loc25_ + 40)) * _loc20_;
                  var _loc12_:*;
                  _loc13_ = (_loc13_ = (_loc12_ = lf64(_loc25_ + 32)) + _loc13_) * _loc20_;
                  _loc13_ = (_loc13_ = (_loc12_ = lf64(_loc25_ + 24)) + _loc13_) * _loc20_;
                  _loc13_ = (_loc13_ = (_loc12_ = lf64(_loc25_ + 16)) + _loc13_) * _loc20_;
                  _loc13_ = (_loc13_ = (_loc12_ = lf64(_loc25_ + 8)) + _loc13_) * _loc20_;
                  _loc20_ = (_loc20_ = (_loc13_ = (_loc12_ = lf64(_loc25_)) + _loc13_) * _loc20_) + 1;
                  _loc20_ = (_loc20_ = (_loc20_ = (_loc20_ = _loc8_ / _loc20_) + 0.375) / _loc16_) * _loc18_;
                  _loc20_ = (_loc20_ = (_loc21_ *= _loc17_) - _loc20_) * 0.5641895835477563;
                  _loc21_ = Math.sqrt(_loc16_);
                  _loc16_ = _loc20_ / _loc21_;
               }
               if(_loc28_ <= -1)
               {
                  _loc16_ = -_loc16_;
               }
               §§goto(addr849);
            }
            §§goto(addr188);
         }
         else
         {
            if(uint(_loc27_) <= 1044381695)
            {
               if(!((_loc20_ = _loc17_ + 1e+300) <= 1 | _loc20_ != _loc20_ | false))
               {
                  _loc16_ = _loc17_ * 0.5;
               }
               §§goto(addr849);
            }
            _loc21_ = (_loc21_ = (_loc21_ = (_loc21_ = (_loc21_ = (_loc21_ = (_loc21_ = (_loc21_ = (_loc20_ = _loc17_ * _loc17_) * 4.9672799960958445e-8) + -0.00001599556310840356) * _loc20_) + 0.001407056669551897) * _loc20_) + -0.0625) * _loc20_) * _loc17_;
            _loc20_ = (_loc20_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = _loc20_ * 1.2354227442613791e-11) + 5.0463625707621704e-9) * _loc20_) + 0.0000011771846404262368) * _loc20_) + 0.00018594678558863092) * _loc20_) + 0.019153759953836346) * _loc20_) + 1;
            _loc20_ = _loc21_ / _loc20_;
            _loc16_ = (_loc21_ = _loc17_ * 0.5) + _loc20_;
         }
      }
      addr849:
      st0 = _loc16_;
      ESP = _loc14_ = _loc15_;
   }
}
