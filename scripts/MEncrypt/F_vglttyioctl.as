package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str89;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_vglttyioctl() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc9_ = li32(_loc3_ + 4);
      _loc8_ = li32(_loc3_);
      if(_loc9_ <= 536900730)
      {
         _loc7_ = li32(___avm2_vgl_fb_w);
         if(_loc9_ <= -1062968476)
         {
            if(_loc9_ <= -2144570349)
            {
               if(_loc9_ != -2147191792)
               {
                  if(_loc9_ != -2147191690)
                  {
                     if(_loc9_ != -2146929150)
                     {
                     }
                  }
               }
            }
            else
            {
               var _loc6_:*;
               if((uint(_loc6_ = _loc9_ + 2144570348)) >= 3)
               {
                  if(_loc9_ != -1072405750)
                  {
                     if(_loc9_ == -1072143543)
                     {
                        si16(_loc7_,_loc1_ + 12);
                        si16(_loc6_ = li32(___avm2_vgl_fb_h),_loc1_ + 10);
                     }
                  }
                  else if((_loc6_ = li32(_loc1_)) == 5)
                  {
                     si32(_loc6_ = li32(_vgl_cur_buttons),_loc1_ + 16);
                     si32(_loc6_ = li32(_vgl_cur_mx),_loc1_ + 4);
                     si32(_loc6_ = li32(_vgl_cur_my),_loc1_ + 8);
                  }
               }
            }
            §§goto(addr611);
         }
         else if(_loc9_ <= 536900701)
         {
            var _loc5_:*;
            var _loc4_:*;
            _loc7_ = (_loc6_ = li32(___avm2_vgl_fb_h)) * _loc7_ * ((_loc5_ += (_loc4_ = (_loc5_ = li32(___avm2_vgl_fb_bpp)) >> 31) >>> 29) >> 3);
            if(_loc9_ != -1062968475)
            {
               if(_loc9_ != -1062968474)
               {
                  if((uint(_loc6_ = _loc9_ + -536890172)) >= 2)
                  {
                  }
               }
               else
               {
                  if((_loc6_ = li32(_loc1_)) == 280)
                  {
                     if((_loc6_ = li32(_VGL_Support_VESA_FULL_1024)) != 0)
                     {
                        si32(280,_loc1_);
                        si32(15,_loc1_ + 4);
                        si32(_loc6_ = li32(___avm2_vgl_fb_w),_loc1_ + 8);
                        si32(_loc6_ = li32(___avm2_vgl_fb_h),_loc1_ + 12);
                        si32(_loc6_ = li32(___avm2_vgl_fb_w),_loc1_ + 16);
                        si32(_loc6_ = li32(___avm2_vgl_fb_h),_loc1_ + 20);
                        si32(32,___avm2_vgl_fb_bpp);
                        si32(32,_loc1_ + 24);
                        si32(16,_loc1_ + 60);
                        si32(8,_loc1_ + 64);
                        si32(0,_loc1_ + 68);
                        si32(24,_loc1_ + 72);
                        si32(8,_loc1_ + 76);
                        si32(8,_loc1_ + 80);
                        si32(8,_loc1_ + 84);
                        si32(0,_loc1_ + 88);
                        si32(3,_loc1_ + 52);
                        si32(4,_loc1_ + 56);
                        si32(1,_loc1_ + 28);
                        si32(16777215,_loc1_ + 32);
                        si32(_loc7_,_loc1_ + 36);
                        si32(0,_loc1_ + 40);
                        si32(16777215,_loc1_ + 44);
                        si32(_loc7_,_loc1_ + 48);
                     }
                     §§goto(addr611);
                  }
                  si32(261,_loc1_);
                  si32(15,_loc1_ + 4);
                  si32(_loc6_ = li32(___avm2_vgl_fb_w),_loc1_ + 8);
                  si32(_loc6_ = li32(___avm2_vgl_fb_h),_loc1_ + 12);
                  si32(_loc6_ = li32(___avm2_vgl_fb_w),_loc1_ + 16);
                  si32(_loc6_ = li32(___avm2_vgl_fb_h),_loc1_ + 20);
                  si32(8,___avm2_vgl_fb_bpp);
                  si32(8,_loc1_ + 24);
                  si32(1,_loc1_ + 28);
                  si32(-1,_loc1_ + 32);
                  si32(_loc7_,_loc1_ + 36);
                  si32(0,_loc1_ + 40);
                  si32(-1,_loc1_ + 44);
                  si32(_loc7_,_loc1_ + 48);
                  si32(2,_loc1_ + 52);
                  si32(1,_loc1_ + 56);
               }
            }
            else
            {
               si32(_loc7_,_loc1_ + 68);
               si32(_loc6_ = li32(___avm2_vgl_fb_w),_loc1_ + 84);
               si32(_loc7_,_loc1_ + 56);
            }
            §§goto(addr611);
         }
         else
         {
            _loc1_ = _loc9_ + -536900702;
            if(uint(_loc1_) <= 17)
            {
               if((_loc6_ = (_loc6_ = 1 << _loc1_) & 196617) == 0)
               {
               }
               §§goto(addr611);
            }
         }
         addr581:
         _loc2_ -= 16;
         si32(_loc8_,_loc2_ + 8);
         si32(_loc9_,_loc2_ + 4);
         si32(L__2E_str89,_loc2_);
         ESP = _loc2_;
         F_tprintf();
         _loc2_ += 16;
      }
      else if(_loc9_ <= 1074029312)
      {
         if(_loc9_ <= 537163267)
         {
            if(_loc9_ != 536900731)
            {
               if(_loc9_ != 537152263)
               {
                  if(_loc9_ != 537152266)
                  {
                     §§goto(addr581);
                  }
               }
            }
         }
         else if(_loc9_ != 537163268)
         {
            if(_loc9_ != 537163270)
            {
               if(_loc9_ != 1074023174)
               {
                  §§goto(addr581);
               }
               else
               {
                  si32(1,_loc1_);
               }
            }
         }
      }
      else if(_loc9_ <= 1074296322)
      {
         if(_loc9_ != 1074029313)
         {
            if(_loc9_ != 1074029314)
            {
               if(_loc9_ != 1074033763)
               {
                  §§goto(addr581);
               }
            }
            else
            {
               si32(261,_loc1_);
            }
         }
         else
         {
            si32(0,_loc1_);
         }
      }
      else if(_loc9_ != 1241672454)
      {
         if(_loc9_ != 1076655123)
         {
            if(_loc9_ == 1074296323)
            {
               si8(1,_loc1_);
            }
            else
            {
               §§goto(addr581);
            }
         }
      }
      else
      {
         si16(256,_loc1_);
         _loc8_ = -1;
         do
         {
            _loc6_ = _loc8_ * -10;
            _loc6_ = _loc1_ + _loc6_;
            si32(0,_loc6_ - 4);
            si32(0,_loc6_ - 8);
            si8(0,_loc6_);
            si8(0,_loc6_ + 1);
         }
         while((_loc8_ += -1) != -257);
         
      }
      addr611:
      eax = 0;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
