package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str172;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str273;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str71;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_strerror_r() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:int = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc13_ = li32(_loc1_);
      _loc2_ -= 16;
      si32(1,_loc2_ + 4);
      si32(L__2E_str172,_loc2_);
      ESP = _loc2_;
      F_catopen();
      _loc1_ = (_loc12_ = li32(_loc3_)) + -1;
      _loc11_ = li32(_loc3_ + 8);
      _loc10_ = li32(_loc3_ + 4);
      _loc2_ += 16;
      _loc9_ = eax;
      if(uint(_loc1_) >= 93)
      {
         _loc2_ -= 16;
         si32(L__2E_str273,_loc2_ + 12);
         si32(65535,_loc2_ + 8);
         si32(1,_loc2_ + 4);
         si32(_loc9_,_loc2_);
         ESP = _loc2_;
         F_catgets();
         _loc2_ += 16;
         _loc8_ = eax;
         si8(0,_loc3_ - 1);
         _loc1_ = _loc12_ >> 31;
         var _loc7_:*;
         _loc6_ = (_loc7_ = _loc12_ + _loc1_) ^ _loc1_;
         _loc5_ = _loc3_ - 36 + 35;
         _loc4_ = _loc3_ - 36 + 34;
         do
         {
            _loc1_ = _loc6_;
            _loc7_ = uint(_loc1_) % 10;
            si8(_loc7_ = li8(_loc7_ = L__2E_str71 + _loc7_),_loc4_);
            _loc5_ += -1;
            _loc4_ += -1;
            _loc6_ = uint(_loc1_) / 10;
         }
         while(uint(_loc1_) > 9);
         
         if(_loc12_ <= -1)
         {
            si8(45,_loc4_);
            _loc5_ = _loc4_;
         }
         si8(32,_loc5_ - 1);
         si8(58,_loc5_ - 2);
         _loc4_ = _loc5_ + -2;
         if(_loc11_ != 0)
         {
            _loc5_ = _loc11_ + -1;
            _loc12_ = _loc10_;
            do
            {
               if(_loc5_ != 0)
               {
                  continue;
               }
               if(_loc11_ != 0)
               {
                  si8(0,_loc12_);
               }
            }
            while(si8(li8(_loc8_),_loc12_), _loc12_ += 1, _loc8_ += 1, _loc5_ += -1, li8(_loc8_) != 0);
            
            §§goto(addr293);
         }
         while(true)
         {
            _loc7_ = _loc8_ + 1;
            _loc1_ = li8(_loc8_);
            _loc8_ = _loc7_;
            if(_loc1_ != 0)
            {
               continue;
            }
            addr293:
            _loc2_ -= 16;
            si32(_loc11_,_loc2_ + 8);
            si32(_loc4_,_loc2_ + 4);
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F_strlcat();
            _loc2_ += 16;
            _loc10_ = 22;
            §§goto(addr458);
         }
      }
      else
      {
         _loc2_ -= 16;
         si32(1,_loc2_ + 4);
         si32(_loc9_,_loc2_);
         si32(_loc12_,_loc2_ + 8);
         si32(li32(_sys_errlist + (_loc12_ << 2)),_loc2_ + 12);
         ESP = _loc2_;
         F_catgets();
         _loc2_ += 16;
         _loc12_ = _loc8_ = eax;
         if(_loc11_ != 0)
         {
            _loc12_ = _loc11_ + -1;
            _loc4_ = _loc8_;
            do
            {
               if(_loc12_ != 0)
               {
                  continue;
               }
               _loc12_ = _loc4_;
               if(_loc11_ != 0)
               {
                  si8(0,_loc10_);
                  _loc12_ = _loc4_;
               }
            }
            while(si8(li8(_loc4_),_loc10_), _loc10_ += 1, _loc4_ += 1, _loc12_ += -1, li8(_loc4_) != 0);
            
            addr438:
            _loc1_ = _loc8_ ^ -1;
            _loc1_ = _loc4_ + _loc1_;
            _loc10_ = 0;
            if(uint(_loc1_) >= uint(_loc11_))
            {
               _loc10_ = 34;
               addr458:
               _loc1_ = _loc9_ + -1;
               if(uint(_loc1_) >= 4294967294)
               {
                  ESP = _loc2_;
                  F___error();
                  si32(9,eax);
               }
               else
               {
                  _loc2_ -= 16;
                  si32(li32(_loc9_ + 4),_loc2_ + 4);
                  si32(li32(_loc9_),_loc2_);
                  ESP = _loc2_;
                  F_munmap();
                  _loc2_ += 16;
                  if(_loc9_ != 0)
                  {
                     _loc2_ -= 16;
                     si32(_loc9_,_loc2_);
                     ESP = _loc2_;
                     F_idalloc();
                     _loc2_ += 16;
                  }
               }
               ESP = _loc2_;
               F___error();
               _loc1_ = eax;
               si32(_loc13_,_loc1_);
               eax = _loc10_;
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
            §§goto(addr293);
         }
         while(true)
         {
            _loc4_ = _loc12_ + 1;
            _loc1_ = li8(_loc12_);
            _loc12_ = _loc4_;
            if(_loc1_ != 0)
            {
               continue;
            }
            §§goto(addr438);
         }
      }
      §§goto(addr293);
   }
}
