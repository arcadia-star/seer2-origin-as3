package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._Zero82;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_fmod() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = NaN;
      var _loc13_:* = 0;
      var _loc4_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc17_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc16_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 24;
      sf64(_loc12_ = lf64(_loc3_),_loc3_ - 8);
      sf64(_loc10_ = lf64(_loc3_ + 8),_loc3_ - 16);
      _loc1_ = _loc3_ - 16;
      _loc1_ |= 4;
      _loc16_ = (_loc17_ = li32(_loc1_)) & 2147483647;
      _loc15_ = li32(_loc3_ - 16);
      _loc1_ = _loc16_ | _loc15_;
      if(_loc1_ != 0)
      {
         if((_loc9_ = (_loc11_ = (_loc13_ = li32(_loc3_ - 8 | 4)) & -2147483648) ^ _loc13_) <= 2146435071)
         {
            if((uint((_loc15_ | 0 - _loc15_) >>> 31 | _loc16_)) >= 2146435073)
            {
               addr124:
               var _loc14_:Number = _loc12_ * _loc10_;
               _loc12_ = _loc14_ / _loc14_;
            }
            else
            {
               _loc8_ = li32(_loc3_ - 8);
               if(_loc9_ <= _loc16_)
               {
                  if(_loc9_ >= _loc16_)
                  {
                     if(uint(_loc8_) >= uint(_loc15_))
                     {
                        if(_loc8_ == _loc15_)
                        {
                           _loc12_ = lf64(_Zero82 + ((_loc13_ & -2147483648) >>> 28));
                        }
                     }
                  }
                  §§goto(addr693);
               }
               if(_loc9_ <= 1048575)
               {
                  if(_loc13_ == _loc11_)
                  {
                     _loc7_ = -1043;
                     _loc6_ = _loc8_;
                     if(_loc8_ >= 1)
                     {
                        do
                        {
                           _loc7_ += -1;
                        }
                        while((_loc6_ <<= 1) > 0);
                        
                     }
                  }
                  else
                  {
                     _loc6_ = _loc9_ << 11;
                     _loc7_ = -1022;
                     if(_loc6_ >= 1)
                     {
                        do
                        {
                           _loc7_ += -1;
                        }
                        while((_loc6_ <<= 1) > 0);
                        
                     }
                  }
               }
               else
               {
                  _loc7_ = (_loc9_ >> 20) + -1023;
               }
               if(uint(_loc16_) <= 1048575)
               {
                  if(_loc16_ == 0)
                  {
                     _loc6_ = -1043;
                     _loc4_ = _loc15_;
                     if(_loc15_ >= 1)
                     {
                        do
                        {
                           _loc6_ += -1;
                        }
                        while((_loc4_ <<= 1) > 0);
                        
                     }
                  }
                  else
                  {
                     _loc4_ = _loc17_ << 11;
                     _loc6_ = -1022;
                     if(_loc4_ >= 1)
                     {
                        do
                        {
                           _loc6_ += -1;
                        }
                        while((_loc4_ <<= 1) > 0);
                        
                     }
                  }
               }
               else
               {
                  _loc6_ = (_loc16_ >>> 20) + -1023;
               }
               if(_loc7_ >= -1022)
               {
                  _loc9_ = _loc9_ & 1048575 | 1048576;
               }
               else if((_loc4_ = -1022 - _loc7_) <= 31)
               {
                  var _loc5_:*;
                  _loc9_ = (_loc5_ = _loc8_ >>> 32 - _loc4_) | _loc9_ << _loc4_;
                  _loc8_ <<= _loc4_;
               }
               else
               {
                  _loc9_ = _loc8_ << _loc4_ + -32;
                  _loc8_ = 0;
               }
               if(_loc6_ >= -1022)
               {
                  _loc17_ = _loc17_ & 1048575 | 1048576;
               }
               else if((_loc4_ = -1022 - _loc6_) <= 31)
               {
                  _loc17_ = (_loc5_ = _loc15_ >>> 32 - _loc4_) | _loc16_ << _loc4_;
                  _loc15_ <<= _loc4_;
               }
               else
               {
                  _loc17_ = _loc15_ << _loc4_ + -32;
                  _loc15_ = 0;
               }
               _loc1_ = _loc7_ + 1;
               _loc7_ = _loc1_ - _loc6_;
               while(true)
               {
                  _loc16_ = 1;
                  if(uint(_loc8_) >= uint(_loc15_))
                  {
                     _loc16_ = 0;
                  }
                  _loc5_ = _loc16_ & 1;
                  _loc1_ = _loc9_ - _loc17_;
                  _loc4_ = _loc1_ - _loc5_;
                  _loc16_ = _loc8_ - _loc15_;
                  if((_loc7_ += -1) == 0)
                  {
                     if(_loc4_ <= -1)
                     {
                        _loc16_ = _loc8_;
                     }
                     if(_loc4_ <= -1)
                     {
                        _loc4_ = _loc9_;
                     }
                     _loc1_ = _loc4_ | _loc16_;
                     if(_loc1_ != 0)
                     {
                        if(_loc4_ < 1048576)
                        {
                           do
                           {
                              _loc5_ = _loc16_ >>> 31;
                              _loc1_ = _loc4_ << 1;
                              _loc4_ = _loc1_ | _loc5_;
                              _loc6_ += -1;
                              _loc16_ <<= 1;
                           }
                           while(_loc4_ < 1048576);
                           
                        }
                        if(_loc6_ >= -1022)
                        {
                           _loc11_ = _loc4_ + -1048576 | _loc11_ | (_loc5_ = _loc6_ << 20) + 1072693248;
                        }
                        else
                        {
                           if((_loc15_ = -1022 - _loc6_) <= 20)
                           {
                              _loc16_ = (_loc5_ = _loc4_ << 32 - _loc15_) | _loc16_ >>> _loc15_;
                              _loc15_ = _loc4_ >> _loc15_;
                           }
                           else if(_loc15_ <= 31)
                           {
                              _loc16_ = (_loc5_ = _loc4_ << 32 - _loc15_) | _loc16_ >>> _loc15_;
                              _loc15_ = _loc11_;
                           }
                           else
                           {
                              _loc16_ = _loc4_ >> _loc15_ + -32;
                              _loc15_ = _loc11_;
                           }
                           _loc11_ = _loc15_ | _loc11_;
                        }
                        _loc1_ = _loc3_ - 24;
                        _loc1_ |= 4;
                        si32(_loc11_,_loc1_);
                        si32(_loc16_,_loc3_ - 24);
                        _loc12_ = lf64(_loc3_ - 24);
                        break;
                     }
                     _loc12_ = lf64(_Zero82 + ((_loc13_ & -2147483648) >>> 28));
                     break;
                  }
                  if(_loc4_ <= -1)
                  {
                     _loc9_ = _loc8_ >>> 31 | _loc9_ << 1;
                  }
                  else
                  {
                     if((_loc4_ | _loc16_) == 0)
                     {
                        _loc12_ = lf64(_Zero82 + ((_loc13_ & -2147483648) >>> 28));
                        break;
                     }
                     _loc9_ = _loc4_ << 1 | _loc16_ >>> 31;
                     _loc8_ = _loc16_;
                  }
                  _loc8_ <<= 1;
               }
            }
            addr693:
            st0 = _loc12_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr124);
   }
}
