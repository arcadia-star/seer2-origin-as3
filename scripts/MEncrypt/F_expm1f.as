package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI415_0;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_expm1f() : void
   {
      var _loc7_:int = 0;
      var _loc14_:* = NaN;
      var _loc8_:* = NaN;
      var _loc19_:* = NaN;
      var _loc16_:* = NaN;
      var _loc1_:* = NaN;
      var _loc9_:* = NaN;
      var _loc20_:* = 0;
      var _loc6_:* = 0;
      var _loc21_:* = NaN;
      var _loc2_:* = NaN;
      var _loc10_:* = NaN;
      var _loc4_:* = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 16;
      _loc2_ = lf32(_loc7_);
      sf32(_loc2_,_loc7_ - 4);
      if((uint(_loc20_ = (_loc6_ = li32(_loc7_ - 4)) & 2147483647)) >= 1100331076)
      {
         if(uint(_loc20_) >= 1118925336)
         {
            if(uint(_loc20_) >= 2139095041)
            {
               var _loc11_:* = _loc2_;
               _loc4_ = _loc11_ += _loc11_;
            }
            else if(_loc20_ == 2139095040)
            {
               _loc9_ = _loc2_;
               if(_loc6_ <= -1)
               {
                  _loc9_ = -1;
               }
               _loc4_ = _loc9_;
            }
            else
            {
               _loc4_ = inf;
               var _loc18_:*;
               if(_loc2_ <= (_loc18_ = 88.7216796875))
               {
                  addr107:
                  if(_loc6_ <= -1)
                  {
                     _loc4_ = -1;
                     if((_loc11_ = _loc2_ + (_loc18_ = 1.0000000031710769e-30)) >= (_loc18_ = 0))
                     {
                        addr126:
                        if(uint(_loc20_) >= 1051816473)
                        {
                           if(uint(_loc20_) <= 1065686417)
                           {
                              if(_loc6_ >= 0)
                              {
                                 _loc2_ = _loc11_ = _loc2_ + (_loc18_ = -0.6931381225585938);
                                 _loc21_ = 0.00000905800061445916;
                                 _loc6_ = 1;
                              }
                              else
                              {
                                 _loc2_ = _loc11_ = _loc2_ + (_loc18_ = 0.6931381225585938);
                                 _loc21_ = -0.00000905800061445916;
                                 _loc6_ = -1;
                              }
                           }
                           else
                           {
                              _loc20_ = 1;
                              if(_loc6_ <= -1)
                              {
                                 _loc20_ = 0;
                              }
                              _loc6_ = 4;
                              if(_loc20_ == 0)
                              {
                                 _loc6_ = 0;
                              }
                              var _loc17_:*;
                              var _loc15_:* = lf32(_loc17_ = LCPI415_0 + _loc6_);
                              _loc11_ = _loc2_;
                              var _loc13_:*;
                              var _loc12_:* = _loc13_ = 1.4426950216293335;
                              _loc15_ = _loc18_ = _loc6_ = _loc18_ = _loc15_ = (_loc12_ = _loc13_ = _loc12_ = _loc11_ * _loc12_) + _loc15_;
                              _loc12_ = _loc13_ = 0.00000905800061445916;
                              _loc21_ = _loc12_ = _loc15_ * _loc12_;
                              _loc12_ = _loc13_ = -0.6931381225585938;
                              _loc2_ = _loc11_ = (_loc15_ = _loc18_ = _loc15_ *= _loc12_) + _loc11_;
                           }
                           _loc11_ = _loc21_;
                           _loc2_ = _loc12_ = (_loc15_ = _loc2_) - _loc11_;
                           _loc12_ = _loc2_;
                           _loc14_ = _loc11_ = (_loc15_ = _loc18_ = _loc15_ -= _loc12_) - _loc11_;
                        }
                        else
                        {
                           _loc6_ = 0;
                           if(uint(_loc20_) <= 855638015)
                           {
                              _loc15_ = _loc18_ = 1.0000000150474662e+30;
                              _loc15_ = _loc18_ = _loc15_ = _loc2_ + _loc15_;
                              _loc4_ = _loc11_ = _loc2_ - (_loc18_ = _loc15_ -= _loc15_);
                           }
                           §§goto(addr809);
                        }
                        _loc19_ = _loc2_;
                        var _loc3_:* = 0.5;
                        _loc16_ = _loc3_;
                        _loc3_ = _loc11_ = _loc19_ * _loc16_;
                        _loc11_ = _loc3_;
                        _loc1_ = _loc18_ = _loc15_ = _loc19_ * _loc11_;
                        _loc15_ = _loc18_ = 0.0015807170420885086;
                        _loc15_ = _loc18_ = _loc15_ = _loc1_ * _loc15_;
                        _loc12_ = _loc13_ = -0.03333321213722229;
                        _loc12_ = _loc18_ = _loc15_ = (_loc15_ = _loc18_ = _loc15_ += _loc12_) * _loc1_;
                        _loc9_ = _loc18_ = 1;
                        _loc3_ = _loc11_ = (_loc15_ = _loc18_ = _loc15_ = _loc12_ + _loc9_) * _loc11_;
                        _loc11_ = _loc3_;
                        _loc3_ = _loc11_ = (_loc12_ = _loc13_ = 3) - _loc11_;
                        _loc12_ = _loc3_;
                        _loc3_ = _loc11_ = _loc15_ - _loc12_;
                        _loc11_ = _loc3_;
                        _loc15_ = _loc18_ = _loc15_ = _loc19_ * _loc12_;
                        _loc15_ = _loc18_ = _loc15_ = (_loc12_ = _loc13_ = 6) - _loc15_;
                        _loc3_ = _loc11_ /= _loc15_;
                        _loc8_ = _loc11_ = (_loc11_ = _loc3_) * _loc1_;
                        if(_loc6_ == 0)
                        {
                           _loc4_ = _loc11_ = _loc19_ - (_loc11_ = (_loc11_ = _loc11_ = _loc19_ * _loc8_) - _loc1_);
                        }
                        else
                        {
                           si32(_loc17_ = (_loc17_ = _loc6_ << 23) + 1065353216,_loc7_ - 8);
                           _loc11_ = _loc14_;
                           _loc14_ = _loc11_ = (_loc11_ = _loc11_ = (_loc15_ = _loc18_ = _loc15_ = (_loc15_ = _loc18_ = _loc15_ = (_loc15_ = _loc8_) - _loc11_) * _loc19_) - _loc11_) - _loc1_;
                           if(_loc6_ != 1)
                           {
                              if(_loc6_ == -1)
                              {
                                 _loc4_ = _loc11_ = (_loc11_ = (_loc11_ = _loc11_ = _loc19_ - _loc14_) * _loc16_) + (_loc18_ = -0.5);
                              }
                              else
                              {
                                 _loc4_ = lf32(_loc7_ - 8);
                                 if((uint(_loc17_ = _loc6_ + 1)) >= 58)
                                 {
                                    _loc2_ = _loc11_ = _loc9_ - (_loc11_ = (_loc11_ = _loc14_) - _loc19_);
                                    if(_loc6_ == 128)
                                    {
                                       _loc15_ = _loc2_;
                                       _loc10_ = _loc11_ = (_loc15_ = _loc18_ = _loc15_ += _loc15_) * 1.7014118346046923e+38;
                                    }
                                    else
                                    {
                                       _loc10_ = _loc11_ = (_loc15_ = _loc2_) * _loc4_;
                                    }
                                    _loc11_ = _loc10_;
                                    _loc15_ = _loc18_ = -1;
                                    _loc4_ = _loc11_ += _loc15_;
                                 }
                                 else
                                 {
                                    if(_loc6_ <= 22)
                                    {
                                       si32(_loc17_ = 1065353216 - (16777216 >>> _loc6_),_loc7_ - 16);
                                       _loc10_ = _loc11_ = (_loc15_ = lf32(_loc7_ - 16)) - (_loc11_ = (_loc11_ = _loc14_) - _loc19_);
                                    }
                                    else
                                    {
                                       si32(_loc17_ = (_loc17_ = 127 - _loc6_) << 23,_loc7_ - 12);
                                       _loc10_ = _loc11_ = (_loc11_ = _loc11_ = _loc19_ - (_loc11_ = _loc14_ + lf32(_loc7_ - 12))) + _loc9_;
                                    }
                                    _loc11_ = _loc4_;
                                    _loc4_ = _loc11_ = (_loc15_ = _loc10_) * _loc11_;
                                 }
                              }
                           }
                           else
                           {
                              _loc11_ = -0.25;
                              if(!(_loc19_ >= _loc11_ | _loc19_ != _loc19_ | _loc11_ != _loc11_))
                              {
                                 _loc4_ = _loc11_ = (_loc11_ = (_loc11_ = _loc14_) - (_loc11_ = _loc19_ + _loc16_)) * (_loc18_ = -2);
                              }
                              else
                              {
                                 _loc11_ = _loc11_ = _loc19_ - _loc14_;
                                 _loc4_ = _loc11_ = (_loc11_ = _loc11_ += _loc11_) + _loc9_;
                              }
                           }
                        }
                     }
                  }
                  §§goto(addr126);
               }
            }
            addr809:
            st0 = _loc4_;
            ESP = _loc5_ = _loc7_;
            return;
         }
         §§goto(addr107);
      }
      §§goto(addr126);
   }
}
