package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_log1pf() : void
   {
      var _loc6_:int = 0;
      var _loc21_:* = 0;
      var _loc11_:* = NaN;
      var _loc17_:* = NaN;
      var _loc15_:* = NaN;
      var _loc1_:* = NaN;
      var _loc12_:* = NaN;
      var _loc9_:* = NaN;
      var _loc25_:* = 0;
      var _loc18_:* = NaN;
      var _loc22_:* = 0;
      var _loc23_:* = 0;
      var _loc16_:* = NaN;
      var _loc20_:* = NaN;
      var _loc5_:* = (_loc6_ = ESP) - 12;
      sf32(_loc18_ = lf32(_loc6_),_loc6_ - 4);
      _loc21_ = li32(_loc6_ - 4);
      _loc25_ = 1;
      if(_loc21_ <= 1054086095)
      {
         if((uint(_loc25_ = _loc21_ & 2147483647)) >= 1065353216)
         {
            _loc20_ = -inf;
            _loc9_ = _loc18_;
            var _loc19_:*;
            if(_loc9_ != (_loc19_ = -1))
            {
               var _loc7_:* = _loc19_ = _loc7_ = _loc9_ - _loc9_;
               _loc20_ = _loc7_ /= _loc7_;
            }
         }
         else if(uint(_loc25_) <= 939524095)
         {
            _loc12_ = _loc18_;
            _loc7_ = _loc19_ = _loc7_ = _loc12_ + (_loc19_ = 33554432);
            var _loc14_:*;
            var _loc10_:* = _loc14_ = 0;
            if(!(_loc7_ <= _loc10_ | _loc7_ != _loc7_ | _loc10_ != _loc10_))
            {
               _loc20_ = _loc18_;
               if(uint(_loc25_) >= 864026624)
               {
               }
               §§goto(addr877);
            }
            _loc7_ = _loc19_ = -0.5;
            _loc20_ = _loc7_ = (_loc7_ = _loc19_ = _loc7_ = (_loc10_ = _loc14_ = _loc10_ = _loc12_ * _loc12_) * _loc7_) + _loc12_;
         }
         else
         {
            _loc25_ = 1;
            if(uint(_loc21_ + 1097468390) >= 1097468391)
            {
               _loc25_ = 0;
               addr189:
               if(_loc21_ >= 2139095040)
               {
                  _loc7_ = _loc18_;
                  _loc20_ = _loc7_ += _loc7_;
               }
               else
               {
                  if(_loc25_ == 0)
                  {
                     _loc7_ = _loc18_;
                     _loc16_ = _loc7_ = (_loc10_ = _loc14_ = _loc10_ = _loc7_ * (_loc14_ = 0.5)) * _loc7_;
                     _loc25_ = 0;
                  }
                  else
                  {
                     if(_loc21_ <= 1509949439)
                     {
                        _loc17_ = _loc18_;
                        _loc15_ = _loc19_ = 1;
                        sf32(_loc11_ = _loc7_ = _loc17_ + _loc15_,_loc6_ - 8);
                        var _loc24_:*;
                        if((_loc25_ = (_loc24_ = (_loc21_ = li32(_loc6_ - 8)) >> 23) + -127) >= 1)
                        {
                           _loc18_ = _loc7_ = _loc15_ - (_loc19_ = _loc7_ = (_loc7_ = _loc11_) - _loc17_);
                        }
                        else
                        {
                           _loc18_ = _loc7_ = _loc17_ - (_loc19_ = _loc7_ = _loc11_ + (_loc14_ = -1));
                        }
                        _loc7_ = _loc11_;
                        _loc11_ = _loc7_ = (_loc10_ = _loc18_) / _loc7_;
                     }
                     else
                     {
                        _loc11_ = 0;
                        _loc25_ = (_loc24_ = _loc21_ >> 23) + -127;
                     }
                     if((uint(_loc23_ = _loc21_ & 8388607)) <= 3474675)
                     {
                        _loc22_ = _loc23_ | 1065353216;
                     }
                     else
                     {
                        _loc22_ = _loc23_ | 1056964608;
                        _loc25_ += 1;
                        _loc23_ = (_loc24_ = 8388608 - _loc23_) >>> 2;
                     }
                     si32(_loc22_,_loc6_ - 12);
                     _loc7_ = _loc19_ = -1;
                     _loc1_ = _loc18_ = _loc7_ = (_loc10_ = lf32(_loc6_ - 12)) + _loc7_;
                     _loc7_ = _loc19_ = 0.5;
                     _loc16_ = _loc7_ = (_loc7_ = _loc19_ = _loc7_ = _loc1_ * _loc7_) * _loc1_;
                     if(_loc23_ == 0)
                     {
                        _loc7_ = _loc20_ = 0;
                        if(!(_loc1_ != _loc7_ | _loc1_ != _loc1_ | _loc7_ != _loc7_))
                        {
                           if(_loc25_ != 0)
                           {
                              var _loc13_:Number;
                              _loc20_ = _loc7_ = (_loc19_ = _loc7_ = (_loc10_ = _loc14_ = _loc25_) * (_loc19_ = 0.6931381225585938)) + (_loc14_ = _loc10_ = (_loc14_ = _loc10_ *= _loc13_ = 0.00000905800061445916) + _loc11_);
                           }
                        }
                        else
                        {
                           _loc18_ = _loc7_ = (_loc19_ = _loc7_ = (_loc19_ = _loc7_ = _loc1_ * (_loc19_ = -0.6666666865348816)) + (_loc14_ = 1)) * _loc16_;
                           if(_loc25_ == 0)
                           {
                              _loc20_ = _loc7_ = _loc1_ - _loc18_;
                           }
                           else
                           {
                              _loc20_ = _loc7_ = (_loc19_ = _loc7_ = (_loc10_ = _loc14_ = _loc25_) * (_loc19_ = 0.6931381225585938)) - (_loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ = _loc18_ - (_loc14_ = _loc10_ = (_loc14_ = _loc10_ *= _loc13_ = 0.00000905800061445916) + _loc11_)) - _loc1_);
                           }
                        }
                     }
                     §§goto(addr877);
                  }
                  _loc15_ = _loc18_;
                  _loc7_ = _loc19_ = 2;
                  _loc7_ = _loc19_ = _loc7_ = _loc15_ + _loc7_;
                  _loc1_ = _loc19_ = _loc7_ = _loc15_ / _loc7_;
                  _loc7_ = _loc19_ = _loc7_ = _loc1_ * _loc1_;
                  _loc10_ = _loc14_ = 0.14798198640346527;
                  _loc10_ = _loc14_ = _loc10_ = _loc7_ * _loc10_;
                  var _loc2_:* = _loc13_ = 0.15313838422298431;
                  _loc10_ = _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  _loc2_ = _loc13_ = 0.18183572590351105;
                  _loc10_ = _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  _loc2_ = _loc13_ = 0.2222219854593277;
                  _loc10_ = _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  _loc2_ = _loc13_ = 0.2857142984867096;
                  _loc10_ = _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  _loc2_ = _loc13_ = 0.4000000059604645;
                  _loc10_ = _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  _loc2_ = _loc13_ = 0.6666666865348816;
                  _loc18_ = _loc7_ = (_loc10_ = _loc14_ = _loc10_ += _loc2_) * _loc7_;
                  if(_loc25_ == 0)
                  {
                     _loc20_ = _loc7_ = _loc15_ - (_loc19_ = _loc7_ -= _loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ = (_loc7_ = _loc16_) + _loc18_) * _loc1_);
                  }
                  else
                  {
                     var _loc8_:Number;
                     _loc20_ = _loc7_ = (_loc10_ = _loc14_ = _loc10_ *= _loc13_ = 0.6931381225585938) - (_loc19_ = _loc7_ = (_loc7_ = _loc19_ = _loc7_ -= _loc13_ = (_loc14_ = _loc10_ = (_loc10_ = _loc14_ = _loc10_ = (_loc7_ = _loc16_) + _loc18_) * _loc1_) + (_loc8_ = (_loc8_ = (_loc10_ = _loc14_ = _loc25_) * (_loc14_ = 0.00000905800061445916)) + _loc11_)) - _loc15_);
                  }
               }
            }
            §§goto(addr189);
         }
         addr877:
         st0 = _loc20_;
         ESP = _loc5_ = _loc6_;
         return;
      }
      §§goto(addr189);
   }
}
