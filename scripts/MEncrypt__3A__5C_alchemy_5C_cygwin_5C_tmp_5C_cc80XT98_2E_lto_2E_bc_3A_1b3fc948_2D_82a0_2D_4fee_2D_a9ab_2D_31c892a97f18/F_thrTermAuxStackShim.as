package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_thrTermAuxStackShim() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc13_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      _loc1_ = li32(_loc3_ + 4);
      _loc13_ = li8(_loc1_ + 8);
      _loc12_ = li32(_loc1_ + 4);
      _loc11_ = li32(_loc1_);
      ESP = _loc2_;
      F_ensureSelfThrEntry();
      _loc1_ = int(threadId);
      _loc2_ -= 16;
      _loc1_ += 8;
      si32(_loc1_,_loc2_ + 4);
      si32(_sThreadListMtx,_loc2_);
      ESP = _loc2_;
      F_avm2_lock_id();
      _loc2_ += 16;
      _loc10_ = _sThreadListHead;
      _loc9_ = int(realThreadId);
      _loc8_ = li32(_loc3_);
      while(true)
      {
         if((_loc7_ = li32(_loc10_)) == 0)
         {
            _loc2_ -= 16;
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            _loc6_ = 0;
            break;
         }
         if(li32(_loc7_ + 8) != _loc11_)
         {
            continue;
         }
         if((_loc5_ = _loc13_ & 255) == 0)
         {
            _loc2_ -= 16;
            si32(_sThreadListMtx,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            _loc6_ = 0;
            if(_loc7_ != 0)
            {
               addr200:
               _loc10_ = li32(_loc7_ + 4);
               _loc6_ = _sLock_2E_3947;
               if(_loc10_ != -1)
               {
                  _loc6_ = _loc10_ + 16;
               }
               if((_loc10_ = li32(_sLock_2E_3947)) == -1)
               {
                  si32(_loc10_ = int(realThreadId) + 1,_sLock_2E_3947);
               }
               if(_loc10_ != 0)
               {
                  if(_loc6_ != _sLock_2E_3947)
                  {
                     si32(_loc10_,_loc6_);
                     si32(0,_sLock_2E_3947);
                  }
               }
               if(_loc9_ != _loc11_)
               {
                  _loc10_ = 0;
                  var _loc4_:*;
                  if(((_loc4_ = li32(_loc6_)) & 2147483647) != int(realThreadId) + 1)
                  {
                     addr270:
                     if((_loc10_ = li32(_loc7_ + 4)) == -1)
                     {
                        _loc10_ = li32(_sCounter_2E_3962);
                        _loc13_ = _sCounter_2E_3962;
                        _loc10_ = _loc6_;
                     }
                     else
                     {
                        _loc13_ = _loc10_ + 20;
                        _loc10_ = _loc6_;
                        if(li32(_sCounter_2E_3962) != 0)
                        {
                           _loc10_ = _loc6_;
                           if(_loc13_ != _sCounter_2E_3962)
                           {
                              si32(li32(_sCounter_2E_3962),_loc13_);
                              si32(0,_sCounter_2E_3962);
                              _loc10_ = _loc6_;
                           }
                        }
                     }
                  }
                  if(_loc5_ != 0)
                  {
                     _loc2_ -= 16;
                     si32(_loc7_,_loc2_);
                     ESP = _loc2_;
                     F_idalloc();
                     _loc2_ += 16;
                  }
                  if(_loc9_ != _loc11_)
                  {
                     _loc2_ -= 16;
                     si32(int(threadId) + 8,_loc2_ + 4);
                     si32(_sThreadListMtx,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     _loc2_ -= 16;
                     si32(int(threadId) + 8,_loc2_ + 4);
                     si32(_skpmallocMtx,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     _loc2_ -= 16;
                     si32(int(threadId) + 8,_loc2_ + 4);
                     si32(_smmapMtx,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     if(li8(_sIsThreaded_2E_b) == 1)
                     {
                        threadArbMutexLock();
                     }
                  }
                  else
                  {
                     if(_loc12_ != 0)
                     {
                        si32(1,_loc12_);
                        si32(_loc12_,_loc3_ - 48);
                        _loc6_ = (_loc7_ = _loc3_ - 48) | 4;
                        si32(3,_loc6_);
                        si32(2147483647,_loc3_ - 40);
                        si32(0,_loc3_ - 36);
                        si32(0,_loc3_ - 32);
                        if(li32(_loc5_ = li32(tcbp + 12)) == 0)
                        {
                           si32(int(threadId) + 8,_loc5_);
                        }
                        if((uint(_loc6_ = li32(_loc6_))) <= 18)
                        {
                           _loc2_ -= 16;
                           si32(_loc7_,_loc2_ + 4);
                           si32(_loc5_,_loc2_);
                           _loc1_ = li32(_op_table + (_loc6_ << 2));
                           ESP = _loc2_;
                           ptr2fun[_loc1_]();
                           _loc2_ += 16;
                        }
                     }
                     if(_loc10_ != 0)
                     {
                        si32(0,_loc13_);
                     }
                  }
                  _loc2_ -= 16;
                  si32(_loc11_,_loc2_);
                  if(_loc9_ != _loc11_)
                  {
                     _loc8_ = 0;
                  }
                  si32(_loc8_,_loc2_ + 8);
                  _loc8_ = _loc10_;
                  if(_loc9_ != _loc11_)
                  {
                     _loc8_ = 0;
                  }
                  si32(_loc8_,_loc2_ + 4);
                  ESP = _loc2_;
                  F_workerTerm();
                  _loc2_ += 16;
                  _loc1_ = li8(_sIsThreaded_2E_b);
                  if(_loc1_ == 1)
                  {
                     threadArbMutexUnlock();
                  }
                  _loc2_ -= 16;
                  si32(_smmapMtx,_loc2_);
                  ESP = _loc2_;
                  F_avm2_unlock();
                  _loc2_ += 16;
                  _loc2_ -= 16;
                  si32(_sThreadListMtx,_loc2_);
                  ESP = _loc2_;
                  F_avm2_unlock();
                  _loc2_ += 16;
                  _loc2_ -= 16;
                  si32(_skpmallocMtx,_loc2_);
                  ESP = _loc2_;
                  F_avm2_unlock();
                  _loc2_ += 16;
                  if(_loc12_ != 0)
                  {
                     si32(1,_loc12_);
                     si32(_loc12_,_loc3_ - 24);
                     _loc9_ = (_loc11_ = _loc3_ - 24) | 4;
                     si32(3,_loc9_);
                     si32(2147483647,_loc3_ - 16);
                     si32(0,_loc3_ - 12);
                     si32(0,_loc3_ - 8);
                     if(li32(_loc12_ = li32(tcbp + 12)) == 0)
                     {
                        si32(int(threadId) + 8,_loc12_);
                     }
                     if((uint(_loc9_ = li32(_loc9_))) <= 18)
                     {
                        _loc2_ -= 16;
                        si32(_loc11_,_loc2_ + 4);
                        si32(_loc12_,_loc2_);
                        _loc1_ = li32(_op_table + (_loc9_ << 2));
                        ESP = _loc2_;
                        ptr2fun[_loc1_]();
                        _loc2_ += 16;
                     }
                  }
                  _loc6_ = 1;
                  if(_loc10_ != 0)
                  {
                     si32(0,_loc13_);
                     _loc2_ -= 16;
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_unlock();
                     _loc2_ += 16;
                     _loc6_ = 1;
                     break;
                  }
                  break;
               }
               §§goto(addr270);
            }
            break;
         }
         si32(li32(_loc7_),_loc10_);
         _loc2_ -= 16;
         si32(_sThreadListMtx,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         §§goto(addr200);
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
