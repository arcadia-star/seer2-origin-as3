package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_callOnAuxStack;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_thr_kill2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      ESP = _loc2_;
      F_getpid();
      _loc1_ = eax;
      _loc6_ = li32(_loc3_);
      if(_loc1_ == _loc6_)
      {
         si32(_loc6_ = (_loc6_ = li32(_loc3_ + 4)) + -8,_loc3_ - 16);
         si32(_loc4_ = 0,(_loc5_ = _loc3_ - 16) | 4);
         si8(_loc4_,_loc3_ - 8);
         if(li32(_loc3_ + 8) != 0)
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F_callOnAuxStack();
            _loc4_ = 0;
            _loc2_ += 16;
            if(eax == 0)
            {
               ESP = _loc2_;
               F___error();
               si32(22,eax);
               _loc4_ = -1;
            }
         }
      }
      else
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc4_ = -1;
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
