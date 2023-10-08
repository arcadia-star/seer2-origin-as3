package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_uiThreadInitThreadProc() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = int(threadId);
      _loc5_ = _loc1_ + 8;
      _loc4_ = li32(_loc3_);
      si32(_loc5_,_loc4_);
      _loc2_ -= 16;
      si32(_loc4_,_loc2_);
      ESP = _loc2_;
      F_avm2_wake();
      _loc2_ += 16;
      si32(_loc1_,_loc3_ - 16);
      _loc4_ = (_loc5_ = _loc3_ - 16) | 4;
      si32(0,_loc4_);
      si8(0,_loc3_ - 8);
      _loc2_ -= 16;
      si32(_loc5_,_loc2_);
      ESP = _loc2_;
      F_callOnAuxStack();
      _loc2_ += 16;
      if((_loc5_ = eax) == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
      }
      eax = 0;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
