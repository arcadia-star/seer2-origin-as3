package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_truncl() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = (_loc9_ = li32(_loc1_)) >>> 20;
      _loc7_ = (_loc8_ = _loc1_ & 2047) + -1023;
      _loc6_ = li32(_loc3_ - 8);
      if(_loc7_ <= 19)
      {
         if(_loc7_ <= -1)
         {
            var _loc4_:Number;
            if(!((_loc4_ = _loc5_ + 1e+300) <= 0 | _loc4_ != _loc4_ | false))
            {
               _loc9_ &= -2147483648;
               _loc6_ = 0;
            }
            addr195:
            _loc1_ = _loc3_ - 16;
            _loc1_ |= 4;
            si32(_loc9_,_loc1_);
            si32(_loc6_,_loc3_ - 16);
            _loc5_ = lf64(_loc3_ - 16);
         }
         else if(((_loc8_ = 1048575 >>> _loc7_) & _loc9_ | _loc6_) != 0)
         {
            if(!((_loc4_ = _loc5_ + 1e+300) <= 0 | _loc4_ != _loc4_ | false))
            {
               _loc9_ &= _loc8_ ^ -1;
               _loc6_ = 0;
            }
            §§goto(addr195);
         }
      }
      else if(_loc7_ >= 52)
      {
         if(_loc7_ == 1024)
         {
            _loc5_ += _loc5_;
         }
      }
      else if(((_loc8_ = -1 >>> _loc8_ + -1043) & _loc6_) != 0)
      {
         if(!((_loc4_ = _loc5_ + 1e+300) <= 0 | _loc4_ != _loc4_ | false))
         {
            _loc6_ &= _loc8_ ^ -1;
         }
         §§goto(addr195);
      }
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
