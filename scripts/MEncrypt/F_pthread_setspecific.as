package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sEntries;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sEntryCount;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_pthread_setspecific() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = -1;
      if((_loc7_ = li32(_loc3_)) >= 0)
      {
         var _loc6_:*;
         if((_loc6_ = li32(_sEntryCount)) > _loc7_)
         {
            var _loc4_:*;
            si32(li32(_loc3_ + 4),(_loc4_ = li32(_sEntries)) + (_loc7_ << 3));
            _loc1_ = 0;
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
