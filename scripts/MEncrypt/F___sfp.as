package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._lastglue;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._thread_lock;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F___sfp() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(___sdidinit);
      if(_loc1_ == 0)
      {
         si32(__cleanup,___cleanup);
         si32(1,___sdidinit);
      }
      _loc6_ = ___sglue;
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_thread_lock,_loc2_);
         ESP = _loc2_;
         F__spinlock();
         _loc2_ += 16;
         _loc6_ = ___sglue;
      }
      while(true)
      {
         if(_loc6_ == 0)
         {
            if(li32(___isthreaded) != 0)
            {
               _loc2_ -= 16;
               si32(_thread_lock,_loc2_);
               ESP = _loc2_;
               F__spinunlock();
               _loc2_ += 16;
            }
            _loc2_ -= 16;
            si32(2335,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc4_ = 0;
            _loc2_ += 16;
            if((_loc5_ = eax) != 0)
            {
               si32(0,_loc5_);
               si32(10,_loc5_ + 4);
               si32(_loc5_ + 15 & -4,_loc5_ + 8);
               _loc2_ -= 16;
               si32(2320,_loc2_ + 8);
               si32(0,_loc2_ + 4);
               si32(_loc5_ + 15 & -4,_loc2_);
               ESP = _loc2_;
               Fmemset();
               _loc2_ += 16;
               if(li32(___isthreaded) != 0)
               {
                  _loc2_ -= 16;
                  si32(_thread_lock,_loc2_);
                  ESP = _loc2_;
                  F__spinlock();
                  _loc2_ += 16;
               }
               _loc1_ = li32(_lastglue);
               si32(_loc5_,_loc1_);
               si32(_loc5_,_lastglue);
               _loc4_ = li32(_loc5_ + 8);
               addr254:
               si16(1,_loc4_ + 12);
               _loc1_ = li32(___isthreaded);
               if(_loc1_ != 0)
               {
                  _loc2_ -= 16;
                  si32(_thread_lock,_loc2_);
                  ESP = _loc2_;
                  F__spinunlock();
                  _loc2_ += 16;
               }
               si32(0,_loc4_);
               si32(0,_loc4_ + 8);
               si32(0,_loc4_ + 4);
               si32(0,_loc4_ + 16);
               si32(0,_loc4_ + 20);
               si32(0,_loc4_ + 24);
               si16(-1,_loc4_ + 14);
               si32(0,_loc4_ + 48);
               si32(0,_loc4_ + 52);
               si32(0,_loc4_ + 68);
               si32(0,_loc4_ + 72);
               _loc2_ -= 16;
               si32(132,_loc2_ + 8);
               si32(0,_loc2_ + 4);
               _loc1_ = _loc4_ + 100;
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               Fmemset();
               _loc2_ += 16;
            }
            eax = _loc4_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
         _loc5_ = li32(_loc6_ + 4);
         _loc4_ = li32(_loc6_ + 8);
         for(; _loc5_ > 0; _loc5_ += -1,_loc4_ += 232)
         {
            if(li16(_loc4_ + 12) != 0)
            {
               continue;
            }
         }
         continue;
         §§goto(addr254);
      }
   }
}
