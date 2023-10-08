package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI366_0;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_sinh() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = NaN;
      var _loc6_:Number = NaN;
      var _loc1_:* = 0;
      var _loc7_:int = 0;
      var _loc12_:* = 0;
      var _loc5_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc5_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      if((uint(_loc10_ = (_loc12_ = li32(_loc1_)) & 2147483647)) >= 2146435072)
      {
         _loc5_ += _loc5_;
      }
      else
      {
         _loc9_ = li32(_loc3_ - 8);
         _loc7_ = 1;
         if(_loc12_ >= 0)
         {
            _loc7_ = 0;
         }
         _loc12_ = 8;
         if(_loc7_ == 0)
         {
            _loc12_ = 0;
         }
         _loc1_ = LCPI366_0 + _loc12_;
         _loc4_ = lf64(_loc1_);
         if(uint(_loc10_) <= 1077280767)
         {
            if(uint(_loc10_) <= 1043333119)
            {
               var _loc8_:Number;
               if((_loc8_ = _loc5_ + 1.0e+307) <= 1)
               {
               }
               §§goto(addr337);
            }
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc5_ = -_loc5_;
            }
            _loc2_ -= 16;
            sf64(_loc5_,_loc2_);
            ESP = _loc2_;
            F_expm1();
            _loc2_ += 16;
            _loc6_ = st0;
            if(uint(_loc10_) <= 1072693247)
            {
               var _loc11_:Number;
               _loc5_ = (_loc8_ = (_loc11_ = _loc6_ + _loc6_) - (_loc11_ = _loc6_ * _loc6_) / (_loc6_ + 1)) * _loc4_;
            }
            else
            {
               _loc5_ = (_loc8_ = (_loc8_ = _loc6_ / (_loc6_ + 1)) + _loc6_) * _loc4_;
            }
         }
         else if(uint(_loc10_) <= 1082535489)
         {
            if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
            {
               _loc5_ = -_loc5_;
            }
            _loc2_ -= 16;
            sf64(_loc5_,_loc2_);
            ESP = _loc2_;
            F_exp();
            _loc2_ += 16;
            _loc5_ = (_loc8_ = st0) * _loc4_;
         }
         else
         {
            if(uint(_loc10_) >= 1082536910)
            {
               if(_loc10_ == 1082536910)
               {
                  if(uint(_loc9_) <= 2411329661)
                  {
                     addr275:
                     if(!(_loc5_ >= 0 | _loc5_ != _loc5_ | false))
                     {
                        _loc5_ = -_loc5_;
                     }
                     _loc2_ -= 16;
                     sf64(_loc8_ = _loc5_ * 0.5,_loc2_);
                     ESP = _loc2_;
                     F_exp();
                     _loc2_ += 16;
                     _loc11_ = st0;
                     _loc5_ = (_loc8_ = _loc4_ * _loc11_) * _loc11_;
                  }
                  §§goto(addr337);
               }
               _loc5_ *= 1.0e+307;
               §§goto(addr337);
            }
            §§goto(addr275);
         }
      }
      addr337:
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
