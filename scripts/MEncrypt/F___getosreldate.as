package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._osreldate_2E_1512;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___getosreldate() : void
   {
      var _loc3_:* = 0;
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
         si32(_loc1_,_loc2_ + 20);
         si32(0,_loc2_ + 16);
         var _loc4_:*;
         si32(_loc4_ = _loc3_ - 4,_loc2_ + 12);
         si32(_loc4_ = _loc3_ - 16,_loc2_ + 8);
         si32(2,_loc2_ + 4);
         si32(_loc4_ = _loc3_ - 12,_loc2_);
         ESP = _loc2_;
         F_sysctl();
         _loc2_ += 32;
         if((_loc4_ = eax) == 0)
         {
            _loc1_ = li32(_loc3_ - 16);
            if(_loc1_ >= 1)
            {
               if((_loc4_ = li32(_loc3_ - 4)) == 4)
               {
                  si32(_loc1_,_osreldate_2E_1512);
               }
               §§goto(addr137);
            }
         }
         _loc1_ = li32(_osreldate_2E_1512);
      }
      addr137:
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
