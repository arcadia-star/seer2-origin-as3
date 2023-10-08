package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._delegateExitToActiveConsoleThunk;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__exit() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_ + 4);
      si32(_delegateExitToActiveConsoleThunk,_loc2_);
      ESP = _loc2_;
      F_avm2_ui_thunk();
      _loc2_ += 16;
      var _loc4_:int;
      if((_loc4_ = eax) == 0)
      {
         throw new Exit(_loc1_);
      }
      ESP = _loc3_;
   }
}
