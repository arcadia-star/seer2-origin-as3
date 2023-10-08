package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__C_monetary_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__C_numeric_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__monetary_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__monetary_using_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__numeric_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__numeric_using_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ret_2E_1158;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_localeconv() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(___mlocale_changed);
      if(_loc1_ != 0)
      {
         _loc4_ = __C_monetary_locale;
         if(li32(__monetary_using_locale) != 0)
         {
            _loc4_ = __monetary_locale;
         }
         _loc1_ = li32(_loc4_);
         si32(_loc1_,_ret_2E_1158 + 12);
         _loc1_ = li32(_loc4_ + 4);
         si32(_loc1_,_ret_2E_1158 + 16);
         _loc1_ = li32(_loc4_ + 8);
         si32(_loc1_,_ret_2E_1158 + 20);
         _loc1_ = li32(_loc4_ + 12);
         si32(_loc1_,_ret_2E_1158 + 24);
         _loc1_ = li32(_loc4_ + 16);
         si32(_loc1_,_ret_2E_1158 + 28);
         _loc1_ = li32(_loc4_ + 20);
         si32(_loc1_,_ret_2E_1158 + 32);
         _loc1_ = li32(_loc4_ + 24);
         si32(_loc1_,_ret_2E_1158 + 36);
         _loc1_ = li32(_loc4_ + 28);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 40);
         _loc1_ = li32(_loc4_ + 32);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 41);
         _loc1_ = li32(_loc4_ + 36);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 42);
         _loc1_ = li32(_loc4_ + 40);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 43);
         _loc1_ = li32(_loc4_ + 44);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 44);
         _loc1_ = li32(_loc4_ + 48);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 45);
         _loc1_ = li32(_loc4_ + 52);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 46);
         _loc1_ = li32(_loc4_ + 56);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 47);
         _loc1_ = li32(_loc4_ + 60);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 48);
         _loc1_ = li32(_loc4_ + 64);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 49);
         _loc1_ = li32(_loc4_ + 68);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 50);
         _loc1_ = li32(_loc4_ + 72);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 51);
         _loc1_ = li32(_loc4_ + 76);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 52);
         _loc1_ = li32(_loc4_ + 80);
         _loc1_ = li8(_loc1_);
         si8(_loc1_,_ret_2E_1158 + 53);
         si32(0,___mlocale_changed);
      }
      _loc1_ = li32(___nlocale_changed);
      if(_loc1_ != 0)
      {
         _loc4_ = __C_numeric_locale;
         if(li32(__numeric_using_locale) != 0)
         {
            _loc4_ = __numeric_locale;
         }
         _loc1_ = li32(_loc4_);
         si32(_loc1_,_ret_2E_1158);
         _loc1_ = li32(_loc4_ + 4);
         si32(_loc1_,_ret_2E_1158 + 4);
         _loc1_ = li32(_loc4_ + 8);
         si32(_loc1_,_ret_2E_1158 + 8);
         si32(0,___nlocale_changed);
      }
      eax = _ret_2E_1158;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
