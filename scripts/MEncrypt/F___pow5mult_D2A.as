package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._p05_2E_3375;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._p5s;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___pow5mult_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc9_ = _loc1_ & 3;
      _loc8_ = li32(_loc3_);
      if(_loc9_ != 0)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 8);
         si32(_loc8_,_loc2_);
         var _loc7_:*;
         si32(_loc7_ = li32((_loc7_ = (_loc7_ = _loc9_ << 2) + _p05_2E_3375) - 4),_loc2_ + 4);
         ESP = _loc2_;
         F___multadd_D2A();
         _loc2_ += 16;
         _loc8_ = eax;
      }
      if((_loc6_ = _loc1_ >> 2) != 0)
      {
         _loc5_ = li32(_p5s);
         _loc9_ = _loc8_;
         if(_loc5_ == 0)
         {
            if((_loc7_ = li32(___isthreaded)) != 0)
            {
               _loc2_ -= 16;
               si32(_loc7_ = ___gdtoa_locks + 4,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_lock();
               _loc2_ += 16;
               if((_loc5_ = li32(_p5s)) == 0)
               {
                  if((_loc7_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(___gdtoa_locks,_loc2_);
                     ESP = _loc2_;
                     F__pthread_mutex_lock();
                     _loc2_ += 16;
                     addr169:
                     if((_loc5_ = li32(_freelist + 4)) != 0)
                     {
                        si32(_loc7_ = li32(_loc5_),_freelist + 4);
                     }
                     else
                     {
                        if((uint(_loc7_ = (_loc7_ = (_loc7_ = (_loc5_ = li32(_pmem_next)) - _private_mem) >> 3) + 4)) <= 288)
                        {
                           si32(_loc7_ = _loc5_ + 32,_pmem_next);
                        }
                        else
                        {
                           _loc2_ -= 16;
                           si32(32,_loc2_);
                           ESP = _loc2_;
                           F_malloc();
                           _loc2_ += 16;
                           _loc5_ = eax;
                        }
                        si32(1,_loc5_ + 4);
                        si32(2,_loc5_ + 8);
                     }
                     if((_loc7_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(___gdtoa_locks,_loc2_);
                        ESP = _loc2_;
                        F__pthread_mutex_unlock();
                        _loc2_ += 16;
                     }
                     si32(0,_loc5_ + 12);
                     si32(625,_loc5_ + 20);
                     si32(1,_loc5_ + 16);
                     si32(_loc5_,_p5s);
                     si32(0,_loc5_);
                  }
                  §§goto(addr169);
               }
               _loc7_ = li32(___isthreaded);
               _loc9_ = _loc8_;
               if(_loc7_ != 0)
               {
                  _loc2_ -= 16;
                  si32(_loc7_ = ___gdtoa_locks + 4,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_unlock();
                  _loc2_ += 16;
                  _loc9_ = _loc8_;
                  while(true)
                  {
                     _loc1_ = _loc5_;
                     _loc7_ = _loc6_ & 1;
                     _loc8_ = _loc9_;
                     if(_loc7_ != 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc1_,_loc2_ + 4);
                        si32(_loc9_,_loc2_);
                        ESP = _loc2_;
                        F___mult_D2A();
                        _loc2_ += 16;
                        _loc8_ = eax;
                        if(_loc9_ != 0)
                        {
                           if((_loc5_ = li32(_loc9_ + 4)) >= 10)
                           {
                              _loc2_ -= 16;
                              si32(_loc9_,_loc2_);
                              ESP = _loc2_;
                              F_idalloc();
                              _loc2_ += 16;
                           }
                           else
                           {
                              if((_loc7_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(___gdtoa_locks,_loc2_);
                                 ESP = _loc2_;
                                 F__pthread_mutex_lock();
                                 _loc2_ += 16;
                                 _loc5_ = li32(_loc9_ + 4);
                              }
                              _loc7_ = _loc5_ << 2;
                              var _loc4_:int;
                              si32(_loc7_ = li32(_loc4_ = _freelist + _loc7_),_loc9_);
                              si32(_loc9_,_loc4_);
                              if((_loc7_ = li32(___isthreaded)) != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(___gdtoa_locks,_loc2_);
                                 ESP = _loc2_;
                                 F__pthread_mutex_unlock();
                                 _loc2_ += 16;
                              }
                           }
                        }
                     }
                     if((_loc6_ >>= 1) == 0)
                     {
                        break;
                     }
                     _loc5_ = li32(_loc1_);
                     _loc9_ = _loc8_;
                     if(_loc5_ != 0)
                     {
                        continue;
                     }
                     if((_loc7_ = li32(___isthreaded)) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc7_ = ___gdtoa_locks + 4,_loc2_);
                        ESP = _loc2_;
                        F__pthread_mutex_lock();
                        _loc2_ += 16;
                        if((_loc5_ = li32(_loc1_)) == 0)
                        {
                           addr554:
                           _loc2_ -= 16;
                           si32(_loc1_,_loc2_ + 4);
                           si32(_loc1_,_loc2_);
                           ESP = _loc2_;
                           F___mult_D2A();
                           _loc2_ += 16;
                           si32(_loc5_ = eax,_loc1_);
                           si32(0,_loc5_);
                        }
                        _loc7_ = li32(___isthreaded);
                        _loc9_ = _loc8_;
                        if(_loc7_ != 0)
                        {
                           _loc2_ -= 16;
                           si32(_loc7_ = ___gdtoa_locks + 4,_loc2_);
                           ESP = _loc2_;
                           F__pthread_mutex_unlock();
                           _loc2_ += 16;
                           _loc9_ = _loc8_;
                        }
                        continue;
                     }
                     §§goto(addr554);
                  }
                  addr627:
                  eax = _loc8_;
                  _loc2_ = _loc3_;
                  ESP = _loc2_;
                  return;
                  addr343:
               }
               §§goto(addr343);
            }
            §§goto(addr169);
         }
         §§goto(addr343);
      }
      §§goto(addr627);
   }
}
