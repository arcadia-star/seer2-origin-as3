package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_extent_tree_ad_remove() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc16_:* = 0;
      var _loc13_:* = 0;
      var _loc5_:int = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc15_:int = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 24;
      _loc3_ = li32(_loc4_);
      si32(_loc16_ = li32(_loc3_),_loc4_ - 16);
      var _loc14_:*;
      si32(_loc14_ = (_loc15_ = _loc3_ + 4) & -2,_loc4_ - 12);
      _loc13_ = li32(_loc16_ + 16);
      _loc11_ = li32((_loc12_ = li32(_loc4_ + 4)) + 16);
      _loc9_ = _loc10_ = 1;
      if(uint(_loc11_) >= uint(_loc13_))
      {
         _loc9_ = 0;
      }
      if(uint(_loc11_) <= uint(_loc13_))
      {
         _loc10_ = 0;
      }
      _loc14_ = _loc9_ & 1;
      var _loc1_:* = _loc10_ & 1;
      if((_loc5_ = _loc1_ - _loc14_) <= -1)
      {
         _loc9_ = _loc15_;
         _loc10_ = _loc16_;
         if(((_loc7_ = li32((_loc6_ = li32(_loc16_ + 8)) + 12)) & 1) == 0)
         {
            _loc10_ = _loc16_;
            if(((_loc14_ = li8((_loc14_ = li32(_loc6_ + 8)) + 12)) & 1) == 0)
            {
               si32(_loc14_ = _loc7_ | 1,_loc6_ + 12);
               if((_loc14_ = (_loc7_ = li32((_loc10_ = li32((_loc6_ = (_loc9_ = li32(_loc16_ + 12)) & -2) + 8)) + 12)) & 1) != 0)
               {
                  si32(_loc14_ = _loc7_ & -2,_loc6_ + 8);
                  si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc10_ + 12)) & 1) | _loc6_,_loc10_ + 12);
                  si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc16_ + 12)) & 1) | _loc10_,_loc16_ + 12);
                  si32(_loc14_ = _loc14_ & 1 | li32((_loc6_ = _loc10_ & -2) + 8),_loc16_ + 12);
                  si32(_loc16_,_loc6_ + 8);
                  if((_loc14_ = (_loc10_ = li32((_loc9_ = (_loc14_ = li32(_loc16_ + 12)) & -2) + 12)) & 1) != 0)
                  {
                     si32(_loc14_ = _loc10_ & -2,_loc9_ + 12);
                     si32(_loc14_ = li32(_loc16_ + 12) | 1,_loc16_ + 12);
                     si32(li32((_loc14_ = li32(_loc16_ + 12) & -2) + 8) | 1,_loc16_ + 12);
                     si32(_loc16_,_loc14_ + 8);
                     si32(_loc14_,_loc6_ + 8);
                  }
                  else
                  {
                     si32(_loc9_,_loc16_ + 12);
                  }
               }
               else
               {
                  si32(_loc14_ = _loc9_ | 1,_loc16_ + 12);
                  si32(_loc14_ = (_loc14_ = li32(_loc6_ + 8)) | 1,_loc16_ + 12);
                  si32(_loc16_,_loc6_ + 8);
               }
               si32(_loc14_ = (_loc14_ = li32(_loc6_ + 12)) & -2,_loc6_ + 12);
               si32(_loc6_,_loc4_ - 16);
               _loc10_ = _loc4_ - 24;
            }
            §§goto(addr1027);
         }
      }
      else
      {
         if(_loc5_ != 0)
         {
            _loc10_ = _loc4_ - 24;
            _loc6_ = _loc16_;
            if(_loc5_ == 1)
            {
               _loc7_ = _loc16_ + 12;
               _loc9_ = _loc15_;
               addr545:
               _loc14_ = (_loc14_ = li8((_loc14_ = li32((_loc6_ = (_loc11_ = li32(_loc7_)) & -2) + 8)) + 12)) & 1;
               _loc10_ = _loc16_;
               if(_loc14_ == 0)
               {
                  if((_loc14_ = (_loc6_ = li32((_loc10_ = li32(_loc16_ + 8)) + 12)) & 1) != 0)
                  {
                     if((_loc14_ = (_loc14_ = li8((_loc13_ = li32((_loc6_ &= -2) + 8)) + 12)) & 1) != 0)
                     {
                        si32(_loc14_ = li32(_loc6_ + 12) & -2 | _loc11_ & 1,_loc6_ + 12);
                        si32(_loc14_ = (_loc14_ = li32(_loc13_ + 12)) & -2,_loc13_ + 12);
                        _loc14_ = li32(_loc10_ + 12) & 1;
                        si32(_loc14_ = li32((_loc6_ = li32(_loc10_ + 12) & -2) + 8) | _loc14_,_loc10_ + 12);
                        si32(_loc10_,_loc6_ + 8);
                        si32(_loc6_,_loc16_ + 8);
                        si32(_loc14_ = (_loc14_ = li32(_loc6_ + 12)) & -2,_loc16_ + 8);
                        si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc6_ + 12)) & 1) | _loc16_,_loc6_ + 12);
                        var _loc8_:*;
                        si32((_loc8_ = li32((_loc14_ &= -2) + 8)) | (_loc14_ = li32(_loc7_)) & 1,_loc7_);
                        si32(_loc16_,_loc14_ + 8);
                        si32(_loc14_ = li32(_loc6_ + 12) & 1 | _loc14_,_loc6_ + 12);
                     }
                     else
                     {
                        si32(_loc14_ = _loc6_ | _loc11_ & 1,_loc10_ + 12);
                        si32(_loc14_ = (_loc14_ = li32(_loc6_ + 12)) | 1,_loc6_ + 12);
                        si32(_loc14_ = (_loc14_ = li32((_loc6_ = li32(_loc16_ + 8)) + 12)) & -2,_loc16_ + 8);
                        si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc6_ + 12)) & 1) | _loc16_,_loc6_ + 12);
                        si32((_loc8_ = li32((_loc14_ &= -2) + 8)) | (_loc14_ = li32(_loc7_)) & 1,_loc7_);
                        si32(_loc16_,_loc14_ + 8);
                        si32(_loc14_ = li32(_loc6_ + 12) & 1 | _loc14_,_loc6_ + 12);
                     }
                     si32(_loc14_ = (_loc14_ = li32(_loc7_)) | 1,_loc7_);
                  }
                  else
                  {
                     si32(_loc14_ = _loc11_ | 1,_loc7_);
                     if((_loc14_ = (_loc11_ = li32((_loc6_ = li32(_loc10_ + 8)) + 12)) & 1) != 0)
                     {
                        si32(_loc14_ = _loc11_ & -2,_loc6_ + 12);
                        si32(_loc14_ = (_loc14_ = li32((_loc6_ = li32(_loc16_ + 8)) + 12)) & -2,_loc16_ + 8);
                        si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc6_ + 12)) & 1) | _loc16_,_loc6_ + 12);
                        si32((_loc8_ = li32((_loc14_ &= -2) + 8)) | (_loc14_ = li32(_loc7_)) & 1,_loc7_);
                        si32(_loc16_,_loc14_ + 8);
                        si32(_loc14_ = li32(_loc6_ + 12) & 1 | _loc14_,_loc6_ + 12);
                     }
                     else
                     {
                        si32(_loc14_ = (_loc14_ = li32(_loc10_ + 12)) | 1,_loc10_ + 12);
                        _loc14_ = li32(_loc7_) & 1;
                        si32(_loc14_ = li32((_loc6_ = li32(_loc7_) & -2) + 8) | _loc14_,_loc7_);
                        si32(_loc16_,_loc6_ + 8);
                     }
                  }
                  si32(_loc6_,_loc4_ - 16);
                  _loc10_ = _loc4_ - 24;
               }
               §§goto(addr1033);
            }
            else
            {
               §§goto(addr1027);
            }
         }
         else
         {
            _loc7_ = _loc16_ + 12;
            _loc9_ = _loc4_ - 24;
            if(((_loc14_ = li32(_loc16_ + 12)) & -2) == _loc15_)
            {
               _loc9_ = li32(_loc16_ + 8);
               _loc10_ = _loc15_;
               if(_loc9_ != _loc15_)
               {
                  si32(_loc14_ = (_loc14_ = li32(_loc9_ + 12)) & -2,_loc16_ + 8);
                  si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc9_ + 12)) & 1) | _loc16_,_loc9_ + 12);
                  si32(_loc14_ = li32(_loc16_ + 12) & 1 | _loc16_ & -2,_loc9_ + 12);
                  si32(_loc14_ = (_loc14_ = li32(_loc16_ + 12)) | 1,_loc16_ + 12);
                  si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc9_ + 12)) & 1) | _loc15_,_loc9_ + 12);
                  _loc10_ = _loc9_;
               }
               si32(_loc10_,_loc4_ - 16);
               _loc10_ = _loc4_ - 24;
               _loc9_ = _loc15_;
               _loc6_ = _loc16_;
               if(_loc5_ == 1)
               {
                  §§goto(addr545);
               }
               else
               {
                  §§goto(addr1027);
               }
               _loc2_ = _loc4_;
               ESP = _loc2_;
               return;
            }
         }
         §§goto(addr545);
      }
      §§goto(addr1033);
   }
}
