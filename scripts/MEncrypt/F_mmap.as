package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._osreldate_2E_1512;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_mmap() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_osreldate_2E_1512);
      if(_loc1_ == 0)
      {
         si32(1,_loc3_ - 12);
         si32(24,_loc3_ - 8);
         si32(0,_loc3_ - 16);
         si32(4,_loc3_ - 4);
         _loc2_ -= 32;
         si32(_loc11_,_loc2_ + 20);
         si32(0,_loc2_ + 16);
         var _loc10_:*;
         si32(_loc10_ = _loc3_ - 4,_loc2_ + 12);
         si32(_loc10_ = _loc3_ - 16,_loc2_ + 8);
         si32(2,_loc2_ + 4);
         si32(_loc10_ = _loc3_ - 12,_loc2_);
         ESP = _loc2_;
         F_sysctl();
         _loc2_ += 32;
         if((_loc10_ = eax) == 0)
         {
            _loc1_ = li32(_loc3_ - 16);
            if(_loc1_ >= 1)
            {
               if((_loc10_ = li32(_loc3_ - 4)) == 4)
               {
                  si32(_loc1_,_osreldate_2E_1512);
               }
               §§goto(addr151);
            }
         }
         _loc1_ = li32(_osreldate_2E_1512);
      }
      addr151:
      _loc9_ = li32(_loc3_ + 24);
      _loc8_ = li32(_loc3_ + 20);
      _loc7_ = li32(_loc3_ + 16);
      _loc6_ = li32(_loc3_ + 12);
      _loc5_ = li32(_loc3_ + 8);
      _loc4_ = li32(_loc3_ + 4);
      _loc11_ = li32(_loc3_);
      if(_loc1_ >= 700051)
      {
         _loc2_ -= 32;
         si32(_loc8_,_loc2_ + 20);
         si32(_loc7_,_loc2_ + 16);
         si32(_loc6_,_loc2_ + 12);
         si32(_loc5_,_loc2_ + 8);
         si32(_loc4_,_loc2_ + 4);
         si32(_loc11_,_loc2_);
         si32(_loc9_,_loc2_ + 24);
         ESP = _loc2_;
         F___sys_mmap();
         _loc2_ += 32;
         _loc11_ = eax;
      }
      else
      {
         _loc2_ -= 32;
         si32(_loc8_,_loc2_ + 24);
         si32(_loc11_,_loc2_ + 20);
         si32(_loc7_,_loc2_ + 16);
         si32(_loc6_,_loc2_ + 12);
         si32(_loc5_,_loc2_ + 8);
         si32(_loc4_,_loc2_ + 4);
         si32(_loc11_,_loc2_);
         si32(_loc9_,_loc2_ + 28);
         ESP = _loc2_;
         F___sys_freebsd6_mmap();
         _loc2_ += 32;
         _loc11_ = eax;
      }
      eax = _loc11_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
