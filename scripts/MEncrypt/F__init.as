package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__init() : void
   {
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc6_:int = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      ESP = _loc2_;
      F_flascc_pthreadsInit();
      _loc2_ -= 16;
      si32(-1,_loc2_);
      ESP = _loc2_;
      F_uiThreadIdRaw();
      _loc2_ += 16;
      _loc1_ = eax;
      if(_loc1_ >= 0)
      {
         _loc2_ -= 16;
         si32(-1,_loc2_);
         ESP = _loc2_;
         F_uiThreadIdRaw();
         _loc2_ += 16;
         if(eax != int(realThreadId))
         {
            _loc2_ -= 16;
            si32(_loc3_ - 12,_loc2_);
            ESP = _loc2_;
            F_uiThreadESPInit();
            _loc2_ += 16;
            si32(_loc7_ = 0,_loc3_ - 16);
            _loc2_ -= 16;
            si32(li32(_loc3_ - 12),_loc2_ + 8);
            si32(eax - li32(_loc3_ - 12),_loc2_ + 4);
            si32(_loc6_ = _loc3_ - 8,_loc2_);
            ESP = _loc2_;
            F_flascc_uiThreadAttrInit();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(_loc5_ = _loc3_ - 16,_loc2_ + 12);
            si32(_uiThreadInitThreadProc,_loc2_ + 8);
            si32(_loc6_,_loc2_ + 4);
            si32(_loc3_ - 4,_loc2_);
            ESP = _loc2_;
            F_pthread_create();
            _loc4_ = int(workerClass.current.getSharedProperty("flascc.uiThread.tcbpp"));
            _loc2_ += 16;
            if(eax == 0)
            {
               if(li32(_loc3_ - 16) == 0)
               {
                  do
                  {
                     _loc2_ -= 16;
                     si32(1,_loc2_ + 4);
                     si32(_loc5_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_self_msleep();
                     _loc2_ += 16;
                     _loc1_ = li32(_loc3_ - 16);
                  }
                  while(_loc1_ == 0);
                  
               }
               _loc1_ = li32(_loc3_ - 16);
               _loc2_ -= 16;
               si32(0,_loc2_ + 8);
               si32(_thrTCB,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               F_avm2_thr_impersonate();
               _loc2_ += 16;
               _loc1_ = eax;
               si32(_loc1_,_loc4_);
            }
            else
            {
               si32(-1,_loc4_);
            }
            _loc1_ = li8(_sIsThreaded_2E_b);
            if(_loc1_ == 1)
            {
               threadArbMutexLock();
               _loc7_ = 0;
               if(li8(_sIsThreaded_2E_b) == 1)
               {
                  ESP = _loc2_;
                  F__sync_synchronize();
                  threadArbCondsNotify(-1);
                  _loc7_ = li8(_sIsThreaded_2E_b);
               }
            }
            _loc1_ = li32(_loc4_);
            if(_loc1_ != 0)
            {
               do
               {
                  _loc5_ = 0;
                  if(_loc7_ != 0)
                  {
                     ESP = _loc2_;
                     F__sync_synchronize();
                     _loc7_ = int(threadArbCondWait(1));
                     ESP = _loc2_;
                     F__sync_synchronize();
                     _loc5_ = li8(_sIsThreaded_2E_b);
                  }
                  _loc1_ = li32(_loc4_);
                  _loc7_ = _loc5_;
               }
               while(_loc1_ != 0);
               
            }
            _loc1_ = _loc7_ & 1;
            if(_loc1_ != 0)
            {
               threadArbMutexUnlock();
            }
            _loc2_ -= 16;
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_flascc_uiThreadAttrDestroy();
            _loc2_ += 16;
         }
      }
      ESP = _loc2_ & -16;
      CModule.runCtors();
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
