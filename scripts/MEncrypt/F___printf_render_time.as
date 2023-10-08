package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1369;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str2370;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str3371;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str368;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str4372;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str5373;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str6374;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_render_time() : void
   {
      var _loc4_:* = 0;
      var _loc14_:* = 0;
      var _loc3_:* = 0;
      var _loc16_:* = 0;
      var _loc12_:int = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc15_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 112;
      _loc3_ = li32(_loc4_ + 4);
      _loc16_ = li32(_loc3_ + 24);
      _loc15_ = li32(_loc4_ + 8);
      _loc14_ = li32(_loc4_);
      if(_loc16_ != 0)
      {
         _loc15_ = (_loc16_ = li32((_loc13_ = li32(_loc16_ = li32(_loc15_))) + 4)) * 1000;
         _loc12_ = 6;
      }
      else
      {
         _loc15_ = li32(_loc15_);
         if((_loc16_ = li32(_loc3_ + 12)) != 0)
         {
            _loc15_ = li32((_loc13_ = li32(_loc15_)) + 4);
            _loc12_ = 9;
         }
         else
         {
            _loc13_ = li32(_loc15_);
            _loc12_ = 0;
         }
      }
      _loc16_ = li32(_loc3_ + 28);
      _loc10_ = (_loc11_ = li32(_loc13_)) >> 31;
      if(_loc16_ != 0)
      {
         _loc13_ = _loc4_ - 100;
         _loc9_ = _loc11_;
         if(_loc11_ >= 31536000)
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(31536000,_loc2_ + 8);
            si32(_loc11_,_loc2_);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___moddi3();
            _loc2_ += 16;
            _loc9_ = eax;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(31536000,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F___divdi3();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(edx,_loc2_ + 12);
            si32(eax,_loc2_ + 8);
            si32(L__2E_str368,_loc2_ + 4);
            var _loc5_:int;
            si32(_loc5_ = _loc4_ - 100,_loc2_);
            ESP = _loc2_;
            F_sprintf();
            _loc2_ += 16;
            _loc13_ = _loc5_ + eax;
            _loc10_ = edx;
         }
         _loc7_ = _loc6_ = 1;
         if(uint(_loc9_) >= 86400)
         {
            _loc7_ = 0;
         }
         if(_loc10_ >= 0)
         {
            _loc6_ = 0;
         }
         if(_loc10_ != 0)
         {
            _loc7_ = _loc6_;
         }
         if(_loc7_ == 0)
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(86400,_loc2_ + 8);
            si32(_loc9_,_loc2_);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___moddi3();
            _loc2_ += 16;
            var _loc1_:int = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(86400,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F___divdi3();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(edx,_loc2_ + 12);
            si32(eax,_loc2_ + 8);
            si32(L__2E_str1369,_loc2_ + 4);
            si32(_loc13_,_loc2_);
            ESP = _loc2_;
            F_sprintf();
            _loc2_ += 16;
            _loc13_ += eax;
            _loc9_ = eax;
            _loc10_ = _loc1_;
         }
         _loc7_ = _loc6_ = 1;
         if(uint(_loc9_) >= 3600)
         {
            _loc7_ = 0;
         }
         if(_loc10_ >= 0)
         {
            _loc6_ = 0;
         }
         if(_loc10_ != 0)
         {
            _loc7_ = _loc6_;
         }
         if(_loc7_ == 0)
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(3600,_loc2_ + 8);
            si32(_loc9_,_loc2_);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___moddi3();
            _loc2_ += 16;
            _loc1_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(3600,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F___divdi3();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(edx,_loc2_ + 12);
            si32(eax,_loc2_ + 8);
            si32(L__2E_str2370,_loc2_ + 4);
            si32(_loc13_,_loc2_);
            ESP = _loc2_;
            F_sprintf();
            _loc2_ += 16;
            _loc13_ += eax;
            _loc9_ = eax;
            _loc10_ = _loc1_;
         }
         _loc6_ = _loc7_ = 1;
         if(uint(_loc9_) >= 60)
         {
            _loc6_ = 0;
         }
         if(_loc10_ >= 0)
         {
            _loc7_ = 0;
         }
         if(_loc10_ != 0)
         {
            _loc6_ = _loc7_;
         }
         if(_loc6_ == 0)
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(60,_loc2_ + 8);
            si32(_loc9_,_loc2_);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___moddi3();
            _loc2_ += 16;
            _loc1_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(60,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F___divdi3();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(edx,_loc2_ + 12);
            si32(eax,_loc2_ + 8);
            si32(L__2E_str3371,_loc2_ + 4);
            si32(_loc13_,_loc2_);
            ESP = _loc2_;
            F_sprintf();
            _loc2_ += 16;
            _loc13_ += eax;
            _loc9_ = eax;
            _loc10_ = _loc1_;
         }
         if((_loc16_ = _loc9_ | _loc10_) == 0)
         {
            if(_loc11_ == 0)
            {
            }
            addr803:
            if((_loc16_ = li32(_loc3_ + 24)) == 0)
            {
               if((_loc16_ = li32(_loc3_ + 12)) != 0)
               {
                  addr821:
                  if((_loc11_ = li32(_loc3_)) <= -1)
                  {
                     _loc11_ = _loc12_;
                  }
                  if(_loc11_ <= 8)
                  {
                     _loc12_ = 9 - _loc11_;
                     do
                     {
                        _loc12_ += -1;
                        _loc15_ /= 10;
                     }
                     while(_loc12_ != 0);
                     
                  }
                  _loc2_ -= 16;
                  si32(_loc15_,_loc2_ + 12);
                  si32(_loc11_,_loc2_ + 8);
                  si32(L__2E_str6374,_loc2_ + 4);
                  si32(_loc13_,_loc2_);
                  ESP = _loc2_;
                  F_sprintf();
                  _loc2_ += 16;
                  _loc16_ = eax;
                  _loc13_ += _loc16_;
               }
               _loc2_ -= 16;
               si32(_loc3_,_loc2_ + 4);
               si32(_loc14_,_loc2_);
               si32(_loc16_ = _loc4_ - 100,_loc2_ + 8);
               si32(_loc16_ = _loc13_ - _loc16_,_loc2_ + 12);
               ESP = _loc2_;
               F___printf_out();
               _loc2_ += 16;
               eax = _loc16_ = eax;
               _loc2_ = _loc4_;
               ESP = _loc2_;
               return;
            }
            §§goto(addr821);
         }
         _loc2_ -= 16;
         si32(_loc9_,_loc2_ + 8);
         si32(L__2E_str4372,_loc2_ + 4);
         si32(_loc10_,_loc2_ + 12);
         si32(_loc13_,_loc2_);
         ESP = _loc2_;
         F_sprintf();
         _loc2_ += 16;
         _loc16_ = eax;
         _loc13_ += _loc16_;
      }
      else
      {
         _loc2_ -= 16;
         si32(_loc11_,_loc2_ + 8);
         si32(L__2E_str5373,_loc2_ + 4);
         si32(_loc10_,_loc2_ + 12);
         si32(_loc16_ = _loc4_ - 100,_loc2_);
         ESP = _loc2_;
         F_sprintf();
         _loc2_ += 16;
         _loc13_ = _loc16_ + eax;
      }
      §§goto(addr803);
   }
}
