package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._Zero82;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_remquo() : void
   {
      var _loc6_:* = 0;
      var _loc15_:* = NaN;
      var _loc13_:* = NaN;
      var _loc11_:* = 0;
      var _loc18_:* = 0;
      var _loc23_:* = 0;
      var _loc19_:* = 0;
      var _loc12_:* = 0;
      var _loc16_:* = 0;
      var _loc21_:* = 0;
      var _loc22_:Number = NaN;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:int = 0;
      var _loc14_:* = 0;
      var _loc1_:* = 0;
      var _loc17_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 40;
      sf64(_loc15_ = lf64(_loc6_),_loc6_ - 8);
      sf64(_loc13_ = lf64(_loc6_ + 8),_loc6_ - 16);
      var _loc4_:*;
      _loc21_ = (_loc23_ = li32(_loc4_ = (_loc4_ = _loc6_ - 16) | 4)) & 2147483647;
      _loc19_ = li32(_loc6_ - 16);
      if((_loc4_ = _loc21_ | _loc19_) != 0)
      {
         if((_loc14_ = (_loc16_ = (_loc18_ = li32(_loc4_ = (_loc4_ = _loc6_ - 8) | 4)) & -2147483648) ^ _loc18_) <= 2146435071)
         {
            if((uint(_loc4_ = (_loc4_ = (_loc4_ = _loc19_ | 0 - _loc19_) >>> 31) | _loc21_)) >= 2146435073)
            {
               addr144:
               var _loc20_:Number = _loc15_ * _loc13_;
               _loc15_ = _loc20_ / _loc20_;
            }
            else
            {
               _loc12_ = _loc23_ ^ _loc18_;
               _loc11_ = li32(_loc6_ + 16);
               _loc1_ = li32(_loc6_ - 8);
               if(_loc14_ <= _loc21_)
               {
                  _loc7_ = 0;
                  if(_loc14_ >= _loc21_)
                  {
                     if(uint(_loc1_) >= uint(_loc19_))
                     {
                        if(_loc1_ == _loc19_)
                        {
                           si32(1,_loc11_);
                           _loc15_ = lf64(_loc4_ = _Zero82 + ((_loc4_ = _loc18_ & -2147483648) >>> 28));
                        }
                        else
                        {
                           addr211:
                           if(_loc14_ <= 1048575)
                           {
                              if(_loc18_ == _loc16_)
                              {
                                 _loc7_ = -1043;
                                 _loc8_ = _loc1_;
                                 if(_loc1_ >= 1)
                                 {
                                    do
                                    {
                                       _loc7_ += -1;
                                    }
                                    while((_loc8_ <<= 1) > 0);
                                    
                                 }
                              }
                              else
                              {
                                 _loc8_ = _loc14_ << 11;
                                 _loc7_ = -1022;
                                 if(_loc8_ >= 1)
                                 {
                                    do
                                    {
                                       _loc7_ += -1;
                                    }
                                    while((_loc8_ <<= 1) > 0);
                                    
                                 }
                              }
                           }
                           else
                           {
                              _loc7_ = (_loc4_ = _loc14_ >> 20) + -1023;
                           }
                           if(uint(_loc21_) <= 1048575)
                           {
                              if(_loc21_ == 0)
                              {
                                 _loc8_ = -1043;
                                 _loc9_ = _loc19_;
                                 if(_loc19_ >= 1)
                                 {
                                    do
                                    {
                                       _loc8_ += -1;
                                    }
                                    while((_loc9_ <<= 1) > 0);
                                    
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc23_ << 11;
                                 _loc8_ = -1022;
                                 if(_loc9_ >= 1)
                                 {
                                    do
                                    {
                                       _loc8_ += -1;
                                    }
                                    while((_loc9_ <<= 1) > 0);
                                    
                                 }
                              }
                           }
                           else
                           {
                              _loc8_ = (_loc4_ = _loc21_ >>> 20) + -1023;
                           }
                           if(_loc7_ >= -1022)
                           {
                              _loc14_ = (_loc4_ = _loc14_ & 1048575) | 1048576;
                           }
                           else if((_loc9_ = -1022 - _loc7_) <= 31)
                           {
                              var _loc10_:*;
                              _loc14_ = (_loc10_ = _loc1_ >>> 32 - _loc9_) | _loc14_ << _loc9_;
                              _loc1_ <<= _loc9_;
                           }
                           else
                           {
                              _loc14_ = _loc1_ << _loc9_ + -32;
                              _loc1_ = 0;
                           }
                           if(_loc8_ >= -1022)
                           {
                              _loc9_ = (_loc4_ = _loc23_ & 1048575) | 1048576;
                           }
                           else if((_loc23_ = -1022 - _loc8_) <= 31)
                           {
                              _loc9_ = (_loc10_ = _loc19_ >>> 32 - _loc23_) | _loc21_ << _loc23_;
                              _loc19_ <<= _loc23_;
                           }
                           else
                           {
                              _loc9_ = _loc19_ << _loc23_ + -32;
                              _loc19_ = 0;
                           }
                           _loc23_ = 0;
                           _loc21_ = 1;
                           if(uint(_loc1_) >= uint(_loc19_))
                           {
                              _loc21_ = _loc23_;
                           }
                           _loc4_ = _loc21_ & 1;
                           _loc2_ = (_loc10_ = _loc14_ - _loc9_) - _loc4_;
                           _loc21_ = _loc1_ - _loc19_;
                           if(_loc7_ != _loc8_)
                           {
                              _loc7_ -= _loc8_;
                              _loc23_ = 0;
                              do
                              {
                                 if(_loc2_ <= -1)
                                 {
                                    _loc14_ = (_loc10_ = _loc1_ >>> 31) | _loc14_ << 1;
                                 }
                                 else
                                 {
                                    _loc14_ = (_loc10_ = _loc21_ >>> 31) | _loc2_ << 1;
                                    _loc23_ |= 1;
                                    _loc1_ = _loc21_;
                                 }
                                 _loc1_ <<= 1;
                                 _loc21_ = 1;
                                 if(uint(_loc1_) >= uint(_loc19_))
                                 {
                                    _loc21_ = 0;
                                 }
                                 _loc10_ = _loc21_ & 1;
                                 _loc2_ = (_loc4_ = _loc14_ - _loc9_) - _loc10_;
                                 _loc21_ = _loc1_ - _loc19_;
                                 _loc7_ += -1;
                                 _loc23_ <<= 1;
                              }
                              while(_loc7_ != 0);
                              
                           }
                           if(_loc2_ <= -1)
                           {
                              _loc21_ = _loc1_;
                           }
                           _loc19_ = _loc2_;
                           if(_loc2_ <= -1)
                           {
                              _loc19_ = _loc14_;
                           }
                           _loc4_ = _loc21_ | _loc19_;
                           _loc10_ = _loc2_ >>> 31;
                           _loc7_ = (_loc10_ = _loc23_ | _loc10_) ^ 1;
                           if(_loc4_ != 0)
                           {
                              if(_loc19_ < 1048576)
                              {
                                 do
                                 {
                                    _loc10_ = _loc19_ << 1;
                                    _loc19_ = (_loc4_ = _loc21_ >>> 31) | _loc10_;
                                    _loc8_ += -1;
                                    _loc21_ <<= 1;
                                 }
                                 while(_loc19_ < 1048576);
                                 
                              }
                              if(_loc8_ >= -1022)
                              {
                                 _loc14_ = (_loc10_ = (_loc10_ = _loc8_ << 20) + 1072693248) | _loc19_ + -1048576;
                                 _loc1_ = _loc21_;
                              }
                              else if((_loc18_ = -1022 - _loc8_) <= 20)
                              {
                                 _loc1_ = (_loc10_ = _loc19_ << 32 - _loc18_) | _loc21_ >>> _loc18_;
                                 _loc14_ = _loc19_ >> _loc18_;
                              }
                              else if(_loc18_ <= 31)
                              {
                                 _loc1_ = (_loc10_ = _loc19_ << 32 - _loc18_) | _loc21_ >>> _loc18_;
                                 _loc14_ = _loc16_;
                              }
                              else
                              {
                                 _loc1_ = _loc19_ >> _loc18_ + -32;
                                 _loc14_ = _loc16_;
                              }
                           }
                           else
                           {
                              _loc16_ = 0 - _loc7_;
                              if(_loc12_ >= 0)
                              {
                                 _loc16_ = _loc7_;
                              }
                              si32(_loc16_,_loc11_);
                              _loc4_ = (_loc4_ = _loc18_ & -2147483648) >>> 28;
                              _loc15_ = lf64(_loc4_ = _Zero82 + _loc4_);
                              §§goto(addr976);
                           }
                        }
                        §§goto(addr976);
                     }
                  }
                  _loc4_ = (_loc4_ = _loc6_ - 24) | 4;
                  si32(_loc14_,_loc4_);
                  si32(_loc1_,_loc6_ - 24);
                  _loc17_ = lf64(_loc6_ - 24);
                  if(!(_loc13_ >= 0 | _loc13_ != _loc13_ | false))
                  {
                     _loc13_ = -_loc13_;
                  }
                  if(!(_loc13_ >= 4.450147717014403e-308 | _loc13_ != _loc13_ | false))
                  {
                     if((_loc22_ = _loc17_ + _loc17_) <= _loc13_)
                     {
                        if(!(_loc22_ != _loc13_ | _loc22_ != _loc22_ | _loc13_ != _loc13_))
                        {
                           if((_loc4_ = _loc7_ & 1) != 0)
                           {
                           }
                        }
                        §§goto(addr909);
                     }
                     _loc17_ -= _loc13_;
                     _loc7_ += 1;
                  }
                  else
                  {
                     if((_loc22_ = _loc13_ * 0.5) >= _loc17_)
                     {
                        if(!(_loc22_ != _loc17_ | _loc22_ != _loc22_ | _loc17_ != _loc17_))
                        {
                           if((_loc4_ = _loc7_ & 1) != 0)
                           {
                           }
                        }
                        §§goto(addr909);
                     }
                     _loc17_ -= _loc13_;
                     _loc7_ += 1;
                  }
                  addr909:
                  sf64(_loc17_,_loc6_ - 32);
                  _loc4_ = (_loc4_ = li32(_loc4_ = (_loc4_ = _loc6_ - 32) | 4)) ^ _loc16_;
                  _loc10_ = (_loc10_ = _loc6_ - 40) | 4;
                  si32(_loc4_,_loc10_);
                  _loc5_ = _loc7_ & 2147483647;
                  _loc16_ = 0 - _loc5_;
                  if(_loc12_ >= 0)
                  {
                     _loc16_ = _loc5_;
                  }
                  si32(_loc16_,_loc11_);
                  si32(_loc4_ = li32(_loc6_ - 32),_loc6_ - 40);
                  _loc15_ = lf64(_loc6_ - 40);
                  §§goto(addr976);
               }
               §§goto(addr211);
            }
            addr976:
            st0 = _loc15_;
            _loc3_ = _loc6_;
            ESP = _loc3_;
            return;
         }
      }
      §§goto(addr144);
   }
}
