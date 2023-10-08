package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_kern_umtx_wake() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc11_:int = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:int = 0;
      var _loc7_:int = 0;
      var _loc9_:int = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = int(threadId);
      _loc2_ -= 16;
      _loc1_ += 8;
      si32(_loc1_,_loc2_ + 4);
      _loc1_ = (_loc12_ = li32(_loc3_ + 4)) * -1640562687;
      _loc1_ >>>= 25;
      _loc1_ *= 44;
      _loc1_ = _umtxq_chains + _loc1_;
      si32(_loc11_ = _loc1_ + 5632,_loc2_);
      ESP = _loc2_;
      F_avm2_lock_id();
      _loc2_ += 16;
      _loc10_ = li32(_loc1_ + 5652);
      _loc9_ = 0;
      _loc8_ = li32(_loc3_ + 8);
      loop0:
      while(true)
      {
         _loc9_ += 1;
         while((_loc6_ = _loc10_) != 0)
         {
            _loc5_ = li32(_loc6_ + 12);
            _loc10_ = li32(_loc6_);
            if(_loc5_ == 0)
            {
               if(li32(_loc6_ + 20) == _loc12_)
               {
                  if(li32(_loc6_ + 24) != 0)
                  {
                     continue;
                  }
                  continue loop0;
               }
            }
         }
         addr268:
         _loc2_ -= 16;
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         eax = 0;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
   }
}
