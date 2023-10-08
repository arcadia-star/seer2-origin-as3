package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.LCPI367_0;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sinhf() : void
   {
      var _loc6_:int = 0;
      var _loc14_:* = 0;
      var _loc3_:* = NaN;
      var _loc11_:int = 0;
      var _loc5_:* = 0;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 16;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc14_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 2139095040)
      {
         var _loc8_:* = _loc1_;
         _loc1_ = _loc8_ += _loc8_;
      }
      else
      {
         _loc11_ = 1;
         if(_loc5_ >= 0)
         {
            _loc11_ = 0;
         }
         _loc5_ = 4;
         if(_loc11_ == 0)
         {
            _loc5_ = 0;
         }
         var _loc10_:int;
         _loc3_ = lf32(_loc10_ = LCPI367_0 + _loc5_);
         if(uint(_loc14_) <= 1091567615)
         {
            if(uint(_loc14_) <= 964689919)
            {
               var _loc12_:*;
               if((_loc12_ = _loc8_ = _loc1_ + 9.999999933815813e+36) <= 1)
               {
               }
               §§goto(addr317);
            }
            _loc4_ -= 16;
            si32(_loc14_,_loc4_);
            ESP = _loc4_;
            F_expm1f();
            _loc4_ += 16;
            _loc1_ = st0;
            if(uint(_loc14_) <= 1065353215)
            {
               _loc8_ = _loc1_;
               var _loc7_:*;
               var _loc9_:*;
               var _loc13_:*;
               _loc1_ = _loc8_ = (_loc12_ = _loc8_ = (_loc8_ = _loc12_ = _loc8_ += _loc8_) - (_loc7_ = (_loc9_ = _loc13_ = _loc9_ = _loc8_ * _loc8_) / (_loc7_ = _loc8_ + 1))) * _loc3_;
            }
            else
            {
               _loc8_ = _loc1_;
               _loc1_ = _loc8_ = (_loc12_ = _loc8_ = (_loc7_ = _loc7_ = _loc8_ / (_loc7_ = _loc8_ + 1)) + _loc8_) * _loc3_;
            }
         }
         else if(uint(_loc14_) <= 1118925334)
         {
            _loc4_ -= 16;
            si32(_loc14_,_loc4_);
            ESP = _loc4_;
            F_expf();
            _loc4_ += 16;
            _loc1_ = _loc8_ = (_loc7_ = st0) * _loc3_;
         }
         else if(uint(_loc14_) <= 1119016188)
         {
            si32(_loc14_,_loc6_ - 8);
            sf32((_loc7_ = lf32(_loc6_ - 8)) * (_loc12_ = 0.5),_loc4_ -= 16);
            ESP = _loc4_;
            F_expf();
            _loc4_ += 16;
            _loc1_ = _loc8_ = (_loc7_ = _loc7_ = _loc3_ * (_loc8_ = _loc12_ = st0)) * _loc8_;
         }
         else
         {
            _loc1_ = _loc8_ = _loc1_ * 9.999999933815813e+36;
         }
      }
      addr317:
      st0 = _loc1_;
      ESP = _loc4_ = _loc6_;
   }
}
