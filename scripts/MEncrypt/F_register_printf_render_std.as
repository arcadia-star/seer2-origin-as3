package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._printf_tbl;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_register_printf_render_std() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      while(true)
      {
         _loc5_ = li8(_loc1_);
         _loc6_ = 0;
         if(_loc5_ == 0)
         {
            break;
         }
         _loc6_ = -1;
         if(_loc5_ <= 80)
         {
            if(_loc5_ != 72)
            {
               if(_loc5_ != 77)
               {
                  break;
               }
               var _loc4_:int = _printf_tbl + _loc5_ * 12;
               si32(___printf_render_errno,_loc4_ + 8);
               si32(___printf_arginfo_errno,_loc4_);
               si32(1,___use_xprintf);
            }
            else
            {
               _loc4_ = _printf_tbl + _loc5_ * 12;
               si32(___printf_render_hexdump,_loc4_ + 8);
               si32(___printf_arginfo_hexdump,_loc4_);
               si32(1,___use_xprintf);
            }
         }
         else if(_loc5_ != 81)
         {
            if(_loc5_ != 84)
            {
               if(_loc5_ != 86)
               {
                  break;
               }
               _loc4_ = _printf_tbl + _loc5_ * 12;
               si32(___printf_render_vis,_loc4_ + 8);
               si32(___printf_arginfo_vis,_loc4_);
               si32(1,___use_xprintf);
            }
            else
            {
               _loc4_ = _printf_tbl + _loc5_ * 12;
               si32(___printf_render_time,_loc4_ + 8);
               si32(___printf_arginfo_time,_loc4_);
               si32(1,___use_xprintf);
            }
         }
         else
         {
            _loc4_ = _printf_tbl + _loc5_ * 12;
            si32(___printf_render_quote,_loc4_ + 8);
            si32(___printf_arginfo_quote,_loc4_);
            si32(1,___use_xprintf);
         }
         _loc1_ += 1;
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
