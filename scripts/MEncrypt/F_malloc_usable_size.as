package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._chunksize_mask;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._huge;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._huge_mtx;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_malloc_usable_size() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:int = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_chunksize_mask);
      _loc1_ ^= -1;
      if((_loc9_ = (_loc10_ = li32(_loc3_)) & _loc1_) != _loc10_)
      {
         _loc9_ = li32(_loc9_ + (_loc10_ - _loc9_ >>> 12) * 12 + 24) & -4096;
         if((li32(_loc9_ + (_loc10_ - _loc9_ >>> 12) * 12 + 24) & 2) == 0)
         {
            _loc9_ = li32(li32(_loc9_) + 20);
         }
      }
      else
      {
         if(li32(___isthreaded) != 0)
         {
            _loc2_ -= 16;
            si32(_huge_mtx,_loc2_);
            ESP = _loc2_;
            F__spinlock();
            _loc2_ += 16;
         }
         _loc8_ = li32(_huge);
         _loc9_ = _huge + 4;
         while(_loc8_ != _loc9_)
         {
            if((_loc5_ = li32(_loc8_ + 16)) == _loc10_)
            {
               break;
            }
            _loc6_ = _loc7_ = 1;
            if(uint(_loc5_) <= uint(_loc10_))
            {
               _loc6_ = 0;
            }
            if(uint(_loc5_) >= uint(_loc10_))
            {
               _loc7_ = 0;
            }
            var _loc4_:* = _loc6_ & 1;
            _loc1_ = _loc7_ & 1;
            _loc1_ -= _loc4_;
            if(_loc1_ <= -1)
            {
               _loc8_ = li32(_loc8_ + 8);
            }
            else
            {
               _loc8_ = li32(_loc8_ + 12) & -2;
            }
         }
         _loc10_ = 0;
         if(_loc8_ != _loc9_)
         {
            _loc10_ = _loc8_;
         }
         _loc9_ = li32(_loc10_ + 20);
         _loc1_ = li32(___isthreaded);
         if(_loc1_ != 0)
         {
            _loc2_ -= 16;
            si32(_huge_mtx,_loc2_);
            ESP = _loc2_;
            F__spinunlock();
            _loc2_ += 16;
         }
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
