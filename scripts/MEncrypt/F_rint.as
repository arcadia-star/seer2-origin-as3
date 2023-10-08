package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._TWO52;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_rint() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc13_:int = 0;
      var _loc12_:* = 0;
      var _loc10_:int = 0;
      var _loc5_:int = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc14_:* = 0;
      var _loc9_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 40;
      sf64(_loc9_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc13_ = (_loc14_ = li32(_loc1_)) >>> 31;
      _loc1_ = _loc14_ >>> 20;
      _loc10_ = (_loc12_ = _loc1_ & 2047) + -1023;
      _loc8_ = li32(_loc3_ - 8);
      if(_loc10_ <= 19)
      {
         if(_loc10_ <= -1)
         {
            if((_loc14_ & 2147483647 | _loc8_) != 0)
            {
               var _loc7_:*;
               si32((_loc8_ | 0 - (_loc14_ & 1048575 | _loc8_)) >>> 12 & 524288 | _loc14_ & -131072,(_loc7_ = _loc3_ - 24) | 4);
               si32(_loc8_,_loc3_ - 24);
               var _loc6_:* = lf64(_TWO52 + (_loc13_ << 3));
               var _loc11_:*;
               sf64(_loc6_ = (_loc11_ = _loc6_ + lf64(_loc3_ - 24)) - _loc6_,_loc3_ - 32);
               si32((_loc7_ = (_loc7_ = li32(_loc7_ = (_loc7_ = _loc3_ - 32) | 4)) & 2147483647) | _loc14_ & -2147483648,(_loc7_ = _loc3_ - 40) | 4);
               si32(li32(_loc3_ - 32),_loc3_ - 40);
               _loc9_ = lf64(_loc3_ - 40);
            }
         }
         else if(((_loc5_ = 1048575 >>> _loc10_) & _loc14_ | _loc8_) != 0)
         {
            _loc4_ = _loc8_;
            if(((_loc5_ >>>= 1) & _loc14_ | _loc8_) != 0)
            {
               _loc4_ = 1073741824;
               if(_loc12_ != 1042)
               {
                  if(_loc12_ == 1041)
                  {
                     _loc4_ = -2147483648;
                  }
                  else
                  {
                     _loc14_ = (_loc7_ = _loc14_ & (_loc5_ ^ -1)) | 131072 >>> _loc10_;
                     _loc4_ = _loc8_;
                  }
               }
            }
            addr323:
            _loc1_ = _loc3_ - 16;
            _loc1_ |= 4;
            si32(_loc14_,_loc1_);
            si32(_loc4_,_loc3_ - 16);
            _loc1_ = _loc13_ << 3;
            _loc1_ = _TWO52 + _loc1_;
            _loc6_ = lf64(_loc1_);
            _loc11_ = lf64(_loc3_ - 16);
            _loc9_ = (_loc11_ = _loc6_ + _loc11_) - _loc6_;
         }
      }
      else if(_loc10_ >= 52)
      {
         if(_loc10_ == 1024)
         {
            _loc9_ += _loc9_;
         }
      }
      else
      {
         _loc10_ = _loc12_ + -1043;
         if(((_loc12_ = -1 >>> _loc10_) & _loc8_) != 0)
         {
            _loc4_ = _loc8_;
            if(((_loc12_ >>>= 1) & _loc8_) != 0)
            {
               _loc4_ = (_loc7_ = _loc8_ & (_loc12_ ^ -1)) | 1073741824 >>> _loc10_;
            }
            §§goto(addr323);
         }
      }
      st0 = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
