package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_arena_avail_tree_remove() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc16_:* = 0;
      var _loc14_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:int = 0;
      var _loc13_:int = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 16;
      _loc3_ = li32(_loc4_);
      si32(_loc16_ = li32(_loc3_),_loc4_ - 16);
      _loc14_ = (_loc15_ = _loc4_ - 16) | 4;
      var _loc12_:*;
      si32(_loc12_ = (_loc13_ = _loc3_ + 4) & -2,_loc14_);
      _loc11_ = (_loc12_ = li32(_loc16_ + 8)) & -4096;
      _loc1_ = (_loc9_ = li32((_loc10_ = li32(_loc4_ + 4)) + 8)) & -4096;
      _loc6_ = _loc5_ = 1;
      if(uint(_loc1_) >= uint(_loc11_))
      {
         _loc6_ = 0;
      }
      if(uint(_loc1_) <= uint(_loc11_))
      {
         _loc5_ = 0;
      }
      _loc14_ = _loc6_ & 1;
      _loc6_ = (_loc12_ = _loc5_ & 1) - _loc14_;
      if(_loc1_ == _loc11_)
      {
         _loc6_ = 0;
         if((_loc9_ & 16) == 0)
         {
            _loc6_ = _loc10_;
         }
         _loc1_ = _loc11_ = 1;
         if(uint(_loc6_) >= uint(_loc16_))
         {
            _loc1_ = 0;
         }
         if(uint(_loc6_) <= uint(_loc16_))
         {
            _loc11_ = 0;
         }
         _loc14_ = _loc1_ & 1;
         _loc6_ = (_loc12_ = _loc11_ & 1) - _loc14_;
      }
      if(_loc6_ <= -1)
      {
         _loc1_ = li32(_loc16_);
         _loc11_ = _loc13_;
         _loc15_ = _loc16_;
         if(((_loc9_ = li32(_loc1_ + 4)) & 1) == 0)
         {
            _loc15_ = _loc16_;
            if(((_loc12_ = li8((_loc12_ = li32(_loc1_)) + 4)) & 1) == 0)
            {
               si32(_loc12_ = _loc9_ | 1,_loc1_ + 4);
               _loc1_ = (_loc9_ = li32(_loc16_ + 4)) & -2;
               if((_loc12_ = (_loc15_ = li32((_loc11_ = li32(_loc1_)) + 4)) & 1) != 0)
               {
                  si32(_loc12_ = _loc15_ & -2,_loc1_);
                  si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc11_ + 4)) & 1) | _loc1_,_loc11_ + 4);
                  si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc16_ + 4)) & 1) | _loc11_,_loc16_ + 4);
                  _loc1_ = _loc11_ & -2;
                  si32(_loc12_ = _loc12_ & 1 | li32(_loc1_),_loc16_ + 4);
                  si32(_loc16_,_loc1_);
                  if((_loc12_ = (_loc11_ = li32((_loc15_ = (_loc12_ = li32(_loc16_ + 4)) & -2) + 4)) & 1) != 0)
                  {
                     si32(_loc12_ = _loc11_ & -2,_loc15_ + 4);
                     si32(_loc14_ = (_loc12_ = li32(_loc16_ + 4)) | 1,_loc16_ + 4);
                     si32(_loc14_ = (_loc14_ = li32(_loc12_ &= -2)) | 1,_loc16_ + 4);
                     si32(_loc16_,_loc12_);
                     si32(_loc12_,_loc1_);
                  }
                  else
                  {
                     si32(_loc15_,_loc16_ + 4);
                  }
               }
               else
               {
                  si32(_loc12_ = _loc9_ | 1,_loc16_ + 4);
                  si32(_loc12_ = (_loc12_ = li32(_loc1_)) | 1,_loc16_ + 4);
                  si32(_loc16_,_loc1_);
               }
               si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & -2,_loc1_ + 4);
               si32(_loc1_,_loc4_ - 16);
               _loc15_ = _loc4_ - 16;
            }
            §§goto(addr1060);
         }
      }
      else
      {
         if(_loc6_ != 0)
         {
            _loc1_ = _loc16_;
            if(_loc6_ == 1)
            {
               _loc9_ = _loc16_ + 4;
               _loc11_ = _loc13_;
               addr590:
               _loc1_ = (_loc6_ = li32(_loc9_)) & -2;
               _loc12_ = (_loc12_ = li8((_loc12_ = li32(_loc1_)) + 4)) & 1;
               _loc15_ = _loc16_;
               if(_loc12_ == 0)
               {
                  _loc1_ = li32((_loc15_ = li32(_loc16_)) + 4);
                  if((_loc12_ = _loc1_ & 1) != 0)
                  {
                     _loc1_ = li32(_loc5_ = _loc1_ & -2);
                     if((_loc12_ = (_loc12_ = li8(_loc1_ + 4)) & 1) != 0)
                     {
                        si32(_loc12_ = (_loc14_ = (_loc14_ = li32(_loc5_ + 4)) & -2) | _loc6_ & 1,_loc5_ + 4);
                        si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & -2,_loc1_ + 4);
                        _loc1_ = _loc14_ & -2;
                        si32(_loc12_ = (_loc14_ = li32(_loc1_)) | (_loc14_ = li32(_loc15_ + 4)) & 1,_loc15_ + 4);
                        si32(_loc15_,_loc1_);
                        si32(_loc1_,_loc16_);
                        si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & -2,_loc16_);
                        si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & 1) | _loc16_,_loc1_ + 4);
                        var _loc7_:*;
                        si32(_loc14_ = (_loc7_ = li32(_loc12_ &= -2)) | (_loc12_ = li32(_loc9_)) & 1,_loc9_);
                        si32(_loc16_,_loc12_);
                        si32(_loc12_ = (_loc14_ = (_loc14_ = li32(_loc1_ + 4)) & 1) | _loc12_,_loc1_ + 4);
                     }
                     else
                     {
                        si32(_loc12_ = _loc5_ | _loc6_ & 1,_loc15_ + 4);
                        si32(_loc12_ = (_loc12_ = li32(_loc5_ + 4)) | 1,_loc5_ + 4);
                        _loc1_ = li32(_loc16_);
                        si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & -2,_loc16_);
                        si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & 1) | _loc16_,_loc1_ + 4);
                        si32(_loc14_ = (_loc7_ = li32(_loc12_ &= -2)) | (_loc12_ = li32(_loc9_)) & 1,_loc9_);
                        si32(_loc16_,_loc12_);
                        si32(_loc12_ = (_loc14_ = (_loc14_ = li32(_loc1_ + 4)) & 1) | _loc12_,_loc1_ + 4);
                     }
                     si32(_loc12_ = (_loc12_ = li32(_loc9_)) | 1,_loc9_);
                  }
                  else
                  {
                     si32(_loc12_ = _loc6_ | 1,_loc9_);
                     _loc1_ = li32(_loc15_);
                     if((_loc12_ = (_loc6_ = li32(_loc1_ + 4)) & 1) != 0)
                     {
                        si32(_loc12_ = _loc6_ & -2,_loc1_ + 4);
                        _loc1_ = li32(_loc16_);
                        si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & -2,_loc16_);
                        si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc1_ + 4)) & 1) | _loc16_,_loc1_ + 4);
                        si32(_loc14_ = (_loc7_ = li32(_loc12_ &= -2)) | (_loc12_ = li32(_loc9_)) & 1,_loc9_);
                        si32(_loc16_,_loc12_);
                        si32(_loc12_ = (_loc14_ = (_loc14_ = li32(_loc1_ + 4)) & 1) | _loc12_,_loc1_ + 4);
                     }
                     else
                     {
                        si32(_loc12_ = (_loc12_ = li32(_loc15_ + 4)) | 1,_loc15_ + 4);
                        _loc1_ = _loc14_ & -2;
                        si32(_loc12_ = (_loc14_ = li32(_loc1_)) | (_loc14_ = li32(_loc9_)) & 1,_loc9_);
                        si32(_loc16_,_loc1_);
                     }
                  }
                  si32(_loc1_,_loc4_ - 16);
                  _loc15_ = _loc4_ - 16;
               }
               §§goto(addr1066);
            }
            else
            {
               §§goto(addr1060);
            }
         }
         else
         {
            _loc9_ = _loc16_ + 4;
            _loc11_ = _loc4_ - 16;
            if(((_loc12_ = li32(_loc16_ + 4)) & -2) == _loc13_)
            {
               _loc11_ = li32(_loc16_);
               _loc15_ = _loc13_;
               if(_loc11_ != _loc13_)
               {
                  si32(_loc12_ = (_loc12_ = li32(_loc11_ + 4)) & -2,_loc16_);
                  si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc11_ + 4)) & 1) | _loc16_,_loc11_ + 4);
                  si32(_loc12_ = (_loc14_ = (_loc14_ = li32(_loc16_ + 4)) & 1) | _loc16_ & -2,_loc11_ + 4);
                  si32(_loc12_ = (_loc12_ = li32(_loc16_ + 4)) | 1,_loc16_ + 4);
                  si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc11_ + 4)) & 1) | _loc13_,_loc11_ + 4);
                  _loc15_ = _loc11_;
               }
               si32(_loc15_,_loc4_ - 16);
               _loc15_ = _loc4_ - 16;
               _loc11_ = _loc13_;
               _loc1_ = _loc16_;
               if(_loc6_ == 1)
               {
                  §§goto(addr590);
               }
               else
               {
                  §§goto(addr1060);
               }
               _loc2_ = _loc4_;
               ESP = _loc2_;
               return;
            }
         }
         §§goto(addr590);
      }
      §§goto(addr1066);
   }
}
