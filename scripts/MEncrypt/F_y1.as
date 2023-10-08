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
   
   public function F_y1() : void
   {
      var _loc7_:int = 0;
      var _loc12_:* = NaN;
      var _loc19_:* = 0;
      var _loc17_:* = 0;
      var _loc14_:Number = NaN;
      var _loc20_:Number = NaN;
      var _loc1_:Number = NaN;
      var _loc11_:int = 0;
      var _loc13_:int = 0;
      var _loc15_:int = 0;
      var _loc8_:int = 0;
      var _loc9_:int = 0;
      var _loc16_:Number = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 16;
      sf64(_loc12_ = lf64(_loc7_),_loc7_ - 8);
      var _loc6_:*;
      if((uint(_loc17_ = (_loc19_ = li32(_loc6_ = (_loc6_ = _loc7_ - 8) | 4)) & 2147483647)) >= 2146435072)
      {
         var _loc10_:Number;
         _loc16_ = 1 / ((_loc10_ = _loc12_ * _loc12_) + _loc12_);
      }
      else
      {
         _loc16_ = -inf;
         if((_loc17_ | li32(_loc7_ - 8)) != 0)
         {
            _loc16_ = nan;
            if(_loc19_ >= 0)
            {
               if(uint(_loc17_) >= 1073741824)
               {
                  _loc14_ = Math.sin(_loc12_);
                  _loc20_ = Math.cos(_loc12_);
                  _loc16_ = (_loc10_ = -_loc14_) - _loc20_;
                  if(uint(_loc17_) <= 2145386495)
                  {
                     var _loc18_:* = _loc14_ * _loc20_;
                     _loc1_ = Math.cos(_loc12_ + _loc12_);
                     if(!(_loc18_ <= 0 | _loc18_ != _loc18_ | false))
                     {
                        _loc20_ = _loc1_ / _loc16_;
                     }
                     else
                     {
                        _loc20_ = _loc14_ - _loc20_;
                        _loc16_ = _loc1_ / _loc20_;
                     }
                     if(uint(_loc17_) < 1207959553)
                     {
                        _loc15_ = _ps8;
                        _loc13_ = _pr8;
                        if(uint(_loc17_) <= 1075838975)
                        {
                           _loc15_ = _ps5;
                           _loc13_ = _pr5;
                           if(uint(_loc17_) <= 1074933386)
                           {
                              _loc11_ = 1;
                              if(uint(_loc17_) >= 1073741824)
                              {
                                 _loc11_ = 0;
                              }
                              _loc15_ = _ps3;
                              _loc13_ = _pr3;
                              if(uint(_loc17_) <= 1074191212)
                              {
                                 if(_loc11_ == 0)
                                 {
                                    _loc15_ = _ps2;
                                    _loc13_ = _pr2;
                                 }
                              }
                           }
                        }
                        _loc9_ = _qs8;
                        _loc8_ = _qr8;
                        if(uint(_loc17_) <= 1075838975)
                        {
                           _loc9_ = _qs5;
                           _loc8_ = _qr5;
                           if(uint(_loc17_) <= 1074933386)
                           {
                              _loc11_ = 1;
                              if(uint(_loc17_) >= 1073741824)
                              {
                                 _loc11_ = 0;
                              }
                              _loc9_ = _qs3;
                              _loc8_ = _qr3;
                              if(uint(_loc17_) <= 1074191212)
                              {
                                 if(_loc11_ == 0)
                                 {
                                    _loc9_ = _qs2;
                                    _loc8_ = _qr2;
                                 }
                              }
                           }
                        }
                        _loc18_ = lf64(_loc13_ + 40);
                        _loc10_ = _loc12_ * _loc12_;
                        _loc10_ = 1 / _loc10_;
                        var _loc2_:* = _loc18_ * _loc10_;
                        _loc2_ = (_loc18_ = (_loc18_ = lf64(_loc13_ + 32)) + _loc2_) * _loc10_;
                        _loc18_ = (_loc18_ = (_loc18_ = lf64(_loc13_ + 24)) + _loc2_) * _loc10_;
                        _loc2_ = lf64(_loc13_ + 16);
                        _loc18_ = (_loc18_ = _loc2_ + _loc18_) * _loc10_;
                        _loc2_ = lf64(_loc13_ + 8);
                        _loc18_ = (_loc18_ = _loc2_ + _loc18_) * _loc10_;
                        _loc2_ = lf64(_loc13_);
                        _loc18_ = _loc2_ + _loc18_;
                        _loc2_ = lf64(_loc15_ + 32);
                        var _loc3_:* = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc15_ + 24);
                        _loc2_ += _loc3_;
                        _loc3_ = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc15_ + 16);
                        _loc2_ += _loc3_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc15_ + 8);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc3_ = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc15_);
                        _loc2_ += _loc3_;
                        _loc2_ *= _loc10_;
                        _loc2_ += 1;
                        _loc18_ = (_loc18_ /= _loc2_) + 1;
                        _loc2_ = lf64(_loc8_ + 40);
                        _loc3_ = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc8_ + 32);
                        _loc2_ += _loc3_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc8_ + 24);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc8_ + 16);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc8_ + 8);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc8_);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc3_ = lf64(_loc9_ + 40);
                        var _loc4_:* = _loc3_ * _loc10_;
                        _loc3_ = lf64(_loc9_ + 32);
                        _loc3_ += _loc4_;
                        _loc4_ = _loc3_ * _loc10_;
                        _loc3_ = lf64(_loc9_ + 24);
                        _loc3_ += _loc4_;
                        _loc4_ = _loc3_ * _loc10_;
                        _loc3_ = lf64(_loc9_ + 16);
                        _loc3_ += _loc4_;
                        _loc4_ = _loc3_ * _loc10_;
                        _loc3_ = lf64(_loc9_ + 8);
                        _loc3_ += _loc4_;
                        _loc3_ *= _loc10_;
                        _loc3_ = (_loc4_ = lf64(_loc9_)) + _loc3_;
                        _loc10_ = (_loc10_ = _loc3_ * _loc10_) + 1;
                        _loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = _loc2_ / _loc10_) + 0.375) / _loc12_) * _loc20_;
                        _loc10_ = (_loc10_ = (_loc18_ *= _loc16_) + _loc10_) * 0.5641895835477563;
                        _loc18_ = Math.sqrt(_loc12_);
                        _loc16_ = _loc10_ / _loc18_;
                     }
                     §§goto(addr834);
                  }
                  _loc18_ = Math.sqrt(_loc12_);
                  _loc16_ = (_loc10_ = _loc16_ * 0.5641895835477563) / _loc18_;
               }
               else if(uint(_loc17_) <= 1016070144)
               {
                  _loc16_ = -0.6366197723675814 / _loc12_;
               }
               else
               {
                  _loc5_ -= 16;
                  sf64(_loc12_,_loc5_);
                  ESP = _loc5_;
                  F_j1();
                  _loc5_ += 16;
                  _loc5_ -= 16;
                  sf64(_loc12_,_loc5_);
                  _loc18_ = (_loc18_ = (((((_loc18_ = _loc12_ * _loc12_) * -9.190991580398789e-8 + 0.00002352526005616105) * _loc18_ + -0.0019125689587576355) * _loc18_ + 0.05044387166398113) * _loc18_ + -0.19605709064623894) / ((_loc18_ = ((((_loc18_ * 1.6655924620799208e-11 + 6.227414523646215e-9) * _loc18_ + 0.0000013560880109751623) * _loc18_ + 0.00020255258102513517) * _loc18_ + 0.01991673182366499) * _loc18_) + 1)) * _loc12_;
                  ESP = _loc5_;
                  F_log();
                  _loc5_ += 16;
                  _loc16_ = _loc18_ + (_loc10_ = st0 * st0 + -1 / _loc12_) * 0.6366197723675814;
               }
            }
         }
      }
      addr834:
      st0 = _loc16_;
      ESP = _loc5_ = _loc7_;
   }
}
