package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._Zero83;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_remquof() : void
   {
      var _loc2_:* = 0;
      var _loc10_:* = NaN;
      var _loc12_:* = NaN;
      var _loc21_:* = 0;
      var _loc24_:* = 0;
      var _loc23_:* = 0;
      var _loc6_:* = NaN;
      var _loc8_:* = NaN;
      var _loc5_:* = NaN;
      var _loc20_:* = 0;
      var _loc18_:* = 0;
      var _loc13_:* = 0;
      var _loc15_:* = 0;
      var _loc16_:* = 0;
      var _loc22_:* = 0;
      var _loc14_:* = 0;
      var _loc25_:* = 0;
      var _loc9_:* = NaN;
      var _loc7_:* = NaN;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 24;
      sf32(_loc10_ = lf32(_loc2_),_loc2_ - 4);
      sf32(_loc12_ = lf32(_loc2_ + 4),_loc2_ - 8);
      if((_loc25_ = (_loc14_ = li32(_loc2_ - 8)) & 2147483647) != 0)
      {
         if((_loc22_ = (_loc23_ = (_loc24_ = li32(_loc2_ - 4)) & -2147483648) ^ _loc24_) <= 2139095039)
         {
            if(uint(_loc25_) >= 2139095041)
            {
               addr104:
               var _loc4_:* = _loc12_;
               var _loc3_:* = _loc10_;
               var _loc11_:*;
               _loc4_ = _loc11_ = _loc4_ = _loc3_ * _loc4_;
               _loc7_ = _loc4_ /= _loc4_;
            }
            else
            {
               _loc24_ = _loc14_ ^ _loc24_;
               _loc21_ = li32(_loc2_ + 8);
               _loc20_ = 0;
               if(_loc22_ >= _loc25_)
               {
                  if(_loc22_ == _loc25_)
                  {
                     si32(1,_loc21_);
                     var _loc19_:*;
                     _loc7_ = lf32(_loc19_ = _Zero83 + (_loc23_ >>> 29));
                  }
                  else
                  {
                     if(_loc22_ <= 8388607)
                     {
                        _loc18_ = _loc22_ << 8;
                        _loc20_ = -126;
                        if(_loc18_ >= 1)
                        {
                           do
                           {
                              _loc20_ += -1;
                           }
                           while((_loc18_ <<= 1) > 0);
                           
                        }
                     }
                     else
                     {
                        _loc20_ = (_loc19_ = _loc22_ >> 23) + -127;
                     }
                     if(uint(_loc25_) <= 8388607)
                     {
                        _loc13_ = _loc14_ << 8;
                        _loc18_ = -126;
                        if(_loc13_ >= 1)
                        {
                           do
                           {
                              _loc18_ += -1;
                           }
                           while((_loc13_ <<= 1) > 0);
                           
                        }
                     }
                     else
                     {
                        _loc18_ = (_loc19_ = _loc25_ >>> 23) + -127;
                     }
                     if(_loc20_ >= -126)
                     {
                        _loc22_ = (_loc19_ = _loc22_ & 8388607) | 8388608;
                     }
                     else
                     {
                        _loc22_ <<= -126 - _loc20_;
                     }
                     if(_loc18_ >= -126)
                     {
                        _loc15_ = (_loc19_ = _loc14_ & 8388607) | 8388608;
                     }
                     else
                     {
                        _loc15_ = _loc25_ << -126 - _loc18_;
                     }
                     _loc13_ = _loc22_ - _loc15_;
                     _loc14_ = 0;
                     if(_loc20_ != _loc18_)
                     {
                        _loc20_ -= _loc18_;
                        _loc16_ = _loc13_;
                        _loc14_ = 0;
                        do
                        {
                           if(_loc16_ >= 0)
                           {
                              _loc22_ = _loc16_;
                           }
                           _loc13_ = (_loc22_ <<= 1) - _loc15_;
                           _loc14_ = (_loc19_ = (_loc19_ = (_loc19_ = _loc16_ >>> 31) | _loc14_) << 1) ^ 2;
                           _loc20_ += -1;
                           _loc16_ = _loc13_;
                        }
                        while(_loc20_ != 0);
                        
                     }
                     _loc15_ = _loc13_;
                     if(_loc13_ <= -1)
                     {
                        _loc15_ = _loc22_;
                     }
                     _loc20_ = (_loc19_ = (_loc19_ = _loc13_ >>> 31) ^ 1) | _loc14_;
                     if(_loc15_ != 0)
                     {
                        if(_loc15_ < 8388608)
                        {
                           do
                           {
                              _loc18_ += -1;
                           }
                           while((_loc15_ <<= 1) < 8388608);
                           
                        }
                        if(_loc18_ >= -126)
                        {
                           var _loc17_:*;
                           _loc22_ = (_loc17_ = (_loc17_ = _loc18_ << 23) + 1065353216) | _loc15_ + -8388608;
                        }
                        else
                        {
                           _loc22_ = _loc15_ >> -126 - _loc18_;
                        }
                     }
                     else
                     {
                        _loc25_ = 0 - _loc20_;
                        if(_loc24_ >= 0)
                        {
                           _loc25_ = _loc20_;
                        }
                        si32(_loc25_,_loc21_);
                        _loc19_ = _loc23_ >>> 29;
                        _loc7_ = lf32(_loc19_ = _Zero83 + _loc19_);
                        §§goto(addr646);
                     }
                  }
                  §§goto(addr646);
               }
               si32(_loc25_,_loc2_ - 16);
               si32(_loc22_,_loc2_ - 12);
               _loc3_ = _loc11_ = 2.350988701644575e-38;
               _loc6_ = _loc11_ = lf32(_loc2_ - 16);
               _loc9_ = lf32(_loc2_ - 12);
               if(!(_loc6_ >= _loc3_ | _loc6_ != _loc6_ | _loc3_ != _loc3_))
               {
                  _loc5_ = _loc9_;
                  if((_loc8_ = _loc11_ = _loc4_ = _loc5_ + _loc5_) <= _loc6_)
                  {
                     if(!(_loc8_ != _loc6_ | _loc8_ != _loc8_ | _loc6_ != _loc6_))
                     {
                        if((_loc19_ = _loc20_ & 1) != 0)
                        {
                        }
                     }
                     §§goto(addr603);
                  }
                  _loc9_ = _loc4_ = _loc5_ - _loc6_;
                  _loc20_ += 1;
               }
               else
               {
                  _loc8_ = _loc11_ = _loc4_ = _loc6_ * (_loc11_ = 0.5);
                  _loc5_ = _loc9_;
                  if(_loc8_ >= _loc5_)
                  {
                     if(!(_loc8_ != _loc5_ | _loc8_ != _loc8_ | _loc5_ != _loc5_))
                     {
                        if((_loc19_ = _loc20_ & 1) != 0)
                        {
                        }
                     }
                     §§goto(addr603);
                  }
                  _loc9_ = _loc4_ = _loc5_ - _loc6_;
                  _loc20_ += 1;
               }
               addr603:
               _loc20_ &= 2147483647;
               _loc18_ = 0 - _loc20_;
               if(_loc24_ >= 0)
               {
                  _loc18_ = _loc20_;
               }
               si32(_loc18_,_loc21_);
               sf32(_loc9_,_loc2_ - 20);
               si32(_loc19_ = (_loc19_ = li32(_loc2_ - 20)) ^ _loc23_,_loc2_ - 24);
               _loc7_ = lf32(_loc2_ - 24);
               §§goto(addr646);
            }
            addr646:
            st0 = _loc7_;
            _loc1_ = _loc2_;
            ESP = _loc1_;
            return;
         }
      }
      §§goto(addr104);
   }
}
