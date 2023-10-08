package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_log10() : void
   {
      var _loc3_:* = 0;
      var _loc2_:* = 0;
      var _loc11_:int = 0;
      var _loc13_:* = 0;
      var _loc5_:* = NaN;
      var _loc4_:Number = NaN;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 32;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc2_ = _loc3_ - 8;
      _loc2_ |= 4;
      _loc13_ = li32(_loc2_);
      _loc11_ = -1023;
      if(_loc13_ <= 1048575)
      {
         _loc4_ = -inf;
         var _loc9_:*;
         if(((_loc9_ = _loc13_ & 2147483647) | li32(_loc3_ - 8)) != 0)
         {
            if(_loc13_ <= -1)
            {
               var _loc10_:Number;
               _loc4_ = (_loc10_ = _loc5_ - _loc5_) / 0;
            }
            else
            {
               sf64(_loc5_ *= 18014398509481984,_loc3_ - 16);
               _loc13_ = li32(_loc3_ - 16 | 4);
               _loc11_ = -1077;
               addr106:
               if(_loc13_ >= 2146435072)
               {
                  _loc4_ = _loc5_ + _loc5_;
               }
               else
               {
                  sf64(_loc5_,_loc3_ - 24);
                  _loc1_ -= 16;
                  si32(li32(_loc3_ - 24),_loc1_);
                  _loc2_ = (_loc9_ = (_loc13_ >> 20) + _loc11_) >>> 31;
                  var _loc7_:*;
                  si32(_loc7_ = (_loc7_ = 1023 - _loc2_) << 20 | _loc13_ & 1048575,_loc1_ + 4);
                  ESP = _loc1_;
                  F_log();
                  _loc1_ += 16;
                  var _loc12_:Number;
                  _loc4_ = (_loc10_ *= 0.30102999566361177) + ((_loc10_ = _loc2_ + _loc9_) * 3.694239077158931e-13 + (_loc12_ = st0) * 0.4342944819032518);
               }
            }
         }
         st0 = _loc4_;
         _loc1_ = _loc3_;
         ESP = _loc1_;
         return;
      }
      §§goto(addr106);
   }
}
