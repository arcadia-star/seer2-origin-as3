package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_extent_tree_szad_insert() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 24;
      _loc1_ = li32(_dss_chunks_szad);
      si32(_loc1_,_loc3_ - 24);
      _loc10_ = (_loc11_ = _loc3_ - 24) | 4;
      var _loc8_:*;
      si32(_loc8_ = (_loc9_ = _dss_chunks_szad + 4) & -2,_loc10_);
      _loc7_ = 0;
      _loc6_ = li32(_loc3_);
      while(true)
      {
         _loc5_ = _loc1_;
         _loc4_ = _loc11_;
         while(true)
         {
            _loc11_ = _dss_chunks_szad + 4;
            if(_loc5_ == _loc11_)
            {
               si32(_loc11_,_loc6_);
               si32(_loc10_ = _loc11_ | 1,_loc6_ + 4);
               if(_loc7_ >= 1)
               {
                  si32(_loc10_ = (_loc10_ = (_loc10_ = li32(_loc4_ + 4)) & 1) | _loc6_,_loc4_ + 4);
                  si32(_loc10_ = _loc10_ & 1 | li32(_loc6_ &= -2),_loc4_ + 4);
                  si32(_loc4_,_loc6_);
                  si32(_loc10_ = (_loc8_ = (_loc8_ = li32(_loc6_ + 4)) & -2) | (_loc10_ = li32(_loc4_ + 4)) & 1,_loc6_ + 4);
                  si32(_loc10_ = (_loc10_ = li32(_loc4_ + 4)) | 1,_loc4_ + 4);
                  if((_loc10_ = li32(_loc9_)) == _loc4_)
                  {
                     si32(_loc6_,_loc9_);
                  }
                  else if((_loc10_ = (_loc5_ = li32(_loc9_ + 4)) & -2) == _loc4_)
                  {
                     si32(_loc10_ = (_loc10_ = _loc5_ & 1) | _loc6_,_loc9_ + 4);
                  }
               }
               else
               {
                  si32(_loc6_,_loc4_);
               }
               si32(_loc10_ = li32(_loc3_ - 24),_dss_chunks_szad);
               si32(_loc8_ = (_loc8_ = li32(_loc10_ + 4)) & -2,_loc10_ + 4);
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
            if((_loc10_ = (_loc7_ = li32((_loc11_ = li32(_loc5_)) + 4)) & 1) == 0)
            {
               break;
            }
            if((_loc10_ = (_loc10_ = li8((_loc10_ = li32(_loc11_)) + 4)) & 1) == 0)
            {
               break;
            }
            si32(_loc10_ = _loc7_ & -2,_loc5_);
            si32(_loc10_ = (_loc10_ = (_loc10_ = li32(_loc11_ + 4)) & 1) | _loc5_,_loc11_ + 4);
            _loc10_ = li32(_loc11_);
            si32(_loc8_ = (_loc8_ = li32(_loc10_ + 4)) & -2,_loc10_ + 4);
            if((_loc10_ = li32(_loc4_)) == _loc5_)
            {
               si32(_loc11_,_loc4_);
               _loc5_ = _loc11_;
               break;
            }
            si32(_loc10_ = (_loc10_ = (_loc10_ = li32(_loc4_ + 4)) & 1) | _loc11_,_loc4_ + 4);
            si32(_loc10_ = _loc10_ & 1 | li32(_loc11_ &= -2),_loc4_ + 4);
            si32(_loc4_,_loc11_);
            si32(_loc10_ = (_loc8_ = (_loc8_ = li32(_loc11_ + 4)) & -2) | (_loc10_ = li32(_loc4_ + 4)) & 1,_loc11_ + 4);
            si32(_loc10_ = (_loc10_ = li32(_loc4_ + 4)) | 1,_loc4_ + 4);
            if((_loc10_ = li32(_loc9_)) == _loc4_)
            {
               si32(_loc11_,_loc9_);
            }
            else
            {
               si32(_loc10_ = (_loc10_ = (_loc10_ = li32(_loc9_ + 4)) & 1) | _loc11_,_loc9_ + 4);
            }
            _loc4_ = li32(_loc11_ + 20);
            _loc5_ = li32(_loc6_ + 20);
            _loc1_ = 1;
            _loc7_ = _loc1_;
            if(uint(_loc5_) >= uint(_loc4_))
            {
               _loc7_ = 0;
            }
            if(uint(_loc5_) <= uint(_loc4_))
            {
               _loc1_ = 0;
            }
            _loc10_ = _loc7_ & 1;
            _loc7_ = (_loc8_ = _loc1_ & 1) - _loc10_;
            if(_loc5_ == _loc4_)
            {
               _loc4_ = li32(_loc11_ + 16);
               _loc5_ = li32(_loc6_ + 16);
               _loc1_ = 1;
               _loc7_ = _loc1_;
               if(uint(_loc5_) >= uint(_loc4_))
               {
                  _loc7_ = 0;
               }
               if(uint(_loc5_) <= uint(_loc4_))
               {
                  _loc1_ = 0;
               }
               _loc8_ = _loc7_ & 1;
               _loc7_ = (_loc10_ = _loc1_ & 1) - _loc8_;
            }
            if(_loc7_ <= -1)
            {
               _loc5_ = li32(_loc11_);
               _loc4_ = _loc11_;
            }
            else
            {
               _loc5_ = (_loc10_ = li32(_loc11_ + 4)) & -2;
               _loc4_ = _loc11_;
            }
         }
         _loc11_ = li32(_loc5_ + 20);
         _loc9_ = li32(_loc6_ + 20);
         _loc1_ = _loc7_ = 1;
         if(uint(_loc9_) >= uint(_loc11_))
         {
            _loc1_ = 0;
         }
         if(uint(_loc9_) <= uint(_loc11_))
         {
            _loc7_ = 0;
         }
         _loc10_ = _loc1_ & 1;
         _loc7_ = (_loc8_ = _loc7_ & 1) - _loc10_;
         if(_loc9_ == _loc11_)
         {
            _loc9_ = li32(_loc5_ + 16);
            _loc11_ = li32(_loc6_ + 16);
            _loc1_ = 1;
            _loc7_ = _loc1_;
            if(uint(_loc11_) >= uint(_loc9_))
            {
               _loc7_ = 0;
            }
            if(uint(_loc11_) <= uint(_loc9_))
            {
               _loc1_ = 0;
            }
            _loc10_ = _loc7_ & 1;
            _loc7_ = (_loc8_ = _loc1_ & 1) - _loc10_;
         }
         if(_loc7_ <= -1)
         {
            _loc1_ = li32(_loc5_);
            _loc11_ = _loc5_;
            _loc9_ = _loc4_;
         }
         else
         {
            _loc1_ = (_loc10_ = li32(_loc5_ + 4)) & -2;
            _loc11_ = _loc5_;
            _loc9_ = _loc4_;
         }
      }
   }
}
