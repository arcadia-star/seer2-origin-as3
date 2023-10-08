package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._halF;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ln2HI;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ln2LO;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._twom1000;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_exp() : void
   {
      var _loc4_:* = 0;
      var _loc6_:* = NaN;
      var _loc13_:* = 0;
      var _loc11_:Number = NaN;
      var _loc1_:Number = NaN;
      var _loc3_:* = 0;
      var _loc14_:* = NaN;
      var _loc5_:* = NaN;
      var _loc9_:* = 0;
      var _loc12_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc6_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      _loc12_ = (_loc13_ = li32(_loc3_)) & 2147483647;
      _loc9_ = _loc13_ >>> 31;
      if(uint(_loc12_) >= 1082535490)
      {
         if(uint(_loc12_) >= 2146435072)
         {
            var _loc7_:*;
            if(((_loc7_ = _loc13_ & 1048575) | li32(_loc4_ - 8)) != 0)
            {
               _loc5_ = _loc6_ + _loc6_;
            }
            else
            {
               if(_loc9_ != 0)
               {
                  _loc6_ = 0;
               }
               _loc5_ = _loc6_;
            }
         }
         else
         {
            _loc5_ = inf;
            if(_loc6_ <= 709.782712893384)
            {
               if(!(_loc6_ >= -745.1332191019411 | _loc6_ != _loc6_ | false))
               {
                  _loc5_ = lf64(_twom1000) * lf64(_twom1000);
               }
               else
               {
                  addr131:
                  if(uint(_loc12_) >= 1071001155)
                  {
                     if(uint(_loc12_) <= 1072734897)
                     {
                        _loc7_ = _loc9_ << 3;
                        _loc5_ = lf64(_ln2LO + _loc7_);
                        _loc14_ = lf64(_ln2HI + _loc7_);
                        _loc9_ = 0 - _loc9_ | 1;
                     }
                     else
                     {
                        var _loc8_:Number;
                        _loc5_ = (_loc8_ = _loc9_ = _loc8_ = (_loc8_ = _loc6_ * 1.4426950408889634) + lf64(_halF + (_loc9_ << 3))) * 1.9082149292705877e-10;
                        _loc14_ = _loc8_ * 0.6931471803691238;
                     }
                     _loc6_ = (_loc14_ = _loc6_ - _loc14_) - _loc5_;
                  }
                  else
                  {
                     _loc9_ = 0;
                     _loc14_ = _loc5_ = 0;
                     if(uint(_loc12_) <= 1043333119)
                     {
                        _loc8_ = _loc6_ + 1e+300;
                        _loc9_ = 0;
                        _loc14_ = _loc5_ = 0;
                        if(!(_loc8_ <= 1 | _loc8_ != _loc8_ | false))
                        {
                           _loc5_ = _loc6_ + 1;
                        }
                        §§goto(addr436);
                     }
                  }
                  _loc12_ = 1072693248;
                  if(_loc9_ <= -1022)
                  {
                     _loc12_ = 2121269248;
                  }
                  _loc3_ = _loc9_ << 20;
                  _loc3_ = _loc12_ + _loc3_;
                  _loc7_ = (_loc7_ = _loc4_ - 16) | 4;
                  si32(_loc3_,_loc7_);
                  si32(0,_loc4_ - 16);
                  var _loc10_:Number;
                  _loc8_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc8_ = _loc6_ * _loc6_) * 4.1381367970572385e-8) + -0.0000016533902205465252) * _loc8_) + 0.00006613756321437934) * _loc8_) + -0.0027777777777015593) * _loc8_) + 0.16666666666666602) * _loc8_;
                  _loc11_ = _loc6_ - _loc8_;
                  _loc1_ = _loc6_ * _loc11_;
                  if(_loc9_ == 0)
                  {
                     _loc5_ = 1 - ((_loc8_ = _loc1_ / (_loc11_ + -2)) - _loc6_);
                  }
                  else
                  {
                     _loc6_ = lf64(_loc4_ - 16);
                     _loc5_ = 1 - ((_loc8_ = _loc5_ - _loc1_ / (2 - _loc11_)) - _loc14_);
                     if(_loc9_ >= -1021)
                     {
                        if(_loc9_ == 1024)
                        {
                           _loc5_ = (_loc8_ = _loc5_ + _loc5_) * 8.98846567431158e+307;
                        }
                        else
                        {
                           _loc5_ *= _loc6_;
                        }
                     }
                     else
                     {
                        _loc5_ = _loc5_ * _loc6_ * lf64(_twom1000);
                     }
                  }
               }
            }
         }
         addr436:
         st0 = _loc5_;
         _loc2_ = _loc4_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr131);
   }
}
