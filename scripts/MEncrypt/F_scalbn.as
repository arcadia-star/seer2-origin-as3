package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_scalbn() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 88;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = (_loc9_ = li32(_loc1_)) >>> 20;
      _loc8_ = _loc1_ & 2047;
      _loc7_ = li32(_loc3_ + 8);
      if(_loc8_ == 0)
      {
         var _loc6_:*;
         if(((_loc6_ = _loc9_ & 2147483647) | li32(_loc3_ - 8)) != 0)
         {
            sf64(_loc5_ *= 18014398509481984,_loc3_ - 16);
            _loc8_ = ((_loc9_ = li32(_loc3_ - 16 | 4)) >>> 20 & 2047) + -54;
            if(_loc7_ <= -50001)
            {
               _loc5_ *= 1e-300;
            }
            else
            {
               addr116:
               if(_loc8_ == 2047)
               {
                  _loc5_ += _loc5_;
               }
               else if((_loc8_ += _loc7_) >= 2047)
               {
                  sf64(_loc5_,_loc3_ - 80);
                  si32(_loc6_ = (_loc6_ = (_loc6_ = li32(_loc6_ = (_loc6_ = _loc3_ - 80) | 4)) & -2147483648) | 2117592124,_loc3_ - 88 | 4);
                  si32(-2013235812,_loc3_ - 88);
                  var _loc4_:*;
                  _loc5_ = (_loc4_ = lf64(_loc3_ - 88)) * 1e+300;
               }
               else if(_loc8_ >= 1)
               {
                  si32((_loc6_ = _loc9_ & -2146435073) | _loc8_ << 20,(_loc6_ = _loc3_ - 72) | 4);
                  sf64(_loc5_,_loc3_ - 64);
                  si32(li32(_loc3_ - 64),_loc3_ - 72);
                  _loc5_ = lf64(_loc3_ - 72);
               }
               else if(_loc8_ <= -54)
               {
                  sf64(_loc5_,_loc3_ - 40);
                  _loc9_ = li32(_loc3_ - 40 | 4) & -2147483648;
                  if(_loc7_ >= 50001)
                  {
                     si32(_loc9_ | 2117592124,(_loc6_ = _loc3_ - 56) | 4);
                     si32(-2013235812,_loc3_ - 56);
                     _loc5_ = (_loc4_ = lf64(_loc3_ - 56)) * 1e+300;
                  }
                  else
                  {
                     si32(_loc9_ | 27618847,(_loc6_ = _loc3_ - 48) | 4);
                     si32(-1023872167,_loc3_ - 48);
                     _loc5_ = (_loc4_ = lf64(_loc3_ - 48)) * 1e-300;
                  }
               }
               else
               {
                  si32((_loc6_ = (_loc6_ = _loc8_ << 20) + 56623104) | _loc9_ & -2146435073,(_loc6_ = _loc3_ - 32) | 4);
                  sf64(_loc5_,_loc3_ - 24);
                  si32(li32(_loc3_ - 24),_loc3_ - 32);
                  _loc5_ = (_loc4_ = lf64(_loc3_ - 32)) * 5.551115123125783e-17;
               }
            }
         }
         st0 = _loc5_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr116);
   }
}
