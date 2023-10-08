package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___multadd_D2A() : void
   {
      var _loc4_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc3_:* = 0;
      var _loc15_:* = 0;
      var _loc1_:int = 0;
      var _loc5_:int = 0;
      var _loc10_:int = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32((_loc4_ = _loc2_) + 4);
      _loc15_ = _loc3_ >> 31;
      _loc13_ = (_loc14_ = li32(_loc4_ + 8)) >> 31;
      _loc11_ = li32((_loc12_ = li32(_loc4_)) + 16);
      _loc10_ = 0;
      do
      {
         _loc2_ -= 16;
         si32(_loc3_,_loc2_ + 8);
         si32(0,_loc2_ + 4);
         si32(_loc15_,_loc2_ + 12);
         var _loc9_:* = _loc10_ << 2;
         var _loc8_:*;
         si32(_loc8_ = li32((_loc9_ = _loc12_ + _loc9_) + 20),_loc2_);
         ESP = _loc2_;
         F___muldi3();
         _loc2_ += 16;
         _loc8_ = eax;
         _loc1_ = edx;
         si32(_loc5_ = _loc8_ + _loc14_,_loc9_ + 20);
         _loc7_ = _loc6_ = 1;
         if(uint(_loc5_) >= uint(_loc8_))
         {
            _loc7_ = 0;
         }
         if(uint(_loc5_) >= uint(_loc14_))
         {
            _loc6_ = _loc7_;
         }
         _loc14_ = (_loc9_ = _loc1_ + _loc13_) + _loc6_;
         _loc10_ += 1;
         _loc13_ = 0;
      }
      while(_loc10_ < _loc11_);
      
      _loc3_ = _loc12_;
      if((_loc14_ | 0) != 0)
      {
         _loc3_ = _loc12_;
         if(li32(_loc12_ + 8) <= _loc11_)
         {
            _loc2_ -= 16;
            si32(_loc9_ = li32(_loc12_ + 4) + 1,_loc2_);
            ESP = _loc2_;
            F___Balloc_D2A();
            _loc2_ += 16;
            _loc3_ = eax;
            _loc2_ -= 16;
            si32(_loc9_ = (_loc9_ = li32(_loc12_ + 16) << 2) + 8,_loc2_ + 8);
            si32(_loc9_ = _loc12_ + 12,_loc2_ + 4);
            si32(_loc9_ = _loc3_ + 12,_loc2_);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            if(_loc12_ != 0)
            {
               if((_loc7_ = li32(_loc12_ + 4)) >= 10)
               {
                  _loc2_ -= 16;
                  si32(_loc12_,_loc2_);
                  ESP = _loc2_;
                  F_idalloc();
                  _loc2_ += 16;
               }
               else
               {
                  if((_loc9_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(___gdtoa_locks,_loc2_);
                     ESP = _loc2_;
                     F__pthread_mutex_lock();
                     _loc2_ += 16;
                     _loc7_ = li32(_loc12_ + 4);
                  }
                  _loc9_ = _loc7_ << 2;
                  si32(_loc8_ = li32(_loc9_ = _freelist + _loc9_),_loc12_);
                  si32(_loc12_,_loc9_);
                  if((_loc9_ = li32(___isthreaded)) != 0)
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
         _loc9_ = _loc11_ << 2;
         _loc9_ = _loc3_ + _loc9_;
         si32(_loc14_,_loc9_ + 20);
         si32(_loc9_ = _loc11_ + 1,_loc3_ + 16);
      }
      eax = _loc3_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
