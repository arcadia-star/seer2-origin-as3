package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str314;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ebuf_2E_1915;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_render_errno() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 64;
      _loc1_ = li32(_loc3_ + 8);
      _loc1_ = li32(_loc1_);
      _loc11_ = li32(_loc1_);
      _loc10_ = li32(_loc3_ + 4);
      _loc9_ = li32(_loc3_);
      if(uint(_loc11_) <= 93)
      {
         _loc2_ -= 16;
         si32(2048,_loc2_ + 8);
         si32(_ebuf_2E_1915,_loc2_ + 4);
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         F_strerror_r();
         _loc2_ += 16;
         if(eax != 0)
         {
            ESP = _loc2_;
            F___error();
            si32(22,eax);
         }
         var _loc7_:*;
         _loc1_ = (_loc7_ = li32(_loc8_ = _ebuf_2E_1915 & -4)) + -16843009;
         _loc1_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & _loc1_;
         _loc11_ = _loc8_ + 4;
         _loc6_ = 0;
         if(_loc1_ != 0)
         {
            while(true)
            {
               _loc5_ = _ebuf_2E_1915 + _loc6_;
               _loc11_ = _loc8_ + 4;
               if(uint(_loc5_) < uint(_loc11_))
               {
                  continue;
               }
            }
            §§goto(addr264);
         }
         while(true)
         {
            _loc1_ = (_loc8_ = li32(_loc11_)) + -16843009;
            _loc1_ = (_loc7_ = (_loc7_ = _loc8_ & -2139062144) ^ -2139062144) & _loc1_;
            if(_loc1_ == 0)
            {
               continue;
            }
            if((_loc8_ & 255) == 0)
            {
               _loc6_ = _loc11_ - _ebuf_2E_1915;
            }
            else if(li8(_loc11_ + 1) == 0)
            {
               _loc6_ = _loc11_ + (1 - _ebuf_2E_1915);
            }
            else if(li8(_loc11_ + 2) == 0)
            {
               _loc6_ = _loc11_ + (2 - _ebuf_2E_1915);
            }
            else
            {
               if(li8(_loc11_ + 3) != 0)
               {
                  continue;
               }
               _loc6_ = _loc11_ + (3 - _ebuf_2E_1915);
            }
            §§goto(addr264);
         }
      }
      else
      {
         _loc2_ -= 16;
         si32(_loc11_,_loc2_ + 12);
         si32(_loc11_,_loc2_ + 8);
         si32(L__2E_str314,_loc2_ + 4);
         si32(_loc11_ = _loc3_ - 64,_loc2_);
         ESP = _loc2_;
         F_sprintf();
         _loc2_ += 16;
         if(((_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & (_loc7_ = li32(_loc6_ = _loc11_ & -4)) + -16843009) != 0)
         {
            _loc5_ = _loc6_ + 4;
            _loc4_ = 0;
            while(true)
            {
               if((uint(_loc8_ = _loc11_ + _loc4_)) < uint(_loc5_))
               {
                  continue;
               }
            }
            §§goto(addr499);
         }
         _loc8_ = _loc6_ + 4;
         while(true)
         {
            _loc1_ = (_loc5_ = li32(_loc8_)) + -16843009;
            _loc1_ = (_loc7_ = (_loc7_ = _loc5_ & -2139062144) ^ -2139062144) & _loc1_;
            if(_loc1_ == 0)
            {
               continue;
            }
            if((_loc5_ & 255) == 0)
            {
               _loc4_ = _loc8_ - _loc11_;
            }
            else if(li8(_loc8_ + 1) == 0)
            {
               _loc4_ = 1 - _loc11_ + _loc8_;
            }
            else if(li8(_loc8_ + 2) == 0)
            {
               _loc4_ = 2 - _loc11_ + _loc8_;
            }
            else
            {
               if(li8(_loc8_ + 3) != 0)
               {
                  continue;
               }
               _loc4_ = 3 - _loc11_ + _loc8_;
            }
            addr499:
            _loc2_ -= 16;
            si32(_loc4_,_loc2_ + 12);
            si32(_loc11_,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F___printf_out();
            _loc2_ += 16;
            _loc10_ = eax;
            _loc7_ = li32(_loc9_);
            _loc2_ -= 16;
            _loc1_ = _loc9_ + 4;
            si32(_loc1_,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            ESP = _loc2_;
            F___sfvwrite();
            _loc2_ += 16;
            _loc1_ = _loc9_ + 16;
            si32(_loc1_,_loc9_ + 80);
            si32(_loc1_,_loc9_ + 4);
            si32(0,_loc9_ + 12);
            si32(0,_loc9_ + 8);
            §§goto(addr264);
         }
      }
      addr264:
      _loc2_ -= 16;
      si32(_loc6_,_loc2_ + 12);
      si32(_ebuf_2E_1915,_loc2_ + 8);
      si32(_loc10_,_loc2_ + 4);
      si32(_loc9_,_loc2_);
      ESP = _loc2_;
      F___printf_out();
      _loc2_ += 16;
      _loc10_ = eax;
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
