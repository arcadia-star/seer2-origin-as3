package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_log1p() : void
   {
      var _loc5_:* = 0;
      var _loc7_:* = NaN;
      var _loc14_:* = 0;
      var _loc12_:* = 0;
      var _loc13_:Number = NaN;
      var _loc9_:Number = NaN;
      var _loc15_:* = NaN;
      var _loc8_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 40;
      sf64(_loc7_ = lf64(_loc5_),_loc5_ - 8);
      var _loc4_:*;
      _loc14_ = li32(_loc4_ = (_loc4_ = _loc5_ - 8) | 4);
      _loc12_ = 1;
      if(_loc14_ <= 1071284857)
      {
         if((uint(_loc12_ = _loc14_ & 2147483647)) >= 1072693248)
         {
            _loc6_ = -inf;
            if(_loc7_ != -1)
            {
               var _loc10_:* = _loc7_ - _loc7_;
               _loc6_ = _loc10_ / _loc10_;
            }
         }
         else if(uint(_loc12_) <= 1042284543)
         {
            if(!((_loc10_ = _loc7_ + 18014398509481984) <= 0 | _loc10_ != _loc10_ | false))
            {
               _loc6_ = _loc7_;
               if(uint(_loc12_) >= 1016070144)
               {
               }
               §§goto(addr595);
            }
            _loc6_ = (_loc10_ = (_loc10_ = _loc7_ * _loc7_) * -0.5) + _loc7_;
         }
         else
         {
            _loc12_ = 1;
            if(uint(_loc14_ + 1076707643) >= 1076707644)
            {
               _loc12_ = 0;
               addr147:
               if(_loc14_ >= 2146435072)
               {
                  _loc6_ = _loc7_ + _loc7_;
               }
               else
               {
                  if(_loc12_ == 0)
                  {
                     _loc9_ = (_loc10_ = _loc7_ * 0.5) * _loc7_;
                     _loc12_ = 0;
                  }
                  else
                  {
                     if(_loc14_ <= 1128267775)
                     {
                        sf64(_loc15_ = _loc7_ + 1,_loc5_ - 16);
                        if((_loc12_ = (_loc4_ = (_loc14_ = li32(_loc4_ = (_loc4_ = _loc5_ - 16) | 4)) >> 20) + -1023) >= 1)
                        {
                           _loc13_ = 1 - (_loc15_ - _loc7_);
                        }
                        else
                        {
                           _loc13_ = _loc7_ - (_loc15_ + -1);
                        }
                        _loc13_ /= _loc15_;
                     }
                     else
                     {
                        _loc12_ = (_loc4_ = _loc14_ >> 20) + -1023;
                        _loc13_ = 0;
                        _loc15_ = _loc7_;
                     }
                     if((uint(_loc11_ = _loc14_ & 1048575)) <= 434333)
                     {
                        sf64(_loc15_,_loc5_ - 32);
                        _loc8_ = _loc11_ | 1072693248;
                        _loc14_ = li32(_loc5_ - 32);
                     }
                     else
                     {
                        sf64(_loc15_,_loc5_ - 24);
                        _loc8_ = _loc11_ | 1071644672;
                        _loc12_ += 1;
                        _loc11_ = (_loc4_ = 1048576 - _loc11_) >>> 2;
                        _loc14_ = li32(_loc5_ - 24);
                     }
                     _loc4_ = (_loc4_ = _loc5_ - 40) | 4;
                     si32(_loc8_,_loc4_);
                     si32(_loc14_,_loc5_ - 40);
                     _loc9_ = (_loc10_ = (_loc7_ = (_loc10_ = lf64(_loc5_ - 40)) + -1) * 0.5) * _loc7_;
                     if(_loc11_ == 0)
                     {
                        _loc6_ = 0;
                        if(!(_loc7_ != _loc6_ | _loc7_ != _loc7_ | _loc6_ != _loc6_))
                        {
                           if(_loc12_ != 0)
                           {
                              _loc6_ = (_loc10_ *= 0.6931471803691238) + ((_loc10_ = _loc12_) * 1.9082149292705877e-10 + _loc13_);
                           }
                        }
                        else
                        {
                           _loc9_ = (_loc10_ = (_loc10_ = _loc7_ * -0.6666666666666666) + 1) * _loc9_;
                           if(_loc12_ == 0)
                           {
                              _loc6_ = _loc7_ - _loc9_;
                           }
                           else
                           {
                              _loc6_ = (_loc10_ *= 0.6931471803691238) - (_loc9_ - ((_loc10_ = _loc12_) * 1.9082149292705877e-10 + _loc13_) - _loc7_);
                           }
                        }
                     }
                     §§goto(addr595);
                  }
                  _loc10_ = _loc7_ + 2;
                  _loc6_ = _loc7_ / _loc10_;
                  var _loc1_:Number = (_loc10_ = _loc6_ * _loc6_) * 0.14798198605116586;
                  _loc1_ += 0.15313837699209373;
                  _loc1_ *= _loc10_;
                  _loc1_ += 0.1818357216161805;
                  _loc1_ *= _loc10_;
                  _loc1_ += 0.22222198432149784;
                  _loc1_ *= _loc10_;
                  _loc1_ += 0.2857142874366239;
                  _loc1_ *= _loc10_;
                  _loc1_ += 0.3999999999940942;
                  _loc1_ *= _loc10_;
                  _loc1_ += 0.6666666666666735;
                  _loc15_ = _loc1_ * _loc10_;
                  if(_loc12_ == 0)
                  {
                     _loc6_ = _loc7_ - (_loc9_ - (_loc10_ = _loc9_ + _loc15_) * _loc6_);
                  }
                  else
                  {
                     _loc6_ = (_loc10_ *= 0.6931471803691238) - (_loc9_ - ((_loc10_ = _loc9_ + _loc15_) * _loc6_ + ((_loc10_ = _loc12_) * 1.9082149292705877e-10 + _loc13_)) - _loc7_);
                  }
               }
            }
            §§goto(addr147);
         }
         addr595:
         st0 = _loc6_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr147);
   }
}
