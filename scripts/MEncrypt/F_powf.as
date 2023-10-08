package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI358_0;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._bp;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._dp_h;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._dp_l;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_powf() : void
   {
      var _loc9_:int = 0;
      var _loc25_:* = NaN;
      var _loc23_:* = NaN;
      var _loc41_:* = 0;
      var _loc27_:* = 0;
      var _loc39_:* = 0;
      var _loc43_:* = 0;
      var _loc36_:int = 0;
      var _loc38_:int = 0;
      var _loc33_:Number = NaN;
      var _loc35_:Number = NaN;
      var _loc30_:int = 0;
      var _loc6_:Number = NaN;
      var _loc5_:Number = NaN;
      var _loc15_:* = NaN;
      var _loc34_:int = 0;
      var _loc24_:* = NaN;
      var _loc18_:Number = NaN;
      var _loc8_:* = (_loc9_ = ESP) - 96;
      sf32(_loc23_ = lf32(_loc9_ + 4),_loc9_ - 8);
      sf32(_loc25_ = lf32(_loc9_),_loc9_ - 4);
      _loc24_ = 1;
      if((_loc43_ = (_loc27_ = li32(_loc9_ - 8)) & 2147483647) != 0)
      {
         if((uint(_loc39_ = (_loc41_ = li32(_loc9_ - 4)) & 2147483647)) <= 2139095040)
         {
            if(uint(_loc43_) < 2139095041)
            {
               _loc38_ = 0;
               if(_loc41_ <= -1)
               {
                  _loc38_ = 2;
                  if(uint(_loc43_) <= 1266679807)
                  {
                     _loc38_ = 0;
                     if(uint(_loc43_) >= 1065353216)
                     {
                        var _loc37_:* = 150 - (_loc43_ >>> 23);
                        _loc38_ = 0;
                        if((_loc36_ = _loc43_ >>> _loc37_) << _loc37_ == _loc43_)
                        {
                           _loc38_ = 2 - (_loc36_ & 1);
                        }
                     }
                  }
               }
               if(_loc43_ != 1065353216)
               {
                  if(_loc43_ == 2139095040)
                  {
                     if(_loc39_ == 1065353216)
                     {
                        var _loc14_:* = _loc23_;
                        _loc24_ = _loc14_ -= _loc14_;
                     }
                     else if(uint(_loc39_) >= 1065353217)
                     {
                        _loc15_ = _loc23_;
                        if(_loc27_ <= -1)
                        {
                           var _loc21_:*;
                           _loc15_ = _loc21_ = 0;
                        }
                        _loc24_ = _loc15_;
                     }
                     else
                     {
                        _loc24_ = 0;
                        if(_loc27_ <= -1)
                        {
                           _loc24_ = _loc14_ = -(_loc14_ = _loc23_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc27_ != 1056964608)
                     {
                        if(_loc27_ == 1073741824)
                        {
                           _loc14_ = _loc25_;
                           _loc24_ = _loc14_ *= _loc14_;
                        }
                     }
                     else if(_loc41_ >= 0)
                     {
                        _loc24_ = _loc14_ = Math.sqrt(_loc25_);
                     }
                     §§goto(addr2226);
                     if(_loc27_ <= -1)
                     {
                        var _loc12_:*;
                        var _loc20_:*;
                        _loc24_ = _loc14_ = (_loc12_ = _loc20_ = 1) / _loc24_;
                     }
                     if(_loc41_ <= -1)
                     {
                        if((_loc37_ = _loc38_ | _loc39_ + -1065353216) == 0)
                        {
                           _loc14_ = _loc24_;
                           _loc14_ = _loc21_ = _loc14_ -= _loc14_;
                           _loc24_ = _loc14_ /= _loc14_;
                        }
                        else if(_loc38_ == 1)
                        {
                           _loc24_ = _loc14_ = -(_loc14_ = _loc24_);
                        }
                     }
                  }
               }
               else
               {
                  _loc24_ = _loc25_;
                  if(_loc27_ <= -1)
                  {
                     _loc24_ = _loc14_ = (_loc12_ = _loc20_ = 1) / _loc25_;
                  }
               }
            }
            §§goto(addr2226);
         }
         _loc14_ = _loc23_;
         _loc12_ = _loc20_ = 0;
         _loc14_ = _loc21_ = _loc14_ += _loc12_;
         var _loc17_:*;
         _loc24_ = _loc14_ = (_loc12_ = _loc20_ = _loc12_ = (_loc17_ = _loc25_) + _loc12_) + _loc14_;
      }
      addr2226:
      st0 = _loc24_;
      ESP = _loc8_ = _loc9_;
   }
}
