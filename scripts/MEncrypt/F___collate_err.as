package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1401;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str400;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ebuf_2E_1915;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___collate_err() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:int = 0;
      var _loc13_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc10_ = (_loc11_ = li32(_loc12_ = (_loc13_ = li32(___progname)) & -4)) + -16843009;
      _loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_;
      _loc9_ = li32(_loc1_);
      _loc8_ = li32(_loc3_ + 4);
      _loc7_ = li32(_loc3_);
      if(_loc10_ != 0)
      {
         _loc6_ = _loc12_ + 4;
         _loc5_ = 0;
         while(true)
         {
            if((uint(_loc4_ = _loc13_ + _loc5_)) < uint(_loc6_))
            {
               continue;
            }
         }
         addr217:
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 8);
         si32(_loc13_,_loc2_ + 4);
         si32(2,_loc2_);
         ESP = _loc2_;
         F__write();
         _loc2_ += 16;
         _loc2_ -= 16;
         si32(2,_loc2_ + 8);
         si32(L__2E_str400,_loc2_ + 4);
         si32(2,_loc2_);
         ESP = _loc2_;
         F__write();
         _loc2_ += 16;
         _loc1_ = (_loc10_ = li32(_loc6_ = _loc8_ & -4)) + -16843009;
         _loc1_ = (_loc10_ = (_loc10_ &= -2139062144) ^ -2139062144) & _loc1_;
         if(_loc1_ != 0)
         {
            _loc4_ = _loc6_ + 4;
            _loc13_ = 0;
            while(true)
            {
               if((uint(_loc5_ = _loc8_ + _loc13_)) < uint(_loc4_))
               {
                  continue;
               }
            }
            addr439:
            _loc2_ -= 16;
            si32(_loc13_,_loc2_ + 8);
            si32(_loc8_,_loc2_ + 4);
            si32(2,_loc2_);
            ESP = _loc2_;
            F__write();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(2,_loc2_ + 8);
            si32(L__2E_str400,_loc2_ + 4);
            si32(2,_loc2_);
            ESP = _loc2_;
            F__write();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(2048,_loc2_ + 8);
            si32(_ebuf_2E_1915,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_strerror_r();
            _loc2_ += 16;
            _loc1_ = eax;
            if(_loc1_ != 0)
            {
               ESP = _loc2_;
               F___error();
               si32(22,eax);
            }
            _loc1_ = (_loc10_ = li32(_loc9_ = _ebuf_2E_1915 & -4)) + -16843009;
            _loc1_ = (_loc10_ = (_loc10_ &= -2139062144) ^ -2139062144) & _loc1_;
            _loc8_ = _loc9_ + 4;
            _loc5_ = 0;
            if(_loc1_ != 0)
            {
               while(true)
               {
                  _loc13_ = _ebuf_2E_1915 + _loc5_;
                  _loc8_ = _loc9_ + 4;
                  if(uint(_loc13_) < uint(_loc8_))
                  {
                     continue;
                  }
               }
               §§goto(addr712);
            }
            while(true)
            {
               _loc1_ = (_loc9_ = li32(_loc8_)) + -16843009;
               _loc1_ = (_loc10_ = (_loc10_ = _loc9_ & -2139062144) ^ -2139062144) & _loc1_;
               if(_loc1_ != 0)
               {
                  if((_loc9_ & 255) == 0)
                  {
                     _loc5_ = _loc8_ - _ebuf_2E_1915;
                  }
                  else if(li8(_loc8_ + 1) == 0)
                  {
                     _loc5_ = _loc8_ + (1 - _ebuf_2E_1915);
                  }
                  else if(li8(_loc8_ + 2) == 0)
                  {
                     _loc5_ = _loc8_ + (2 - _ebuf_2E_1915);
                  }
                  else
                  {
                     if(li8(_loc8_ + 3) != 0)
                     {
                        continue;
                     }
                     _loc5_ = _loc8_ + (3 - _ebuf_2E_1915);
                  }
                  addr712:
                  _loc2_ -= 16;
                  si32(_loc5_,_loc2_ + 8);
                  si32(_ebuf_2E_1915,_loc2_ + 4);
                  si32(2,_loc2_);
                  ESP = _loc2_;
                  F__write();
                  _loc2_ += 16;
                  _loc2_ -= 16;
                  si32(1,_loc2_ + 8);
                  si32(L__2E_str1401,_loc2_ + 4);
               }
               continue;
               si32(2,_loc2_);
               ESP = _loc2_;
               F__write();
               _loc2_ += 16;
               _loc2_ -= 16;
               si32(_loc7_,_loc2_);
               ESP = _loc2_;
               F_exit();
               _loc2_ += 16;
               return;
            }
         }
         _loc5_ = _loc6_ + 4;
         while(true)
         {
            _loc1_ = (_loc13_ = li32(_loc5_)) + -16843009;
            _loc1_ = (_loc10_ = (_loc10_ = _loc13_ & -2139062144) ^ -2139062144) & _loc1_;
            if(_loc1_ == 0)
            {
               continue;
            }
            if((_loc13_ & 255) == 0)
            {
               _loc13_ = _loc5_ - _loc8_;
            }
            else if(li8(_loc5_ + 1) == 0)
            {
               _loc13_ = 1 - _loc8_ + _loc5_;
            }
            else if(li8(_loc5_ + 2) == 0)
            {
               _loc13_ = 2 - _loc8_ + _loc5_;
            }
            else
            {
               if(li8(_loc5_ + 3) != 0)
               {
                  continue;
               }
               _loc13_ = 3 - _loc8_ + _loc5_;
            }
            §§goto(addr439);
         }
      }
      _loc4_ = _loc12_ + 4;
      while(true)
      {
         _loc1_ = (_loc5_ = li32(_loc4_)) + -16843009;
         _loc1_ = (_loc10_ = (_loc10_ = _loc5_ & -2139062144) ^ -2139062144) & _loc1_;
         if(_loc1_ == 0)
         {
            continue;
         }
         if((_loc5_ & 255) == 0)
         {
            _loc5_ = _loc4_ - _loc13_;
         }
         else if(li8(_loc4_ + 1) == 0)
         {
            _loc5_ = 1 - _loc13_ + _loc4_;
         }
         else if(li8(_loc4_ + 2) == 0)
         {
            _loc5_ = 2 - _loc13_ + _loc4_;
         }
         else
         {
            if(li8(_loc4_ + 3) != 0)
            {
               continue;
            }
            _loc5_ = 3 - _loc13_ + _loc4_;
         }
         §§goto(addr217);
      }
   }
}
