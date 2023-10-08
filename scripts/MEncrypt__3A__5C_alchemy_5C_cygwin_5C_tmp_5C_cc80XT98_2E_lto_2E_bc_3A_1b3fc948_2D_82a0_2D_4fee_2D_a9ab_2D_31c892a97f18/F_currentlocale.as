package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si8;
   
   public function F_currentlocale() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li8(_current_categories + 32);
      si8(_loc1_,_current_locale_string);
      _loc9_ = _current_categories + 33;
      _loc7_ = (_loc8_ = _current_locale_string) + 1;
      _loc6_ = 2;
      if(_loc1_ != 0)
      {
         do
         {
            _loc1_ = li8(_loc9_);
            si8(_loc1_,_loc7_);
            _loc7_ += 1;
            _loc9_ += 1;
            _loc6_ = 2;
         }
         while(_loc1_ != 0);
         
      }
      loop1:
      for(; _loc6_ <= 6; _loc6_ += 1)
      {
         _loc9_ = _current_categories + 64;
         _loc5_ = 0;
         while(true)
         {
            _loc1_ = _current_categories + _loc5_;
            var _loc4_:* = _loc6_ << 5;
            _loc1_ += _loc4_;
            _loc1_ = li8(_loc1_);
            if((_loc7_ = li8(_loc9_ - 32)) != _loc1_)
            {
               break;
            }
            _loc5_ += 1;
            _loc9_ += 1;
            if(_loc7_ != 0)
            {
               continue;
            }
            continue loop1;
         }
         _loc6_ = _loc7_ + 4;
         _loc5_ = 0;
         if(((_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc7_ = _loc8_ & -4)) + -16843009) != 0)
         {
            while(true)
            {
               _loc9_ = _loc8_ + _loc5_;
               _loc6_ = _loc7_ + 4;
               if(uint(_loc9_) < uint(_loc6_))
               {
                  continue;
               }
            }
            addr270:
            _loc1_ = _loc8_ + _loc5_;
            si16(47,_loc1_);
            _loc7_ = _current_categories + 64;
            _loc1_ = li8(_current_locale_string);
            _loc6_ = _loc8_;
            if(_loc1_ != 0)
            {
               do
               {
                  _loc7_ = _current_categories + 64;
                  _loc6_ = _loc8_ + 1;
                  _loc1_ = li8(_loc8_ + 1);
                  _loc8_ = _loc6_;
               }
               while(_loc1_ != 0);
               
            }
            do
            {
               _loc1_ = li8(_loc7_);
               si8(_loc1_,_loc6_);
               _loc7_ += 1;
               _loc6_ += 1;
            }
            while(_loc1_ != 0);
            
            _loc6_ = _loc9_ + 4;
            _loc5_ = 0;
            if(((_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc9_ = (_loc8_ = _current_locale_string) & -4)) + -16843009) != 0)
            {
               while(true)
               {
                  _loc7_ = _loc8_ + _loc5_;
                  _loc6_ = _loc9_ + 4;
                  if(uint(_loc7_) < uint(_loc6_))
                  {
                     continue;
                  }
               }
               addr494:
               _loc1_ = _loc8_ + _loc5_;
               si16(47,_loc1_);
               _loc7_ = _current_categories + 96;
               _loc1_ = li8(_current_locale_string);
               _loc6_ = _loc8_;
               if(_loc1_ != 0)
               {
                  do
                  {
                     _loc7_ = _current_categories + 96;
                     _loc6_ = _loc8_ + 1;
                     _loc1_ = li8(_loc8_ + 1);
                     _loc8_ = _loc6_;
                  }
                  while(_loc1_ != 0);
                  
               }
               do
               {
                  _loc1_ = li8(_loc7_);
                  si8(_loc1_,_loc6_);
                  _loc7_ += 1;
                  _loc6_ += 1;
               }
               while(_loc1_ != 0);
               
               _loc6_ = _loc5_ + 4;
               _loc9_ = 0;
               if(((_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc5_ = (_loc8_ = _current_locale_string) & -4)) + -16843009) != 0)
               {
                  while(true)
                  {
                     _loc7_ = _loc8_ + _loc9_;
                     _loc6_ = _loc5_ + 4;
                     if(uint(_loc7_) < uint(_loc6_))
                     {
                        continue;
                     }
                  }
                  addr718:
                  _loc1_ = _loc8_ + _loc9_;
                  si16(47,_loc1_);
                  _loc7_ = _current_categories + 128;
                  _loc1_ = li8(_current_locale_string);
                  _loc6_ = _loc8_;
                  if(_loc1_ != 0)
                  {
                     do
                     {
                        _loc7_ = _current_categories + 128;
                        _loc6_ = _loc8_ + 1;
                        _loc1_ = li8(_loc8_ + 1);
                        _loc8_ = _loc6_;
                     }
                     while(_loc1_ != 0);
                     
                  }
                  do
                  {
                     _loc1_ = li8(_loc7_);
                     si8(_loc1_,_loc6_);
                     _loc7_ += 1;
                     _loc6_ += 1;
                  }
                  while(_loc1_ != 0);
                  
                  _loc6_ = _loc5_ + 4;
                  _loc7_ = 0;
                  if(((_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc5_ = (_loc8_ = _current_locale_string) & -4)) + -16843009) != 0)
                  {
                     while(true)
                     {
                        _loc9_ = _loc8_ + _loc7_;
                        _loc6_ = _loc5_ + 4;
                        if(uint(_loc9_) < uint(_loc6_))
                        {
                           continue;
                        }
                     }
                     addr942:
                     _loc1_ = _loc8_ + _loc7_;
                     si16(47,_loc1_);
                     _loc6_ = _current_categories + 160;
                     _loc1_ = li8(_current_locale_string);
                     _loc7_ = _loc8_;
                     if(_loc1_ != 0)
                     {
                        do
                        {
                           _loc6_ = _current_categories + 160;
                           _loc7_ = _loc8_ + 1;
                           _loc1_ = li8(_loc8_ + 1);
                           _loc8_ = _loc7_;
                        }
                        while(_loc1_ != 0);
                        
                     }
                     do
                     {
                        _loc1_ = li8(_loc6_);
                        si8(_loc1_,_loc7_);
                        _loc6_ += 1;
                        _loc7_ += 1;
                     }
                     while(_loc1_ != 0);
                     
                     _loc6_ = _loc7_ + 4;
                     _loc5_ = 0;
                     if(((_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc7_ = (_loc8_ = _current_locale_string) & -4)) + -16843009) != 0)
                     {
                        while(true)
                        {
                           _loc9_ = _loc8_ + _loc5_;
                           _loc6_ = _loc7_ + 4;
                           if(uint(_loc9_) < uint(_loc6_))
                           {
                              continue;
                           }
                        }
                        addr1166:
                        _loc1_ = _loc8_ + _loc5_;
                        si16(47,_loc1_);
                        _loc7_ = _current_categories + 192;
                        _loc1_ = li8(_current_locale_string);
                        _loc6_ = _loc8_;
                        if(_loc1_ != 0)
                        {
                           do
                           {
                              _loc7_ = _current_categories + 192;
                              _loc6_ = _loc8_ + 1;
                              _loc1_ = li8(_loc8_ + 1);
                              _loc8_ = _loc6_;
                           }
                           while(_loc1_ != 0);
                           
                        }
                        while(true)
                        {
                           _loc1_ = li8(_loc7_);
                           si8(_loc1_,_loc6_);
                           _loc7_ += 1;
                           _loc6_ += 1;
                           if(_loc1_ == 0)
                           {
                              break loop1;
                           }
                        }
                     }
                     while(true)
                     {
                        _loc1_ = (_loc7_ = li32(_loc6_)) + -16843009;
                        _loc1_ = (_loc4_ = (_loc4_ = _loc7_ & -2139062144) ^ -2139062144) & _loc1_;
                        if(_loc1_ == 0)
                        {
                           continue;
                        }
                        if((_loc7_ & 255) == 0)
                        {
                           _loc5_ = _loc6_ - _current_locale_string;
                        }
                        else if(li8(_loc6_ + 1) == 0)
                        {
                           _loc5_ = _loc6_ + (1 - _current_locale_string);
                        }
                        else if(li8(_loc6_ + 2) == 0)
                        {
                           _loc5_ = _loc6_ + (2 - _current_locale_string);
                        }
                        else
                        {
                           if(li8(_loc6_ + 3) != 0)
                           {
                              continue;
                           }
                           _loc5_ = _loc6_ + (3 - _current_locale_string);
                        }
                        §§goto(addr1166);
                     }
                  }
                  while(true)
                  {
                     _loc1_ = (_loc7_ = li32(_loc6_)) + -16843009;
                     _loc1_ = (_loc4_ = (_loc4_ = _loc7_ & -2139062144) ^ -2139062144) & _loc1_;
                     if(_loc1_ == 0)
                     {
                        continue;
                     }
                     if((_loc7_ & 255) == 0)
                     {
                        _loc7_ = _loc6_ - _current_locale_string;
                     }
                     else if(li8(_loc6_ + 1) == 0)
                     {
                        _loc7_ = _loc6_ + (1 - _current_locale_string);
                     }
                     else if(li8(_loc6_ + 2) == 0)
                     {
                        _loc7_ = _loc6_ + (2 - _current_locale_string);
                     }
                     else
                     {
                        if(li8(_loc6_ + 3) != 0)
                        {
                           continue;
                        }
                        _loc7_ = _loc6_ + (3 - _current_locale_string);
                     }
                     §§goto(addr942);
                  }
               }
               while(true)
               {
                  _loc1_ = (_loc7_ = li32(_loc6_)) + -16843009;
                  _loc1_ = (_loc4_ = (_loc4_ = _loc7_ & -2139062144) ^ -2139062144) & _loc1_;
                  if(_loc1_ == 0)
                  {
                     continue;
                  }
                  if((_loc7_ & 255) == 0)
                  {
                     _loc9_ = _loc6_ - _current_locale_string;
                  }
                  else if(li8(_loc6_ + 1) == 0)
                  {
                     _loc9_ = _loc6_ + (1 - _current_locale_string);
                  }
                  else if(li8(_loc6_ + 2) == 0)
                  {
                     _loc9_ = _loc6_ + (2 - _current_locale_string);
                  }
                  else
                  {
                     if(li8(_loc6_ + 3) != 0)
                     {
                        continue;
                     }
                     _loc9_ = _loc6_ + (3 - _current_locale_string);
                  }
                  §§goto(addr718);
               }
            }
            while(true)
            {
               _loc1_ = (_loc7_ = li32(_loc6_)) + -16843009;
               _loc1_ = (_loc4_ = (_loc4_ = _loc7_ & -2139062144) ^ -2139062144) & _loc1_;
               if(_loc1_ == 0)
               {
                  continue;
               }
               if((_loc7_ & 255) == 0)
               {
                  _loc5_ = _loc6_ - _current_locale_string;
               }
               else if(li8(_loc6_ + 1) == 0)
               {
                  _loc5_ = _loc6_ + (1 - _current_locale_string);
               }
               else if(li8(_loc6_ + 2) == 0)
               {
                  _loc5_ = _loc6_ + (2 - _current_locale_string);
               }
               else
               {
                  if(li8(_loc6_ + 3) != 0)
                  {
                     continue;
                  }
                  _loc5_ = _loc6_ + (3 - _current_locale_string);
               }
               §§goto(addr494);
            }
         }
         while(true)
         {
            _loc1_ = (_loc7_ = li32(_loc6_)) + -16843009;
            _loc1_ = (_loc4_ = (_loc4_ = _loc7_ & -2139062144) ^ -2139062144) & _loc1_;
            if(_loc1_ == 0)
            {
               continue;
            }
            if((_loc7_ & 255) == 0)
            {
               _loc5_ = _loc6_ - _current_locale_string;
            }
            else if(li8(_loc6_ + 1) == 0)
            {
               _loc5_ = _loc6_ + (1 - _current_locale_string);
            }
            else if(li8(_loc6_ + 2) == 0)
            {
               _loc5_ = _loc6_ + (2 - _current_locale_string);
            }
            else
            {
               if(li8(_loc6_ + 3) != 0)
               {
                  continue;
               }
               _loc5_ = _loc6_ + (3 - _current_locale_string);
            }
            §§goto(addr270);
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
