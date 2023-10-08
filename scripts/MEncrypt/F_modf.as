package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_modf() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:int = 0;
      var _loc1_:* = 0;
      var _loc7_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      sf64(_loc7_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = (_loc11_ = li32(_loc1_)) >>> 20;
      _loc9_ = (_loc10_ = _loc1_ & 2047) + -1023;
      _loc8_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_ - 8);
      if(_loc9_ <= 19)
      {
         if(_loc9_ <= -1)
         {
            si32(0,_loc8_);
            si32(_loc11_ & -2147483648,_loc8_ + 4);
         }
         else if(((_loc9_ = 1048575 >>> _loc9_) & _loc11_ | _loc6_) == 0)
         {
            sf64(_loc7_,_loc8_);
            si32(_loc11_ & -2147483648,_loc3_ - 48 | 4);
            si32(0,_loc3_ - 48);
            _loc7_ = lf64(_loc3_ - 48);
         }
         else
         {
            si32(0,_loc8_);
            var _loc5_:* = (_loc5_ = _loc3_ - 40) | 4;
            si32(_loc11_ & (_loc9_ ^ -1),_loc5_);
            si32(_loc11_ & (_loc9_ ^ -1),_loc8_ + 4);
            si32(0,_loc3_ - 40);
            _loc7_ -= lf64(_loc3_ - 40);
         }
      }
      else if(_loc9_ >= 52)
      {
         sf64(_loc7_,_loc8_);
         if(_loc9_ == 1024)
         {
            _loc7_ = 0 / _loc7_;
         }
         else
         {
            si32(_loc11_ & -2147483648,_loc3_ - 32 | 4);
            si32(0,_loc3_ - 32);
            _loc7_ = lf64(_loc3_ - 32);
         }
      }
      else if(((_loc9_ = -1 >>> _loc10_ + -1043) & _loc6_) == 0)
      {
         sf64(_loc7_,_loc8_);
         si32(_loc11_ & -2147483648,_loc3_ - 24 | 4);
         si32(0,_loc3_ - 24);
         _loc7_ = lf64(_loc3_ - 24);
      }
      else
      {
         si32(_loc11_,_loc3_ - 16 | 4);
         si32(_loc11_,_loc8_ + 4);
         si32(_loc6_ & (_loc9_ ^ -1),_loc8_);
         si32(_loc6_ & (_loc9_ ^ -1),_loc3_ - 16);
         _loc7_ -= lf64(_loc3_ - 16);
      }
      st0 = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
