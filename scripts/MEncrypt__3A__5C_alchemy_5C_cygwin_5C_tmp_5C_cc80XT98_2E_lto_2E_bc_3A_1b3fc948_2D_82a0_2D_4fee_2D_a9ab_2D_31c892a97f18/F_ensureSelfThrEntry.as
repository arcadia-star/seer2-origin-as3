package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_ensureSelfThrEntry() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = int(threadId);
      _loc6_ = int(threadId);
      _loc2_ -= 16;
      si32(_loc6_ += 8,_loc2_ + 4);
      si32(_sThreadListMtx,_loc2_);
      ESP = _loc2_;
      F_avm2_lock_id();
      _loc2_ += 16;
      _loc5_ = _sThreadListHead;
      while(true)
      {
         if((_loc5_ = li32(_loc5_)) == 0)
         {
            _loc2_ -= 16;
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(12,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc2_ += 16;
            _loc6_ = eax;
            si32(_loc1_,_loc6_ + 8);
            var _loc4_:*;
            si32(_loc4_ = tcbp,_loc6_ + 4);
            _loc2_ -= 16;
            si32(_loc4_ = int(threadId) + 8,_loc2_ + 4);
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            si32(_loc4_ = li32(_sThreadListHead),_loc6_);
            si32(_loc6_,_sThreadListHead);
            _loc2_ -= 16;
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            break;
         }
         if((_loc6_ = li32(_loc5_ + 8)) == _loc1_)
         {
            _loc2_ -= 16;
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            break;
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
