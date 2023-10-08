package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._atanhi;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._atanlo;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_atan() : void
   {
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = NaN;
      var _loc1_:Number = NaN;
      var _loc12_:Number = NaN;
      var _loc3_:* = 0;
      var _loc9_:int = 0;
      var _loc6_:* = NaN;
      var _loc2_:int = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 8;
      sf64(_loc6_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      if((uint(_loc11_ = (_loc13_ = li32(_loc3_)) & 2147483647)) >= 1141899264)
      {
         if(uint(_loc11_) <= 2146435072)
         {
            if(_loc11_ == 2146435072)
            {
               if(li32(_loc4_ - 8) != 0)
               {
                  addr76:
                  _loc6_ += _loc6_;
               }
               §§goto(addr406);
            }
            _loc5_ = lf64(_atanlo + 24);
            if(_loc13_ >= 1)
            {
               _loc6_ = _loc5_ + 1.5707963267948966;
            }
            else
            {
               _loc6_ = -1.5707963267948966 - _loc5_;
            }
            §§goto(addr406);
            ESP = _loc2_;
            return;
         }
         §§goto(addr76);
      }
      else
      {
         if(uint(_loc11_) <= 1071382527)
         {
            _loc9_ = -1;
            if(uint(_loc11_) <= 1042284543)
            {
               _loc9_ = -1;
               if(_loc6_ + 1e+300 <= 1)
               {
               }
               §§goto(addr76);
            }
         }
         else
         {
            if(!(_loc6_ >= 0 | _loc6_ != _loc6_ | false))
            {
               _loc6_ = -_loc6_;
            }
            if(uint(_loc11_) <= 1072889855)
            {
               if(uint(_loc11_) <= 1072037887)
               {
                  var _loc8_:Number;
                  _loc6_ = (_loc8_ = (_loc8_ = _loc6_ + _loc6_) + -1) / (_loc6_ + 2);
                  _loc9_ = 0;
               }
               else
               {
                  _loc6_ = (_loc8_ = _loc6_ + -1) / (_loc6_ + 1);
                  _loc9_ = 1;
               }
            }
            else if(uint(_loc11_) <= 1073971199)
            {
               _loc6_ = (_loc6_ + -1.5) / ((_loc8_ = _loc6_ * 1.5) + 1);
               _loc9_ = 2;
            }
            else
            {
               _loc6_ = -1 / _loc6_;
               _loc9_ = 3;
            }
         }
         var _loc10_:* = _loc6_ * _loc6_;
         var _loc14_:Number;
         _loc12_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc8_ = _loc10_ * _loc10_) * -0.036531572744216916) + -0.058335701337905735) * _loc8_) + -0.0769187620504483) * _loc8_) + -0.11111110405462356) * _loc8_) + -0.19999999999876483) * _loc8_;
         _loc1_ = (_loc8_ = (_loc8_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = (_loc14_ = _loc8_ * 0.016285820115365782) + 0.049768779946159324) * _loc8_) + 0.06661073137387531) * _loc8_) + 0.09090887133436507) * _loc8_) + 0.14285714272503466) * _loc8_) + 0.3333333333333293) * _loc10_;
         if(_loc9_ <= -1)
         {
            _loc6_ -= (_loc10_ = _loc1_ + _loc12_) * _loc6_;
         }
         else
         {
            _loc3_ = _loc9_ << 3;
            var _loc7_:int;
            _loc6_ = (_loc10_ = lf64(_atanhi + _loc3_)) - ((_loc8_ = (_loc10_ = _loc1_ + _loc12_) * _loc6_ - lf64(_loc7_ = _atanlo + _loc3_)) - _loc6_);
            if(_loc13_ <= -1)
            {
               _loc6_ = -_loc6_;
            }
         }
      }
      §§goto(addr76);
   }
}
