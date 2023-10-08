package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._arenas;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._arenas_lock;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._base_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._dss_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._huge_mtx;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._narenas;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__malloc_postfork() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_narenas);
      _loc1_ <<= 2;
      _loc1_ += 15;
      _loc9_ = _loc1_ & -16;
      _loc1_ = _loc2_;
      _loc1_ -= _loc9_;
      _loc2_ = _loc8_ = _loc1_ & -16;
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_dss_mtx,_loc2_);
         ESP = _loc2_;
         F__spinunlock();
         _loc2_ += 16;
         if(li32(___isthreaded) != 0)
         {
            _loc2_ -= 16;
            si32(_huge_mtx,_loc2_);
            ESP = _loc2_;
            F__spinunlock();
            _loc2_ += 16;
            if(li32(___isthreaded) == 0)
            {
               addr110:
               _loc1_ = li32(_arenas);
               _loc7_ = li32(_narenas);
               _loc2_ -= 16;
               si32(_loc9_ = _loc7_ << 2,_loc2_ + 8);
               si32(_loc1_,_loc2_ + 4);
               si32(_loc8_,_loc2_);
               ESP = _loc2_;
               Fmemcpy();
               _loc2_ += 16;
            }
            else
            {
               _loc2_ -= 16;
               si32(_base_mtx,_loc2_);
               ESP = _loc2_;
               F__spinunlock();
               _loc2_ += 16;
               _loc7_ = li32(_narenas);
               _loc2_ -= 16;
               var _loc6_:*;
               si32(_loc6_ = _loc7_ << 2,_loc2_ + 8);
               si32(li32(_arenas),_loc2_ + 4);
               si32(_loc8_,_loc2_);
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
                  _loc7_ = li32(_narenas);
               }
            }
            _loc5_ = 0;
            if(_loc7_ != 0)
            {
               do
               {
                  _loc1_ = _loc5_ << 2;
                  _loc1_ = _loc8_ + _loc1_;
                  if((_loc4_ = li32(_loc1_)) != 0)
                  {
                     if(li32(___isthreaded) != 0)
                     {
                        _loc2_ -= 16;
                        si32(_loc4_,_loc2_);
                        ESP = _loc2_;
                        F__pthread_mutex_unlock();
                        _loc2_ += 16;
                        _loc7_ = li32(_narenas);
                     }
                  }
               }
               while((uint(_loc5_ += 1)) < uint(_loc7_));
               
            }
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr110);
   }
}
