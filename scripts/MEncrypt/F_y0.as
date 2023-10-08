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
   
   public function F_y0() : void
   {
      var _loc7_:int = 0;
      var _loc12_:* = NaN;
      var _loc19_:* = 0;
      var _loc17_:* = 0;
      var _loc1_:Number = NaN;
      var _loc14_:Number = NaN;
      var _loc20_:Number = NaN;
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
                  _loc16_ = Math.cos(_loc12_);
                  _loc20_ = _loc14_ - _loc16_;
                  if(uint(_loc17_) <= 2145386495)
                  {
                     _loc10_ = _loc14_ * _loc16_;
                     var _loc18_:*;
                     _loc1_ = -(_loc18_ = Math.cos(_loc12_ + _loc12_));
                     if(!(_loc10_ >= 0 | _loc10_ != _loc10_ | false))
                     {
                        _loc16_ = _loc1_ / _loc20_;
                     }
                     else
                     {
                        _loc16_ = _loc14_ + _loc16_;
                        _loc20_ = _loc1_ / _loc16_;
                     }
                     if(uint(_loc17_) < 1207959553)
                     {
                        _loc15_ = _pS8;
                        _loc13_ = _pR8;
                        if(uint(_loc17_) <= 1075838975)
                        {
                           _loc15_ = _pS5;
                           _loc13_ = _pR5;
                           if(uint(_loc17_) <= 1074933386)
                           {
                              _loc11_ = 1;
                              if(uint(_loc17_) >= 1073741824)
                              {
                                 _loc11_ = 0;
                              }
                              _loc15_ = _pS3;
                              _loc13_ = _pR3;
                              if(uint(_loc17_) <= 1074191212)
                              {
                                 if(_loc11_ == 0)
                                 {
                                    _loc15_ = _pS2;
                                    _loc13_ = _pR2;
                                 }
                              }
                           }
                        }
                        _loc9_ = _qS8;
                        _loc8_ = _qR8;
                        if(uint(_loc17_) <= 1075838975)
                        {
                           _loc9_ = _qS5;
                           _loc8_ = _qR5;
                           if(uint(_loc17_) <= 1074933386)
                           {
                              _loc11_ = 1;
                              if(uint(_loc17_) >= 1073741824)
                              {
                                 _loc11_ = 0;
                              }
                              _loc9_ = _qS3;
                              _loc8_ = _qR3;
                              if(uint(_loc17_) <= 1074191212)
                              {
                                 if(_loc11_ == 0)
                                 {
                                    _loc9_ = _qS2;
                                    _loc8_ = _qR2;
                                 }
                              }
                           }
                        }
                        _loc18_ = lf64(_loc13_ + 40);
                        _loc10_ = _loc12_ * _loc12_;
                        _loc10_ = 1 / _loc10_;
                        _loc18_ *= _loc10_;
                        var _loc2_:* = lf64(_loc13_ + 32);
                        _loc18_ = (_loc18_ = _loc2_ + _loc18_) * _loc10_;
                        _loc2_ = lf64(_loc13_ + 24);
                        _loc2_ = (_loc18_ = _loc2_ + _loc18_) * _loc10_;
                        _loc2_ = (_loc18_ = (_loc18_ = lf64(_loc13_ + 16)) + _loc2_) * _loc10_;
                        _loc2_ = (_loc18_ = (_loc18_ = lf64(_loc13_ + 8)) + _loc2_) * _loc10_;
                        _loc18_ = (_loc18_ = lf64(_loc13_)) + _loc2_;
                        _loc2_ = lf64(_loc15_ + 32);
                        _loc2_ *= _loc10_;
                        var _loc3_:* = lf64(_loc15_ + 24);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc15_ + 16);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc15_ + 8);
                        _loc2_ = _loc3_ + _loc2_;
                        _loc2_ *= _loc10_;
                        _loc3_ = lf64(_loc15_);
                        _loc2_ = _loc3_ + _loc2_;
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
                        _loc3_ = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc8_ + 16);
                        _loc2_ += _loc3_;
                        _loc3_ = _loc2_ * _loc10_;
                        _loc2_ = lf64(_loc8_ + 8);
                        _loc2_ += _loc3_;
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
                        _loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = _loc2_ / _loc10_) + -0.125) / _loc12_) * _loc16_;
                        _loc10_ = (_loc10_ = (_loc18_ *= _loc20_) + _loc10_) * 0.5641895835477563;
                        _loc18_ = Math.sqrt(_loc12_);
                        _loc16_ = _loc10_ / _loc18_;
                     }
                     §§goto(addr859);
                  }
                  _loc18_ = Math.sqrt(_loc12_);
                  _loc16_ = (_loc10_ = _loc20_ * 0.5641895835477563) / _loc18_;
               }
               else if(uint(_loc17_) <= 1044381696)
               {
                  _loc5_ -= 16;
                  sf64(_loc12_,_loc5_);
                  ESP = _loc5_;
                  F_log();
                  _loc5_ += 16;
                  _loc16_ = (_loc10_ = (_loc10_ = st0) * 0.6366197723675814) + -0.07380429510868723;
               }
               else
               {
                  _loc5_ -= 16;
                  sf64(_loc12_,_loc5_);
                  ESP = _loc5_;
                  F_j0();
                  _loc5_ += 16;
                  _loc5_ -= 16;
                  sf64(_loc12_,_loc5_);
                  _loc18_ = (_loc18_ = (_loc18_ = (((((_loc18_ * -3.982051941321034e-11 + 1.9559013703502292e-8) * _loc18_ + -0.0000038140705372436416) * _loc18_ + 0.00034745343209368365) * _loc18_ + -0.01381856719455969) * _loc18_ + 0.17666645250918112) * _loc18_) + -0.07380429510868723) / (((((_loc18_ = _loc12_ * _loc12_) * 4.4111031133267547e-10 + 2.591508518404578e-7) * _loc18_ + 0.00007600686273503533) * _loc18_ + 0.01273048348341237) * _loc18_ + 1);
                  ESP = _loc5_;
                  F_log();
                  _loc5_ += 16;
                  _loc16_ = _loc18_ + (_loc10_ = st0 * st0) * 0.6366197723675814;
               }
            }
         }
      }
      addr859:
      st0 = _loc16_;
      ESP = _loc5_ = _loc7_;
   }
}
