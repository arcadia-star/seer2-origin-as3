package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F___swsetup() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(___sdidinit);
      if(_loc1_ == 0)
      {
         si32(__cleanup,___cleanup);
         si32(1,___sdidinit);
      }
      _loc1_ = (_loc5_ = li16((_loc6_ = li32(_loc3_)) + 12)) & 8;
      if(_loc1_ == 0)
      {
         if((_loc5_ & 16) == 0)
         {
            ESP = _loc2_;
            F___error();
            si32(9,eax);
            si16(li16(_loc6_ + 12) | 64,_loc6_ + 12);
            _loc4_ = -1;
         }
         else
         {
            if((_loc5_ & 4) != 0)
            {
               if((_loc4_ = li32(_loc6_ + 48)) != 0)
               {
                  if(_loc4_ != _loc6_ + 64)
                  {
                     _loc2_ -= 16;
                     si32(_loc4_,_loc2_);
                     ESP = _loc2_;
                     F_idalloc();
                     _loc2_ += 16;
                     _loc5_ = li16(_loc6_ + 12);
                  }
                  si32(0,_loc6_ + 48);
               }
               si16(_loc5_ &= 65499,_loc6_ + 12);
               si32(0,_loc6_ + 4);
               _loc1_ = li32(_loc6_ + 16);
               si32(_loc1_,_loc6_);
            }
            si16(_loc5_ |= 8,_loc6_ + 12);
            addr168:
            _loc1_ = li32(_loc6_ + 16);
            if(_loc1_ == 0)
            {
               _loc2_ -= 16;
               si32(_loc6_,_loc2_);
               ESP = _loc2_;
               F___smakebuf();
               _loc2_ += 16;
               _loc5_ = li16(_loc6_ + 12);
            }
            _loc1_ = _loc5_ & 1;
            if(_loc1_ != 0)
            {
               si32(_loc4_ = 0,_loc6_ + 8);
               si32(0 - li32(_loc6_ + 20),_loc6_ + 24);
            }
            else
            {
               _loc5_ = _loc4_ = 0;
               if((_loc5_ & 2) == 0)
               {
                  _loc5_ = li32(_loc6_ + 20);
               }
               si32(_loc5_,_loc6_ + 8);
            }
         }
         eax = _loc4_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr168);
   }
}
