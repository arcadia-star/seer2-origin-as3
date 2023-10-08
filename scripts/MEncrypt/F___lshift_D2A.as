package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___lshift_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc13_:* = 0;
      var _loc1_:* = 0;
      var _loc14_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:int = 0;
      var _loc8_:* = 0;
      var _loc7_:int = 0;
      var _loc4_:int = 0;
      var _loc10_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc14_ = _loc1_ >> 5;
      var _loc12_:*;
      _loc10_ = (_loc11_ = (_loc12_ = li32((_loc13_ = li32(_loc3_)) + 16)) + _loc14_) + 1;
      _loc9_ = li32(_loc13_ + 8);
      _loc8_ = li32(_loc13_ + 4);
      if(_loc10_ > _loc9_)
      {
         do
         {
            _loc8_ += 1;
            _loc9_ <<= 1;
         }
         while(_loc10_ > _loc9_);
         
      }
      _loc2_ -= 16;
      si32(_loc8_,_loc2_);
      ESP = _loc2_;
      F___Balloc_D2A();
      _loc2_ += 16;
      _loc8_ = (_loc9_ = eax) + 20;
      if(_loc14_ >= 1)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 4);
         si32(_loc8_,_loc2_);
         si32(_loc12_ = (_loc12_ = _loc1_ >> 3) & -4,_loc2_ + 8);
         _loc8_ = (_loc12_ += _loc9_) + 20;
         ESP = _loc2_;
         Fmemset();
         _loc2_ += 16;
      }
      _loc12_ = (_loc12_ = li32(_loc13_ + 16)) << 2;
      _loc14_ = (_loc12_ = _loc13_ + _loc12_) + 20;
      _loc1_ &= 31;
      if(_loc1_ == 0)
      {
         _loc10_ = _loc13_ + 20;
         do
         {
            si32(_loc12_ = li32(_loc10_),_loc8_);
            _loc8_ += 4;
         }
         while((uint(_loc10_ += 4)) < uint(_loc14_));
         
         si32(_loc11_,_loc9_ + 16);
      }
      else
      {
         _loc7_ = _loc13_ + 20;
         _loc6_ = 32 - _loc1_;
         _loc4_ = 0;
         do
         {
            si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc7_)) << _loc1_) | _loc4_,_loc8_);
            _loc4_ = (_loc12_ = li32(_loc7_)) >>> _loc6_;
            _loc7_ += 4;
            _loc8_ += 4;
         }
         while(uint(_loc7_) < uint(_loc14_));
         
         si32(_loc4_,_loc8_);
         if(_loc4_ != 0)
         {
            _loc10_ = _loc11_ + 2;
         }
         si32(_loc12_ = _loc10_ + -1,_loc9_ + 16);
      }
      if((_loc11_ = li32(_loc13_ + 4)) >= 10)
      {
         if(_loc13_ != 0)
         {
            _loc2_ -= 16;
            si32(_loc13_,_loc2_);
            ESP = _loc2_;
            F_idalloc();
            _loc2_ += 16;
         }
      }
      else
      {
         if((_loc12_ = li32(___isthreaded)) != 0)
         {
            _loc2_ -= 16;
            si32(___gdtoa_locks,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            _loc11_ = li32(_loc13_ + 4);
         }
         _loc12_ = _loc11_ << 2;
         var _loc5_:*;
         si32(_loc5_ = li32(_loc12_ = _freelist + _loc12_),_loc13_);
         si32(_loc13_,_loc12_);
         if((_loc12_ = li32(___isthreaded)) != 0)
         {
            _loc2_ -= 16;
            si32(___gdtoa_locks,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_unlock();
            _loc2_ += 16;
         }
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
