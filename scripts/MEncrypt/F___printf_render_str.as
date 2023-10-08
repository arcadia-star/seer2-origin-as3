package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___printf_render_str() : void
   {
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:int = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 144;
      _loc1_ = li32(_loc3_ + 4);
      _loc12_ = li32(_loc1_ + 24);
      _loc11_ = li32(_loc3_ + 8);
      _loc10_ = li32(_loc3_);
      if(_loc12_ == 0)
      {
         if((_loc12_ = li32(_loc1_ + 8)) == 83)
         {
            addr64:
            if((_loc9_ = li32(_loc12_ = li32(_loc11_))) == 0)
            {
               _loc2_ -= 16;
               si32(6,_loc2_ + 12);
               si32(L__2E_str2363,_loc2_ + 8);
               si32(_loc1_,_loc2_ + 4);
               si32(_loc10_,_loc2_);
               ESP = _loc2_;
               F___printf_out();
               _loc2_ += 16;
               _loc8_ = eax;
            }
            else
            {
               if((_loc11_ = li32(_loc1_)) <= -1)
               {
                  si32(_loc9_,_loc3_ - 140);
                  _loc2_ -= 16;
                  si32(128,_loc2_ + 8);
                  si32(0,_loc2_ + 4);
                  var _loc7_:*;
                  si32(_loc7_ = _loc3_ - 128,_loc2_);
                  ESP = _loc2_;
                  Fmemset();
                  _loc2_ += 16;
                  _loc12_ = li32(___wcsnrtombs);
                  _loc2_ -= 32;
                  si32(_loc7_,_loc2_ + 16);
                  si32(0,_loc2_ + 12);
                  si32(_loc8_ = -1,_loc2_ + 8);
                  si32(_loc7_ = _loc3_ - 140,_loc2_ + 4);
                  si32(0,_loc2_);
                  ESP = _loc2_;
                  ptr2fun[_loc12_]();
                  _loc2_ += 32;
                  if((_loc6_ = eax) != -1)
                  {
                  }
                  §§goto(addr1046);
               }
               else
               {
                  _loc6_ = _loc11_;
                  if(_loc11_ >= 128)
                  {
                     si32(_loc9_,_loc3_ - 140);
                     _loc2_ -= 16;
                     si32(128,_loc2_ + 8);
                     si32(_loc6_ = 0,_loc2_ + 4);
                     si32(_loc8_ = _loc3_ - 128,_loc2_);
                     ESP = _loc2_;
                     Fmemset();
                     _loc2_ += 16;
                     _loc5_ = _loc9_;
                     while(true)
                     {
                        _loc12_ = li32(_loc5_);
                        si32(_loc7_ = _loc5_ + 4,_loc3_ - 140);
                        _loc7_ = li32(___wcrtomb);
                        _loc2_ -= 16;
                        si32(_loc8_,_loc2_ + 8);
                        si32(_loc12_,_loc2_ + 4);
                        si32(_loc12_ = _loc3_ - 134,_loc2_);
                        ESP = _loc2_;
                        ptr2fun[_loc7_]();
                        _loc2_ += 16;
                        if((uint(_loc12_ = (_loc5_ = eax) + -1)) > 4294967293)
                        {
                           break;
                        }
                        if((_loc4_ = _loc5_ + _loc6_) > _loc11_)
                        {
                           break;
                        }
                        _loc5_ = li32(_loc3_ - 140);
                        _loc6_ = _loc4_;
                     }
                  }
               }
               _loc2_ -= 16;
               si32(_loc12_ = _loc6_ + 1,_loc2_);
               ESP = _loc2_;
               F_malloc();
               _loc8_ = -1;
               _loc2_ += 16;
               if((_loc11_ = eax) != 0)
               {
                  si32(_loc9_,_loc3_ - 140);
                  _loc2_ -= 16;
                  si32(128,_loc2_ + 8);
                  si32(_loc9_ = 0,_loc2_ + 4);
                  si32(_loc7_ = _loc3_ - 128,_loc2_);
                  ESP = _loc2_;
                  Fmemset();
                  _loc2_ += 16;
                  _loc12_ = li32(___wcsnrtombs);
                  _loc2_ -= 32;
                  si32(_loc7_,_loc2_ + 16);
                  si32(_loc6_,_loc2_ + 12);
                  si32(_loc8_ = -1,_loc2_ + 8);
                  si32(_loc7_ = _loc3_ - 140,_loc2_ + 4);
                  si32(_loc11_,_loc2_);
                  ESP = _loc2_;
                  ptr2fun[_loc12_]();
                  _loc2_ += 32;
                  if((_loc6_ = eax) == -1)
                  {
                     _loc2_ -= 16;
                     si32(_loc11_,_loc2_);
                     ESP = _loc2_;
                     F_idalloc();
                     _loc2_ += 16;
                  }
                  else
                  {
                     si8(_loc9_,_loc11_ + _loc6_);
                     if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & (_loc7_ = li32(_loc5_ = _loc11_ & -4)) + -16843009) != 0)
                     {
                        _loc8_ = _loc5_ + 4;
                        while(true)
                        {
                           if((uint(_loc6_ = _loc11_ + _loc9_)) < uint(_loc8_))
                           {
                              continue;
                           }
                        }
                        §§goto(addr693);
                     }
                     _loc9_ = _loc5_ + 4;
                     while(true)
                     {
                        _loc12_ = (_loc6_ = li32(_loc9_)) + -16843009;
                        if((_loc12_ = (_loc7_ = (_loc7_ = _loc6_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
                        {
                           continue;
                        }
                        if((_loc12_ = _loc6_ & 255) == 0)
                        {
                           _loc9_ -= _loc11_;
                        }
                        else if((_loc12_ = li8(_loc9_ + 1)) == 0)
                        {
                           _loc9_ = (_loc12_ = 1 - _loc11_) + _loc9_;
                        }
                        else if((_loc12_ = li8(_loc9_ + 2)) == 0)
                        {
                           _loc9_ = (_loc12_ = 2 - _loc11_) + _loc9_;
                        }
                        else
                        {
                           if((_loc12_ = li8(_loc9_ + 3)) != 0)
                           {
                              continue;
                           }
                           _loc9_ = (_loc12_ = 3 - _loc11_) + _loc9_;
                        }
                        addr693:
                        _loc2_ -= 16;
                        si32(_loc9_,_loc2_ + 12);
                        si32(_loc11_,_loc2_ + 8);
                        si32(_loc1_,_loc2_ + 4);
                        si32(_loc10_,_loc2_);
                        ESP = _loc2_;
                        F___printf_out();
                        _loc2_ += 16;
                        _loc8_ = eax;
                        if(_loc11_ != 0)
                        {
                           _loc2_ -= 16;
                           si32(_loc11_,_loc2_);
                           ESP = _loc2_;
                           F_idalloc();
                           _loc2_ += 16;
                        }
                        §§goto(addr1046);
                     }
                  }
               }
            }
         }
         else if((_loc6_ = li32(_loc12_ = li32(_loc11_))) == 0)
         {
            _loc2_ -= 16;
            si32(6,_loc2_ + 12);
            si32(L__2E_str2363,_loc2_ + 8);
            si32(_loc1_,_loc2_ + 4);
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F___printf_out();
            _loc2_ += 16;
            _loc8_ = eax;
         }
         else
         {
            if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & (_loc7_ = li32(_loc9_ = _loc6_ & -4)) + -16843009) != 0)
            {
               _loc5_ = _loc9_ + 4;
               _loc11_ = 0;
               while(true)
               {
                  if((uint(_loc8_ = _loc6_ + _loc11_)) < uint(_loc5_))
                  {
                     continue;
                  }
               }
               §§goto(addr979);
            }
            _loc9_ += 4;
            while(true)
            {
               _loc12_ = (_loc11_ = li32(_loc9_)) + -16843009;
               if((_loc12_ = (_loc7_ = (_loc7_ = _loc11_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
               {
                  continue;
               }
               if((_loc12_ = _loc11_ & 255) == 0)
               {
                  _loc11_ = _loc9_ - _loc6_;
               }
               else if((_loc12_ = li8(_loc9_ + 1)) == 0)
               {
                  _loc11_ = (_loc12_ = 1 - _loc6_) + _loc9_;
               }
               else if((_loc12_ = li8(_loc9_ + 2)) == 0)
               {
                  _loc11_ = (_loc12_ = 2 - _loc6_) + _loc9_;
               }
               else
               {
                  if((_loc12_ = li8(_loc9_ + 3)) != 0)
                  {
                     continue;
                  }
                  _loc11_ = (_loc12_ = 3 - _loc6_) + _loc9_;
               }
               addr979:
               _loc9_ = li32(_loc1_);
               _loc2_ -= 16;
               si32(_loc6_,_loc2_ + 8);
               si32(_loc1_,_loc2_ + 4);
               si32(_loc10_,_loc2_);
               _loc1_ = 1;
               _loc10_ = _loc1_;
               if(_loc9_ >= _loc11_)
               {
                  _loc10_ = 0;
               }
               if(_loc9_ <= -1)
               {
                  _loc1_ = 0;
               }
               if((_loc12_ = _loc1_ & _loc10_) == 0)
               {
                  _loc9_ = _loc11_;
               }
               si32(_loc9_,_loc2_ + 12);
               ESP = _loc2_;
               F___printf_out();
               _loc2_ += 16;
               _loc8_ = eax;
               §§goto(addr1046);
            }
         }
         addr1046:
         eax = _loc8_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr64);
   }
}
