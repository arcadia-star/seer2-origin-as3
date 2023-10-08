package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._Zero83;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_fmodf() : void
   {
      var _loc6_:int = 0;
      var _loc3_:* = NaN;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc16_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 12;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      _loc3_ = lf32(_loc6_ + 4);
      sf32(_loc3_,_loc6_ - 8);
      if((_loc16_ = (_loc5_ = li32(_loc6_ - 8)) & 2147483647) != 0)
      {
         var _loc15_:*;
         if((_loc13_ = (_loc14_ = (_loc15_ = li32(_loc6_ - 4)) & -2147483648) ^ _loc15_) <= 2139095039)
         {
            if(uint(_loc16_) >= 2139095041)
            {
               addr86:
               var _loc12_:* = _loc3_;
               var _loc10_:*;
               var _loc2_:* = _loc10_ = (_loc10_ = _loc1_) * _loc12_;
               _loc10_ = _loc2_;
               _loc1_ = _loc10_ /= _loc10_;
            }
            else if(_loc13_ >= _loc16_)
            {
               if(_loc13_ == _loc16_)
               {
                  _loc1_ = lf32(_loc15_ = _Zero83 + (_loc14_ >>> 29));
               }
               else
               {
                  if(_loc13_ <= 8388607)
                  {
                     _loc11_ = _loc13_ << 8;
                     _loc9_ = -126;
                     if(_loc11_ >= 1)
                     {
                        do
                        {
                           _loc9_ += -1;
                        }
                        while((_loc11_ <<= 1) > 0);
                        
                     }
                  }
                  else
                  {
                     _loc9_ = (_loc15_ = _loc13_ >> 23) + -127;
                  }
                  if(uint(_loc16_) <= 8388607)
                  {
                     _loc8_ = _loc5_ << 8;
                     _loc11_ = -126;
                     if(_loc8_ >= 0)
                     {
                        do
                        {
                           _loc11_ += -1;
                        }
                        while((_loc8_ <<= 1) > -1);
                        
                     }
                  }
                  else
                  {
                     _loc11_ = (_loc15_ = _loc16_ >>> 23) + -127;
                  }
                  if(_loc9_ >= -126)
                  {
                     _loc13_ = (_loc15_ = _loc13_ & 8388607) | 8388608;
                  }
                  else
                  {
                     _loc13_ <<= -126 - _loc9_;
                  }
                  if(_loc11_ >= -126)
                  {
                     _loc16_ = (_loc15_ = _loc5_ & 8388607) | 8388608;
                  }
                  else
                  {
                     _loc16_ <<= -126 - _loc11_;
                  }
                  _loc5_ = (_loc15_ = _loc9_ + 1) - _loc11_;
                  while(true)
                  {
                     _loc9_ = _loc13_ - _loc16_;
                     if((_loc5_ += -1) == 0)
                     {
                        if(_loc9_ <= -1)
                        {
                           _loc9_ = _loc13_;
                        }
                        if(_loc9_ != 0)
                        {
                           if(_loc9_ < 8388608)
                           {
                              do
                              {
                                 _loc11_ += -1;
                              }
                              while((_loc9_ <<= 1) < 8388608);
                              
                           }
                           if(_loc11_ >= -126)
                           {
                              var _loc7_:*;
                              _loc11_ = (_loc7_ = (_loc7_ = _loc11_ << 23) + 1065353216) | _loc9_ + -8388608;
                           }
                           else
                           {
                              _loc11_ = _loc9_ >> -126 - _loc11_;
                           }
                           si32(_loc15_ = _loc11_ | _loc14_,_loc6_ - 12);
                           _loc1_ = lf32(_loc6_ - 12);
                           break;
                        }
                        _loc1_ = lf32(_loc15_ = _Zero83 + (_loc14_ >>> 29));
                        break;
                     }
                     _loc8_ = _loc13_;
                     if(_loc9_ > -1)
                     {
                        _loc8_ = _loc9_;
                        if(_loc13_ == _loc16_)
                        {
                           _loc1_ = lf32(_loc15_ = _Zero83 + (_loc14_ >>> 29));
                           break;
                        }
                     }
                     _loc13_ = _loc8_ << 1;
                  }
               }
            }
            st0 = _loc1_;
            ESP = _loc4_ = _loc6_;
            return;
         }
      }
      §§goto(addr86);
   }
}
