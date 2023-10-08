package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_self_lock() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _sLock_2E_3947;
      if((_loc5_ = tcbp) != -1)
      {
         _loc1_ = _loc5_ + 16;
      }
      if((_loc5_ = li32(_sLock_2E_3947)) == -1)
      {
         var _loc4_:*;
         si32(_loc5_ = (_loc4_ = int(realThreadId)) + 1,_sLock_2E_3947);
      }
      if(_loc5_ != 0)
      {
         if(_loc1_ != _sLock_2E_3947)
         {
            si32(_loc5_,_loc1_);
            si32(0,_sLock_2E_3947);
         }
      }
      _loc5_ = (_loc4_ = int(realThreadId)) + 1;
      if((_loc4_ = (_loc4_ = li32(_loc1_)) & 2147483647) != _loc5_)
      {
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 4);
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
      }
      _loc1_ = tcbp;
      if(_loc1_ == -1)
      {
         _loc1_ = li32(_sCounter_2E_3962);
         _loc1_ = _sCounter_2E_3962;
      }
      else
      {
         _loc1_ += 20;
         if((_loc4_ = li32(_sCounter_2E_3962)) != 0)
         {
            if(_loc1_ != _sCounter_2E_3962)
            {
               si32(_loc4_ = li32(_sCounter_2E_3962),_loc1_);
               si32(0,_sCounter_2E_3962);
            }
         }
      }
      si32(_loc4_ = (_loc4_ = li32(_loc1_)) + 1,_loc1_);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
