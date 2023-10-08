package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI414_0;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_expm1() : void
   {
      var _loc4_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:Number = NaN;
      var _loc3_:* = 0;
      var _loc7_:* = NaN;
      var _loc5_:* = NaN;
      var _loc6_:* = NaN;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 32;
      sf64(_loc6_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      if((uint(_loc10_ = (_loc12_ = li32(_loc3_)) & 2147483647)) >= 1078159482)
      {
         if(uint(_loc10_) >= 1082535490)
         {
            if(uint(_loc10_) >= 2146435072)
            {
               var _loc8_:*;
               if(((_loc8_ = _loc12_ & 1048575) | li32(_loc4_ - 8)) != 0)
               {
                  _loc5_ = _loc6_ + _loc6_;
               }
               else
               {
                  if(_loc12_ <= -1)
                  {
                     _loc6_ = -1;
                  }
                  _loc5_ = _loc6_;
               }
            }
            else
            {
               _loc5_ = inf;
               if(_loc6_ <= 709.782712893384)
               {
                  addr106:
                  if(_loc12_ <= -1)
                  {
                     _loc5_ = -1;
                     if(_loc6_ + 1e-300 >= 0)
                     {
                        addr119:
                        if(uint(_loc10_) >= 1071001155)
                        {
                           if(uint(_loc10_) <= 1072734897)
                           {
                              if(_loc12_ >= 0)
                              {
                                 _loc5_ = _loc6_ + -0.6931471803691238;
                                 _loc7_ = 1.9082149292705877e-10;
                                 _loc12_ = 1;
                              }
                              else
                              {
                                 _loc5_ = _loc6_ + 0.6931471803691238;
                                 _loc7_ = -1.9082149292705877e-10;
                                 _loc12_ = -1;
                              }
                           }
                           else
                           {
                              _loc10_ = 1;
                              if(_loc12_ <= -1)
                              {
                                 _loc10_ = 0;
                              }
                              _loc12_ = 8;
                              if(_loc10_ == 0)
                              {
                                 _loc12_ = 0;
                              }
                              _loc3_ = LCPI414_0 + _loc12_;
                              var _loc9_:* = lf64(_loc3_);
                              var _loc13_:*;
                              _loc5_ = (_loc13_ = (_loc9_ = _loc12_ = _loc9_ = (_loc13_ = _loc6_ * 1.4426950408889634) + _loc9_) * -0.6931471803691238) + _loc6_;
                              _loc7_ = _loc9_ * 1.9082149292705877e-10;
                           }
                           _loc6_ = _loc5_ - _loc7_;
                           _loc11_ = (_loc9_ = _loc5_ - _loc6_) - _loc7_;
                        }
                        else
                        {
                           _loc12_ = 0;
                           if(uint(_loc10_) <= 1016070143)
                           {
                              _loc9_ = _loc6_ + 1e+300;
                              _loc5_ = _loc6_ - (_loc9_ - _loc9_);
                           }
                           §§goto(addr620);
                        }
                        _loc9_ = _loc6_ * 0.5;
                        _loc9_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc5_ = _loc6_ * _loc9_) * -2.0109921818362437e-7) + 0.000004008217827329362) * _loc5_) + -0.0000793650757867488) * _loc5_) + 0.0015873015872548146) * _loc5_) + -0.03333333333333313) * _loc5_) + 1) * _loc9_;
                        var _loc1_:Number = 3 - _loc9_;
                        _loc9_ = _loc13_ - _loc1_;
                        _loc13_ = _loc6_ * _loc1_;
                        _loc13_ = 6 - _loc13_;
                        _loc7_ = (_loc9_ /= _loc13_) * _loc5_;
                        if(_loc12_ == 0)
                        {
                           _loc5_ = _loc6_ - ((_loc9_ = _loc6_ * _loc7_) - _loc5_);
                        }
                        else
                        {
                           si32(_loc8_ = (_loc8_ = _loc12_ << 20) + 1072693248,_loc4_ - 16 | 4);
                           si32(0,_loc4_ - 16);
                           _loc5_ = (_loc9_ = (_loc9_ = (_loc9_ = _loc7_ - _loc11_) * _loc6_) - _loc11_) - _loc5_;
                           if(_loc12_ != 1)
                           {
                              if(_loc12_ == -1)
                              {
                                 _loc5_ = (_loc9_ = (_loc9_ = _loc6_ - _loc5_) * 0.5) + -0.5;
                              }
                              else
                              {
                                 _loc7_ = lf64(_loc4_ - 16);
                                 if(uint(_loc12_ + 1) >= 58)
                                 {
                                    _loc6_ = 1 - (_loc5_ - _loc6_);
                                    if(_loc12_ == 1024)
                                    {
                                       _loc6_ = (_loc9_ = _loc6_ + _loc6_) * 8.98846567431158e+307;
                                    }
                                    else
                                    {
                                       _loc6_ *= _loc7_;
                                    }
                                    _loc5_ = _loc6_ + -1;
                                 }
                                 else
                                 {
                                    if(_loc12_ <= 19)
                                    {
                                       si32(1072693248 - (2097152 >>> _loc12_),(_loc8_ = _loc4_ - 32) | 4);
                                       si32(0,_loc4_ - 32);
                                       _loc6_ = (_loc13_ = lf64(_loc4_ - 32)) - (_loc5_ - _loc6_);
                                    }
                                    else
                                    {
                                       si32(_loc8_ = (_loc8_ = 1023 - _loc12_) << 20,_loc4_ - 24 | 4);
                                       si32(0,_loc4_ - 24);
                                       _loc6_ = (_loc9_ = _loc6_ - (_loc5_ + lf64(_loc4_ - 24))) + 1;
                                    }
                                    _loc5_ = _loc6_ * _loc7_;
                                 }
                              }
                           }
                           else if(!(_loc6_ >= -0.25 | _loc6_ != _loc6_ | false))
                           {
                              _loc5_ = (_loc9_ = _loc5_ - (_loc6_ + 0.5)) * -2;
                           }
                           else
                           {
                              _loc9_ = _loc6_ - _loc5_;
                              _loc5_ = (_loc9_ += _loc9_) + 1;
                           }
                        }
                     }
                  }
                  §§goto(addr119);
               }
            }
            addr620:
            st0 = _loc5_;
            _loc2_ = _loc4_;
            ESP = _loc2_;
            return;
         }
         §§goto(addr106);
      }
      §§goto(addr119);
   }
}
