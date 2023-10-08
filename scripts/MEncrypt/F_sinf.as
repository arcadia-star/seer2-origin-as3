package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI504_0;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI504_1;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_sinf() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = NaN;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 32;
      _loc1_ = lf32(_loc5_);
      sf32(_loc1_,_loc5_ - 20);
      if((uint(_loc13_ = (_loc4_ = li32(_loc5_ - 20)) & 2147483647)) <= 1061752794)
      {
         if(uint(_loc13_) <= 964689919)
         {
            var _loc11_:int;
            if((_loc11_ = _loc1_) != 0)
            {
            }
            §§goto(addr997);
         }
         var _loc7_:* = _loc1_;
         var _loc6_:Number;
         var _loc10_:* = (_loc6_ = _loc7_ * _loc7_) * _loc7_;
         var _loc8_:Number = _loc6_ * _loc6_;
         _loc8_ = _loc10_ * _loc8_;
         var _loc14_:Number = (_loc14_ = _loc6_ * 0.000002718311493989822) + -0.00019839334836096632;
         _loc8_ *= _loc14_;
         _loc1_ = _loc7_ = (_loc7_ = (_loc10_ = (_loc6_ = (_loc6_ *= 0.008333329385889463) + -0.16666666641626524) * _loc10_) + _loc7_) + _loc8_;
      }
      else if(uint(_loc13_) <= 1081824209)
      {
         if(uint(_loc13_) <= 1075235811)
         {
            _loc12_ = _loc1_;
            if(_loc4_ >= 1)
            {
               _loc7_ = _loc12_ + -1.5707963267948966;
               _loc7_ *= _loc7_;
               _loc8_ = _loc7_ * _loc7_;
               _loc1_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc7_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc7_ * ((_loc6_ = _loc7_ * 0.00002439044879627741) + -0.001388676377460993);
            }
            else
            {
               _loc7_ = _loc12_ + 1.5707963267948966;
               _loc7_ *= _loc7_;
               _loc8_ = _loc7_ * _loc7_;
               _loc1_ = _loc7_ = -(_loc7_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc7_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc7_ * ((_loc6_ = _loc7_ * 0.00002439044879627741) + -0.001388676377460993));
            }
         }
         else
         {
            _loc13_ = 1;
            if(_loc4_ <= 0)
            {
               _loc13_ = 0;
            }
            _loc4_ = 8;
            if(_loc13_ == 0)
            {
               _loc4_ = 0;
            }
            _loc10_ = lf64(_loc11_ = LCPI504_1 + _loc4_);
            _loc7_ = _loc1_;
            _loc7_ = _loc10_ - _loc7_;
            _loc10_ = (_loc8_ = _loc7_ * _loc7_) * _loc7_;
            _loc6_ = _loc8_ * _loc8_;
            _loc6_ = _loc10_ * _loc6_;
            _loc14_ = (_loc14_ = _loc8_ * 0.000002718311493989822) + -0.00019839334836096632;
            _loc6_ *= _loc14_;
            _loc1_ = _loc7_ = (_loc7_ = (_loc10_ = (_loc8_ = (_loc8_ *= 0.008333329385889463) + -0.16666666641626524) * _loc10_) + _loc7_) + _loc6_;
         }
      }
      else if(uint(_loc13_) <= 1088565717)
      {
         if(uint(_loc13_) <= 1085271519)
         {
            _loc12_ = _loc1_;
            if(_loc4_ >= 1)
            {
               _loc7_ = _loc12_ + -4.71238898038469;
               _loc10_ = _loc7_ * _loc7_;
               _loc8_ = _loc10_ * _loc10_;
               _loc1_ = _loc7_ = -(_loc7_ = _loc7_ = (_loc10_ = (_loc10_ = (_loc10_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc10_ * ((_loc6_ = _loc10_ * 0.00002439044879627741) + -0.001388676377460993));
            }
            else
            {
               _loc7_ = _loc12_ + 4.71238898038469;
               _loc7_ *= _loc7_;
               _loc8_ = _loc7_ * _loc7_;
               _loc1_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc7_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc7_ * ((_loc6_ = _loc7_ * 0.00002439044879627741) + -0.001388676377460993);
            }
         }
         else
         {
            _loc13_ = 1;
            if(_loc4_ <= 0)
            {
               _loc13_ = 0;
            }
            _loc4_ = 8;
            if(_loc13_ == 0)
            {
               _loc4_ = 0;
            }
            _loc10_ = lf64(_loc11_ = LCPI504_0 + _loc4_);
            _loc7_ = (_loc7_ = _loc1_) + _loc10_;
            _loc10_ = (_loc6_ = _loc7_ * _loc7_) * _loc7_;
            _loc8_ = _loc6_ * _loc6_;
            _loc8_ = _loc10_ * _loc8_;
            _loc14_ = (_loc14_ = _loc6_ * 0.000002718311493989822) + -0.00019839334836096632;
            _loc8_ *= _loc14_;
            _loc1_ = _loc7_ = (_loc7_ = (_loc10_ = (_loc6_ = (_loc6_ *= 0.008333329385889463) + -0.16666666641626524) * _loc10_) + _loc7_) + _loc8_;
         }
      }
      else if(uint(_loc13_) >= 2139095040)
      {
         _loc7_ = _loc1_;
         _loc1_ = _loc7_ -= _loc7_;
      }
      else
      {
         if(uint(_loc13_) <= 1305022426)
         {
            _loc10_ = _loc1_;
            _loc12_ = _loc10_ + (_loc7_ = (_loc7_ = (_loc7_ = _loc10_ * 0.6366197723675814) + 6755399441055744) + -6755399441055744) * -1.5707963109016418 + _loc7_ * -1.5893254773528196e-8;
            _loc13_ = _loc7_;
         }
         else
         {
            var _loc9_:int;
            si32(_loc9_ = _loc13_ - ((_loc11_ = (_loc11_ = _loc13_ >>> 23) + -150) << 23),_loc5_ - 24);
            sf64(_loc10_ = lf32(_loc5_ - 24),_loc5_ - 8);
            _loc3_ -= 32;
            si32(0,_loc3_ + 16);
            si32(1,_loc3_ + 12);
            si32(_loc11_,_loc3_ + 8);
            si32(_loc11_ = _loc5_ - 16,_loc3_ + 4);
            si32(_loc11_ = _loc5_ - 8,_loc3_);
            ESP = _loc3_;
            F___kernel_rem_pio2();
            _loc3_ += 32;
            _loc13_ = eax;
            _loc12_ = lf64(_loc5_ - 16);
            if(_loc4_ <= -1)
            {
               _loc13_ = 0 - _loc13_;
               _loc12_ = -_loc12_;
            }
         }
         if((_loc4_ = _loc13_ & 3) != 2)
         {
            if(_loc4_ != 1)
            {
               if(_loc4_ == 0)
               {
                  _loc7_ = (_loc10_ = _loc12_ * _loc12_) * _loc12_;
                  _loc1_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc10_ = (_loc10_ *= 0.008333329385889463) + -0.16666666641626524) * _loc7_) + _loc12_) + _loc7_ * (_loc10_ * _loc10_) * ((_loc6_ = _loc10_ * 0.000002718311493989822) + -0.00019839334836096632);
               }
               else
               {
                  _loc10_ = _loc12_ * _loc12_;
                  _loc8_ = _loc10_ * _loc10_;
                  _loc1_ = _loc7_ = -(_loc7_ = _loc7_ = (_loc10_ = (_loc10_ = (_loc10_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc10_ * ((_loc6_ = _loc10_ * 0.00002439044879627741) + -0.001388676377460993));
               }
            }
            else
            {
               _loc7_ = _loc12_ * _loc12_;
               _loc8_ = _loc7_ * _loc7_;
               _loc1_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc7_ *= -0.499999997251031) + 1) + _loc8_ * 0.04166662332373906) + _loc8_ * _loc7_ * ((_loc6_ = _loc7_ * 0.00002439044879627741) + -0.001388676377460993);
            }
         }
         else
         {
            _loc7_ = (_loc10_ = _loc12_ * _loc12_) * -_loc12_;
            _loc1_ = _loc7_ = (_loc7_ = (_loc7_ = (_loc10_ = (_loc10_ *= 0.008333329385889463) + -0.16666666641626524) * _loc7_) - _loc12_) + _loc7_ * (_loc10_ * _loc10_) * ((_loc6_ = _loc10_ * 0.000002718311493989822) + -0.00019839334836096632);
         }
      }
      addr997:
      st0 = _loc1_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
