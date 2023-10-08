package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_extent_tree_ad_insert() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc12_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc10_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 24;
      _loc1_ = li32(_loc3_);
      si32(_loc13_ = li32(_loc1_),_loc3_ - 16);
      var _loc11_:*;
      si32(_loc11_ = (_loc12_ = _loc1_ + 4) & -2,_loc3_ - 12);
      _loc10_ = 0;
      _loc9_ = _loc3_ - 24;
      _loc8_ = li32(_loc3_ + 4);
      _loc7_ = _loc12_;
      while(true)
      {
         _loc6_ = _loc13_;
         _loc4_ = _loc9_;
         while(true)
         {
            if(_loc12_ == _loc6_)
            {
               si32(_loc12_,_loc8_ + 8);
               si32(_loc11_ = _loc12_ | 1,_loc8_ + 12);
               if(_loc10_ >= 1)
               {
                  si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc4_ + 12)) & 1) | _loc8_,_loc4_ + 12);
                  si32(_loc11_ = _loc11_ & 1 | li32((_loc8_ &= -2) + 8),_loc4_ + 12);
                  si32(_loc4_,_loc8_ + 8);
                  var _loc5_:*;
                  si32(_loc11_ = (_loc5_ = (_loc5_ = li32(_loc8_ + 12)) & -2) | (_loc11_ = li32(_loc4_ + 12)) & 1,_loc8_ + 12);
                  si32(_loc11_ = (_loc11_ = li32(_loc4_ + 12)) | 1,_loc4_ + 12);
                  if((_loc11_ = li32(_loc7_ + 8)) == _loc4_)
                  {
                     si32(_loc8_,_loc7_ + 8);
                  }
                  else if((_loc11_ = (_loc12_ = li32(_loc7_ + 12)) & -2) == _loc4_)
                  {
                     si32(_loc11_ = (_loc11_ = _loc12_ & 1) | _loc8_,_loc7_ + 12);
                  }
               }
               else
               {
                  si32(_loc8_,_loc4_ + 8);
               }
               si32(_loc11_ = li32(_loc3_ - 16),_loc1_);
               si32(_loc5_ = (_loc5_ = li32(_loc11_ + 12)) & -2,_loc11_ + 12);
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
            if((_loc11_ = (_loc9_ = li32((_loc10_ = li32(_loc6_ + 8)) + 12)) & 1) == 0)
            {
               break;
            }
            if((_loc11_ = (_loc11_ = li8((_loc11_ = li32(_loc10_ + 8)) + 12)) & 1) == 0)
            {
               break;
            }
            si32(_loc11_ = _loc9_ & -2,_loc6_ + 8);
            si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc10_ + 12)) & 1) | _loc6_,_loc10_ + 12);
            _loc11_ = li32(_loc10_ + 8);
            si32(_loc5_ = (_loc5_ = li32(_loc11_ + 12)) & -2,_loc11_ + 12);
            if((_loc11_ = li32(_loc4_ + 8)) == _loc6_)
            {
               si32(_loc10_,_loc4_ + 8);
               _loc6_ = _loc10_;
               break;
            }
            si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc4_ + 12)) & 1) | _loc10_,_loc4_ + 12);
            si32(_loc11_ = _loc11_ & 1 | li32((_loc9_ = _loc10_ & -2) + 8),_loc4_ + 12);
            si32(_loc4_,_loc9_ + 8);
            si32(_loc11_ = (_loc5_ = (_loc5_ = li32(_loc9_ + 12)) & -2) | (_loc11_ = li32(_loc4_ + 12)) & 1,_loc9_ + 12);
            si32(_loc11_ = (_loc11_ = li32(_loc4_ + 12)) | 1,_loc4_ + 12);
            if((_loc11_ = li32(_loc7_ + 8)) == _loc4_)
            {
               si32(_loc9_,_loc7_ + 8);
            }
            else
            {
               si32(_loc11_ = (_loc11_ = (_loc11_ = li32(_loc7_ + 12)) & 1) | _loc9_,_loc7_ + 12);
            }
            _loc4_ = li32(_loc9_ + 16);
            _loc6_ = li32(_loc8_ + 16);
            _loc10_ = _loc13_ = 1;
            if(uint(_loc6_) >= uint(_loc4_))
            {
               _loc10_ = 0;
            }
            if(uint(_loc6_) <= uint(_loc4_))
            {
               _loc13_ = 0;
            }
            _loc5_ = _loc10_ & 1;
            if((_loc10_ = (_loc11_ = _loc13_ & 1) - _loc5_) <= -1)
            {
               _loc6_ = li32(_loc9_ + 8);
               _loc4_ = _loc9_;
            }
            else
            {
               _loc6_ = (_loc11_ = li32(_loc9_ + 12)) & -2;
               _loc4_ = _loc9_;
            }
         }
         _loc10_ = li32(_loc6_ + 16);
         _loc13_ = li32(_loc8_ + 16);
         _loc9_ = _loc7_ = 1;
         if(uint(_loc13_) >= uint(_loc10_))
         {
            _loc9_ = 0;
         }
         if(uint(_loc13_) <= uint(_loc10_))
         {
            _loc7_ = 0;
         }
         _loc5_ = _loc9_ & 1;
         if((_loc10_ = (_loc11_ = _loc7_ & 1) - _loc5_) <= -1)
         {
            _loc13_ = li32(_loc6_ + 8);
            _loc9_ = _loc6_;
            _loc7_ = _loc4_;
         }
         else
         {
            _loc13_ = (_loc11_ = li32(_loc6_ + 12)) & -2;
            _loc9_ = _loc6_;
            _loc7_ = _loc4_;
         }
      }
   }
}
