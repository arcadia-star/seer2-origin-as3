package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._Zero82;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_modfl() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 24;
      sf64(_loc7_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = (_loc11_ = li32(_loc1_)) >>> 20;
      _loc9_ = (_loc10_ = _loc1_ & 2047) + -1023;
      _loc8_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_ - 8);
      if(_loc9_ <= 20)
      {
         if(_loc9_ <= -1)
         {
            var _loc5_:*;
            sf64(_loc5_ = lf64(_Zero82 + ((_loc11_ & -2147483648) >>> 28)),_loc8_);
         }
         else
         {
            _loc10_ = 1043 - _loc10_;
            if(((_loc9_ = _loc11_ & 1048575) & (-1 << _loc10_ ^ -1) | _loc6_) == 0)
            {
               sf64(_loc7_,_loc8_);
               _loc7_ = lf64(_Zero82 + ((_loc11_ & -2147483648) >>> 28));
            }
            else
            {
               si32(0,_loc8_);
               var _loc4_:* = (_loc4_ = _loc3_ - 24) | 4;
               si32((_loc9_ >>> _loc10_ & 1048575) << _loc10_ & 1048575 | _loc11_ & -1048576,_loc4_);
               si32((_loc9_ >>> _loc10_ & 1048575) << _loc10_ & 1048575 | _loc11_ & -1048576,_loc8_ + 4);
               si32(0,_loc3_ - 24);
               _loc7_ -= lf64(_loc3_ - 24);
            }
         }
      }
      else if(_loc9_ >= 52)
      {
         sf64(_loc7_,_loc8_);
         if(!(_loc7_ != _loc7_ | _loc7_ != _loc7_))
         {
            _loc7_ = lf64(_Zero82 + ((_loc11_ & -2147483648) >>> 28));
         }
      }
      else
      {
         _loc9_ = 1075 - _loc10_;
         if((_loc6_ & (-1 << _loc9_ ^ -1)) == 0)
         {
            sf64(_loc7_,_loc8_);
            _loc7_ = lf64(_Zero82 + ((_loc11_ & -2147483648) >>> 28));
         }
         else
         {
            si32(_loc11_,_loc3_ - 16 | 4);
            si32(_loc11_,_loc8_ + 4);
            si32(_loc6_ >>> _loc9_ << _loc9_,_loc8_);
            si32(_loc6_ >>> _loc9_ << _loc9_,_loc3_ - 16);
            _loc7_ -= lf64(_loc3_ - 16);
         }
      }
      st0 = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
