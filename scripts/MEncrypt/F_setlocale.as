package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_currentlocale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_loadlocale;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str208;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str7215;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str8216;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._categories;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._current_categories;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._current_locale_string;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._new_categories;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._saved_categories;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_setlocale() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if(uint(_loc1_) >= 7)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc1_ = 0;
      }
      else if((_loc11_ = li32(_loc3_ + 4)) != 0)
      {
         var _loc12_:*;
         si8(_loc12_ = li8(_current_categories + 32),_new_categories + 32);
         _loc10_ = _current_categories + 33;
         _loc9_ = _new_categories + 33;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc10_),_loc9_);
               _loc9_ += 1;
               _loc10_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         si8(_loc12_ = li8(_current_categories + 64),_new_categories + 64);
         _loc10_ = _current_categories + 65;
         _loc9_ = _new_categories + 65;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc10_),_loc9_);
               _loc9_ += 1;
               _loc10_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         si8(_loc12_ = li8(_current_categories + 96),_new_categories + 96);
         _loc10_ = _current_categories + 97;
         _loc9_ = _new_categories + 97;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc10_),_loc9_);
               _loc9_ += 1;
               _loc10_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         si8(_loc12_ = li8(_current_categories + 128),_new_categories + 128);
         _loc10_ = _current_categories + 129;
         _loc9_ = _new_categories + 129;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc10_),_loc9_);
               _loc9_ += 1;
               _loc10_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         si8(_loc12_ = li8(_current_categories + 160),_new_categories + 160);
         _loc9_ = _current_categories + 161;
         _loc10_ = _new_categories + 161;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc9_),_loc10_);
               _loc10_ += 1;
               _loc9_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         si8(_loc12_ = li8(_current_categories + 192),_new_categories + 192);
         _loc10_ = _current_categories + 193;
         _loc9_ = _new_categories + 193;
         if(_loc12_ != 0)
         {
            do
            {
               si8(_loc12_ = li8(_loc10_),_loc9_);
               _loc9_ += 1;
               _loc10_ += 1;
            }
            while(_loc12_ != 0);
            
         }
         if((_loc10_ = li8(_loc11_)) != 0)
         {
            if(_loc1_ == 0)
            {
               _loc5_ = _loc11_ + 1;
               _loc9_ = _loc10_;
               for(; (_loc9_ &= 255) != 0; _loc9_ = li8(_loc5_),_loc5_ += 1)
               {
                  if(_loc9_ != 47)
                  {
                     continue;
                  }
                  _loc9_ = _loc5_ + -2;
                  if(_loc5_ == 1)
                  {
                     break;
                  }
                  do
                  {
                     _loc6_ = li8(_loc9_ + 2);
                     _loc5_ = _new_categories + 32;
                     _loc9_ += 1;
                     _loc10_ = 6;
                  }
                  while(_loc6_ == 47);
                  
                  if(_loc6_ == 0)
                  {
                     ESP = _loc2_;
                     F___error();
                     si32(22,eax);
                     _loc1_ = 0;
                     §§goto(addr2398);
                  }
                  loop22:
                  while(true)
                  {
                     if(_loc10_ != 0)
                     {
                        if((_loc6_ = _loc9_ - _loc11_) >= 32)
                        {
                           ESP = _loc2_;
                           F___error();
                           si32(22,eax);
                           _loc1_ = 0;
                           §§goto(addr2398);
                        }
                        else
                        {
                           if(_loc6_ != -1)
                           {
                              _loc4_ = _loc5_;
                              _loc8_ = _loc6_;
                              do
                              {
                                 if(_loc8_ != 0)
                                 {
                                    continue;
                                 }
                                 if(_loc6_ != -1)
                                 {
                                    si8(0,_loc4_);
                                 }
                              }
                              while(si8(_loc12_ = li8(_loc11_),_loc4_), _loc4_ += 1, _loc11_ += 1, _loc8_ += -1, _loc12_ != 0);
                              
                              §§goto(addr1968);
                           }
                           while(true)
                           {
                              if((_loc12_ = li8(_loc11_)) != 0)
                              {
                                 _loc11_ += 1;
                                 continue;
                              }
                              addr1968:
                              if((_loc6_ = li8(_loc9_)) == 47)
                              {
                                 do
                                 {
                                    _loc12_ = _loc9_ + 1;
                                    _loc6_ = li8(_loc9_ + 1);
                                    _loc9_ = _loc12_;
                                 }
                                 while(_loc6_ == 47);
                                 
                              }
                              _loc11_ = _loc9_;
                              _loc8_ = _loc6_;
                              while((_loc8_ &= 255) != 0)
                              {
                                 if(_loc8_ == 47)
                                 {
                                    break;
                                 }
                                 _loc8_ = li8(_loc9_ + 1);
                                 _loc9_ += 1;
                              }
                              _loc10_ += -1;
                              _loc5_ += 32;
                              if(_loc6_ != 0)
                              {
                                 continue loop22;
                              }
                              _loc9_ = _loc5_ + 1;
                              if((_loc12_ = 7 - _loc10_) <= 6)
                              {
                                 addr2049:
                                 si8(_loc12_ = li8(_loc9_ - 33),_loc9_ - 1);
                                 _loc11_ = _loc9_;
                                 if(_loc12_ != 0)
                                 {
                                    addr2064:
                                    si8(_loc12_ = li8(_loc11_ - 32),_loc11_);
                                    _loc11_ += 1;
                                    if(_loc12_ == 0)
                                    {
                                       §§goto(addr2081);
                                    }
                                    §§goto(addr2064);
                                 }
                                 §§goto(addr2081);
                              }
                              addr2081:
                              _loc10_ += -1;
                              _loc9_ += 32;
                              if(_loc10_ != 0)
                              {
                                 §§goto(addr2049);
                              }
                              _loc10_ = 33;
                              _loc11_ = 1;
                              if(_loc1_ != 0)
                              {
                                 _loc2_ -= 16;
                                 si32(_loc1_,_loc2_);
                                 ESP = _loc2_;
                                 F_loadlocale();
                                 _loc2_ += 16;
                                 _loc1_ = eax;
                                 §§goto(addr2398);
                              }
                              else
                              {
                                 while(true)
                                 {
                                    if(_loc11_ < 7)
                                    {
                                       continue;
                                    }
                                    ESP = _loc2_;
                                    F_currentlocale();
                                    _loc1_ = _current_locale_string;
                                    §§goto(addr2398);
                                 }
                              }
                              §§goto(addr2398);
                           }
                        }
                        §§goto(addr2398);
                     }
                     §§goto(addr2081);
                  }
                  §§goto(addr2398);
               }
               var _loc7_:*;
               _loc12_ = (_loc7_ = li32(_loc9_ = _loc11_ & -4)) + -16843009;
               if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & _loc12_) != 0)
               {
                  _loc5_ = _loc9_ + 4;
                  _loc6_ = 0;
                  while(true)
                  {
                     if((uint(_loc8_ = _loc11_ + _loc6_)) < uint(_loc5_))
                     {
                        continue;
                     }
                  }
                  §§goto(addr1560);
               }
               _loc9_ += 4;
               while(true)
               {
                  _loc12_ = (_loc5_ = li32(_loc9_)) + -16843009;
                  if((_loc12_ = (_loc7_ = (_loc7_ = _loc5_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
                  {
                     continue;
                  }
                  if((_loc12_ = _loc5_ & 255) == 0)
                  {
                     _loc6_ = _loc9_ - _loc11_;
                  }
                  else if((_loc12_ = li8(_loc9_ + 1)) == 0)
                  {
                     _loc6_ = (_loc12_ = 1 - _loc11_) + _loc9_;
                  }
                  else if((_loc12_ = li8(_loc9_ + 2)) == 0)
                  {
                     _loc6_ = (_loc12_ = 2 - _loc11_) + _loc9_;
                  }
                  else
                  {
                     if((_loc12_ = li8(_loc9_ + 3)) != 0)
                     {
                        continue;
                     }
                     _loc6_ = (_loc12_ = 3 - _loc11_) + _loc9_;
                  }
                  addr1560:
                  if(uint(_loc6_) <= 31)
                  {
                     si8(_loc10_,_new_categories + 32);
                     _loc10_ = 0;
                     do
                     {
                        _loc12_ = _new_categories + _loc10_;
                        si8(_loc7_ = li8((_loc7_ = _loc11_ + _loc10_) + 1),_loc12_ + 33);
                        _loc10_ += 1;
                     }
                     while(_loc7_ != 0);
                     
                     si8(_loc12_ = li8(_loc11_),_new_categories + 64);
                     if(_loc12_ != 0)
                     {
                        _loc10_ = _new_categories + 65;
                        _loc9_ = _loc11_ + 1;
                        do
                        {
                           si8(_loc12_ = li8(_loc9_),_loc10_);
                           _loc10_ += 1;
                           _loc9_ += 1;
                        }
                        while(_loc12_ != 0);
                        
                     }
                     si8(_loc12_ = li8(_loc11_),_new_categories + 96);
                     if(_loc12_ != 0)
                     {
                        _loc10_ = _new_categories + 97;
                        _loc9_ = _loc11_ + 1;
                        do
                        {
                           si8(_loc12_ = li8(_loc9_),_loc10_);
                           _loc10_ += 1;
                           _loc9_ += 1;
                        }
                        while(_loc12_ != 0);
                        
                     }
                     si8(_loc12_ = li8(_loc11_),_new_categories + 128);
                     if(_loc12_ != 0)
                     {
                        _loc10_ = _new_categories + 129;
                        _loc9_ = _loc11_ + 1;
                        do
                        {
                           si8(_loc12_ = li8(_loc9_),_loc10_);
                           _loc10_ += 1;
                           _loc9_ += 1;
                        }
                        while(_loc12_ != 0);
                        
                     }
                     si8(_loc12_ = li8(_loc11_),_new_categories + 160);
                     if(_loc12_ != 0)
                     {
                        _loc10_ = _new_categories + 161;
                        _loc9_ = _loc11_ + 1;
                        do
                        {
                           si8(_loc12_ = li8(_loc9_),_loc10_);
                           _loc10_ += 1;
                           _loc9_ += 1;
                        }
                        while(_loc12_ != 0);
                        
                     }
                     si8(_loc12_ = li8(_loc11_),_new_categories + 192);
                     if(_loc12_ != 0)
                     {
                        _loc10_ = _new_categories + 193;
                        _loc11_ += 1;
                        while(true)
                        {
                           si8(_loc12_ = li8(_loc11_),_loc10_);
                           _loc10_ += 1;
                           _loc11_ += 1;
                           if(_loc12_ != 0)
                           {
                              continue;
                           }
                           §§goto(addr2081);
                        }
                     }
                     §§goto(addr2081);
                  }
                  else
                  {
                     ESP = _loc2_;
                     F___error();
                     si32(22,eax);
                     _loc1_ = 0;
                     §§goto(addr2398);
                  }
               }
            }
            else
            {
               if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & (_loc7_ = li32(_loc8_ = _loc11_ & -4)) + -16843009) != 0)
               {
                  _loc5_ = _loc8_ + 4;
                  _loc6_ = 0;
                  while(true)
                  {
                     if((uint(_loc9_ = _loc11_ + _loc6_)) < uint(_loc5_))
                     {
                        continue;
                     }
                  }
                  §§goto(addr1288);
               }
               _loc9_ = _loc8_ + 4;
               while(true)
               {
                  _loc12_ = (_loc5_ = li32(_loc9_)) + -16843009;
                  if((_loc12_ = (_loc7_ = (_loc7_ = _loc5_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
                  {
                     continue;
                  }
                  if((_loc12_ = _loc5_ & 255) == 0)
                  {
                     _loc6_ = _loc9_ - _loc11_;
                  }
                  else if((_loc12_ = li8(_loc9_ + 1)) == 0)
                  {
                     _loc6_ = (_loc12_ = 1 - _loc11_) + _loc9_;
                  }
                  else if((_loc12_ = li8(_loc9_ + 2)) == 0)
                  {
                     _loc6_ = (_loc12_ = 2 - _loc11_) + _loc9_;
                  }
                  else
                  {
                     if((_loc12_ = li8(_loc9_ + 3)) != 0)
                     {
                        continue;
                     }
                     _loc6_ = (_loc12_ = 3 - _loc11_) + _loc9_;
                  }
                  addr1288:
                  if(uint(_loc6_) >= 32)
                  {
                     ESP = _loc2_;
                     F___error();
                     si32(22,eax);
                     _loc1_ = 0;
                     §§goto(addr2398);
                  }
                  else
                  {
                     _loc12_ = _new_categories + (_loc1_ << 5);
                     si8(_loc10_,_loc12_);
                     _loc10_ = _loc12_ + 1;
                     _loc11_ += 1;
                     while(true)
                     {
                        si8(_loc12_ = li8(_loc11_),_loc10_);
                        _loc10_ += 1;
                        _loc11_ += 1;
                        if(_loc12_ != 0)
                        {
                           continue;
                        }
                        §§goto(addr2081);
                     }
                  }
                  §§goto(addr2398);
               }
            }
            §§goto(addr2081);
         }
         else
         {
            _loc10_ = _new_categories + 33;
            _loc11_ = 1;
            if(_loc1_ != 0)
            {
               _loc2_ -= 16;
               si32(L__2E_str208,_loc2_);
               ESP = _loc2_;
               F_getenv();
               _loc2_ += 16;
               if((_loc11_ = eax) != 0)
               {
                  if((_loc12_ = li8(_loc11_)) == 0)
                  {
                     addr770:
                     _loc12_ = _loc1_ << 2;
                     _loc12_ = li32(_loc12_ = _categories + _loc12_);
                     _loc2_ -= 16;
                     si32(_loc12_,_loc2_);
                     ESP = _loc2_;
                     F_getenv();
                     _loc2_ += 16;
                     if((_loc11_ = eax) != 0)
                     {
                        if((_loc12_ = li8(_loc11_)) == 0)
                        {
                        }
                        addr852:
                        _loc12_ = (_loc7_ = li32(_loc6_ = _loc11_ & -4)) + -16843009;
                        if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & _loc12_) != 0)
                        {
                           _loc5_ = _loc6_ + 4;
                           _loc10_ = 0;
                           while(true)
                           {
                              if((uint(_loc9_ = _loc11_ + _loc10_)) < uint(_loc5_))
                              {
                                 continue;
                              }
                           }
                           §§goto(addr1028);
                        }
                        _loc9_ = _loc6_ + 4;
                        while(true)
                        {
                           _loc12_ = (_loc10_ = li32(_loc9_)) + -16843009;
                           if((_loc12_ = (_loc7_ = (_loc7_ = _loc10_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
                           {
                              continue;
                           }
                           if((_loc12_ = _loc10_ & 255) == 0)
                           {
                              _loc10_ = _loc9_ - _loc11_;
                           }
                           else if((_loc12_ = li8(_loc9_ + 1)) == 0)
                           {
                              _loc10_ = (_loc12_ = 1 - _loc11_) + _loc9_;
                           }
                           else if((_loc12_ = li8(_loc9_ + 2)) == 0)
                           {
                              _loc10_ = (_loc12_ = 2 - _loc11_) + _loc9_;
                           }
                           else
                           {
                              if((_loc12_ = li8(_loc9_ + 3)) != 0)
                              {
                                 continue;
                              }
                              _loc10_ = (_loc12_ = 3 - _loc11_) + _loc9_;
                           }
                           addr1028:
                           if(uint(_loc10_) >= 32)
                           {
                              ESP = _loc2_;
                              F___error();
                              si32(22,eax);
                              _loc1_ = 0;
                              §§goto(addr2398);
                           }
                           else
                           {
                              _loc10_ = _new_categories + (_loc1_ << 5);
                              si8(_loc12_ = li8(_loc11_),_loc10_);
                              if(_loc12_ != 0)
                              {
                                 _loc10_ += 1;
                                 _loc11_ += 1;
                                 do
                                 {
                                    si8(_loc12_ = li8(_loc11_),_loc10_);
                                    _loc10_ += 1;
                                    _loc11_ += 1;
                                 }
                                 while(_loc12_ != 0);
                                 
                              }
                              §§goto(addr2081);
                           }
                        }
                     }
                     _loc2_ -= 16;
                     si32(L__2E_str7215,_loc2_);
                     ESP = _loc2_;
                     F_getenv();
                     _loc2_ += 16;
                     if((_loc11_ = eax) != 0)
                     {
                        if((_loc12_ = li8(_loc11_)) == 0)
                        {
                        }
                        §§goto(addr852);
                     }
                     _loc11_ = L__2E_str8216;
                  }
                  §§goto(addr852);
               }
               §§goto(addr770);
            }
            else
            {
               while(true)
               {
                  if(_loc11_ >= 7)
                  {
                     §§goto(addr2081);
                  }
                  else
                  {
                     _loc2_ -= 16;
                     si32(L__2E_str208,_loc2_);
                     ESP = _loc2_;
                     F_getenv();
                     _loc2_ += 16;
                     if((_loc9_ = eax) != 0)
                     {
                        if((_loc12_ = li8(_loc9_)) == 0)
                        {
                           addr402:
                           _loc12_ = _loc11_ << 2;
                           _loc12_ = li32(_loc12_ = _categories + _loc12_);
                           _loc2_ -= 16;
                           si32(_loc12_,_loc2_);
                           ESP = _loc2_;
                           F_getenv();
                           _loc2_ += 16;
                           if((_loc9_ = eax) != 0)
                           {
                              if((_loc12_ = li8(_loc9_)) == 0)
                              {
                              }
                              addr484:
                              _loc12_ = (_loc7_ = li32(_loc8_ = _loc9_ & -4)) + -16843009;
                              if((_loc12_ = (_loc7_ = (_loc7_ &= -2139062144) ^ -2139062144) & _loc12_) != 0)
                              {
                                 _loc6_ = _loc8_ + 4;
                                 _loc5_ = 0;
                                 while(true)
                                 {
                                    if((uint(_loc4_ = _loc9_ + _loc5_)) < uint(_loc6_))
                                    {
                                       continue;
                                    }
                                 }
                                 addr660:
                                 if(uint(_loc5_) >= 32)
                                 {
                                    ESP = _loc2_;
                                    F___error();
                                    si32(22,eax);
                                    _loc1_ = 0;
                                    break;
                                 }
                                 continue;
                              }
                              _loc6_ = _loc8_ + 4;
                              while(true)
                              {
                                 _loc12_ = (_loc5_ = li32(_loc6_)) + -16843009;
                                 if((_loc12_ = (_loc7_ = (_loc7_ = _loc5_ & -2139062144) ^ -2139062144) & _loc12_) == 0)
                                 {
                                    continue;
                                 }
                                 if((_loc12_ = _loc5_ & 255) == 0)
                                 {
                                    _loc5_ = _loc6_ - _loc9_;
                                 }
                                 else if((_loc12_ = li8(_loc6_ + 1)) == 0)
                                 {
                                    _loc5_ = (_loc12_ = 1 - _loc9_) + _loc6_;
                                 }
                                 else if((_loc12_ = li8(_loc6_ + 2)) == 0)
                                 {
                                    _loc5_ = (_loc12_ = 2 - _loc9_) + _loc6_;
                                 }
                                 else
                                 {
                                    if((_loc12_ = li8(_loc6_ + 3)) != 0)
                                    {
                                       continue;
                                    }
                                    _loc5_ = (_loc12_ = 3 - _loc9_) + _loc6_;
                                 }
                                 §§goto(addr660);
                              }
                           }
                           _loc2_ -= 16;
                           si32(L__2E_str7215,_loc2_);
                           ESP = _loc2_;
                           F_getenv();
                           _loc2_ += 16;
                           if((_loc9_ = eax) != 0)
                           {
                              if((_loc12_ = li8(_loc9_)) == 0)
                              {
                              }
                              §§goto(addr484);
                           }
                           _loc9_ = L__2E_str8216;
                        }
                        §§goto(addr484);
                     }
                     §§goto(addr402);
                  }
               }
            }
         }
      }
      else if(_loc1_ != 0)
      {
         _loc1_ = _current_categories + (_loc1_ << 5);
      }
      else
      {
         ESP = _loc2_;
         F_currentlocale();
         _loc1_ = _current_locale_string;
      }
      addr2398:
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
