package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pi_lo;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tiny;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_atan2() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = NaN;
      var _loc8_:* = NaN;
      var _loc13_:* = 0;
      var _loc2_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:int = 0;
      var _loc16_:* = 0;
      var _loc15_:Number = NaN;
      var _loc12_:* = NaN;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 16;
      sf64(_loc8_ = lf64(_loc3_ + 8),_loc3_ - 16);
      sf64(_loc6_ = lf64(_loc3_),_loc3_ - 8);
      _loc2_ = li32(_loc3_ - 16);
      _loc16_ = 0 - _loc2_;
      _loc16_ = (_loc16_ = _loc2_ | _loc16_) >>> 31;
      var _loc14_:*;
      _loc11_ = (_loc13_ = li32(_loc14_ = (_loc14_ = _loc3_ - 16) | 4)) & 2147483647;
      if((uint(_loc16_ |= _loc11_)) <= 2146435072)
      {
         _loc7_ = (_loc9_ = li32(_loc16_ = (_loc16_ = _loc3_ - 8) | 4)) & 2147483647;
         _loc5_ = li32(_loc3_ - 8);
         if((uint(_loc16_ = (_loc16_ = (_loc16_ = _loc5_ | 0 - _loc5_) >>> 31) | _loc7_)) >= 2146435073)
         {
            addr144:
            _loc12_ = _loc8_ + _loc6_;
         }
         else if((_loc16_ = (_loc16_ = _loc13_ + -1072693248) | _loc2_) == 0)
         {
            _loc1_ -= 16;
            sf64(_loc6_,_loc1_);
            ESP = _loc1_;
            F_atan();
            _loc1_ += 16;
            _loc12_ = st0;
         }
         else
         {
            _loc4_ = _loc9_ >>> 31;
            _loc5_ = (_loc14_ = (_loc14_ = _loc13_ >>> 30) & 2) | _loc4_;
            if((_loc7_ | _loc5_) == 0)
            {
               _loc12_ = _loc6_;
               if(uint(_loc5_) >= 2)
               {
                  if(_loc5_ != 3)
                  {
                     if(_loc5_ == 2)
                     {
                        var _loc10_:*;
                        _loc12_ = (_loc10_ = lf64(_tiny)) + 3.141592653589793;
                     }
                  }
                  else
                  {
                     _loc12_ = -3.141592653589793 - lf64(_tiny);
                  }
               }
               §§goto(addr546);
            }
            if((_loc16_ = _loc11_ | _loc2_) == 0)
            {
               _loc6_ = lf64(_tiny);
               if(_loc9_ <= -1)
               {
                  _loc12_ = -1.5707963267948966 - _loc6_;
               }
               else
               {
                  _loc12_ = _loc6_ + 1.5707963267948966;
               }
            }
            else
            {
               if(_loc11_ == 2146435072)
               {
                  if(_loc7_ == 2146435072)
                  {
                     if(_loc5_ <= 1)
                     {
                        if(_loc5_ != 0)
                        {
                           if(_loc5_ != 1)
                           {
                              addr394:
                              _loc6_ = lf64(_tiny);
                              if(_loc9_ <= -1)
                              {
                                 _loc12_ = -1.5707963267948966 - _loc6_;
                              }
                              else
                              {
                                 _loc12_ = _loc6_ + 1.5707963267948966;
                              }
                           }
                           else
                           {
                              _loc12_ = -0.7853981633974483 - lf64(_tiny);
                           }
                        }
                        else
                        {
                           _loc12_ = (_loc10_ = lf64(_tiny)) + 0.7853981633974483;
                        }
                     }
                     else if(_loc5_ != 2)
                     {
                        if(_loc5_ != 3)
                        {
                           §§goto(addr394);
                        }
                        else
                        {
                           _loc12_ = -2.356194490192345 - lf64(_tiny);
                           §§goto(addr546);
                        }
                     }
                     else
                     {
                        _loc12_ = (_loc10_ = lf64(_tiny)) + 2.356194490192345;
                        §§goto(addr546);
                     }
                  }
                  else if(_loc5_ <= 1)
                  {
                     _loc12_ = 0;
                     if(_loc5_ != 0)
                     {
                        if(_loc5_ == 1)
                        {
                           _loc12_ = 0;
                        }
                     }
                  }
                  else if(_loc5_ != 2)
                  {
                     if(_loc5_ == 3)
                     {
                        _loc12_ = -3.141592653589793 - lf64(_tiny);
                     }
                  }
                  else
                  {
                     _loc12_ = (_loc10_ = lf64(_tiny)) + 3.141592653589793;
                  }
               }
               else if(_loc7_ == 2146435072)
               {
                  §§goto(addr394);
               }
               §§goto(addr546);
               if(_loc4_ != 0)
               {
                  if(_loc4_ != 2)
                  {
                     if(_loc4_ == 1)
                     {
                        _loc12_ = -_loc12_;
                     }
                     else
                     {
                        _loc12_ = (_loc10_ = _loc12_ - lf64(_pi_lo)) + -3.141592653589793;
                     }
                  }
                  else
                  {
                     _loc12_ = 3.141592653589793 - (_loc12_ - lf64(_pi_lo));
                  }
               }
               §§goto(addr546);
            }
         }
         addr546:
         st0 = _loc12_;
         _loc1_ = _loc3_;
         ESP = _loc1_;
         return;
      }
      §§goto(addr144);
   }
}
