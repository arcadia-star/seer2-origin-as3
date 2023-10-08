package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_workerTerm() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc3_:* = ESP;
      _loc2_ = li32(_loc4_ = _loc3_);
      _loc6_ = li32(_loc4_ + 4);
      _loc5_ = li32(_loc4_ + 8);
      for each(var _loc1_ in workerDomainClass.current.listWorkers())
      {
         if(Number(_loc1_.getSharedProperty("flascc.threadId")) == _loc2_)
         {
            if(_loc6_)
            {
               CModule.callI(_avm2_unlock,new <int>[_loc6_]);
            }
            if(_loc5_)
            {
               CModule.callI(_avm2_unlock,new <int>[_loc5_]);
            }
            _loc1_.terminate();
            while(_loc1_.state == "running" || _loc1_.state == "new")
            {
               yield();
            }
            break;
         }
      }
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
