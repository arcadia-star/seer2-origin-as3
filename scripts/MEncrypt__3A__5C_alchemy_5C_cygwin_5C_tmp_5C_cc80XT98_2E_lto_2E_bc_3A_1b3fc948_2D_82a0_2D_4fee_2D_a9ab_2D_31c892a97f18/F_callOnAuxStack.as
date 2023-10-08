package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_callOnAuxStack() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = int(threadId);
      _loc2_ -= 16;
      _loc1_ += 8;
      si32(_loc1_,_loc2_ + 4);
      si32(_sLock_2E_5382,_loc2_);
      ESP = _loc2_;
      F_avm2_lock_id();
      _loc2_ += 16;
      _loc1_ = _sAuxStack_2E_5383 + 65536;
      _loc4_ = li32(_loc3_);
      _loc1_ = CModule.callI(_thrTermAuxStackShim,new <int>[_sLock_2E_5382,_loc4_],_loc1_);
      _loc2_ -= 16;
      si32(_sLock_2E_5382,_loc2_);
      ESP = _loc2_;
      F_avm2_unlock();
      _loc2_ += 16;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
