package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._TWO23;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_scalbf() : void
   {
      var _loc6_:int = 0;
      var _loc1_:* = NaN;
      var _loc5_:* = 0;
      var _loc20_:* = 0;
      var _loc14_:int = 0;
      var _loc16_:int = 0;
      var _loc9_:* = 0;
      var _loc7_:int = 0;
      var _loc12_:* = NaN;
      var _loc10_:* = NaN;
      var _loc8_:* = 0;
      var _loc17_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 64;
      _loc1_ = lf32(_loc6_ + 4);
      _loc12_ = _loc1_;
      _loc3_ = lf32(_loc6_);
      _loc10_ = _loc3_;
      if(!(_loc10_ == _loc10_ & _loc12_ == _loc12_))
      {
         var _loc15_:*;
         _loc3_ = _loc15_ = _loc10_ * _loc12_;
      }
      else
      {
         sf32(_loc1_,_loc6_ - 4);
         var _loc18_:*;
         if((_loc18_ = (_loc20_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647) + -2139095040) >= 0)
         {
            _loc15_ = 0;
            if(!(_loc12_ <= _loc15_ | _loc12_ != _loc12_ | _loc15_ != _loc15_))
            {
               _loc3_ = _loc15_ = _loc10_ * _loc12_;
            }
            else
            {
               _loc3_ = _loc15_ = _loc10_ / (_loc15_ = -_loc12_);
            }
         }
         else
         {
            if((_loc16_ = (_loc18_ = (_loc18_ = _loc5_ >>> 23) & 255) + -127) <= 22)
            {
               _loc14_ = _loc5_ >>> 31;
               if(_loc16_ <= -1)
               {
                  _loc17_ = _loc1_;
                  if(_loc20_ != 0)
                  {
                     var _loc13_:*;
                     var _loc19_:*;
                     sf32(_loc15_ = (_loc13_ = _loc19_ = _loc13_ = (_loc15_ = lf32(_loc18_ = _TWO23 + (_loc14_ << 2))) + _loc12_) - _loc15_,_loc6_ - 8);
                     var _loc11_:*;
                     si32(_loc18_ = (_loc11_ = (_loc11_ = li32(_loc6_ - 8)) & 2147483647) | _loc5_ & -2147483648,_loc6_ - 12);
                     _loc17_ = lf32(_loc6_ - 12);
                  }
               }
               else
               {
                  _loc17_ = _loc15_ = (_loc13_ = _loc19_ = _loc13_ = (_loc15_ = lf32(_loc18_ = _TWO23 + (_loc14_ << 2))) + _loc12_) - _loc15_;
               }
            }
            else
            {
               _loc17_ = _loc1_;
               if(_loc16_ == 128)
               {
                  _loc17_ = _loc15_ = _loc12_ + _loc12_;
               }
            }
            if((_loc15_ = _loc17_) != _loc12_)
            {
               _loc15_ = _loc15_ = _loc12_ - _loc12_;
               _loc3_ = _loc15_ /= _loc15_;
            }
            else
            {
               _loc15_ = 65000;
               if(!(_loc12_ <= _loc15_ | _loc12_ != _loc12_ | _loc15_ != _loc15_))
               {
                  sf32(_loc3_,_loc6_ - 24);
                  if((_loc8_ = (_loc18_ = (_loc9_ = li32(_loc6_ - 24)) >>> 23) & 255) == 0)
                  {
                     if((_loc18_ = _loc9_ & 2147483647) != 0)
                     {
                        _loc3_ = _loc15_ = _loc10_ * 33554432;
                        sf32(_loc3_,_loc6_ - 28);
                        _loc8_ = (_loc18_ = (_loc18_ = (_loc9_ = li32(_loc6_ - 28)) >>> 23) & 255) + -25;
                     }
                     §§goto(addr673);
                  }
                  if(_loc8_ == 255)
                  {
                     _loc15_ = _loc3_;
                     _loc3_ = _loc15_ += _loc15_;
                  }
                  else if((_loc7_ = _loc8_ + 65000) >= 255)
                  {
                     sf32(_loc3_,_loc6_ - 48);
                     si32(_loc18_ = (_loc18_ = (_loc18_ = li32(_loc6_ - 48)) & -2147483648) | 1900671690,_loc6_ - 52);
                     _loc3_ = _loc15_ = (_loc13_ = lf32(_loc6_ - 52)) * 1.0000000150474662e+30;
                  }
                  else if(_loc7_ >= 1)
                  {
                     si32(_loc18_ = (_loc11_ = _loc9_ & -2139095041) | _loc7_ << 23,_loc6_ - 44);
                     _loc3_ = lf32(_loc6_ - 44);
                  }
                  else if(_loc7_ <= -25)
                  {
                     sf32(_loc3_,_loc6_ - 36);
                     si32(_loc18_ = (_loc18_ = (_loc18_ = li32(_loc6_ - 36)) & -2147483648) | 1900671690,_loc6_ - 40);
                     _loc3_ = _loc15_ = (_loc13_ = lf32(_loc6_ - 40)) * 1.0000000150474662e+30;
                  }
                  else
                  {
                     si32(_loc18_ = (_loc11_ = (_loc11_ = _loc7_ << 23) + 209715200) | _loc9_ & -2139095041,_loc6_ - 32);
                     _loc3_ = _loc15_ = (_loc13_ = lf32(_loc6_ - 32)) * 2.9802322387695312e-8;
                  }
               }
               else
               {
                  _loc15_ = -65000;
                  if(!(_loc12_ >= _loc15_ | _loc12_ != _loc12_ | _loc15_ != _loc15_))
                  {
                     sf32(_loc3_,_loc6_ - 16);
                     if((_loc8_ = (_loc18_ = (_loc9_ = li32(_loc6_ - 16)) >>> 23) & 255) != 255)
                     {
                        if(_loc8_ == 0)
                        {
                           if((_loc18_ = _loc9_ & 2147483647) != 0)
                           {
                              _loc3_ = _loc15_ = (_loc15_ = _loc10_ * 33554432) * (_loc19_ = 1.0000000031710769e-30);
                           }
                        }
                        else
                        {
                           si32(_loc18_ = (_loc18_ = _loc9_ & -2147483648) | 228737632,_loc6_ - 20);
                           _loc3_ = _loc15_ = (_loc15_ = lf32(_loc6_ - 20)) * 1.0000000031710769e-30;
                        }
                     }
                     else
                     {
                        _loc3_ = _loc15_ = _loc10_ + _loc10_;
                     }
                  }
                  else
                  {
                     _loc4_ -= 16;
                     sf32(_loc3_,_loc4_);
                     si32(_loc18_ = _loc1_,_loc4_ + 4);
                     ESP = _loc4_;
                     F_scalbnf();
                     _loc4_ += 16;
                     _loc3_ = st0;
                  }
               }
            }
         }
      }
      addr673:
      st0 = _loc3_;
      ESP = _loc4_ = _loc6_;
   }
}
