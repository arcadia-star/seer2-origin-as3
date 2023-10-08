package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str193;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2196;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__numeric_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__numeric_locale_buf;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.__numeric_using_locale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._nogrouping;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___numeric_load_locale() : void
   {
      var _loc3_:* = 0;
      var _loc10_:int = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      si32(__numeric_locale,_loc2_ + 24);
      si32(3,_loc2_ + 20);
      si32(3,_loc2_ + 16);
      si32(L__2E_str2196,_loc2_ + 12);
      si32(__numeric_locale_buf,_loc2_ + 8);
      si32(__numeric_using_locale,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F___part_load_locale();
      _loc2_ += 32;
      if((_loc10_ = eax) != -1)
      {
         si32(1,___nlocale_changed);
         if(_loc10_ == 0)
         {
            if(li8(li32(__numeric_locale)) == 0)
            {
               si32(L__2E_str193,__numeric_locale);
            }
            _loc9_ = _nogrouping;
            if((_loc8_ = li32(__numeric_locale + 8)) != 0)
            {
               _loc7_ = li8(_loc8_);
               _loc9_ = _nogrouping;
               _loc6_ = _loc8_;
               _loc5_ = _loc8_;
               if(_loc7_ != 0)
               {
                  while(true)
                  {
                     if((_loc4_ = _loc7_ & 255) != 59)
                     {
                        if(_loc4_ != 45)
                        {
                           if(_loc4_ == 0)
                           {
                              si8(0,_loc5_);
                              _loc9_ = _loc8_;
                              break;
                           }
                           _loc9_ = _nogrouping;
                           if(_loc7_ << 24 >> 24 >= 0)
                           {
                           }
                           break;
                        }
                        if(li8(_loc6_ + 1) != 49)
                        {
                           _loc1_ = _loc4_ << 2;
                           _loc1_ = __DefaultRuneLocale + _loc1_;
                           _loc1_ = li8(_loc1_ + 53);
                           _loc1_ &= 4;
                        }
                        _loc6_ += 1;
                        si8(127,_loc5_);
                        _loc5_ += 1;
                        continue;
                        _loc9_ = _nogrouping;
                        if(_loc1_ == 0)
                        {
                           break;
                        }
                        _loc9_ = _loc7_ + -48;
                        if((_loc4_ = si8(li8(_loc6_ + 1))) >= 0)
                        {
                           if((li8(__DefaultRuneLocale + ((_loc4_ & 255) << 2) + 53) & 4) != 0)
                           {
                              _loc6_ += 1;
                              _loc9_ = _loc9_ * 10 + _loc4_ + -48;
                           }
                        }
                        si8(_loc9_,_loc5_);
                        _loc1_ = _loc9_ & 255;
                        if(_loc1_ == 0)
                        {
                           _loc9_ = _nogrouping;
                           if(_loc5_ != _loc8_)
                           {
                              _loc9_ = _loc8_;
                           }
                           break;
                        }
                        _loc5_ += 1;
                     }
                  }
               }
            }
            si32(_loc9_,__numeric_locale + 8);
         }
      }
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
