package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str380;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___printf_render_vis() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc10_:* = 0;
      var _loc13_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc1_ = li32(_loc1_);
      _loc13_ = li32(_loc1_);
      _loc12_ = li32(_loc3_ + 4);
      _loc11_ = li32(_loc3_);
      if(_loc13_ == 0)
      {
         _loc2_ -= 16;
         si32(6,_loc2_ + 12);
         si32(L__2E_str380,_loc2_ + 8);
         si32(_loc12_,_loc2_ + 4);
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         F___printf_out();
         _loc2_ += 16;
         _loc10_ = eax;
      }
      else
      {
         if((_loc9_ = li32(_loc12_)) <= -1)
         {
            var _loc8_:*;
            if(((_loc8_ = (_loc8_ &= -2139062144) ^ -2139062144) & (_loc8_ = li32(_loc10_ = _loc13_ & -4)) + -16843009) != 0)
            {
               _loc7_ = _loc10_ + 4;
               _loc9_ = 0;
               while(true)
               {
                  if((uint(_loc6_ = _loc13_ + _loc9_)) < uint(_loc7_))
                  {
                     continue;
                  }
               }
               §§goto(addr254);
            }
            _loc9_ = _loc10_ + 4;
            while(true)
            {
               _loc1_ = (_loc6_ = li32(_loc9_)) + -16843009;
               _loc1_ = (_loc8_ = (_loc8_ = _loc6_ & -2139062144) ^ -2139062144) & _loc1_;
               if(_loc1_ == 0)
               {
                  continue;
               }
               if((_loc6_ & 255) == 0)
               {
                  _loc9_ -= _loc13_;
               }
               else if(li8(_loc9_ + 1) == 0)
               {
                  _loc9_ = 1 - _loc13_ + _loc9_;
               }
               else if(li8(_loc9_ + 2) == 0)
               {
                  _loc9_ = 2 - _loc13_ + _loc9_;
               }
               else
               {
                  if(li8(_loc9_ + 3) != 0)
                  {
                     continue;
                  }
                  _loc9_ = 3 - _loc13_ + _loc9_;
               }
            }
         }
         addr254:
         _loc2_ -= 16;
         _loc1_ = _loc9_ << 2;
         _loc1_ |= 1;
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F_malloc();
         _loc10_ = -1;
         _loc2_ += 16;
         if((_loc6_ = eax) != 0)
         {
            if(li32(_loc12_ + 40) != 0)
            {
               if(uint(_loc9_) >= 2)
               {
                  _loc7_ = _loc13_ + 1;
                  _loc5_ = _loc9_ += -1;
                  _loc10_ = _loc6_;
                  do
                  {
                     _loc8_ = si8(li8(_loc7_ - 1));
                     _loc1_ = si8(li8(_loc7_));
                     _loc2_ -= 16;
                     si32(_loc1_,_loc2_ + 12);
                     si32(156,_loc2_ + 8);
                     si32(_loc8_,_loc2_ + 4);
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_vis();
                     _loc5_ += -1;
                     _loc7_ += 1;
                     _loc2_ += 16;
                     _loc10_ = eax;
                  }
                  while(_loc5_ != 0);
                  
                  _loc13_ += _loc9_;
                  addr392:
                  _loc1_ = si8(li8(_loc13_));
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 12);
                  si32(156,_loc2_ + 8);
                  si32(_loc1_,_loc2_ + 4);
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_vis();
                  _loc2_ += 16;
                  _loc7_ = eax;
               }
               else
               {
                  _loc10_ = _loc6_;
                  _loc7_ = _loc6_;
                  if(_loc9_ != 0)
                  {
                     §§goto(addr392);
                  }
               }
               si8(0,_loc7_);
               _loc13_ = _loc7_ - _loc6_;
            }
            else if(li32(_loc12_ + 56) == 48)
            {
               if(uint(_loc9_) >= 2)
               {
                  _loc7_ = _loc13_ + 1;
                  _loc9_ = _loc5_ = _loc9_ + -1;
                  _loc10_ = _loc6_;
                  do
                  {
                     _loc1_ = si8(li8(_loc7_ - 1));
                     _loc8_ = si8(li8(_loc7_));
                     _loc2_ -= 16;
                     si32(_loc8_,_loc2_ + 12);
                     si32(29,_loc2_ + 8);
                     si32(_loc1_,_loc2_ + 4);
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_vis();
                     _loc9_ += -1;
                     _loc7_ += 1;
                     _loc2_ += 16;
                     _loc10_ = eax;
                  }
                  while(_loc9_ != 0);
                  
                  _loc13_ += _loc5_;
                  addr546:
                  _loc1_ = si8(li8(_loc13_));
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 12);
                  si32(29,_loc2_ + 8);
                  si32(_loc1_,_loc2_ + 4);
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_vis();
                  _loc2_ += 16;
                  _loc7_ = eax;
               }
               else
               {
                  _loc10_ = _loc6_;
                  _loc7_ = _loc6_;
                  if(_loc9_ != 0)
                  {
                     §§goto(addr546);
                  }
               }
               si8(0,_loc7_);
               _loc13_ = _loc7_ - _loc6_;
            }
            else if(li32(_loc12_ + 28) != 0)
            {
               if(uint(_loc9_) >= 2)
               {
                  _loc7_ = _loc13_ + 1;
                  _loc9_ = _loc5_ = _loc9_ + -1;
                  _loc10_ = _loc6_;
                  do
                  {
                     _loc1_ = si8(li8(_loc7_ - 1));
                     _loc8_ = si8(li8(_loc7_));
                     _loc2_ -= 16;
                     si32(_loc8_,_loc2_ + 12);
                     si32(28,_loc2_ + 8);
                     si32(_loc1_,_loc2_ + 4);
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_vis();
                     _loc9_ += -1;
                     _loc7_ += 1;
                     _loc2_ += 16;
                     _loc10_ = eax;
                  }
                  while(_loc9_ != 0);
                  
                  _loc13_ += _loc5_;
                  addr700:
                  _loc1_ = si8(li8(_loc13_));
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 12);
                  si32(28,_loc2_ + 8);
                  si32(_loc1_,_loc2_ + 4);
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_vis();
                  _loc2_ += 16;
                  _loc7_ = eax;
               }
               else
               {
                  _loc10_ = _loc6_;
                  _loc7_ = _loc6_;
                  if(_loc9_ != 0)
                  {
                     §§goto(addr700);
                  }
               }
               si8(0,_loc7_);
               _loc13_ = _loc7_ - _loc6_;
            }
            else
            {
               if(uint(_loc9_) >= 2)
               {
                  _loc7_ = _loc13_ + 1;
                  _loc9_ = _loc5_ = _loc9_ + -1;
                  _loc10_ = _loc6_;
                  do
                  {
                     _loc8_ = si8(li8(_loc7_ - 1));
                     _loc1_ = si8(li8(_loc7_));
                     _loc2_ -= 16;
                     si32(_loc1_,_loc2_ + 12);
                     si32(31,_loc2_ + 8);
                     si32(_loc8_,_loc2_ + 4);
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_vis();
                     _loc9_ += -1;
                     _loc7_ += 1;
                     _loc2_ += 16;
                     _loc10_ = eax;
                  }
                  while(_loc9_ != 0);
                  
                  _loc13_ += _loc5_;
                  addr847:
                  _loc1_ = si8(li8(_loc13_));
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 12);
                  si32(31,_loc2_ + 8);
                  si32(_loc1_,_loc2_ + 4);
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_vis();
                  _loc2_ += 16;
                  _loc7_ = eax;
               }
               else
               {
                  _loc10_ = _loc6_;
                  _loc7_ = _loc6_;
                  if(_loc9_ != 0)
                  {
                     §§goto(addr847);
                  }
               }
               si8(0,_loc7_);
               _loc13_ = _loc7_ - _loc6_;
            }
            _loc2_ -= 16;
            si32(_loc6_,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc11_,_loc2_);
            si32(_loc13_,_loc2_ + 12);
            ESP = _loc2_;
            F___printf_out();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc8_ = li32(_loc11_);
            _loc2_ -= 16;
            var _loc4_:int;
            si32(_loc4_ = _loc11_ + 4,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F___sfvwrite();
            _loc2_ += 16;
            si32(_loc8_ = _loc11_ + 16,_loc11_ + 80);
            si32(_loc8_,_loc11_ + 4);
            si32(0,_loc11_ + 12);
            si32(0,_loc11_ + 8);
            _loc10_ = _loc1_ + _loc13_;
            if(_loc6_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc6_,_loc2_);
               ESP = _loc2_;
               F_idalloc();
               _loc2_ += 16;
            }
         }
         §§goto(addr1021);
      }
      addr1021:
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
