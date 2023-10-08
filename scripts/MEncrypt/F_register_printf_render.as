package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._printf_tbl;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_register_printf_render() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = -1;
      if((uint(_loc7_ = li32(_loc3_))) <= 255)
      {
         var _loc4_:int;
         si32(li32(_loc3_ + 4),(_loc4_ = _printf_tbl + _loc7_ * 12) + 8);
         si32(li32(_loc3_ + 8),_loc4_);
         si32(1,___use_xprintf);
         _loc1_ = 0;
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
