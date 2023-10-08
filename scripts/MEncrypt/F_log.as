package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_log() : void
   {
      var _loc7_:int = 0;
      var _loc13_:* = 0;
      var _loc9_:int = 0;
      var _loc18_:Number = NaN;
      var _loc16_:Number = NaN;
      var _loc4_:Number = NaN;
      var _loc3_:Number = NaN;
      var _loc17_:int = 0;
      var _loc19_:* = 0;
      var _loc10_:* = NaN;
      var _loc8_:Number = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 32;
      sf64(_loc10_ = lf64(_loc7_),_loc7_ - 8);
      var _loc6_:*;
      _loc19_ = li32(_loc6_ = (_loc6_ = _loc7_ - 8) | 4);
      _loc17_ = -1023;
      if(_loc19_ <= 1048575)
      {
         _loc8_ = -inf;
         if(((_loc6_ = _loc19_ & 2147483647) | li32(_loc7_ - 8)) != 0)
         {
            if(_loc19_ <= -1)
            {
               var _loc15_:Number;
               _loc8_ = (_loc15_ = _loc10_ - _loc10_) / 0;
            }
            else
            {
               sf64(_loc10_ *= 18014398509481984,_loc7_ - 16);
               _loc19_ = li32(_loc6_ = (_loc6_ = _loc7_ - 16) | 4);
               _loc17_ = -1077;
               addr120:
               if(_loc19_ >= 2146435072)
               {
                  _loc8_ = _loc10_ + _loc10_;
               }
               else
               {
                  var _loc11_:int;
                  var _loc14_:*;
                  si32((_loc14_ = (_loc6_ = (_loc6_ = (_loc13_ = _loc19_ & 1048575) + 614244) & 1048576) | _loc13_) ^ 1072693248,(_loc11_ = _loc7_ - 32) | 4);
                  sf64(_loc10_,_loc7_ - 24);
                  si32(_loc14_ = li32(_loc7_ - 24),_loc7_ - 32);
                  _loc9_ = (_loc14_ = _loc19_ >> 20) + _loc17_ + (_loc6_ >>> 20);
                  var _loc12_:*;
                  _loc18_ = (_loc12_ = lf64(_loc7_ - 32)) + -1;
                  if((uint((_loc6_ = _loc19_ + 2) & 1048575)) <= 2)
                  {
                     _loc8_ = 0;
                     if(!(_loc18_ != _loc8_ | _loc18_ != _loc18_ | _loc8_ != _loc8_))
                     {
                        if(_loc9_ != 0)
                        {
                           _loc8_ = (_loc12_ *= 0.6931471803691238) + (_loc12_ = _loc9_) * 1.9082149292705877e-10;
                        }
                     }
                     else
                     {
                        _loc8_ = _loc18_ * _loc18_ * ((_loc12_ = _loc18_ * -0.3333333333333333) + 0.5);
                        if(_loc9_ == 0)
                        {
                           _loc8_ = _loc18_ - _loc8_;
                        }
                        else
                        {
                           _loc8_ = (_loc15_ *= 0.6931471803691238) - ((_loc12_ = (_loc12_ = (_loc15_ = _loc9_) * -1.9082149292705877e-10) + _loc8_) - _loc18_);
                        }
                     }
                  }
                  else
                  {
                     _loc16_ = _loc18_ / (_loc18_ + 2);
                     _loc15_ = _loc16_ * _loc16_;
                     _loc3_ = (_loc15_ = (_loc12_ = (_loc12_ = ((_loc12_ * 0.14798198605116586 + 0.1818357216161805) * _loc12_ + 0.2857142874366239) * _loc12_) + 0.6666666666666735) * _loc15_) + (((_loc12_ = _loc15_ * _loc15_) * 0.15313837699209373 + 0.22222198432149784) * _loc12_ + 0.3999999999940942) * _loc12_;
                     _loc4_ = _loc9_;
                     if(((_loc14_ = _loc13_ + -398458) | 440401 - _loc13_) >= 1)
                     {
                        _loc8_ = (_loc15_ = _loc18_ * 0.5) * _loc18_;
                        if(_loc9_ == 0)
                        {
                           _loc8_ = _loc18_ - (_loc8_ - (_loc15_ = _loc8_ + _loc3_) * _loc16_);
                        }
                        else
                        {
                           _loc8_ = (_loc12_ = _loc4_ * 0.6931471803691238) - ((_loc15_ = _loc8_ - ((_loc15_ = _loc8_ + _loc3_) * _loc16_ + _loc4_ * 1.9082149292705877e-10)) - _loc18_);
                        }
                     }
                     else if(_loc9_ == 0)
                     {
                        _loc8_ = _loc18_ - (_loc15_ = _loc18_ - _loc3_) * _loc16_;
                     }
                     else
                     {
                        _loc8_ = (_loc12_ = _loc4_ * 0.6931471803691238) - ((_loc15_ = (_loc15_ = _loc18_ - _loc3_) * _loc16_ + _loc4_ * -1.9082149292705877e-10) - _loc18_);
                     }
                  }
               }
            }
         }
         st0 = _loc8_;
         ESP = _loc5_ = _loc7_;
         return;
      }
      §§goto(addr120);
   }
}
