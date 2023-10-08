package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_jnf() : void
   {
      var _loc7_:int = 0;
      var _loc36_:* = 0;
      var _loc21_:* = NaN;
      var _loc22_:* = NaN;
      var _loc23_:* = NaN;
      var _loc31_:int = 0;
      var _loc9_:* = NaN;
      var _loc15_:* = NaN;
      var _loc1_:* = NaN;
      var _loc2_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = NaN;
      var _loc5_:* = NaN;
      var _loc25_:* = 0;
      var _loc34_:* = 0;
      var _loc19_:* = NaN;
      var _loc29_:int = 0;
      var _loc10_:* = NaN;
      var _loc16_:* = NaN;
      var _loc28_:* = 0;
      var _loc27_:int = 0;
      var _loc26_:* = NaN;
      var _loc8_:* = NaN;
      var _loc33_:* = NaN;
      var _loc35_:* = NaN;
      var _loc6_:* = (_loc7_ = ESP) - 32;
      sf32(_loc21_ = lf32(_loc7_ + 4),_loc7_ - 4);
      if((uint(_loc36_ = (_loc25_ = li32(_loc7_ - 4)) & 2147483647)) >= 2139095041)
      {
         var _loc11_:* = _loc21_;
         _loc23_ = _loc11_ += _loc11_;
      }
      else
      {
         if((_loc34_ = li32(_loc7_)) <= -1)
         {
            _loc25_ ^= -2147483648;
            _loc34_ = 0 - _loc34_;
            _loc21_ = _loc11_ = -(_loc11_ = _loc21_);
         }
         if(_loc34_ != 1)
         {
            if(_loc34_ == 0)
            {
               _loc6_ -= 16;
               sf32(_loc21_,_loc6_);
               ESP = _loc6_;
               F_j0f();
               _loc6_ += 16;
               _loc23_ = st0;
            }
            else
            {
               sf32(_loc21_,_loc7_ - 8);
               var _loc32_:*;
               si32(_loc32_ = (_loc32_ = li32(_loc7_ - 8)) & 2147483647,_loc7_ - 12);
               _loc23_ = 0;
               if(_loc36_ != 0)
               {
                  if(uint(_loc36_) <= 2139095039)
                  {
                     _loc9_ = _loc22_ = lf32(_loc7_ - 12);
                     var _loc17_:*;
                     if(!((_loc15_ = _loc17_ = _loc34_) > _loc9_ | _loc15_ != _loc15_ | _loc9_ != _loc9_))
                     {
                        _loc6_ -= 16;
                        sf32(_loc22_,_loc6_);
                        ESP = _loc6_;
                        F_j1f();
                        _loc6_ += 16;
                        _loc23_ = st0;
                        if(_loc34_ >= 2)
                        {
                           _loc6_ -= 16;
                           sf32(_loc22_,_loc6_);
                           ESP = _loc6_;
                           F_j0f();
                           _loc36_ = _loc34_ + -1;
                           _loc31_ = 2;
                           _loc6_ += 16;
                           _loc22_ = st0;
                           _loc19_ = _loc23_;
                           do
                           {
                              var _loc13_:* = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = _loc31_) / _loc9_;
                              _loc11_ = _loc19_;
                              _loc13_ = _loc17_ = _loc11_ = _loc13_ * _loc11_;
                              _loc11_ = _loc22_;
                              _loc23_ = _loc11_ = _loc13_ - _loc11_;
                              _loc31_ += 2;
                              _loc36_ += -1;
                              _loc22_ = _loc19_;
                              _loc19_ = _loc23_;
                           }
                           while(_loc36_ != 0);
                           
                        }
                     }
                     else if(uint(_loc36_) <= 813694975)
                     {
                        _loc23_ = 0;
                        if(_loc34_ <= 33)
                        {
                           _loc23_ = _loc11_ = _loc9_ * (_loc17_ = 0.5);
                           _loc22_ = 1;
                           _loc21_ = _loc23_;
                           if(_loc34_ >= 2)
                           {
                              _loc22_ = 1;
                              _loc31_ = 0 - _loc34_;
                              _loc36_ = 2;
                              _loc21_ = _loc23_;
                              do
                              {
                                 _loc32_ = _loc36_ + 1;
                                 var _loc30_:int = _loc31_ + _loc32_;
                                 var _loc20_:* = _loc23_;
                                 var _loc18_:*;
                                 _loc21_ = _loc18_ = (_loc18_ = _loc21_) * _loc20_;
                                 _loc18_ = _loc22_;
                                 var _loc14_:Number;
                                 _loc22_ = _loc18_ = (_loc20_ = _loc14_ = _loc36_) * _loc18_;
                                 _loc36_ = _loc32_;
                              }
                              while(_loc30_ != 1);
                              
                           }
                           _loc11_ = _loc22_;
                           _loc23_ = _loc11_ = (_loc13_ = _loc21_) / _loc11_;
                        }
                     }
                     else
                     {
                        _loc1_ = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = 2) / _loc9_;
                        var _loc12_:*;
                        _loc11_ = _loc23_ = _loc11_ = (_loc17_ = _loc11_ *= _loc10_ = _loc13_ = (_loc11_ = _loc16_ = _loc11_ = (_loc11_ = _loc17_ = _loc36_ = _loc34_ << 1) / _loc9_) + _loc1_) + (_loc12_ = -1);
                        _loc2_ = _loc12_ = 1000000000;
                        _loc29_ = 1;
                        if(!(_loc11_ >= _loc2_ | _loc11_ != _loc11_ | _loc2_ != _loc2_))
                        {
                           do
                           {
                              _loc17_ = _loc23_;
                              _loc13_ = _loc10_ = _loc13_ = (_loc13_ = _loc10_) + _loc1_;
                              _loc18_ = _loc17_;
                              _loc18_ = _loc12_ = _loc13_ *= _loc18_;
                              _loc13_ = _loc16_;
                              _loc13_ = _loc23_ = _loc13_ = _loc18_ - _loc13_;
                              _loc29_ += 1;
                              _loc16_ = _loc17_;
                           }
                           while(_loc13_ < _loc2_);
                           
                        }
                        _loc28_ = (_loc32_ = _loc29_ + _loc34_) << 1;
                        _loc23_ = 0;
                        if(_loc28_ >= _loc36_)
                        {
                           _loc23_ = 0;
                           do
                           {
                              _loc13_ = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = _loc28_) / _loc9_;
                              _loc11_ = _loc23_;
                              _loc11_ = _loc17_ = _loc11_ = _loc13_ - _loc11_;
                              _loc23_ = _loc11_ = (_loc13_ = _loc12_ = 1) / _loc11_;
                           }
                           while((_loc28_ += -2) >= _loc36_);
                           
                        }
                        sf32(_loc11_ = _loc1_ * _loc15_,_loc7_ - 16);
                        _loc6_ -= 16;
                        si32(_loc32_ = (_loc32_ = li32(_loc7_ - 16)) & 2147483647,_loc6_);
                        ESP = _loc6_;
                        F_logf();
                        _loc6_ += 16;
                        _loc11_ = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = st0) * _loc15_;
                        _loc13_ = _loc12_ = 88.7216796875;
                        var _loc24_:*;
                        _loc8_ = _loc24_ = (_loc27_ = _loc34_ + -1) << 1;
                        if(!(_loc11_ >= _loc13_ | _loc11_ != _loc11_ | _loc13_ != _loc13_))
                        {
                           _loc33_ = 1;
                           _loc35_ = _loc23_;
                           if(_loc27_ >= 1)
                           {
                              _loc33_ = 1;
                              _loc27_ = _loc34_ + -1;
                              _loc26_ = _loc23_;
                              while(true)
                              {
                                 _loc35_ = _loc33_;
                                 _loc11_ = _loc8_;
                                 _loc13_ = _loc12_ = -2;
                                 _loc8_ = _loc13_ = _loc11_ + _loc13_;
                                 _loc11_ = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = _loc11_ = (_loc13_ = _loc35_) * _loc11_) / _loc9_;
                                 _loc13_ = _loc26_;
                                 _loc33_ = _loc11_ -= _loc13_;
                                 _loc27_ += -1;
                                 _loc26_ = _loc35_;
                                 if(_loc27_ != 0)
                                 {
                                    continue;
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc33_ = 1;
                           _loc35_ = _loc23_;
                           if(_loc27_ >= 1)
                           {
                              _loc26_ = 1;
                              _loc35_ = _loc23_;
                              do
                              {
                                 _loc3_ = _loc8_;
                                 _loc13_ = _loc17_ = _loc11_ = (_loc11_ = _loc17_ = _loc11_ = (_loc4_ = _loc26_) * _loc3_) / _loc9_;
                                 _loc11_ = _loc35_;
                                 _loc5_ = _loc33_ = _loc11_ = _loc13_ - _loc11_;
                                 _loc11_ = _loc17_ = 10000000000;
                                 if(!(_loc5_ <= _loc11_ | _loc5_ != _loc5_ | _loc11_ != _loc11_))
                                 {
                                    _loc23_ = _loc11_ = (_loc11_ = _loc23_) / _loc5_;
                                    _loc26_ = _loc11_ = _loc4_ / _loc5_;
                                    _loc33_ = 1;
                                 }
                                 _loc35_ = _loc26_;
                                 _loc11_ = _loc17_ = -2;
                                 _loc8_ = _loc11_ = _loc3_ + _loc11_;
                                 _loc27_ += -1;
                                 _loc26_ = _loc33_;
                              }
                              while(_loc27_ != 0);
                              
                           }
                        }
                        _loc6_ -= 16;
                        sf32(_loc22_,_loc6_);
                        ESP = _loc6_;
                        F_j0f();
                        _loc6_ += 16;
                        sf32(_loc21_ = st0,_loc7_ - 20);
                        _loc6_ -= 16;
                        sf32(_loc22_,_loc6_);
                        si32(_loc32_ = (_loc32_ = li32(_loc7_ - 20)) & 2147483647,_loc7_ - 24);
                        ESP = _loc6_;
                        F_j1f();
                        _loc6_ += 16;
                        sf32(_loc22_ = st0,_loc7_ - 28);
                        si32(_loc32_ = (_loc32_ = li32(_loc7_ - 28)) & 2147483647,_loc7_ - 32);
                        _loc13_ = lf32(_loc7_ - 24);
                        _loc11_ = lf32(_loc7_ - 32);
                        if(!(_loc13_ < _loc11_ | _loc13_ != _loc13_ | _loc11_ != _loc11_))
                        {
                           _loc23_ = _loc11_ = (_loc17_ = _loc11_ = (_loc13_ = _loc23_) * _loc21_) / _loc33_;
                        }
                        else
                        {
                           _loc23_ = _loc11_ = (_loc17_ = _loc11_ = (_loc11_ = _loc23_) * _loc22_) / _loc35_;
                        }
                     }
                  }
               }
               _loc32_ = _loc25_ >>> 31;
               if((_loc32_ = _loc34_ & _loc32_) == 1)
               {
                  _loc23_ = _loc11_ = -(_loc11_ = _loc23_);
               }
            }
         }
         else
         {
            _loc6_ -= 16;
            sf32(_loc21_,_loc6_);
            ESP = _loc6_;
            F_j1f();
            _loc6_ += 16;
            _loc23_ = st0;
         }
      }
      st0 = _loc23_;
      ESP = _loc6_ = _loc7_;
   }
}
