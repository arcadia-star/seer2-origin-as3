package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___build_env;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___merge_environ;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___setenv;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._envVars;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_setenv() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      _loc8_ = li32(_loc3_ + 8);
      _loc7_ = li32(_loc3_ + 4);
      if((_loc6_ = li32(_loc3_)) != 0)
      {
         var _loc5_:*;
         for(; (_loc4_ = li8(_loc5_ = _loc6_ - _loc1_)) != 61; _loc1_ += -1)
         {
            if(_loc4_ != 0)
            {
               continue;
            }
            if(_loc1_ == 0)
            {
               break;
            }
            ESP = _loc2_;
            F___merge_environ();
            _loc4_ = -1;
            if((_loc5_ = eax) != -1)
            {
               if((_loc5_ = li32(_envVars)) == 0)
               {
                  ESP = _loc2_;
                  F___build_env();
                  _loc4_ = -1;
                  if((_loc5_ = eax) != -1)
                  {
                  }
                  §§goto(addr164);
               }
               _loc5_ = 0 - _loc1_;
               _loc2_ -= 16;
               si32(_loc8_,_loc2_ + 12);
               si32(_loc7_,_loc2_ + 8);
               si32(_loc5_,_loc2_ + 4);
               si32(_loc6_,_loc2_);
               ESP = _loc2_;
               F___setenv();
               _loc2_ += 16;
               _loc4_ = eax;
            }
            §§goto(addr164);
         }
      }
      ESP = _loc2_;
      F___error();
      _loc5_ = eax;
      si32(22,_loc5_);
      _loc4_ = -1;
      addr164:
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
