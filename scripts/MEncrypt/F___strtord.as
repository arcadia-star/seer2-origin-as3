package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._fpi0_2E_3243;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___strtord() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:int = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      _loc1_ = _fpi0_2E_3243;
      if((_loc9_ = li32(_loc3_ + 8)) != 1)
      {
         var _loc8_:*;
         si32(_loc8_ = li32(_fpi0_2E_3243),_loc3_ - 24);
         _loc1_ = _loc3_ - 24;
         var _loc7_:*;
         si32(_loc7_ = li32(_fpi0_2E_3243 + 4),_loc1_ | 4);
         si32(_loc8_ = li32(_fpi0_2E_3243 + 8),_loc3_ - 16);
         si32(_loc8_ = li32(_fpi0_2E_3243 + 16),_loc3_ - 8);
         si32(_loc9_,_loc3_ - 12);
      }
      _loc9_ = li32(_loc3_ + 12);
      _loc7_ = li32(_loc3_ + 4);
      _loc8_ = li32(_loc3_);
      _loc2_ -= 32;
      var _loc6_:int;
      si32(_loc6_ = _loc3_ - 32,_loc2_ + 16);
      si32(_loc6_ = _loc3_ - 36,_loc2_ + 12);
      si32(_loc1_,_loc2_ + 8);
      si32(_loc7_,_loc2_ + 4);
      si32(_loc8_,_loc2_);
      ESP = _loc2_;
      F___strtodg();
      _loc2_ += 32;
      _loc1_ = (_loc5_ = eax) & 7;
      _loc4_ = li32(_loc3_ - 36);
      if(_loc1_ <= 2)
      {
         if(_loc1_ != 0)
         {
            if(_loc1_ != 1)
            {
               if(_loc1_ == 2)
               {
                  si32(_loc8_ = li32(_loc3_ - 32),_loc9_);
                  si32(_loc8_ = li32(_loc3_ - 28),_loc9_ + 4);
               }
            }
            else
            {
               addr227:
               si32(_loc8_ = li32(_loc3_ - 32),_loc9_);
               _loc8_ = (_loc8_ = _loc4_ << 20) + 1127219200;
               si32(_loc8_ = (_loc7_ = (_loc7_ = li32(_loc3_ - 28)) & -1048577) | _loc8_,_loc9_ + 4);
            }
         }
         else
         {
            addr197:
            si32(0,_loc9_ + 4);
            si32(0,_loc9_);
         }
         §§goto(addr283);
      }
      else
      {
         if(_loc1_ <= 4)
         {
            if(_loc1_ != 3)
            {
               if(_loc1_ == 4)
               {
                  si32(0,_loc9_);
                  si32(2146959360,_loc9_ + 4);
               }
            }
            else
            {
               si32(2146435072,_loc9_ + 4);
               si32(0,_loc9_);
            }
         }
         else if(_loc1_ != 5)
         {
            if(_loc1_ == 6)
            {
               §§goto(addr197);
            }
         }
         else
         {
            §§goto(addr227);
         }
         addr283:
         if((_loc8_ = _loc5_ & 8) != 0)
         {
            si32(_loc8_ = (_loc8_ = li32(_loc9_ + 4)) | -2147483648,_loc9_ + 4);
         }
         eax = _loc5_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr227);
   }
}
