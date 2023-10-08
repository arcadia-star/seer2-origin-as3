package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_cmpSwapUns() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_avm2_haveWorkers_2E_4273);
      if(_loc1_ == -1)
      {
         _loc1_ = int(Boolean(workerClass));
         si32(_loc1_,_avm2_haveWorkers_2E_4273);
      }
      _loc6_ = li32(_loc3_ + 8);
      _loc5_ = li32(_loc3_ + 4);
      _loc4_ = li32(_loc3_);
      if(_loc1_ != 0)
      {
         _loc1_ = casi32(_loc4_,_loc5_,_loc6_);
      }
      else
      {
         _loc1_ = li32(_loc4_);
         if(_loc1_ == _loc5_)
         {
            si32(_loc6_,_loc4_);
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
