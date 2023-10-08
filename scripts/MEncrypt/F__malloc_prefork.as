package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._arenas;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._arenas_lock;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._base_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._dss_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._huge_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._narenas;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ncpus;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__malloc_prefork() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_narenas);
      _loc1_ <<= 2;
      _loc11_ = (_loc11_ = _loc1_ + 15) & -16;
      var _loc10_:*;
      _loc2_ = _loc9_ = (_loc10_ = (_loc10_ = _loc2_) - _loc11_) & -16;
      _loc2_ = _loc8_ = (_loc11_ = (_loc10_ = _loc2_) - _loc11_) & -16;
      _loc2_ -= 16;
      si32(_loc1_,_loc2_ + 8);
      si32(0,_loc2_ + 4);
      si32(_loc9_,_loc2_);
      ESP = _loc2_;
      Fmemset();
      _loc2_ += 16;
      loop0:
      while(true)
      {
         _loc1_ = li32(___isthreaded);
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(_arenas_lock,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_trylock();
            _loc2_ += 16;
            if(eax != 0)
            {
               _loc7_ = 1;
               if(uint(li32(_ncpus)) > 1)
               {
                  while(true)
                  {
                     if(uint(_loc7_) < 12)
                     {
                        continue;
                     }
                  }
                  §§goto(addr535);
               }
               _loc2_ -= 16;
               si32(_arenas_lock,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_lock();
               _loc2_ += 16;
            }
         }
         addr535:
         _loc5_ = li32(_arenas);
         _loc6_ = li32(_narenas);
         _loc7_ = 0;
         while(uint(_loc7_) < uint(_loc6_))
         {
            _loc11_ = _loc7_ << 2;
            if((_loc11_ = li32(_loc11_ = _loc5_ + _loc11_)) != li32(_loc9_ + _loc11_))
            {
               _loc2_ -= 16;
               si32(_loc5_,_loc2_ + 4);
               si32(_loc8_,_loc2_);
               si32(_loc6_ << 2,_loc2_ + 8);
               ESP = _loc2_;
               Fmemcpy();
               _loc2_ += 16;
               if(li32(___isthreaded) != 0)
               {
                  _loc2_ -= 16;
                  si32(_arenas_lock,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_unlock();
                  _loc2_ += 16;
                  _loc6_ = li32(_narenas);
               }
               _loc7_ = 0;
               if(_loc6_ != 0)
               {
                  do
                  {
                     _loc1_ = _loc7_ << 2;
                     _loc6_ = li32(_loc11_ = _loc8_ + _loc1_);
                     _loc1_ = li32(_loc5_ = _loc9_ + _loc1_);
                     if(_loc1_ != _loc6_)
                     {
                        si32(_loc6_,_loc5_);
                        if(li32(___isthreaded) != 0)
                        {
                           _loc2_ -= 16;
                           si32(_loc6_,_loc2_);
                           ESP = _loc2_;
                           F__pthread_mutex_trylock();
                           _loc2_ += 16;
                           if(eax != 0)
                           {
                              _loc5_ = 1;
                              if(uint(li32(_ncpus)) > 1)
                              {
                                 while(true)
                                 {
                                    if(uint(_loc5_) < 12)
                                    {
                                       continue;
                                    }
                                 }
                                 continue;
                              }
                              _loc2_ -= 16;
                              si32(_loc6_,_loc2_);
                              ESP = _loc2_;
                              F__pthread_mutex_lock();
                              _loc2_ += 16;
                           }
                        }
                     }
                  }
                  while(_loc7_ += 1, _loc1_ = li32(_narenas), uint(_loc7_) < uint(_loc1_));
                  
               }
               continue loop0;
            }
            _loc7_ += 1;
         }
         if(li32(___isthreaded) != 0)
         {
            _loc2_ -= 16;
            si32(_base_mtx,_loc2_);
            ESP = _loc2_;
            F__spinlock();
            _loc2_ += 16;
            if(li32(___isthreaded) != 0)
            {
               _loc2_ -= 16;
               si32(_huge_mtx,_loc2_);
               ESP = _loc2_;
               F__spinlock();
               _loc2_ += 16;
               if(li32(___isthreaded) != 0)
               {
                  _loc2_ -= 16;
                  si32(_dss_mtx,_loc2_);
                  ESP = _loc2_;
                  F__spinlock();
                  _loc2_ += 16;
               }
            }
         }
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
   }
}
