package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_is_ui_worker() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_sUITID_2E_4001);
      if(_loc1_ == -2)
      {
         _loc2_ -= 16;
         si32(-1,_loc2_);
         ESP = _loc2_;
         F_uiThreadIdRaw();
         _loc2_ += 16;
         var _loc6_:*;
         si32(_loc6_ = eax,_sUITID_2E_4001);
         _loc5_ = 1;
         if(_loc6_ >= 0)
         {
            si8(1,_sIsThreaded_2E_b);
            addr63:
            _loc5_ = 1;
            _loc6_ = li32(_sUITID_2E_4001);
            var _loc4_:int;
            if((_loc4_ = int(realThreadId)) != _loc6_)
            {
               _loc5_ = 0;
            }
         }
      }
      else
      {
         _loc5_ = 1;
         if(_loc1_ >= 0)
         {
            §§goto(addr63);
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
