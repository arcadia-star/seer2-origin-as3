package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___increment_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc8_ = _loc1_ + 20;
      _loc7_ = (_loc7_ = li32(_loc1_ + 16)) << 2;
      _loc6_ = _loc8_ + _loc7_;
      while(true)
      {
         if((_loc5_ = li32(_loc8_)) != -1)
         {
            si32(_loc7_ = _loc5_ + 1,_loc8_);
            _loc5_ = _loc1_;
            break;
         }
         si32(0,_loc8_);
         if((uint(_loc8_ += 4)) >= uint(_loc6_))
         {
            _loc6_ = li32(_loc1_ + 16);
            _loc5_ = _loc1_;
            if(_loc6_ >= li32(_loc1_ + 8))
            {
               _loc2_ -= 16;
               si32(_loc7_ = li32(_loc1_ + 4) + 1,_loc2_);
               ESP = _loc2_;
               F___Balloc_D2A();
               _loc2_ += 16;
               _loc5_ = eax;
               _loc2_ -= 16;
               si32(_loc7_ = (_loc7_ = li32(_loc1_ + 16) << 2) + 8,_loc2_ + 8);
               si32(_loc7_ = _loc1_ + 12,_loc2_ + 4);
               si32(_loc7_ = _loc5_ + 12,_loc2_);
               ESP = _loc2_;
               Fmemcpy();
               _loc2_ += 16;
               if(_loc1_ != 0)
               {
                  if((_loc6_ = li32(_loc1_ + 4)) >= 10)
                  {
                     _loc2_ -= 16;
                     si32(_loc1_,_loc2_);
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
                        _loc6_ = li32(_loc1_ + 4);
                     }
                     _loc7_ = _loc6_ << 2;
                     var _loc4_:*;
                     si32(_loc4_ = li32(_loc7_ = _freelist + _loc7_),_loc1_);
                     si32(_loc1_,_loc7_);
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
               _loc6_ = li32(_loc5_ + 16);
            }
            _loc7_ = _loc6_ << 2;
            _loc7_ = _loc5_ + _loc7_;
            si32(1,_loc7_ + 20);
            si32(_loc7_ = _loc6_ + 1,_loc5_ + 16);
            break;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
