package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._atanhi52;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._atanlo53;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_atanf() : void
   {
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc18_:* = 0;
      var _loc3_:* = NaN;
      var _loc13_:* = NaN;
      var _loc11_:* = NaN;
      var _loc15_:int = 0;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 8;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc18_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 1283457024)
      {
         if(uint(_loc18_) >= 2139095041)
         {
            var _loc8_:* = _loc1_;
            _loc1_ = _loc8_ += _loc8_;
         }
         else
         {
            _loc3_ = lf32(_atanlo53 + 12);
            if(_loc5_ >= 1)
            {
               _loc1_ = _loc8_ = _loc3_ + 1.570796251296997;
            }
            else
            {
               var _loc7_:*;
               _loc1_ = _loc8_ = (_loc7_ = -1.570796251296997) - _loc3_;
            }
         }
      }
      else
      {
         if(uint(_loc18_) <= 1054867455)
         {
            _loc15_ = -1;
            if(uint(_loc18_) <= 964689919)
            {
               var _loc16_:*;
               if((_loc16_ = _loc8_ = _loc1_ + 1.0000000150474662e+30) <= 1)
               {
               }
               §§goto(addr484);
            }
         }
         else
         {
            si32(_loc18_,_loc6_ - 8);
            _loc3_ = lf32(_loc6_ - 8);
            if(uint(_loc18_) <= 1066926079)
            {
               if(uint(_loc18_) <= 1060110335)
               {
                  _loc7_ = _loc3_;
                  var _loc19_:*;
                  _loc1_ = _loc8_ = (_loc7_ = _loc7_ = (_loc7_ = _loc7_ += _loc7_) + (_loc19_ = -1)) / (_loc16_ = _loc8_ = _loc7_ + (_loc16_ = 2));
                  _loc15_ = 0;
               }
               else
               {
                  _loc7_ = 1;
                  _loc7_ = _loc7_ = _loc3_ + _loc7_;
                  _loc1_ = _loc8_ = (_loc8_ = _loc16_ = _loc8_ = _loc3_ + (_loc19_ = -1)) / _loc7_;
                  _loc15_ = 1;
               }
            }
            else if(uint(_loc18_) <= 1075576831)
            {
               _loc8_ = _loc16_ = -1.5;
               _loc8_ = _loc16_ = _loc8_ = _loc3_ + _loc8_;
               _loc1_ = _loc8_ /= _loc7_ = (_loc7_ = _loc3_ * (_loc19_ = 1.5)) + (_loc19_ = 1);
               _loc15_ = 2;
            }
            else
            {
               _loc1_ = _loc8_ = (_loc7_ = -1) / _loc3_;
               _loc15_ = 3;
            }
         }
         var _loc14_:* = _loc16_ = -0.106480173766613;
         _loc11_ = _loc1_;
         _loc8_ = _loc16_ = _loc8_ = _loc11_ * _loc11_;
         var _loc2_:* = _loc7_ = _loc8_ * _loc8_;
         _loc14_ = _loc19_ = _loc14_ = (_loc7_ = _loc2_) * _loc14_;
         var _loc10_:Number;
         var _loc17_:* = _loc10_ = -0.19999158382415771;
         _loc1_ = _loc14_ = (_loc14_ = _loc19_ = _loc14_ += _loc17_) * _loc7_;
         _loc14_ = _loc19_ = 0.06168760731816292;
         _loc14_ = _loc19_ = _loc14_ = _loc7_ * _loc14_;
         _loc17_ = _loc10_ = 0.14253635704517365;
         _loc2_ = _loc7_ = (_loc14_ = _loc19_ = _loc14_ += _loc17_) * _loc7_;
         _loc7_ = _loc2_;
         _loc14_ = _loc19_ = 0.333333283662796;
         _loc2_ = _loc7_ += _loc14_;
         _loc13_ = _loc8_ = (_loc7_ = _loc2_) * _loc8_;
         if(_loc15_ <= -1)
         {
            _loc1_ = _loc8_ = _loc11_ - (_loc16_ = _loc8_ = (_loc8_ = _loc16_ = _loc8_ = (_loc8_ = _loc13_) + _loc1_) * _loc11_);
         }
         else
         {
            var _loc12_:* = _loc15_ << 2;
            var _loc9_:int;
            _loc1_ = _loc8_ = (_loc8_ = lf32(_loc12_ = _atanhi52 + _loc12_)) - (_loc7_ = (_loc7_ = _loc7_ = (_loc14_ = _loc19_ = _loc14_ = (_loc14_ = _loc19_ = _loc14_ = (_loc17_ = _loc13_) + _loc1_) * _loc11_) - lf32(_loc9_ = _atanlo53 + _loc12_)) - _loc11_);
            if(_loc5_ <= -1)
            {
               _loc1_ = _loc8_ = -(_loc8_ = _loc1_);
            }
         }
      }
      addr484:
      st0 = _loc1_;
      ESP = _loc4_ = _loc6_;
   }
}
