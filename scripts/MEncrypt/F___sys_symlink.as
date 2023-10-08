package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___sys_symlink() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      ESP = _loc2_;
      F___error();
      _loc1_ = li32(_loc3_ + 4);
      _loc10_ = li32(_loc3_);
      _loc9_ = eax;
      if((_loc8_ = li32(_sUITID_2E_4001)) == -2)
      {
         _loc2_ -= 16;
         si32(-1,_loc2_);
         ESP = _loc2_;
         F_uiThreadIdRaw();
         _loc2_ += 16;
         var _loc7_:*;
         si32(_loc7_ = eax,_sUITID_2E_4001);
         if(_loc7_ >= 0)
         {
            si8(1,_sIsThreaded_2E_b);
            addr87:
            _loc7_ = li32(_sUITID_2E_4001);
            var _loc6_:*;
            if((_loc6_ = int(realThreadId)) != _loc7_)
            {
               _loc2_ = _loc7_ = (_loc7_ = (_loc7_ = _loc2_) + -16) & -16;
               si32(_loc6_ = _loc3_,_loc7_);
               var _loc4_:* = (_loc6_ = _loc3_ - 32) | 4;
               si32(0,_loc4_);
               si32(0,_loc3_ - 4);
               si32(0,_loc3_ - 8);
               si32(0,_loc3_ - 12);
               si32(0,_loc3_ - 16);
               si32(0,_loc3_ - 20);
               si32(0,_loc3_ - 24);
               si32(0,_loc3_ - 32);
               si32(___sys_symlink,_loc3_ - 32);
               si32(_loc7_,_loc4_);
               si32(8,_loc3_ - 24);
               _loc2_ -= 16;
               si32(_loc6_,_loc2_ + 4);
               si32(_applyThunk,_loc2_);
               ESP = _loc2_;
               F_avm2_ui_thunk();
               _loc2_ += 16;
               eax = _loc4_ = li32(_loc3_ - 16);
               edx = li32(_loc3_ - 12);
               st0 = lf64(_loc3_ - 8);
               ESP = _loc3_;
               return;
            }
         }
      }
      else if(_loc8_ >= 0)
      {
         §§goto(addr87);
      }
      ESP = _loc2_ & -16;
      eax = _loc7_ = int(CModule.kernel.symlink(_loc10_,_loc1_,_loc9_));
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
