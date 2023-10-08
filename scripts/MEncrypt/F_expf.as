package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._halF7;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ln2HI5;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ln2LO6;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._twom100;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_expf() : void
   {
      var _loc8_:int = 0;
      var _loc2_:* = NaN;
      var _loc20_:int = 0;
      var _loc9_:* = NaN;
      var _loc17_:* = NaN;
      var _loc18_:* = NaN;
      var _loc1_:* = NaN;
      var _loc3_:* = NaN;
      var _loc10_:* = NaN;
      var _loc22_:* = NaN;
      var _loc19_:* = NaN;
      var _loc7_:* = 0;
      var _loc23_:* = 0;
      var _loc5_:* = NaN;
      var _loc6_:* = (_loc8_ = ESP) - 8;
      _loc2_ = lf32(_loc8_);
      sf32(_loc2_,_loc8_ - 4);
      _loc23_ = (_loc7_ = li32(_loc8_ - 4)) & 2147483647;
      _loc20_ = _loc7_ >>> 31;
      if(uint(_loc23_) >= 1118925336)
      {
         if(uint(_loc23_) >= 2139095041)
         {
            var _loc11_:* = _loc2_;
            _loc5_ = _loc11_ += _loc11_;
         }
         else if(_loc23_ == 2139095040)
         {
            _loc10_ = _loc2_;
            if(_loc20_ != 0)
            {
               var _loc4_:*;
               _loc10_ = _loc4_ = 0;
            }
            _loc5_ = _loc10_;
         }
         else
         {
            _loc5_ = inf;
            _loc17_ = _loc2_;
            if(_loc17_ <= (_loc4_ = 88.7216796875))
            {
               _loc11_ = _loc4_ = -103.97208404541016;
               if(!(_loc17_ >= _loc11_ | _loc17_ != _loc17_ | _loc11_ != _loc11_))
               {
                  _loc5_ = _loc11_ = lf32(_twom100) * lf32(_twom100);
               }
               else
               {
                  addr144:
                  if(uint(_loc23_) >= 1051816473)
                  {
                     if(uint(_loc23_) <= 1065686417)
                     {
                        var _loc16_:* = _loc20_ << 2;
                        var _loc13_:int;
                        _loc19_ = lf32(_loc13_ = _ln2LO6 + _loc16_);
                        _loc22_ = lf32(_loc16_ = _ln2HI5 + _loc16_);
                        _loc7_ = (_loc16_ = _loc7_ >> 30) | 1;
                     }
                     else
                     {
                        var _loc15_:*;
                        var _loc14_:* = _loc15_ = 0.000001428606765330187;
                        var _loc12_:Number;
                        _loc19_ = _loc14_ = (_loc4_ = _loc7_ = _loc4_ = _loc11_ = (_loc14_ = _loc15_ = _loc14_ = _loc2_ * (_loc12_ = 1.4426950216293335)) + lf32(_loc16_ = _halF7 + (_loc20_ << 2))) * _loc14_;
                        _loc22_ = _loc11_ = (_loc4_ = _loc7_ = _loc4_ = _loc11_ = (_loc14_ = _loc15_ = _loc14_ = _loc2_ * (_loc12_ = 1.4426950216293335)) + lf32(_loc16_ = _halF7 + (_loc20_ << 2))) * (_loc15_ = 0.693145751953125);
                     }
                     _loc11_ = _loc22_;
                     _loc11_ = _loc22_ = _loc11_ = (_loc14_ = _loc2_) - _loc11_;
                     _loc14_ = _loc19_;
                     _loc2_ = _loc11_ -= _loc14_;
                  }
                  else
                  {
                     _loc19_ = 0;
                     _loc7_ = 0;
                     _loc22_ = _loc19_;
                     if(uint(_loc23_) <= 830472191)
                     {
                        _loc18_ = _loc2_;
                        _loc11_ = _loc4_ = _loc11_ = _loc18_ + (_loc4_ = 1.0000000150474662e+30);
                        _loc1_ = _loc15_ = 1;
                        _loc22_ = _loc19_;
                        if(!(_loc11_ <= _loc1_ | _loc11_ != _loc11_ | _loc1_ != _loc1_))
                        {
                           _loc5_ = _loc11_ = _loc18_ + _loc1_;
                        }
                        §§goto(addr566);
                     }
                  }
                  _loc23_ = 1065353216;
                  if(_loc7_ <= -126)
                  {
                     _loc23_ = 1904214016;
                  }
                  _loc16_ = _loc7_ << 23;
                  si32(_loc16_ = _loc23_ + _loc16_,_loc8_ - 8);
                  _loc14_ = _loc4_ = -0.0027667332906275988;
                  _loc18_ = _loc2_;
                  _loc14_ = _loc15_ = _loc14_ = (_loc11_ = _loc4_ = _loc11_ = _loc18_ * _loc18_) * _loc14_;
                  var _loc21_:* = _loc12_ = 0.16666625440120697;
                  _loc11_ = _loc4_ = _loc11_ = (_loc14_ = _loc15_ = _loc14_ += _loc21_) * _loc11_;
                  _loc3_ = _loc4_ = _loc11_ = _loc18_ - _loc11_;
                  _loc9_ = _loc11_ = _loc18_ * _loc3_;
                  if(_loc7_ == 0)
                  {
                     _loc5_ = _loc11_ = (_loc14_ = _loc15_ = 1) - (_loc4_ = _loc11_ = (_loc11_ = _loc4_ = _loc11_ = (_loc11_ = _loc9_) / (_loc4_ = _loc11_ = _loc3_ + (_loc4_ = -2))) - _loc18_);
                  }
                  else
                  {
                     _loc5_ = lf32(_loc8_ - 8);
                     _loc19_ = _loc11_ = (_loc14_ = _loc15_ = 1) - (_loc4_ = _loc11_ = (_loc4_ = _loc11_ = (_loc14_ = _loc19_) - (_loc4_ = _loc11_ = (_loc11_ = _loc9_) / (_loc4_ = _loc11_ = (_loc11_ = _loc4_ = 2) - _loc3_))) - _loc22_);
                     if(_loc7_ >= -125)
                     {
                        if(_loc7_ == 128)
                        {
                           _loc14_ = _loc19_;
                           _loc5_ = _loc11_ = (_loc14_ = _loc15_ = _loc14_ += _loc14_) * (_loc4_ = 1.7014118346046923e+38);
                        }
                        else
                        {
                           _loc5_ = _loc11_ = (_loc11_ = _loc19_) * _loc5_;
                        }
                     }
                     else
                     {
                        _loc5_ = _loc11_ = (_loc4_ = _loc11_ = (_loc11_ = _loc19_) * _loc5_) * lf32(_twom100);
                     }
                  }
               }
            }
         }
         addr566:
         st0 = _loc5_;
         ESP = _loc6_ = _loc8_;
         return;
      }
      §§goto(addr144);
   }
}
