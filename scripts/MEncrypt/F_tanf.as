package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI507_0;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI507_1;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI507_2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI507_3;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_tanf() : void
   {
      var _loc7_:int = 0;
      var _loc1_:* = NaN;
      var _loc6_:* = 0;
      var _loc16_:* = 0;
      var _loc3_:* = NaN;
      var _loc12_:int = 0;
      var _loc4_:Number = NaN;
      var _loc2_:* = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 32;
      _loc2_ = lf32(_loc7_);
      sf32(_loc2_,_loc7_ - 20);
      if((uint(_loc16_ = (_loc6_ = li32(_loc7_ - 20)) & 2147483647)) <= 1061752794)
      {
         if(uint(_loc16_) <= 964689919)
         {
            var _loc14_:*;
            if((_loc14_ = _loc2_) != 0)
            {
            }
            §§goto(addr894);
         }
         var _loc9_:* = _loc2_;
         var _loc8_:Number;
         var _loc13_:* = (_loc8_ = _loc9_ * _loc9_) * _loc9_;
         var _loc11_:Number = _loc8_ * _loc8_;
         var _loc17_:Number = _loc13_ * _loc11_;
         var _loc15_:Number = (_loc15_ = _loc8_ * 0.009465647849436732) + 0.002974357433599673;
         _loc11_ *= _loc15_;
         _loc15_ = (_loc15_ = _loc8_ * 0.024528318116654728) + 0.05338123784456704;
         _loc11_ += _loc15_;
         _loc17_ *= _loc11_;
         _loc8_ = (_loc8_ *= 0.13339200271297674) + 0.3333313950307914;
         _loc2_ = _loc9_ = (_loc9_ = (_loc13_ *= _loc8_) + _loc9_) + _loc17_;
      }
      else if(uint(_loc16_) <= 1081824209)
      {
         _loc1_ = _loc2_;
         if(uint(_loc16_) <= 1075235811)
         {
            _loc16_ = 1;
            if(_loc6_ <= 0)
            {
               _loc16_ = 0;
            }
            _loc6_ = 8;
            if(_loc16_ == 0)
            {
               _loc6_ = 0;
            }
            _loc9_ = lf64(_loc14_ = LCPI507_3 + _loc6_);
            _loc9_ = _loc1_ + _loc9_;
            _loc13_ = (_loc8_ = _loc9_ * _loc9_) * _loc9_;
            _loc11_ = _loc8_ * _loc8_;
            _loc17_ = _loc13_ * _loc11_;
            _loc15_ = (_loc15_ = _loc8_ * 0.009465647849436732) + 0.002974357433599673;
            _loc11_ *= _loc15_;
            _loc15_ = (_loc15_ = _loc8_ * 0.024528318116654728) + 0.05338123784456704;
            _loc11_ += _loc15_;
            _loc17_ *= _loc11_;
            _loc8_ = (_loc8_ *= 0.13339200271297674) + 0.3333313950307914;
            _loc9_ = (_loc9_ = (_loc13_ *= _loc8_) + _loc9_) + _loc17_;
            _loc2_ = _loc9_ = -1 / _loc9_;
         }
         else
         {
            _loc16_ = 1;
            if(_loc6_ <= 0)
            {
               _loc16_ = 0;
            }
            _loc6_ = 8;
            if(_loc16_ == 0)
            {
               _loc6_ = 0;
            }
            _loc9_ = lf64(_loc14_ = LCPI507_2 + _loc6_);
            _loc9_ = _loc1_ + _loc9_;
            _loc13_ = (_loc8_ = _loc9_ * _loc9_) * _loc9_;
            _loc11_ = _loc8_ * _loc8_;
            _loc17_ = _loc13_ * _loc11_;
            _loc15_ = (_loc15_ = _loc8_ * 0.009465647849436732) + 0.002974357433599673;
            _loc11_ *= _loc15_;
            _loc15_ = (_loc15_ = _loc8_ * 0.024528318116654728) + 0.05338123784456704;
            _loc11_ += _loc15_;
            _loc17_ *= _loc11_;
            _loc8_ = (_loc8_ *= 0.13339200271297674) + 0.3333313950307914;
            _loc2_ = _loc9_ = (_loc9_ = (_loc13_ *= _loc8_) + _loc9_) + _loc17_;
         }
      }
      else if(uint(_loc16_) <= 1088565717)
      {
         _loc1_ = _loc2_;
         if(uint(_loc16_) <= 1085271519)
         {
            _loc16_ = 1;
            if(_loc6_ <= 0)
            {
               _loc16_ = 0;
            }
            _loc6_ = 8;
            if(_loc16_ == 0)
            {
               _loc6_ = 0;
            }
            _loc9_ = lf64(_loc14_ = LCPI507_1 + _loc6_);
            _loc9_ = _loc1_ + _loc9_;
            _loc13_ = (_loc8_ = _loc9_ * _loc9_) * _loc9_;
            _loc11_ = _loc8_ * _loc8_;
            _loc17_ = _loc13_ * _loc11_;
            _loc15_ = (_loc15_ = _loc8_ * 0.009465647849436732) + 0.002974357433599673;
            _loc11_ *= _loc15_;
            _loc15_ = (_loc15_ = _loc8_ * 0.024528318116654728) + 0.05338123784456704;
            _loc11_ += _loc15_;
            _loc17_ *= _loc11_;
            _loc8_ = (_loc8_ *= 0.13339200271297674) + 0.3333313950307914;
            _loc9_ = (_loc9_ = (_loc13_ *= _loc8_) + _loc9_) + _loc17_;
            _loc2_ = _loc9_ = -1 / _loc9_;
         }
         else
         {
            _loc16_ = 1;
            if(_loc6_ <= 0)
            {
               _loc16_ = 0;
            }
            _loc6_ = 8;
            if(_loc16_ == 0)
            {
               _loc6_ = 0;
            }
            _loc9_ = lf64(_loc14_ = LCPI507_0 + _loc6_);
            _loc9_ = _loc1_ + _loc9_;
            _loc13_ = (_loc8_ = _loc9_ * _loc9_) * _loc9_;
            _loc11_ = _loc8_ * _loc8_;
            _loc17_ = _loc13_ * _loc11_;
            _loc15_ = (_loc15_ = _loc8_ * 0.009465647849436732) + 0.002974357433599673;
            _loc11_ *= _loc15_;
            _loc15_ = (_loc15_ = _loc8_ * 0.024528318116654728) + 0.05338123784456704;
            _loc11_ += _loc15_;
            _loc17_ *= _loc11_;
            _loc8_ = (_loc8_ *= 0.13339200271297674) + 0.3333313950307914;
            _loc2_ = _loc9_ = (_loc9_ = (_loc13_ *= _loc8_) + _loc9_) + _loc17_;
         }
      }
      else if(uint(_loc16_) >= 2139095040)
      {
         _loc9_ = _loc2_;
         _loc2_ = _loc9_ -= _loc9_;
      }
      else
      {
         if(uint(_loc16_) <= 1305022426)
         {
            _loc9_ = _loc2_;
            _loc3_ = _loc9_ + (_loc13_ = (_loc13_ = (_loc13_ = _loc9_ * 0.6366197723675814) + 6755399441055744) + -6755399441055744) * -1.5707963109016418 + _loc13_ * -1.5893254773528196e-8;
            _loc12_ = _loc13_;
         }
         else
         {
            var _loc10_:int;
            si32(_loc10_ = _loc16_ - ((_loc14_ = (_loc14_ = _loc16_ >>> 23) + -150) << 23),_loc7_ - 24);
            sf64(_loc13_ = lf32(_loc7_ - 24),_loc7_ - 8);
            _loc5_ -= 32;
            si32(0,_loc5_ + 16);
            si32(1,_loc5_ + 12);
            si32(_loc14_,_loc5_ + 8);
            si32(_loc14_ = _loc7_ - 16,_loc5_ + 4);
            si32(_loc14_ = _loc7_ - 8,_loc5_);
            ESP = _loc5_;
            F___kernel_rem_pio2();
            _loc5_ += 32;
            _loc12_ = eax;
            _loc3_ = lf64(_loc7_ - 16);
            if(_loc6_ <= -1)
            {
               _loc12_ = 0 - _loc12_;
               _loc3_ = -_loc3_;
            }
         }
         _loc9_ = (_loc13_ = _loc3_ * _loc3_) * _loc3_;
         _loc17_ = _loc13_ * _loc13_;
         _loc8_ = _loc9_ * _loc17_;
         _loc11_ = (_loc11_ = _loc13_ * 0.009465647849436732) + 0.002974357433599673;
         _loc17_ *= _loc11_;
         _loc11_ = (_loc11_ = _loc13_ * 0.024528318116654728) + 0.05338123784456704;
         _loc17_ += _loc11_;
         _loc8_ *= _loc17_;
         _loc13_ = (_loc13_ *= 0.13339200271297674) + 0.3333313950307914;
         _loc4_ = (_loc9_ = (_loc9_ *= _loc13_) + _loc3_) + _loc8_;
         if((_loc14_ = _loc12_ & 1) != 0)
         {
            _loc4_ = -1 / _loc4_;
         }
         _loc2_ = _loc4_;
      }
      addr894:
      st0 = _loc2_;
      ESP = _loc5_ = _loc7_;
   }
}
