package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_remainder() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = NaN;
      var _loc9_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:Number = NaN;
      var _loc2_:* = 0;
      var _loc13_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = NaN;
      var _loc4_:* = 0;
      var _loc1_:int = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 32;
      sf64(_loc8_ = lf64(_loc3_ + 8),_loc3_ - 16);
      sf64(_loc6_ = lf64(_loc3_),_loc3_ - 8);
      _loc2_ = _loc3_ - 16;
      _loc2_ |= 4;
      _loc2_ = li32(_loc2_);
      _loc15_ = _loc2_ & 2147483647;
      _loc14_ = li32(_loc3_ - 16);
      _loc2_ = _loc15_ | _loc14_;
      if(_loc2_ == 0)
      {
         var _loc12_:Number = _loc6_ * _loc8_;
         _loc6_ = _loc12_ / _loc12_;
      }
      else
      {
         if((uint(_loc11_ = (_loc13_ = li32(_loc3_ - 8 | 4)) & 2147483647)) <= 2146435071)
         {
            _loc9_ = li32(_loc3_ - 8);
            if(uint(_loc15_) >= 2146435072)
            {
               if((_loc15_ + -2146435072 | _loc14_) != 0)
               {
                  addr132:
                  _loc12_ = _loc6_ * _loc8_;
                  _loc6_ = _loc12_ / _loc12_;
               }
               §§goto(addr409);
            }
            if(uint(_loc15_) <= 2145386495)
            {
               _loc1_ -= 16;
               sf64(_loc6_,_loc1_);
               sf64(_loc12_ = _loc8_ + _loc8_,_loc1_ + 8);
               ESP = _loc1_;
               F_fmod();
               _loc1_ += 16;
               _loc6_ = st0;
            }
            var _loc7_:* = _loc9_ - _loc14_;
            _loc2_ = _loc11_ - _loc15_;
            _loc2_ |= _loc7_;
            if(_loc2_ == 0)
            {
               _loc6_ *= 0;
            }
            else
            {
               if(!(_loc6_ >= 0 | _loc6_ != _loc6_ | false))
               {
                  _loc6_ = -_loc6_;
               }
               if(!(_loc8_ >= 0 | _loc8_ != _loc8_ | false))
               {
                  _loc8_ = -_loc8_;
               }
               _loc14_ = _loc13_ & -2147483648;
               if(uint(_loc15_) <= 2097151)
               {
                  if(!((_loc12_ = _loc6_ + _loc6_) <= _loc8_ | _loc12_ != _loc12_ | _loc8_ != _loc8_))
                  {
                     _loc6_ -= _loc8_;
                     if(!((_loc12_ = _loc6_ + _loc6_) < _loc8_ | _loc12_ != _loc12_ | _loc8_ != _loc8_))
                     {
                        _loc6_ -= _loc8_;
                     }
                  }
               }
               else
               {
                  _loc10_ = _loc8_ * 0.5;
                  if(!(_loc6_ <= _loc10_ | _loc6_ != _loc6_ | _loc10_ != _loc10_))
                  {
                     if(!((_loc6_ -= _loc8_) < _loc10_ | _loc6_ != _loc6_ | _loc10_ != _loc10_))
                     {
                        _loc6_ -= _loc8_;
                     }
                  }
               }
               sf64(_loc6_,_loc3_ - 24);
               _loc2_ = _loc3_ - 24;
               _loc2_ |= 4;
               _loc2_ = (_loc5_ = li32(_loc2_)) & 2147483647;
               _loc4_ = 0;
               if(_loc2_ != _loc4_)
               {
                  _loc4_ = _loc5_;
               }
               _loc2_ = _loc4_ ^ _loc14_;
               _loc7_ = (_loc7_ = _loc3_ - 32) | 4;
               si32(_loc2_,_loc7_);
               _loc2_ = li32(_loc3_ - 24);
               si32(_loc2_,_loc3_ - 32);
               _loc6_ = lf64(_loc3_ - 32);
            }
            §§goto(addr409);
            ESP = _loc1_;
            return;
         }
         §§goto(addr132);
      }
      §§goto(addr132);
   }
}
