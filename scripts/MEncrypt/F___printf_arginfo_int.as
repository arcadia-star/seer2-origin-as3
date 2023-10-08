package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1337;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str336;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.___func___2E_2883;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_arginfo_int() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      if(_loc1_ == 0)
      {
         _loc2_ -= 16;
         si32(L__2E_str1337,_loc2_ + 12);
         si32(234,_loc2_ + 8);
         si32(L__2E_str336,_loc2_ + 4);
         si32(___func___2E_2883,_loc2_);
         ESP = _loc2_;
         F___assert();
         _loc2_ += 16;
      }
      _loc5_ = li32(_loc3_ + 8);
      _loc4_ = li32(_loc3_);
      si32(1,_loc5_);
      _loc1_ = li32(_loc4_ + 68);
      if(_loc1_ != 0)
      {
         si32(8388609,_loc5_);
      }
      else if(li32(_loc4_ + 72) != 0)
      {
         si32(4194305,_loc5_);
      }
      else if(li32(_loc4_ + 24) != 0)
      {
         si32(131073,_loc5_);
      }
      else if(li32(_loc4_ + 64) != 0)
      {
         si32(2097153,_loc5_);
      }
      else if(li32(_loc4_ + 60) != 0)
      {
         si32(1048577,_loc5_);
      }
      else if(li32(_loc4_ + 12) != 0)
      {
         si32(65537,_loc5_);
      }
      else if(li32(_loc4_ + 20) != 0)
      {
         si32(262145,_loc5_);
      }
      else if(li32(_loc4_ + 16) != 0)
      {
         si32(2,_loc5_);
      }
      eax = 1;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
