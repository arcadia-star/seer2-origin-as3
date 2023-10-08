package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_extent_tree_szad_remove() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc10_:* = 0;
      var _loc12_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 24;
      _loc1_ = li32(_dss_chunks_szad);
      si32(_loc1_,_loc3_ - 24);
      _loc13_ = (_loc14_ = _loc3_ - 24) | 4;
      var _loc11_:*;
      si32(_loc11_ = (_loc12_ = _dss_chunks_szad + 4) & -2,_loc13_);
      _loc10_ = li32(_loc1_ + 20);
      _loc8_ = li32((_loc9_ = li32(_loc3_)) + 20);
      _loc6_ = _loc7_ = 1;
      if(uint(_loc8_) >= uint(_loc10_))
      {
         _loc6_ = 0;
      }
      if(uint(_loc8_) <= uint(_loc10_))
      {
         _loc7_ = 0;
      }
      _loc11_ = _loc6_ & 1;
      _loc6_ = (_loc13_ = _loc7_ & 1) - _loc11_;
      if(_loc8_ == _loc10_)
      {
         _loc7_ = li32(_loc1_ + 16);
         _loc8_ = li32(_loc9_ + 16);
         _loc10_ = _loc6_ = 1;
         if(uint(_loc8_) >= uint(_loc7_))
         {
            _loc10_ = 0;
         }
         if(uint(_loc8_) <= uint(_loc7_))
         {
            _loc6_ = 0;
         }
         _loc11_ = _loc10_ & 1;
         _loc6_ = (_loc13_ = _loc6_ & 1) - _loc11_;
      }
      if(_loc6_ <= -1)
      {
         _loc12_ = _dss_chunks_szad + 4;
         _loc14_ = _loc1_;
         if(((_loc8_ = li32((_loc10_ = li32(_loc1_)) + 4)) & 1) == 0)
         {
            _loc14_ = _loc1_;
            if(((_loc11_ = li8((_loc11_ = li32(_loc10_)) + 4)) & 1) == 0)
            {
               si32(_loc11_ = _loc8_ | 1,_loc10_ + 4);
               if((_loc11_ = (_loc8_ = li32((_loc14_ = li32(_loc10_ = (_loc12_ = li32(_loc1_ + 4)) & -2)) + 4)) & 1) != 0)
               {
                  si32(_loc11_ = _loc8_ & -2,_loc10_);
                  si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc14_ + 4)) & 1) | _loc10_,_loc14_ + 4);
                  si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc1_ + 4)) & 1) | _loc14_,_loc1_ + 4);
                  si32(_loc11_ = _loc11_ & 1 | li32(_loc10_ = _loc14_ & -2),_loc1_ + 4);
                  si32(_loc1_,_loc10_);
                  if((_loc11_ = (_loc12_ = li32((_loc14_ = (_loc11_ = li32(_loc1_ + 4)) & -2) + 4)) & 1) != 0)
                  {
                     si32(_loc11_ = _loc12_ & -2,_loc14_ + 4);
                     si32(_loc13_ = (_loc11_ = li32(_loc1_ + 4)) | 1,_loc1_ + 4);
                     si32(_loc13_ = (_loc13_ = li32(_loc11_ &= -2)) | 1,_loc1_ + 4);
                     si32(_loc1_,_loc11_);
                     si32(_loc11_,_loc10_);
                  }
                  else
                  {
                     si32(_loc14_,_loc1_ + 4);
                  }
               }
               else
               {
                  si32(_loc11_ = _loc12_ | 1,_loc1_ + 4);
                  si32(_loc11_ = (_loc11_ = li32(_loc10_)) | 1,_loc1_ + 4);
                  si32(_loc1_,_loc10_);
               }
               si32(_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & -2,_loc10_ + 4);
               si32(_loc10_,_loc3_ - 24);
               _loc14_ = _loc3_ - 24;
            }
            §§goto(addr1052);
         }
      }
      else
      {
         if(_loc6_ != 0)
         {
            _loc10_ = _loc1_;
            if(_loc6_ == 1)
            {
               _loc8_ = _loc1_ + 4;
               addr582:
               _loc11_ = (_loc11_ = li8((_loc11_ = li32(_loc10_ = (_loc6_ = li32(_loc8_)) & -2)) + 4)) & 1;
               _loc14_ = _loc1_;
               if(_loc11_ == 0)
               {
                  if((_loc11_ = (_loc10_ = li32((_loc14_ = li32(_loc1_)) + 4)) & 1) != 0)
                  {
                     if((_loc11_ = (_loc11_ = li8((_loc10_ = li32(_loc7_ = _loc10_ & -2)) + 4)) & 1) != 0)
                     {
                        si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc7_ + 4)) & -2) | _loc6_ & 1,_loc7_ + 4);
                        si32(_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & -2,_loc10_ + 4);
                        si32(_loc11_ = (_loc13_ = li32(_loc10_ = _loc13_ & -2)) | (_loc13_ = li32(_loc14_ + 4)) & 1,_loc14_ + 4);
                        si32(_loc14_,_loc10_);
                        si32(_loc10_,_loc1_);
                        si32(_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & -2,_loc1_);
                        si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & 1) | _loc1_,_loc10_ + 4);
                        var _loc4_:*;
                        si32(_loc13_ = (_loc4_ = li32(_loc11_ &= -2)) | (_loc11_ = li32(_loc8_)) & 1,_loc8_);
                        si32(_loc1_,_loc11_);
                        si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc10_ + 4)) & 1) | _loc11_,_loc10_ + 4);
                     }
                     else
                     {
                        si32(_loc11_ = _loc7_ | _loc6_ & 1,_loc14_ + 4);
                        si32(_loc11_ = (_loc11_ = li32(_loc7_ + 4)) | 1,_loc7_ + 4);
                        si32(_loc11_ = (_loc11_ = li32((_loc10_ = li32(_loc1_)) + 4)) & -2,_loc1_);
                        si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & 1) | _loc1_,_loc10_ + 4);
                        si32(_loc13_ = (_loc4_ = li32(_loc11_ &= -2)) | (_loc11_ = li32(_loc8_)) & 1,_loc8_);
                        si32(_loc1_,_loc11_);
                        si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc10_ + 4)) & 1) | _loc11_,_loc10_ + 4);
                     }
                     si32(_loc11_ = (_loc11_ = li32(_loc8_)) | 1,_loc8_);
                  }
                  else
                  {
                     si32(_loc11_ = _loc6_ | 1,_loc8_);
                     if((_loc11_ = (_loc10_ = li32((_loc6_ = li32(_loc14_)) + 4)) & 1) != 0)
                     {
                        si32(_loc11_ = _loc10_ & -2,_loc6_ + 4);
                        si32(_loc11_ = (_loc11_ = li32((_loc10_ = li32(_loc1_)) + 4)) & -2,_loc1_);
                        si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc10_ + 4)) & 1) | _loc1_,_loc10_ + 4);
                        si32(_loc13_ = (_loc4_ = li32(_loc11_ &= -2)) | (_loc11_ = li32(_loc8_)) & 1,_loc8_);
                        si32(_loc1_,_loc11_);
                        si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc10_ + 4)) & 1) | _loc11_,_loc10_ + 4);
                     }
                     else
                     {
                        si32(_loc11_ = (_loc11_ = li32(_loc14_ + 4)) | 1,_loc14_ + 4);
                        si32(_loc11_ = (_loc13_ = li32(_loc10_ = _loc13_ & -2)) | (_loc13_ = li32(_loc8_)) & 1,_loc8_);
                        si32(_loc1_,_loc10_);
                     }
                  }
                  si32(_loc10_,_loc3_ - 24);
                  _loc14_ = _loc3_ - 24;
               }
               §§goto(addr1061);
            }
            else
            {
               §§goto(addr1052);
            }
         }
         else
         {
            _loc8_ = _loc1_ + 4;
            _loc10_ = _dss_chunks_szad + 4;
            _loc12_ = _loc3_ - 24;
            if(((_loc11_ = li32(_loc1_ + 4)) & -2) == _loc10_)
            {
               _loc14_ = li32(_loc1_);
               _loc12_ = _loc10_;
               if(_loc14_ != _loc10_)
               {
                  si32(_loc11_ = (_loc11_ = li32(_loc14_ + 4)) & -2,_loc1_);
                  si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc14_ + 4)) & 1) | _loc1_,_loc14_ + 4);
                  si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc1_ + 4)) & 1) | _loc1_ & -2,_loc14_ + 4);
                  si32(_loc11_ = (_loc11_ = li32(_loc1_ + 4)) | 1,_loc1_ + 4);
                  si32(_loc11_ = (_loc13_ = (_loc13_ = li32(_loc14_ + 4)) & 1) | _dss_chunks_szad + 4,_loc14_ + 4);
                  _loc12_ = _loc14_;
               }
               si32(_loc12_,_loc3_ - 24);
               _loc14_ = _loc3_ - 24;
               _loc12_ = _loc10_;
               _loc10_ = _loc1_;
               if(_loc6_ == 1)
               {
                  §§goto(addr582);
               }
               else
               {
                  §§goto(addr1052);
               }
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
         }
         §§goto(addr582);
      }
      §§goto(addr1061);
   }
}
