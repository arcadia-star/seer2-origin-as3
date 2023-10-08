package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tls_init;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tls_init_size;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._tls_static_space;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___libc_allocate_tls() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_tls_static_space);
      _loc2_ -= 16;
      si32(1,_loc2_);
      _loc9_ = 8;
      if((uint(_loc8_ = li32(_loc3_ + 4))) >= uint(_loc9_))
      {
         _loc9_ = _loc8_;
      }
      var _loc7_:*;
      var _loc6_:int = (_loc6_ = (_loc7_ = li32(_loc3_ + 8)) + _loc1_) + -1;
      _loc7_ = 0 - _loc7_;
      si32(_loc6_ = (_loc7_ = _loc6_ & _loc7_) + _loc9_,_loc2_ + 4);
      ESP = _loc2_;
      F_calloc();
      _loc2_ += 16;
      _loc6_ = eax;
      _loc2_ -= 16;
      si32(12,_loc2_);
      _loc9_ = _loc6_ + _loc7_;
      ESP = _loc2_;
      F_malloc();
      _loc2_ += 16;
      _loc7_ = eax;
      si32(_loc9_,_loc9_);
      si32(_loc7_,_loc9_ + 4);
      si32(1,_loc7_);
      si32(1,_loc7_ + 4);
      _loc1_ = li32(_tls_static_space);
      si32(_loc5_ = _loc9_ - _loc1_,_loc7_ + 8);
      if((_loc8_ = li32(_loc3_)) != 0)
      {
         _loc2_ -= 16;
         si32(_loc5_,_loc2_);
         si32(_loc1_,_loc2_ + 8);
         si32(_loc7_ = _loc8_ - _loc1_,_loc2_ + 4);
         ESP = _loc2_;
         Fmemcpy();
         _loc2_ += 16;
         _loc2_ -= 16;
         si32(4,_loc2_ + 8);
         si32(8,_loc2_ + 4);
         si32(_loc8_,_loc2_);
         ESP = _loc2_;
         F__rtld_free_tls();
         _loc2_ += 16;
      }
      else
      {
         _loc2_ -= 16;
         si32(li32(_tls_init_size),_loc2_ + 8);
         si32(li32(_tls_init),_loc2_ + 4);
         si32(_loc5_,_loc2_);
         ESP = _loc2_;
         Fmemcpy();
         _loc2_ += 16;
         _loc7_ = li32(_tls_init_size);
         _loc2_ -= 16;
         var _loc4_:*;
         si32((_loc4_ = li32(_tls_static_space)) - _loc7_,_loc2_ + 8);
         si32(0,_loc2_ + 4);
         si32(_loc7_ = (_loc6_ = _loc9_ - _loc4_) + _loc7_,_loc2_);
         ESP = _loc2_;
         Fmemset();
         _loc2_ += 16;
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
