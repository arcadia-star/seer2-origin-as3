package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_thr_new() : void
   {
      var _loc5_:* = 0;
      var _loc30_:* = 0;
      var _loc27_:int = 0;
      var _loc24_:int = 0;
      var _loc20_:int = 0;
      var _loc17_:int = 0;
      var _loc11_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc29_:int = 0;
      var _loc21_:int = 0;
      var _loc19_:int = 0;
      var _loc8_:int = 0;
      var _loc26_:int = 0;
      var _loc25_:int = 0;
      var _loc12_:* = 0;
      var _loc23_:int = 0;
      var _loc16_:int = 0;
      var _loc18_:* = 0;
      var _loc13_:int = 0;
      var _loc6_:* = 0;
      var _loc9_:int = 0;
      var _loc31_:int = 0;
      var _loc2_:* = ESP;
      var _loc15_:*;
      if((_loc15_ = li32((_loc5_ = _loc2_) + 4)) != 52)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc31_ = -1;
      }
      else if((_loc15_ = (_loc15_ = li32((_loc30_ = li32(_loc5_)) + 32)) & -3) != 0)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc31_ = -1;
      }
      else
      {
         if((_loc15_ = li32(_sTID_2E_5319)) <= -1)
         {
            _loc2_ -= 16;
            si32(0,_loc2_);
            ESP = _loc2_;
            F_uiThreadIdRaw();
            _loc2_ += 16;
            si32(_loc15_ = eax,_sTID_2E_5319);
         }
         _loc2_ -= 16;
         si32(0,_loc2_);
         ESP = _loc2_;
         F_uiThreadESPInit();
         _loc2_ += 16;
         _loc29_ = eax;
         var _loc28_:* = li32(_loc30_ + 12);
         _loc27_ = (_loc15_ = li32(_loc30_ + 8)) + _loc28_;
         _loc26_ = 1;
         if(_loc29_ == _loc27_)
         {
            _loc26_ = 0;
         }
         if((_loc15_ = li32(_flascc_maxWorkers)) >= 1)
         {
            if((_loc15_ = _loc26_ & 1) != 0)
            {
               if((_loc15_ = int(workerDomainClass.current.listWorkers().length)) >= li32(_flascc_maxWorkers))
               {
                  ESP = _loc2_;
                  F___error();
                  si32(67,eax);
                  _loc31_ = -1;
               }
               §§goto(addr821);
            }
         }
         ESP = _loc2_;
         F_ensureSelfThrEntry();
         _loc25_ = _sLock_2E_3947;
         if((_loc24_ = tcbp) != -1)
         {
            _loc25_ = _loc24_ + 16;
         }
         if((_loc12_ = li32(_sLock_2E_3947)) == -1)
         {
            si32(_loc12_ = (_loc15_ = int(realThreadId)) + 1,_sLock_2E_3947);
         }
         if(_loc12_ != 0)
         {
            if(_loc25_ != _sLock_2E_3947)
            {
               si32(_loc12_,_loc25_);
               si32(0,_sLock_2E_3947);
            }
         }
         _loc20_ = (_loc15_ = int(realThreadId)) + 1;
         if((_loc15_ = (_loc15_ = li32(_loc25_)) & 2147483647) != _loc20_)
         {
            _loc2_ -= 16;
            si32(_loc20_,_loc2_ + 4);
            si32(_loc25_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
         }
         if((_loc21_ = tcbp) == -1)
         {
            li32(_sCounter_2E_3962);
            _loc23_ = _sCounter_2E_3962;
         }
         else
         {
            _loc23_ = _loc21_ + 20;
            if((_loc15_ = li32(_sCounter_2E_3962)) != 0)
            {
               if(_loc23_ != _sCounter_2E_3962)
               {
                  si32(_loc15_ = li32(_sCounter_2E_3962),_loc23_);
                  si32(0,_sCounter_2E_3962);
               }
            }
         }
         si32(_loc15_ = (_loc15_ = li32(_loc23_)) + 1,_loc23_);
         _loc16_ = _sLock_2E_3947;
         if((_loc17_ = tcbp) != -1)
         {
            _loc16_ = _loc17_ + 16;
         }
         if((_loc18_ = li32(_sLock_2E_3947)) == -1)
         {
            si32(_loc18_ = (_loc15_ = int(realThreadId)) + 1,_sLock_2E_3947);
         }
         if(_loc18_ != 0)
         {
            if(_loc16_ != _sLock_2E_3947)
            {
               si32(_loc18_,_loc16_);
               si32(0,_sLock_2E_3947);
            }
         }
         if((_loc19_ = tcbp) == -1)
         {
            li32(_sCounter_2E_3962);
            _loc13_ = _sCounter_2E_3962;
         }
         else
         {
            _loc13_ = _loc19_ + 20;
            if((_loc15_ = li32(_sCounter_2E_3962)) != 0)
            {
               if(_loc13_ != _sCounter_2E_3962)
               {
                  si32(_loc15_ = li32(_sCounter_2E_3962),_loc13_);
                  si32(0,_sCounter_2E_3962);
               }
            }
         }
         si32(_loc15_ = (_loc15_ = li32(_loc13_)) + -1,_loc13_);
         if(_loc15_ == 0)
         {
            _loc2_ -= 16;
            si32(_loc16_,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
         }
         if((_loc11_ = li32(_sUITID_2E_4001)) == -2)
         {
            _loc2_ -= 16;
            si32(-1,_loc2_);
            ESP = _loc2_;
            F_uiThreadIdRaw();
            _loc2_ += 16;
            si32(_loc15_ = eax,_sUITID_2E_4001);
            if(_loc15_ >= 0)
            {
               si8(1,_sIsThreaded_2E_b);
               addr558:
            }
         }
         else if(_loc11_ >= 0)
         {
            §§goto(addr558);
         }
         _loc2_ -= 16;
         si32(12,_loc2_);
         ESP = _loc2_;
         F_malloc();
         _loc2_ += 16;
         _loc8_ = eax;
         if(_loc29_ == _loc27_)
         {
            _loc2_ -= 16;
            si32(-1,_loc2_);
            ESP = _loc2_;
            F_uiThreadIdRaw();
            _loc2_ += 16;
            _loc9_ = eax;
         }
         else
         {
            _loc6_ = li32(_sTID_2E_5319);
            do
            {
               var _loc7_:* = _loc6_;
               _loc2_ -= 16;
               si32(_loc7_,_loc2_ + 4);
               si32(_sTID_2E_5319,_loc2_);
               si32(_loc9_ = _loc7_ + 1,_loc2_ + 8);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc2_ += 16;
            }
            while((_loc6_ = eax) != _loc7_);
            
         }
         si32(_loc9_,_loc8_ + 8);
         si32(_loc15_ = li32(_loc30_ + 16),_loc8_ + 4);
         _loc15_ = li32(_loc30_ + 12);
         _loc15_ = (_loc28_ = li32(_loc30_ + 8)) + _loc15_;
         var _loc3_:* = li32(_loc30_ + 4);
         _loc28_ = li32(_loc30_);
         var _loc10_:* = newThread(_loc9_,_loc15_,_thread_run,new <int>[_loc8_,_loc28_,_loc3_]);
         _loc15_ = int(threadId);
         _loc2_ -= 16;
         si32(_loc15_ += 8,_loc2_ + 4);
         si32(_sThreadListMtx,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
         si32(_loc15_ = li32(_sThreadListHead),_loc8_);
         si32(_loc8_,_sThreadListHead);
         _loc2_ -= 16;
         si32(_sThreadListMtx,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         if((_loc4_ = li32(_loc30_ + 24)) != 0)
         {
            si32(_loc15_ = _loc9_ + 8,_loc4_);
         }
         _loc1_ = li32(_loc30_ + 28);
         if(_loc1_ != 0)
         {
            si32(_loc15_ = _loc9_ + 8,_loc1_);
         }
         si8(1,_sIsThreaded_2E_b);
         _loc10_.start();
         _loc31_ = 0;
      }
      addr821:
      eax = _loc31_;
      _loc2_ = _loc5_;
      ESP = _loc2_;
   }
}
