package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._one;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___hdtoa() : void
   {
      var _loc4_:* = 0;
      var _loc10_:* = NaN;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc3_:* = 0;
      var _loc15_:* = 0;
      var _loc12_:* = 0;
      var _loc5_:* = 0;
      var _loc14_:* = 0;
      var _loc16_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 32;
      sf64(_loc10_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      _loc3_ = (_loc16_ = li32(_loc3_)) >>> 31;
      _loc15_ = li32(_loc4_ + 20);
      si32(_loc3_,_loc15_);
      _loc12_ = (_loc14_ = _loc16_ >>> 20) & 2047;
      _loc11_ = li32(_loc4_ + 24);
      _loc9_ = li32(_loc4_ + 16);
      _loc7_ = li32(_loc4_ + 12);
      _loc6_ = li32(_loc4_ + 8);
      _loc1_ = li32(_loc4_ - 8);
      if(_loc12_ != 2047)
      {
         if(_loc12_ == 0)
         {
            _loc12_ = 16;
            if((_loc16_ & 1048575 | _loc1_) != 0)
            {
               _loc12_ = 8;
            }
            addr141:
            if(_loc12_ <= 7)
            {
               if(_loc12_ != 1)
               {
                  if(_loc12_ != 4)
                  {
                     addr354:
                     si32(2147483647,_loc9_);
                     _loc2_ -= 16;
                     si32(0,_loc2_);
                     ESP = _loc2_;
                     F___Balloc_D2A();
                     _loc2_ += 16;
                     _loc1_ = eax;
                     si32(0,_loc1_);
                     si8(78,_loc1_ + 4);
                     si8(97,_loc1_ + 5);
                     si8(78,_loc1_ + 6);
                     si8(0,_loc1_ + 7);
                     _loc9_ = _loc1_ + 4;
                     if(_loc11_ != 0)
                     {
                        si32(_loc1_ + 7,_loc11_);
                     }
                  }
                  else
                  {
                     addr163:
                     _loc3_ = _loc14_ & 2047;
                     _loc5_ = _loc3_ + -1022;
                     addr419:
                     si32(_loc5_,_loc9_);
                     _loc5_ = 1;
                     _loc14_ = 0;
                     if(_loc7_ != _loc14_)
                     {
                        _loc5_ = _loc7_;
                     }
                     _loc12_ = _loc5_;
                     if(_loc5_ <= _loc14_)
                     {
                        _loc12_ = 15;
                     }
                     _loc7_ = 4;
                     if(uint(_loc12_) >= 20)
                     {
                        do
                        {
                           _loc14_ += 1;
                           _loc3_ = (_loc7_ <<= 1) + 16;
                        }
                        while(uint(_loc3_) <= uint(_loc12_));
                        
                     }
                     _loc2_ -= 16;
                     si32(_loc14_,_loc2_);
                     ESP = _loc2_;
                     F___Balloc_D2A();
                     _loc2_ += 16;
                     _loc7_ = eax;
                     si32(_loc14_,_loc7_);
                     _loc3_ = _loc5_ + -1;
                     if(uint(_loc3_) <= 13)
                     {
                        si32(_loc16_ & -2146435073 | (_loc15_ = (_loc15_ = _loc5_ << 22) + 1013972992) & 2146435072,(_loc15_ = _loc4_ - 24) | 4);
                        si32(_loc1_,_loc4_ - 24);
                        var _loc8_:* = lf32(_one + ((_loc16_ & -2147483648) >>> 29));
                        var _loc13_:*;
                        sf64(_loc8_ = (_loc13_ = (_loc13_ = lf64(_loc4_ - 24)) + _loc8_) - _loc8_,_loc4_ - 32);
                        si32((_loc15_ = -967 - (_loc5_ << 2)) + li32(_loc9_) + ((_loc15_ = (_loc16_ = li32(_loc15_ = (_loc15_ = _loc4_ - 32) | 4)) >>> 20) & 2047),_loc9_);
                        _loc1_ = li32(_loc4_ - 32);
                     }
                     _loc9_ = _loc7_ + 4;
                     si8(49,_loc9_);
                     if(_loc12_ >= 2)
                     {
                        _loc14_ = _loc9_ + _loc12_;
                        _loc12_ = _loc9_ + 2;
                        if(uint(_loc14_) <= uint(_loc12_))
                        {
                           _loc14_ = _loc12_;
                        }
                        _loc3_ = _loc9_ ^ -1;
                        _loc14_ += _loc3_;
                        _loc12_ = _loc7_ + 5;
                        _loc16_ &= 1048575;
                        do
                        {
                           _loc3_ = _loc16_ >>> 16;
                           _loc3_ &= 15;
                           _loc3_ = _loc6_ + _loc3_;
                           _loc3_ = li8(_loc3_);
                           si8(_loc3_,_loc12_);
                           _loc3_ = _loc1_ >>> 28;
                           _loc16_ = (_loc15_ = _loc16_ << 4) | _loc3_;
                           _loc12_ += 1;
                           _loc14_ += -1;
                           _loc1_ <<= 4;
                        }
                        while(_loc14_ != 0);
                        
                     }
                     _loc1_ = 16;
                     if(_loc5_ <= -1)
                     {
                        do
                        {
                           _loc3_ = _loc7_ + _loc1_;
                           _loc3_ = li8(_loc3_ + 2);
                           _loc1_ += -1;
                           _loc5_ = _loc1_;
                        }
                        while(_loc3_ == 48);
                        
                     }
                     _loc1_ = _loc9_ + _loc5_;
                     si8(0,_loc1_);
                     if(_loc11_ != 0)
                     {
                        si32(_loc1_,_loc11_);
                     }
                  }
               }
               else
               {
                  si32(2147483647,_loc9_);
                  _loc2_ -= 16;
                  si32(0,_loc2_);
                  ESP = _loc2_;
                  F___Balloc_D2A();
                  _loc2_ += 16;
                  _loc1_ = eax;
                  si32(0,_loc1_);
                  si8(73,_loc1_ + 4);
                  si8(110,_loc1_ + 5);
                  si8(102,_loc1_ + 6);
                  si8(105,_loc1_ + 7);
                  si8(110,_loc1_ + 8);
                  si8(105,_loc1_ + 9);
                  si8(116,_loc1_ + 10);
                  si8(121,_loc1_ + 11);
                  si8(0,_loc1_ + 12);
                  _loc9_ = _loc1_ + 4;
                  if(_loc11_ != 0)
                  {
                     si32(_loc1_ + 12,_loc11_);
                  }
               }
               §§goto(addr751);
            }
            else
            {
               if(_loc12_ != 8)
               {
                  if(_loc12_ != 16)
                  {
                     §§goto(addr354);
                  }
                  else
                  {
                     si32(1,_loc9_);
                     _loc2_ -= 16;
                     si32(0,_loc2_);
                     ESP = _loc2_;
                     F___Balloc_D2A();
                     _loc2_ += 16;
                     _loc3_ = eax;
                     si32(0,_loc3_);
                     si8(48,_loc3_ + 4);
                     si8(0,_loc3_ + 5);
                     _loc9_ = _loc3_ + 4;
                     if(_loc11_ != 0)
                     {
                        si32(_loc9_ + 1,_loc11_);
                     }
                  }
               }
               else
               {
                  sf64(_loc8_ = _loc10_ * 5.363123171977039e+154,_loc4_ - 16);
                  _loc5_ = ((_loc16_ = li32(_loc4_ - 16 | 4)) >>> 20 & 2047) + -1536;
                  _loc1_ = li32(_loc4_ - 16);
                  §§goto(addr419);
               }
               addr751:
               eax = _loc9_;
               _loc2_ = _loc4_;
               ESP = _loc2_;
               return;
            }
            §§goto(addr419);
         }
         §§goto(addr163);
      }
      else
      {
         _loc12_ = 1;
         if((_loc16_ & 1048575 | _loc1_) != 0)
         {
            _loc12_ = 2;
         }
      }
      §§goto(addr141);
   }
}
