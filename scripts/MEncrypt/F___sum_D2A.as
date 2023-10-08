package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F___sum_D2A() : void
   {
      var _loc4_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:int = 0;
      var _loc3_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc1_:int = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32((_loc4_ = _loc2_) + 4);
      _loc15_ = li32(_loc3_ + 16);
      _loc13_ = li32((_loc14_ = li32(_loc4_)) + 16);
      _loc12_ = _loc3_;
      if(_loc13_ >= _loc15_)
      {
         _loc12_ = _loc14_;
      }
      var _loc11_:* = li32(_loc12_ + 4);
      _loc2_ -= 16;
      si32(_loc11_,_loc2_);
      ESP = _loc2_;
      F___Balloc_D2A();
      _loc2_ += 16;
      _loc10_ = eax;
      si32(_loc11_ = li32(_loc12_ + 16),_loc10_ + 16);
      if(_loc13_ >= _loc15_)
      {
         _loc14_ = _loc3_;
      }
      _loc11_ = (_loc9_ = li32(_loc14_ + 16)) << 2;
      _loc8_ = (_loc13_ = _loc10_ + 20) + _loc11_;
      _loc1_ = _loc14_ + 20;
      _loc3_ = _loc12_ + 20;
      _loc15_ = 0;
      do
      {
         var _loc5_:*;
         var _loc6_:int = (_loc5_ = li32(_loc3_)) >>> 16;
         var _loc7_:*;
         _loc11_ = (_loc11_ = (_loc7_ = li32(_loc1_)) >>> 16) + _loc6_;
         _loc5_ = (_loc5_ &= 65535) + _loc15_;
         _loc7_ &= 65535;
         _loc5_ = (_loc5_ = (_loc7_ = _loc5_ + _loc7_) >>> 16) & 1;
         si16(_loc11_ += _loc5_,_loc13_ + 2);
         si16(_loc7_,_loc13_);
         _loc15_ = (_loc11_ >>>= 16) & 1;
         _loc1_ += 4;
         _loc3_ += 4;
      }
      while((uint(_loc13_ += 4)) < uint(_loc8_));
      
      _loc14_ = (_loc11_ = _loc10_ + ((_loc11_ = (_loc11_ = li32(_loc12_ + 16)) + _loc9_ - li32(_loc14_ + 16)) << 2)) + 20;
      if(uint(_loc13_) < uint(_loc14_))
      {
         do
         {
            _loc5_ = (_loc5_ = (_loc11_ = (_loc11_ = (_loc7_ = li32(_loc3_)) & 65535) + _loc15_) >>> 16) & 1;
            _loc7_ >>>= 16;
            si16(_loc7_ = _loc5_ + _loc7_,_loc13_ + 2);
            si16(_loc11_,_loc13_);
            _loc15_ = (_loc11_ = _loc7_ >>> 16) & 1;
            _loc3_ += 4;
         }
         while((uint(_loc13_ += 4)) < uint(_loc14_));
         
      }
      if(_loc15_ != 0)
      {
         _loc12_ = li32(_loc10_ + 16);
         _loc14_ = _loc10_;
         if(_loc12_ == li32(_loc10_ + 8))
         {
            _loc2_ -= 16;
            si32(_loc11_ = li32(_loc10_ + 4) + 1,_loc2_);
            ESP = _loc2_;
            F___Balloc_D2A();
            _loc2_ += 16;
            _loc14_ = eax;
            _loc2_ -= 16;
            si32(_loc11_ = (_loc11_ = li32(_loc10_ + 16) << 2) + 8,_loc2_ + 8);
            si32(_loc11_ = _loc10_ + 12,_loc2_ + 4);
            si32(_loc11_ = _loc14_ + 12,_loc2_);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            if(_loc10_ != 0)
            {
               if((_loc12_ = li32(_loc10_ + 4)) >= 10)
               {
                  _loc2_ -= 16;
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_idalloc();
                  _loc2_ += 16;
               }
               else
               {
                  if((_loc11_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(___gdtoa_locks,_loc2_);
                     ESP = _loc2_;
                     F__pthread_mutex_lock();
                     _loc2_ += 16;
                     _loc12_ = li32(_loc10_ + 4);
                  }
                  _loc11_ = _loc12_ << 2;
                  si32(_loc7_ = li32(_loc11_ = _freelist + _loc11_),_loc10_);
                  si32(_loc10_,_loc11_);
                  if((_loc11_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(___gdtoa_locks,_loc2_);
                     ESP = _loc2_;
                     F__pthread_mutex_unlock();
                     _loc2_ += 16;
                  }
               }
            }
            _loc12_ = li32(_loc14_ + 16);
         }
         _loc11_ = _loc12_ << 2;
         _loc11_ = _loc14_ + _loc11_;
         si32(1,_loc11_ + 20);
         si32(_loc11_ = _loc12_ + 1,_loc14_ + 16);
         _loc10_ = _loc14_;
      }
      eax = _loc10_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
