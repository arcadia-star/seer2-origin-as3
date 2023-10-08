package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_jn() : void
   {
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc12_:* = NaN;
      var _loc11_:* = 0;
      var _loc15_:* = 0;
      var _loc2_:Number = NaN;
      var _loc1_:* = NaN;
      var _loc21_:* = 0;
      var _loc16_:* = 0;
      var _loc13_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:int = 0;
      var _loc18_:* = NaN;
      var _loc17_:* = NaN;
      var _loc4_:Number = NaN;
      var _loc3_:* = NaN;
      var _loc10_:Number = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 16;
      sf64(_loc12_ = lf64(_loc7_ + 4),_loc7_ - 8);
      _loc6_ = li32(_loc7_ - 8);
      _loc21_ = 0 - _loc6_;
      _loc21_ = (_loc21_ = _loc6_ | _loc21_) >>> 31;
      var _loc19_:*;
      _loc15_ = (_loc16_ = li32(_loc19_ = (_loc19_ = _loc7_ - 8) | 4)) & 2147483647;
      if((uint(_loc21_ |= _loc15_)) >= 2146435073)
      {
         _loc10_ = _loc12_ + _loc12_;
      }
      else
      {
         if((_loc13_ = li32(_loc7_)) <= -1)
         {
            _loc16_ ^= -2147483648;
            _loc12_ = -_loc12_;
            _loc13_ = 0 - _loc13_;
         }
         if(_loc13_ != 1)
         {
            if(_loc13_ == 0)
            {
               _loc5_ -= 16;
               sf64(_loc12_,_loc5_);
               ESP = _loc5_;
               F_j0();
               _loc5_ += 16;
               _loc10_ = st0;
            }
            else
            {
               _loc10_ = 0;
               if(!(_loc12_ >= _loc10_ | _loc12_ != _loc12_ | _loc10_ != _loc10_))
               {
                  _loc12_ = -_loc12_;
               }
               if((_loc21_ = _loc15_ | _loc6_) != 0)
               {
                  if(uint(_loc15_) <= 2146435071)
                  {
                     if(!((_loc17_ = _loc13_) > _loc12_ | _loc17_ != _loc17_ | _loc12_ != _loc12_))
                     {
                        if(uint(_loc15_) >= 1389363200)
                        {
                           if((_loc11_ = _loc13_ & 3) <= 1)
                           {
                              if(_loc11_ != 0)
                              {
                                 if(_loc11_ == 1)
                                 {
                                    _loc10_ = Math.sin(_loc12_) - Math.cos(_loc12_);
                                 }
                              }
                              else
                              {
                                 _loc10_ = Math.cos(_loc12_) + Math.sin(_loc12_);
                              }
                           }
                           else if(_loc11_ != 2)
                           {
                              if(_loc11_ == 3)
                              {
                                 _loc10_ = Math.cos(_loc12_) - Math.sin(_loc12_);
                              }
                           }
                           else
                           {
                              var _loc20_:* = Math.sin(_loc12_);
                              var _loc14_:Number;
                              _loc10_ = (_loc14_ = -Math.cos(_loc12_)) - _loc20_;
                           }
                           _loc14_ = Math.sqrt(_loc12_);
                           _loc10_ = (_loc20_ = _loc10_ * 0.5641895835477563) / _loc14_;
                        }
                        else
                        {
                           _loc5_ -= 16;
                           sf64(_loc12_,_loc5_);
                           ESP = _loc5_;
                           F_j0();
                           _loc5_ += 16;
                           _loc18_ = st0;
                           _loc5_ -= 16;
                           sf64(_loc12_,_loc5_);
                           ESP = _loc5_;
                           F_j1();
                           _loc5_ += 16;
                           _loc10_ = st0;
                           if(_loc13_ >= 2)
                           {
                              _loc9_ = _loc13_ + -1;
                              _loc8_ = 2;
                              _loc17_ = _loc10_;
                              do
                              {
                                 _loc10_ = (_loc20_ = (_loc20_ = (_loc20_ = _loc8_) / _loc12_) * _loc17_) - _loc18_;
                                 _loc8_ += 2;
                                 _loc9_ += -1;
                                 _loc18_ = _loc17_;
                                 _loc17_ = _loc10_;
                              }
                              while(_loc9_ != 0);
                              
                           }
                        }
                     }
                     else if(uint(_loc15_) <= 1041235967)
                     {
                        _loc10_ = 0;
                        if(_loc13_ <= 33)
                        {
                           _loc12_ *= 0.5;
                           _loc18_ = 1;
                           _loc17_ = _loc12_;
                           if(_loc13_ >= 2)
                           {
                              _loc11_ = 0 - _loc13_;
                              _loc18_ = 1;
                              _loc9_ = 2;
                              _loc17_ = _loc12_;
                              do
                              {
                                 _loc17_ *= _loc12_;
                                 _loc18_ = (_loc20_ = _loc9_) * _loc18_;
                                 _loc9_ += 1;
                              }
                              while((_loc21_ = _loc11_ + _loc9_) != 1);
                              
                           }
                           _loc10_ = _loc17_ / _loc18_;
                        }
                     }
                     else
                     {
                        _loc1_ = (_loc20_ = _loc15_ = _loc13_ << 1) / _loc12_;
                        _loc2_ = 2 / _loc12_;
                        _loc3_ = _loc1_ + _loc2_;
                        _loc4_ = (_loc20_ = _loc1_ * _loc3_) + -1;
                        _loc11_ = 1;
                        if(!(_loc4_ >= 1000000000 | _loc4_ != _loc4_ | false))
                        {
                           do
                           {
                              _loc20_ = _loc4_;
                              _loc3_ += _loc2_;
                              _loc4_ = (_loc14_ = _loc3_ * _loc20_) - _loc1_;
                              _loc11_ += 1;
                              _loc1_ = _loc20_;
                           }
                           while(_loc4_ < 1000000000);
                           
                        }
                        _loc8_ = (_loc21_ = _loc11_ + _loc13_) << 1;
                        _loc10_ = 0;
                        if(_loc8_ >= _loc15_)
                        {
                           _loc10_ = 0;
                           do
                           {
                              _loc20_ = (_loc20_ = (_loc20_ = _loc8_) / _loc12_) - _loc10_;
                              _loc10_ = 1 / _loc20_;
                           }
                           while((_loc8_ += -2) >= _loc15_);
                           
                        }
                        if(!((_loc18_ = _loc2_ * _loc17_) >= 0 | _loc18_ != _loc18_ | false))
                        {
                           _loc18_ = -_loc18_;
                        }
                        _loc5_ -= 16;
                        sf64(_loc18_,_loc5_);
                        ESP = _loc5_;
                        F_log();
                        _loc5_ += 16;
                        _loc14_ = (_loc20_ = st0) * _loc17_;
                        _loc2_ = _loc21_ = (_loc8_ = _loc13_ + -1) << 1;
                        if(!(_loc14_ >= 709.782712893384 | _loc14_ != _loc14_ | false))
                        {
                           _loc17_ = 1;
                           _loc18_ = _loc10_;
                           if(_loc8_ >= 1)
                           {
                              _loc8_ = _loc13_ + -1;
                              _loc17_ = 1;
                              _loc1_ = _loc10_;
                              while(true)
                              {
                                 _loc17_ = (_loc20_ = (_loc20_ = (_loc18_ = _loc17_) * _loc2_) / _loc12_) - _loc1_;
                                 _loc8_ += -1;
                                 _loc2_ += -2;
                                 _loc1_ = _loc18_;
                                 if(_loc8_ != 0)
                                 {
                                    continue;
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc17_ = 1;
                           _loc18_ = _loc10_;
                           if(_loc8_ >= 1)
                           {
                              _loc1_ = 1;
                              _loc18_ = _loc10_;
                              do
                              {
                                 if(!((_loc17_ = (_loc20_ = (_loc20_ = _loc1_ * _loc2_) / _loc12_) - _loc18_) <= 1e+100 | _loc17_ != _loc17_ | false))
                                 {
                                    _loc10_ /= _loc17_;
                                    _loc1_ /= _loc17_;
                                    _loc17_ = 1;
                                 }
                                 _loc18_ = _loc1_;
                                 _loc2_ += -2;
                                 _loc8_ += -1;
                                 _loc1_ = _loc17_;
                              }
                              while(_loc8_ != 0);
                              
                           }
                        }
                        _loc5_ -= 16;
                        sf64(_loc12_,_loc5_);
                        ESP = _loc5_;
                        F_j0();
                        _loc5_ += 16;
                        _loc2_ = st0;
                        _loc5_ -= 16;
                        sf64(_loc12_,_loc5_);
                        ESP = _loc5_;
                        F_j1();
                        _loc5_ += 16;
                        _loc1_ = st0;
                        _loc3_ = _loc2_;
                        if(!(_loc2_ >= 0 | _loc2_ != _loc2_ | false))
                        {
                           _loc3_ = -_loc2_;
                        }
                        _loc12_ = _loc1_;
                        if(!(_loc1_ >= 0 | _loc1_ != _loc1_ | false))
                        {
                           _loc12_ = -_loc1_;
                        }
                        if(!(_loc3_ < _loc12_ | _loc3_ != _loc3_ | _loc12_ != _loc12_))
                        {
                           _loc10_ = (_loc20_ = _loc10_ * _loc2_) / _loc17_;
                        }
                        else
                        {
                           _loc10_ = (_loc20_ = _loc10_ * _loc1_) / _loc18_;
                        }
                     }
                  }
               }
               _loc21_ = _loc16_ >>> 31;
               if((_loc21_ = _loc13_ & _loc21_) == 1)
               {
                  _loc10_ = -_loc10_;
               }
            }
         }
         else
         {
            _loc5_ -= 16;
            sf64(_loc12_,_loc5_);
            ESP = _loc5_;
            F_j1();
            _loc5_ += 16;
            _loc10_ = st0;
         }
      }
      st0 = _loc10_;
      ESP = _loc5_ = _loc7_;
   }
}
