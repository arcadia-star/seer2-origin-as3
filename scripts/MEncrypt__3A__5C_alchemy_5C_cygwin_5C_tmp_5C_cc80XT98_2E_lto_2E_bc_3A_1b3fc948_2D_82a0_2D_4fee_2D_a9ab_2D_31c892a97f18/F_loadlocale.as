package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_loadlocale() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:int = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc11_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc12_ = _loc1_ << 5;
      _loc9_ = _loc10_ = li8(_loc11_ = _new_categories + _loc12_);
      if(_loc10_ == 46)
      {
         if((_loc7_ = li8((_loc8_ = _new_categories + _loc12_) + 1)) != 0)
         {
            _loc9_ = 46;
            if(_loc7_ == 46)
            {
               _loc9_ = _loc10_;
               if(li8(_loc8_ + 2) != 0)
               {
                  §§goto(addr76);
               }
            }
            §§goto(addr76);
         }
         §§goto(addr113);
      }
      addr76:
      _loc8_ = _current_categories + _loc12_;
      _loc10_ = _loc11_ + 1;
      while((_loc9_ &= 255) != 0)
      {
         if(_loc9_ == 47)
         {
            if(_loc10_ != 1)
            {
               addr113:
               ESP = _loc2_;
               F___error();
               var _loc6_:* = eax;
               si32(22,_loc6_);
               _loc9_ = 0;
               §§goto(addr400);
            }
            break;
         }
         _loc9_ = li8(_loc10_);
         _loc10_ += 1;
      }
      ESP = _loc2_;
      F___error();
      _loc10_ = li32(_loc6_ = eax);
      ESP = _loc2_;
      F___error();
      var _loc5_:int = eax;
      ESP = _loc2_;
      F___detect_path_locale();
      si32(_loc6_ = eax,_loc5_);
      ESP = _loc2_;
      F___error();
      _loc6_ = li32(_loc6_ = eax);
      _loc9_ = 0;
      if(_loc6_ == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(_loc10_,eax);
         if(_loc1_ <= 3)
         {
            if(_loc1_ != 1)
            {
               _loc10_ = ___wrap_setrunelocale;
               if(_loc1_ != 2)
               {
                  if(_loc1_ != 3)
                  {
                     addr259:
                     ESP = _loc2_;
                     F___error();
                     _loc6_ = eax;
                     si32(22,_loc6_);
                     _loc9_ = 0;
                     §§goto(addr400);
                  }
                  else
                  {
                     _loc10_ = ___monetary_load_locale;
                  }
                  §§goto(addr400);
               }
            }
            else
            {
               _loc10_ = ___collate_load_tables;
            }
         }
         else if(_loc1_ != 4)
         {
            if(_loc1_ != 5)
            {
               if(_loc1_ != 6)
               {
                  §§goto(addr259);
               }
               else
               {
                  _loc10_ = ___messages_load_locale;
               }
               §§goto(addr400);
            }
            else
            {
               _loc10_ = ___time_load_locale;
            }
         }
         else
         {
            _loc10_ = ___numeric_load_locale;
         }
         _loc7_ = _current_categories + _loc12_;
         _loc4_ = _loc11_;
         loop1:
         do
         {
            _loc1_ = li8(_loc4_);
            _loc6_ = li8(_loc7_);
            if(_loc1_ != _loc6_)
            {
               _loc2_ -= 16;
               si32(_loc11_,_loc2_);
               ESP = _loc2_;
               ptr2fun[_loc10_]();
               _loc9_ = 0;
               _loc2_ += 16;
               if((_loc6_ = eax) != -1)
               {
                  si8(_loc6_ = li8(_loc11_),_loc8_);
                  _loc9_ = _loc8_;
                  if(_loc6_ != 0)
                  {
                     _loc11_ = (_loc6_ = _current_categories + _loc12_) + 1;
                     _loc12_ = (_loc6_ = _new_categories + _loc12_) + 1;
                     while(true)
                     {
                        si8(_loc6_ = li8(_loc12_),_loc11_);
                        _loc11_ += 1;
                        _loc12_ += 1;
                        _loc9_ = _loc8_;
                        if(_loc6_ == 0)
                        {
                           break loop1;
                        }
                     }
                  }
                  break;
               }
               break;
            }
            _loc7_ += 1;
            _loc4_ += 1;
            _loc9_ = _loc8_;
         }
         while(_loc1_ != 0);
         
      }
      addr400:
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
