package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._logF_head;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._logF_tail;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___log__D() : void
   {
      var _loc10_:int = 0;
      var _loc19_:* = 0;
      var _loc21_:* = 0;
      var _loc18_:* = 0;
      var _loc22_:Number = NaN;
      var _loc20_:Number = NaN;
      var _loc2_:Number = NaN;
      var _loc3_:Number = NaN;
      var _loc16_:Number = NaN;
      var _loc9_:* = 0;
      var _loc14_:* = NaN;
      var _loc12_:* = NaN;
      var _loc8_:* = (_loc10_ = ESP) - 104;
      sf64(_loc14_ = lf64(_loc10_ + 4),_loc10_ - 32);
      _loc21_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 32) | 4)) & 2147483647;
      _loc9_ = li32(_loc10_ - 32);
      _loc9_ = _loc21_ | _loc9_;
      _loc19_ = li32(_loc10_);
      if(_loc9_ == 0)
      {
         _loc12_ = _loc14_;
         if(!(_loc14_ >= 0 | _loc14_ != _loc14_ | false))
         {
            _loc12_ = -_loc14_;
         }
         _loc12_ = -1 / _loc12_;
      }
      else if(uint(_loc21_) >= 2146435072)
      {
         _loc12_ = _loc14_ * _loc14_;
      }
      else if(uint(_loc21_) <= 1048575)
      {
         var _loc17_:*;
         sf64(_loc17_ = _loc14_ * 18014398509481984,_loc10_ - 40);
         _loc12_ = _loc9_ = (_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 40) | 4)) >>> 20) & 2047) + -1077;
      }
      else
      {
         _loc12_ = _loc9_ = (_loc9_ = _loc21_ >>> 20) + -1023;
      }
      _loc21_ = _loc12_;
      _loc9_ = 0 - _loc21_;
      _loc16_ = _loc14_ * Math.pow(2,_loc9_);
      if(_loc21_ == -1022)
      {
         sf64(_loc16_,_loc10_ - 48);
         _loc18_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 48) | 4)) & 2147483647;
         if((_loc9_ = _loc18_ | li32(_loc10_ - 48)) == 0)
         {
            _loc14_ = _loc16_;
            if(!(_loc16_ >= 0 | _loc16_ != _loc16_ | false))
            {
               _loc14_ = -_loc16_;
            }
            _loc14_ = -1 / _loc14_;
         }
         else if(uint(_loc18_) >= 2146435072)
         {
            _loc14_ = _loc16_ * _loc16_;
         }
         else if(uint(_loc18_) <= 1048575)
         {
            sf64(_loc17_ = _loc16_ * 18014398509481984,_loc10_ - 56);
            _loc14_ = _loc9_ = (_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 56) | 4)) >>> 20) & 2047) + -1077;
         }
         else
         {
            _loc14_ = _loc9_ = (_loc9_ = _loc18_ >>> 20) + -1023;
         }
         _loc21_ = (_loc9_ = _loc14_) + _loc21_;
         _loc9_ = 0 - _loc9_;
         _loc16_ *= Math.pow(2,_loc9_);
      }
      _loc22_ = (_loc17_ = (_loc17_ = _loc18_ = _loc17_ = (_loc17_ = (_loc17_ = _loc16_ + -1) * 128) + 0.5) * 0.0078125) + 1;
      _loc20_ = _loc16_ - _loc22_;
      _loc17_ = _loc20_ + _loc20_;
      var _loc1_:* = _loc22_ + _loc22_;
      _loc1_ += _loc20_;
      _loc2_ = 1 / _loc1_;
      _loc3_ = _loc17_ * _loc2_;
      _loc1_ = _loc3_ * _loc3_;
      _loc17_ = _loc3_ * _loc1_;
      var _loc4_:*;
      _loc1_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = _loc1_ * 0.0004348877777076146) + 0.002232139987919448) * _loc1_) + 0.01250000000377175) * _loc1_;
      _loc1_ += 0.08333333333333179;
      _loc16_ = _loc17_ * _loc1_;
      if((_loc9_ = _loc18_ | _loc21_) != 0)
      {
         sf64(_loc17_ = _loc3_ + 513,_loc10_ - 8);
         sf64(_loc17_ = (_loc17_ = lf64(_loc10_ - 8)) + -513,_loc10_ - 8);
      }
      else
      {
         sf64(_loc3_,_loc10_ - 8);
         sf64(lf64(_loc10_ - 8),_loc10_ - 72);
         var _loc15_:*;
         var _loc13_:*;
         si32(_loc13_ = li32(_loc13_ = (_loc13_ = _loc10_ - 72) | 4),(_loc15_ = _loc10_ - 80) | 4);
         sf64(lf64(_loc10_ - 8),_loc10_ - 64);
         si32(_loc9_ = (_loc9_ = li32(_loc10_ - 64)) & -134217728,_loc10_ - 80);
         sf64(_loc17_ = lf64(_loc10_ - 80),_loc10_ - 8);
      }
      _loc15_ = _loc18_ << 3;
      _loc4_ = lf64(_loc9_ = _logF_head + _loc15_);
      var _loc7_:*;
      var _loc6_:Number = (_loc7_ = (_loc17_ = _loc21_) * 0.6931471805601177) + _loc4_;
      _loc4_ = lf64(_loc10_ - 8);
      _loc7_ = lf64(_loc10_ - 8);
      var _loc5_:* = lf64(_loc10_ - 8);
      sf64(_loc5_ = _loc6_ + _loc5_,_loc10_ - 8);
      _loc7_ *= _loc20_;
      _loc4_ = _loc22_ * _loc4_;
      _loc4_ = _loc20_ - _loc4_;
      _loc4_ = (_loc4_ = (_loc4_ += _loc4_) - _loc7_) * _loc2_;
      _loc1_ = lf64(_loc15_ = _logF_tail + _loc15_);
      _loc1_ += _loc4_;
      _loc1_ += _loc16_;
      _loc17_ = (_loc17_ *= -1.7239444525614835e-13) + _loc1_;
      _loc1_ = lf64(_loc10_ - 8);
      _loc1_ += _loc17_;
      sf64(_loc1_,_loc10_ - 24);
      _loc1_ = lf64(_loc10_ - 24);
      sf64(_loc4_ = lf64(_loc10_ - 24),_loc10_ - 96);
      var _loc11_:* = (_loc13_ = _loc10_ - 104) | 4;
      si32(_loc13_ = li32(_loc13_ = (_loc13_ = _loc10_ - 96) | 4),_loc11_);
      sf64(_loc1_,_loc10_ - 88);
      si32(_loc15_ = (_loc15_ = li32(_loc10_ - 88)) & -134217728,_loc10_ - 104);
      sf64(_loc7_ = lf64(_loc10_ - 104),_loc10_ - 24);
      _loc5_ = lf64(_loc10_ - 8);
      si32(_loc13_,_loc19_ + 4);
      si32(_loc15_,_loc19_);
      _loc1_ = _loc5_ - _loc7_;
      sf64(_loc17_ = _loc1_ + _loc17_,_loc19_ + 8);
      ESP = _loc8_ = _loc10_;
   }
}
