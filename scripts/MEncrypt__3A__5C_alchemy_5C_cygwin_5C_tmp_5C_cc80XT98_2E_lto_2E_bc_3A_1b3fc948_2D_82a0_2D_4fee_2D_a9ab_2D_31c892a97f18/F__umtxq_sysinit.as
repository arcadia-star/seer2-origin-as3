package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F_kmtx_init;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__umtxq_sysinit() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      do
      {
         _loc2_ -= 16;
         si32(16,_loc2_ + 12);
         si32(0,_loc2_ + 8);
         si32(L__2E_str8,_loc2_ + 4);
         var _loc6_:int;
         si32(_loc6_ = _umtxq_chains + _loc1_,_loc2_);
         ESP = _loc2_;
         F_kmtx_init();
         _loc2_ += 16;
         si32(0,_loc6_ + 20);
         var _loc5_:int;
         si32(_loc5_ = _loc6_ + 20,_loc6_ + 24);
         si32(0,_loc6_ + 28);
         si32(_loc5_ = _loc6_ + 28,_loc6_ + 32);
         si8(0,_loc6_ + 36);
         si32(0,_loc6_ + 40);
         _loc1_ += 44;
         _loc4_ = 0;
      }
      while(_loc1_ != 5632);
      
      do
      {
         _loc2_ -= 16;
         si32(16,_loc2_ + 12);
         si32(0,_loc2_ + 8);
         si32(L__2E_str8,_loc2_ + 4);
         si32(_loc5_ = (_loc6_ = _umtxq_chains + _loc4_) + 5632,_loc2_);
         ESP = _loc2_;
         F_kmtx_init();
         _loc2_ += 16;
         si32(0,_loc6_ + 5652);
         si32(_loc5_ = _loc6_ + 5652,_loc6_ + 5656);
         si32(0,_loc6_ + 5660);
         si32(_loc5_ = _loc6_ + 5660,_loc6_ + 5664);
         si8(0,_loc6_ + 5668);
         si32(0,_loc6_ + 5672);
      }
      while((_loc4_ += 44) != 5632);
      
      _loc2_ -= 16;
      si32(1,_loc2_ + 12);
      si32(0,_loc2_ + 8);
      si32(L__2E_str9,_loc2_ + 4);
      si32(_umtx_lock,_loc2_);
      ESP = _loc2_;
      F_kmtx_init();
      _loc2_ += 16;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
