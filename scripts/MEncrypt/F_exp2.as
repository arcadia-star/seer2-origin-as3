package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tbl;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._twom100060;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_exp2() : void
   {
      var _loc5_:* = 0;
      var _loc8_:* = NaN;
      var _loc17_:* = 0;
      var _loc15_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = NaN;
      var _loc14_:Number = NaN;
      var _loc2_:* = NaN;
      var _loc7_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 32;
      sf64(_loc8_ = lf64(_loc5_),_loc5_ - 8);
      var _loc4_:*;
      if((uint(_loc15_ = (_loc17_ = li32(_loc4_ = (_loc4_ = _loc5_ - 8) | 4)) & 2147483647)) >= 1083179008)
      {
         if(uint(_loc15_) >= 2146435072)
         {
            if((_loc4_ = (_loc4_ = _loc17_ & 1048575) | li32(_loc5_ - 8)) == 0)
            {
               _loc7_ = 0;
               if(_loc17_ >= 0)
               {
               }
               §§goto(addr358);
            }
            _loc7_ = _loc8_ + _loc8_;
         }
         else
         {
            _loc7_ = inf;
            if(_loc8_ < 1024)
            {
               if(!(_loc8_ > -1075 | _loc8_ != _loc8_ | false))
               {
                  _loc7_ = lf64(_twom100060) * lf64(_twom100060);
               }
               else
               {
                  addr134:
                  var _loc13_:Number;
                  sf64(_loc13_ = _loc8_ + 26388279066624,_loc5_ - 16);
                  _loc13_ += -26388279066624;
                  var _loc10_:Number = _loc8_ - _loc13_;
                  var _loc11_:*;
                  var _loc9_:* = (_loc9_ = (_loc11_ = (_loc11_ = (_loc4_ = (_loc4_ = li32(_loc5_ - 16)) + 128) << 1) & 510) | 1) << 3;
                  var _loc16_:* = lf64(_loc9_ = _tbl + _loc9_);
                  _loc14_ = _loc10_ - _loc16_;
                  var _loc12_:* = _loc11_ << 3;
                  _loc1_ = lf64(_loc12_ = _tbl + _loc12_);
                  if((_loc6_ = (_loc4_ <<= 12) & -1048576) >= -1070596096)
                  {
                     si32(_loc6_ + 1072693248,(_loc12_ = _loc5_ - 32) | 4);
                     si32(0,_loc5_ - 32);
                     _loc2_ = lf64(_loc5_ - 32);
                  }
                  else
                  {
                     si32(_loc6_ + 2121269248,(_loc12_ = _loc5_ - 24) | 4);
                     si32(0,_loc5_ - 24);
                     _loc7_ = lf64(_loc5_ - 24);
                  }
                  _loc13_ = _loc1_ * _loc14_;
                  _loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = (_loc10_ = _loc14_ * 0.0013333559164630223) + 0.009618129842126066) * _loc14_) + 0.0555041086648214) * _loc14_) + 0.2402265069591) * _loc14_) + 0.6931471805599453;
                  _loc1_ = (_loc13_ *= _loc10_) + _loc1_;
                  if(_loc6_ >= -1070596096)
                  {
                     if(_loc6_ == 1073741824)
                     {
                        _loc7_ = (_loc13_ = _loc1_ + _loc1_) * 8.98846567431158e+307;
                     }
                     else
                     {
                        _loc7_ = _loc1_ * _loc2_;
                     }
                  }
                  else
                  {
                     _loc7_ = _loc1_ * _loc7_ * lf64(_twom100060);
                  }
               }
            }
         }
         §§goto(addr358);
      }
      else
      {
         if(uint(_loc15_) <= 1016070143)
         {
            _loc7_ = _loc8_ + 1;
         }
         else
         {
            §§goto(addr134);
         }
         addr358:
         st0 = _loc7_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr134);
   }
}
