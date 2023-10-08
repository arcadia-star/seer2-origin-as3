package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pi_lo3;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tiny2;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_atan2f() : void
   {
      var _loc6_:int = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = NaN;
      var _loc5_:* = 0;
      var _loc16_:* = 0;
      var _loc14_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 16;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      _loc3_ = lf32(_loc6_ + 4);
      sf32(_loc3_,_loc6_ - 8);
      if((uint(_loc16_ = (_loc5_ = li32(_loc6_ - 8)) & 2147483647)) <= 2139095040)
      {
         if((uint(_loc12_ = (_loc14_ = li32(_loc6_ - 4)) & 2147483647)) >= 2139095041)
         {
            addr79:
            var _loc10_:* = _loc1_;
            var _loc8_:*;
            _loc2_ = _loc8_ = (_loc8_ = _loc3_) + _loc10_;
         }
         else if(_loc5_ == 1065353216)
         {
            _loc4_ -= 16;
            sf32(_loc1_,_loc4_);
            ESP = _loc4_;
            F_atanf();
            _loc4_ += 16;
            _loc2_ = st0;
         }
         else
         {
            _loc11_ = _loc14_ >>> 31;
            var _loc9_:*;
            _loc7_ = (_loc9_ = (_loc9_ = _loc5_ >>> 30) & 2) | _loc11_;
            if(_loc12_ == 0)
            {
               _loc2_ = _loc1_;
               if(uint(_loc7_) >= 2)
               {
                  if(_loc7_ != 3)
                  {
                     if(_loc7_ == 2)
                     {
                        var _loc13_:*;
                        _loc2_ = _loc8_ = (_loc10_ = lf32(_tiny2)) + (_loc13_ = 3.1415927410125732);
                     }
                  }
                  else
                  {
                     _loc2_ = _loc8_ = (_loc13_ = -3.1415927410125732) - lf32(_tiny2);
                  }
               }
               §§goto(addr554);
            }
            if(_loc16_ != 2139095040)
            {
               if(_loc16_ == 0)
               {
                  _loc3_ = lf32(_tiny2);
                  if(_loc14_ <= -1)
                  {
                     var _loc15_:Number;
                     _loc2_ = _loc8_ = (_loc10_ = _loc15_ = -1.5707963705062866) - _loc3_;
                  }
                  else
                  {
                     _loc2_ = _loc8_ = _loc3_ + (_loc15_ = 1.5707963705062866);
                  }
               }
               else if(_loc12_ == 2139095040)
               {
                  addr363:
                  _loc3_ = lf32(_tiny2);
                  if(_loc14_ <= -1)
                  {
                     _loc2_ = _loc8_ = (_loc10_ = _loc15_ = -1.5707963705062866) - _loc3_;
                  }
                  else
                  {
                     _loc2_ = _loc8_ = _loc3_ + (_loc15_ = 1.5707963705062866);
                  }
               }
               else
               {
                  §§goto(addr395);
               }
            }
            else if(_loc12_ == 2139095040)
            {
               if(_loc7_ <= 1)
               {
                  if(_loc7_ != 0)
                  {
                     if(_loc7_ != 1)
                     {
                        §§goto(addr363);
                     }
                     else
                     {
                        _loc2_ = _loc8_ = (_loc13_ = -0.7853981852531433) - lf32(_tiny2);
                     }
                  }
                  else
                  {
                     _loc2_ = _loc8_ = (_loc10_ = lf32(_tiny2)) + (_loc13_ = 0.7853981852531433);
                  }
               }
               else if(_loc7_ != 2)
               {
                  if(_loc7_ != 3)
                  {
                     §§goto(addr363);
                  }
                  else
                  {
                     _loc2_ = _loc8_ = (_loc13_ = -2.356194496154785) - lf32(_tiny2);
                  }
               }
               else
               {
                  _loc2_ = _loc8_ = (_loc10_ = lf32(_tiny2)) + (_loc13_ = 2.356194496154785);
               }
            }
            else if(_loc7_ <= 1)
            {
               _loc2_ = 0;
               if(_loc7_ != 0)
               {
                  if(_loc7_ != 1)
                  {
                     §§goto(addr395);
                  }
                  else
                  {
                     _loc2_ = 0;
                  }
               }
            }
            else if(_loc7_ != 2)
            {
               if(_loc7_ != 3)
               {
                  addr395:
                  if((_loc14_ = (_loc9_ = _loc12_ - _loc16_) >> 23) >= 27)
                  {
                     _loc2_ = _loc8_ = (_loc13_ = _loc8_ = (_loc10_ = lf32(_pi_lo3)) * (_loc13_ = 0.5)) + (_loc15_ = 1.5707963705062866);
                  }
                  else
                  {
                     if(_loc14_ <= -27)
                     {
                        _loc2_ = 0;
                        _loc11_ = _loc7_;
                        if(_loc5_ >= 0)
                        {
                        }
                        §§goto(addr492);
                     }
                     _loc8_ = _loc3_;
                     sf32(_loc8_ = (_loc10_ = _loc1_) / _loc8_,_loc6_ - 12);
                     _loc4_ -= 16;
                     si32(_loc9_ = (_loc9_ = li32(_loc6_ - 12)) & 2147483647,_loc4_);
                     ESP = _loc4_;
                     F_atanf();
                     _loc4_ += 16;
                     _loc2_ = st0;
                     _loc11_ = _loc7_;
                  }
                  addr492:
                  if(_loc11_ != 0)
                  {
                     if(_loc11_ != 2)
                     {
                        if(_loc11_ == 1)
                        {
                           _loc2_ = _loc8_ = -(_loc8_ = _loc2_);
                        }
                        else
                        {
                           _loc2_ = _loc8_ = (_loc13_ = _loc8_ = _loc2_ - lf32(_pi_lo3)) + (_loc15_ = -3.1415927410125732);
                        }
                     }
                     else
                     {
                        _loc2_ = _loc8_ = (_loc10_ = _loc15_ = 3.1415927410125732) - (_loc13_ = _loc8_ = _loc2_ - lf32(_pi_lo3));
                     }
                  }
                  §§goto(addr554);
               }
               else
               {
                  _loc2_ = _loc8_ = (_loc13_ = -3.1415927410125732) - lf32(_tiny2);
               }
            }
            else
            {
               _loc2_ = _loc8_ = (_loc10_ = lf32(_tiny2)) + (_loc13_ = 3.1415927410125732);
            }
         }
         addr554:
         st0 = _loc2_;
         ESP = _loc4_ = _loc6_;
         return;
      }
      §§goto(addr79);
   }
}
