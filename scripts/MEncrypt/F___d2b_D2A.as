package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._freelist;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._pmem_next;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._private_mem;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___d2b_D2A() : void
   {
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc3_ = li32(___isthreaded);
      if(_loc3_ != 0)
      {
         _loc2_ -= 16;
         si32(___gdtoa_locks,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_lock();
         _loc2_ += 16;
      }
      _loc3_ = _loc4_;
      _loc3_ |= 4;
      _loc15_ = li32(_loc3_);
      _loc14_ = li32(_loc4_);
      _loc13_ = li32(_loc4_ + 12);
      _loc12_ = li32(_loc4_ + 8);
      if((_loc11_ = li32(_freelist + 4)) != 0)
      {
         si32(li32(_loc11_),_freelist + 4);
      }
      else
      {
         if(uint(((_loc11_ = li32(_pmem_next)) - _private_mem >> 3) + 4) <= 288)
         {
            si32(_loc11_ + 32,_pmem_next);
         }
         else
         {
            _loc2_ -= 16;
            si32(32,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc2_ += 16;
            _loc11_ = eax;
         }
         si32(1,_loc11_ + 4);
         si32(2,_loc11_ + 8);
      }
      _loc3_ = li32(___isthreaded);
      if(_loc3_ != 0)
      {
         _loc2_ -= 16;
         si32(___gdtoa_locks,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_unlock();
         _loc2_ += 16;
      }
      si32(0,_loc11_ + 16);
      si32(0,_loc11_ + 12);
      _loc10_ = _loc15_ & 1048575;
      _loc3_ = _loc15_ >>> 20;
      if((_loc15_ = _loc3_ & 2047) != 0)
      {
         _loc10_ |= 1048576;
      }
      if(_loc14_ != 0)
      {
         if((_loc14_ & 7) != 0)
         {
            if((_loc14_ & 1) == 0)
            {
               if((_loc14_ & 2) != 0)
               {
                  _loc9_ = _loc14_ >>> 1;
                  _loc8_ = 1;
               }
               else
               {
                  _loc9_ = _loc14_ >>> 2;
                  _loc8_ = 2;
               }
               addr396:
               _loc3_ = 32 - _loc8_;
               _loc3_ = _loc10_ << _loc3_;
               _loc3_ |= _loc9_;
               si32(_loc3_,_loc11_ + 20);
               _loc10_ >>>= _loc8_;
            }
            else
            {
               addr421:
               si32(_loc14_,_loc11_ + 20);
               _loc8_ = 0;
            }
            §§goto(addr429);
         }
         else
         {
            _loc8_ = _loc14_ >>> 16;
            _loc1_ = _loc14_ & 65535;
            if(_loc1_ != 0)
            {
               _loc8_ = _loc14_;
            }
            _loc5_ = _loc8_ >>> 8;
            if((_loc6_ = _loc8_ & 255) != 0)
            {
               _loc5_ = _loc8_;
            }
            _loc7_ = _loc5_ >>> 4;
            if((_loc9_ = _loc5_ & 15) != 0)
            {
               _loc7_ = _loc5_;
            }
            _loc5_ = _loc7_ >>> 2;
            if((_loc8_ = _loc7_ & 3) != 0)
            {
               _loc5_ = _loc7_;
            }
            _loc7_ = 16;
            if(_loc1_ != 0)
            {
               _loc7_ = 0;
            }
            _loc1_ = _loc7_ | 8;
            if(_loc6_ != 0)
            {
               _loc1_ = _loc7_;
            }
            _loc7_ = _loc1_ | 4;
            if(_loc9_ != 0)
            {
               _loc7_ = _loc1_;
            }
            _loc6_ = _loc7_ | 2;
            if(_loc8_ != 0)
            {
               _loc6_ = _loc7_;
            }
            _loc3_ = _loc5_ & 1;
            if(_loc3_ == 0)
            {
               _loc5_ >>>= 1;
               _loc6_ += 1;
               _loc8_ = 32;
               _loc9_ = _loc14_;
               if(_loc5_ != 0)
               {
                  §§goto(addr386);
               }
               §§goto(addr396);
            }
            addr386:
            _loc8_ = _loc6_;
            _loc9_ = _loc5_;
            _loc14_ = _loc5_;
            if(_loc6_ != 0)
            {
               §§goto(addr396);
            }
            else
            {
               §§goto(addr421);
            }
         }
         §§goto(addr421);
      }
      else
      {
         if((_loc10_ & 7) != 0)
         {
            _loc5_ = 0;
            if((_loc10_ & 1) == 0)
            {
               if((_loc10_ & 2) != 0)
               {
                  _loc10_ >>>= 1;
                  _loc5_ = 1;
               }
               else
               {
                  _loc10_ >>>= 2;
                  _loc5_ = 2;
               }
            }
         }
         else
         {
            _loc5_ = _loc10_ >>> 16;
            if((_loc9_ = _loc10_ & 65535) != 0)
            {
               _loc5_ = _loc10_;
            }
            _loc14_ = _loc5_ >>> 8;
            if((_loc8_ = _loc5_ & 255) != 0)
            {
               _loc14_ = _loc5_;
            }
            _loc1_ = _loc14_ >>> 4;
            if((_loc6_ = _loc14_ & 15) != 0)
            {
               _loc1_ = _loc14_;
            }
            _loc14_ = _loc1_ >>> 2;
            if((_loc5_ = _loc1_ & 3) != 0)
            {
               _loc14_ = _loc1_;
            }
            _loc1_ = 16;
            if(_loc9_ != 0)
            {
               _loc1_ = 0;
            }
            _loc9_ = _loc1_ | 8;
            if(_loc8_ != 0)
            {
               _loc9_ = _loc1_;
            }
            _loc8_ = _loc9_ | 4;
            if(_loc6_ != 0)
            {
               _loc8_ = _loc9_;
            }
            _loc6_ = _loc8_ | 2;
            if(_loc5_ != 0)
            {
               _loc6_ = _loc8_;
            }
            _loc3_ = _loc14_ & 1;
            if(_loc3_ == 0)
            {
               _loc14_ >>>= 1;
               _loc6_ += 1;
               _loc5_ = 32;
               if(_loc14_ != 0)
               {
               }
               §§goto(addr614);
            }
            _loc10_ = _loc14_;
            _loc5_ = _loc6_;
         }
         addr614:
         si32(_loc10_,_loc11_ + 20);
         si32(_loc14_ = 1,_loc11_ + 16);
         _loc8_ = _loc5_ + 32;
         §§goto(addr429);
      }
      si32(_loc10_,_loc13_);
      eax = _loc11_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
