package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_catclose() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc6_:int;
      if((uint(_loc6_ = _loc1_ + -1)) >= 4294967294)
      {
         ESP = _loc2_;
         F___error();
         si32(9,eax);
         _loc5_ = -1;
      }
      else
      {
         _loc2_ -= 16;
         si32(li32(_loc1_ + 4),_loc2_ + 4);
         si32(li32(_loc1_),_loc2_);
         ESP = _loc2_;
         F_munmap();
         _loc2_ += 16;
         _loc5_ = 0;
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(_loc1_,_loc2_);
            ESP = _loc2_;
            F_idalloc();
            _loc2_ += 16;
            _loc5_ = 0;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
