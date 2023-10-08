package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_csqrt() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc2_:* = 0;
      var _loc13_:* = NaN;
      var _loc5_:* = NaN;
      var _loc8_:* = NaN;
      var _loc9_:* = 0;
      var _loc4_:* = NaN;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 48;
      _loc2_ = _loc3_ - 16;
      _loc2_ |= 4;
      si32(_loc14_ = li32(_loc3_ + 16),_loc2_);
      _loc2_ = _loc3_ - 8;
      _loc2_ |= 4;
      si32(_loc12_ = li32(_loc3_ + 8),_loc2_);
      _loc2_ = li32(_loc3_ + 12);
      si32(_loc2_,_loc3_ - 16);
      si32(_loc9_ = li32(_loc3_ + 4),_loc3_ - 8);
      _loc7_ = li32(_loc3_);
      _loc5_ = lf64(_loc3_ - 16);
      if(!((_loc4_ = lf64(_loc3_ - 8)) != 0 | _loc4_ != _loc4_ | false))
      {
         if(!(_loc5_ != 0 | _loc5_ != _loc5_ | false))
         {
            si32(0,_loc7_ + 4);
            si32(0,_loc7_);
            sf64(_loc5_,_loc7_ + 8);
         }
         else
         {
            addr141:
            _loc1_ -= 16;
            sf64(_loc5_,_loc1_);
            ESP = _loc1_;
            F_isinf();
            _loc1_ += 16;
            _loc2_ = eax;
            if(_loc2_ != 0)
            {
               si32(2146435072,_loc7_ + 4);
               si32(0,_loc7_);
               sf64(_loc5_,_loc7_ + 8);
            }
            else if(!(_loc4_ == _loc4_ & _loc4_ == _loc4_))
            {
               sf64(_loc4_,_loc7_);
               var _loc10_:Number = _loc5_ - _loc5_;
               sf64(_loc10_ /= _loc10_,_loc7_ + 8);
            }
            else
            {
               _loc1_ -= 16;
               sf64(_loc4_,_loc1_);
               ESP = _loc1_;
               F_isinf();
               _loc1_ += 16;
               if(eax != 0)
               {
                  _loc5_ -= _loc5_;
                  if(_loc12_ <= -1)
                  {
                     if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
                     {
                        _loc5_ = -_loc5_;
                     }
                     sf64(_loc5_,_loc7_);
                     si32(_loc9_,_loc7_ + 8);
                     _loc2_ = _loc12_ & 2147483647;
                     var _loc6_:*;
                     _loc2_ = (_loc6_ = _loc14_ & -2147483648) | _loc2_;
                     si32(_loc2_,_loc7_ + 12);
                  }
                  else
                  {
                     sf64(_loc4_,_loc7_);
                     sf64(_loc5_,_loc3_ - 24);
                     si32(li32(_loc3_ - 24),_loc7_ + 8);
                     si32((_loc6_ = (_loc6_ = li32(_loc6_ = (_loc6_ = _loc3_ - 24) | 4)) & 2147483647) | _loc14_ & -2147483648,_loc7_ + 12);
                  }
               }
               else
               {
                  _loc8_ = _loc4_;
                  if(!(_loc4_ >= 0 | _loc4_ != _loc4_ | false))
                  {
                     _loc8_ = -_loc4_;
                  }
                  if(_loc8_ < 7.446288774449766e+307)
                  {
                     _loc13_ = _loc5_;
                     if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
                     {
                        _loc13_ = -_loc5_;
                     }
                     _loc9_ = 0;
                     if(!(_loc13_ < 7.446288774449766e+307 | _loc13_ != _loc13_ | false))
                     {
                        addr392:
                        _loc5_ *= 0.25;
                        _loc4_ *= 0.25;
                        _loc9_ = 1;
                     }
                     _loc1_ -= 16;
                     sf64(_loc5_,_loc1_ + 8);
                     sf64(_loc4_,_loc1_);
                     ESP = _loc1_;
                     F_hypot();
                     _loc1_ += 16;
                     _loc13_ = st0;
                     if(!(_loc4_ < 0 | _loc4_ != _loc4_ | false))
                     {
                        _loc4_ = Math.sqrt((_loc10_ = _loc13_ + _loc4_) * 0.5);
                        _loc5_ /= _loc4_ + _loc4_;
                     }
                     else
                     {
                        _loc13_ = Math.sqrt((_loc10_ = _loc13_ - _loc4_) * 0.5);
                        _loc4_ = _loc5_;
                        if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
                        {
                           _loc4_ = -_loc5_;
                        }
                        sf64(_loc5_,_loc3_ - 40);
                        sf64(_loc13_,_loc3_ - 32);
                        _loc2_ = _loc3_ - 40;
                        _loc2_ |= 4;
                        _loc2_ = li32(_loc2_);
                        _loc2_ &= -2147483648;
                        _loc2_ = (_loc6_ = (_loc6_ = li32(_loc6_ = (_loc6_ = _loc3_ - 32) | 4)) & 2147483647) | _loc2_;
                        _loc6_ = (_loc6_ = _loc3_ - 48) | 4;
                        si32(_loc2_,_loc6_);
                        _loc2_ = li32(_loc3_ - 32);
                        si32(_loc2_,_loc3_ - 48);
                        _loc10_ = _loc13_ + _loc13_;
                        _loc4_ /= _loc10_;
                        _loc5_ = lf64(_loc3_ - 48);
                     }
                     if(_loc9_ != 0)
                     {
                        sf64(_loc10_ = (_loc10_ = _loc4_ + _loc4_) - _loc5_ * 0,_loc7_);
                        sf64(_loc10_ = (_loc10_ = _loc4_ * 0) + (_loc5_ + _loc5_),_loc7_ + 8);
                     }
                     else
                     {
                        sf64(_loc4_,_loc7_);
                        sf64(_loc5_,_loc7_ + 8);
                     }
                     §§goto(addr637);
                  }
                  §§goto(addr392);
               }
            }
         }
         addr637:
         _loc1_ = _loc3_;
         ESP = _loc1_;
         return;
      }
      §§goto(addr141);
   }
}
