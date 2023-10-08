package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F__write;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_wrtmessage() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc10_ = (_loc11_ = li32(_loc12_ = _loc1_ & -4)) + -16843009;
      _loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_;
      _loc9_ = li32(_loc3_ + 12);
      _loc8_ = li32(_loc3_ + 8);
      _loc7_ = li32(_loc3_ + 4);
      if(_loc10_ != 0)
      {
         _loc6_ = _loc12_ + 4;
         _loc5_ = 0;
         while(true)
         {
            if((uint(_loc4_ = _loc1_ + _loc5_)) < uint(_loc6_))
            {
               continue;
            }
         }
         addr224:
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 8);
         si32(_loc1_,_loc2_ + 4);
         si32(2,_loc2_);
         ESP = _loc2_;
         F__write();
         _loc2_ += 16;
         _loc10_ = (_loc11_ = li32(_loc4_ = _loc7_ & -4)) + -16843009;
         if((_loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_) != 0)
         {
            _loc6_ = _loc4_ + 4;
            _loc1_ = 0;
            while(true)
            {
               if((uint(_loc12_ = _loc7_ + _loc1_)) < uint(_loc6_))
               {
                  continue;
               }
            }
            addr431:
            _loc2_ -= 16;
            si32(_loc1_,_loc2_ + 8);
            si32(_loc7_,_loc2_ + 4);
            si32(2,_loc2_);
            ESP = _loc2_;
            F__write();
            _loc2_ += 16;
            _loc10_ = (_loc11_ = li32(_loc6_ = _loc8_ & -4)) + -16843009;
            if((_loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_) != 0)
            {
               _loc4_ = _loc6_ + 4;
               _loc7_ = 0;
               while(true)
               {
                  _loc1_ = _loc8_ + _loc7_;
                  if(uint(_loc1_) < uint(_loc4_))
                  {
                     continue;
                  }
               }
               addr638:
               _loc2_ -= 16;
               si32(_loc7_,_loc2_ + 8);
               si32(_loc8_,_loc2_ + 4);
               si32(2,_loc2_);
               ESP = _loc2_;
               F__write();
               _loc2_ += 16;
               _loc10_ = (_loc11_ = li32(_loc8_ = _loc9_ & -4)) + -16843009;
               if((_loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_) != 0)
               {
                  _loc4_ = _loc8_ + 4;
                  _loc7_ = 0;
                  while(true)
                  {
                     _loc1_ = _loc9_ + _loc7_;
                     if(uint(_loc1_) < uint(_loc4_))
                     {
                        continue;
                     }
                  }
                  §§goto(addr845);
               }
               _loc8_ += 4;
               while(true)
               {
                  _loc10_ = (_loc7_ = li32(_loc8_)) + -16843009;
                  if((_loc10_ = (_loc11_ = (_loc11_ = _loc7_ & -2139062144) ^ -2139062144) & _loc10_) != 0)
                  {
                     if((_loc10_ = _loc7_ & 255) == 0)
                     {
                        _loc7_ = _loc8_ - _loc9_;
                     }
                     else if((_loc10_ = li8(_loc8_ + 1)) == 0)
                     {
                        _loc7_ = (_loc10_ = 1 - _loc9_) + _loc8_;
                     }
                     else if((_loc10_ = li8(_loc8_ + 2)) == 0)
                     {
                        _loc7_ = (_loc10_ = 2 - _loc9_) + _loc8_;
                     }
                     else
                     {
                        if((_loc10_ = li8(_loc8_ + 3)) != 0)
                        {
                           continue;
                        }
                        _loc7_ = (_loc10_ = 3 - _loc9_) + _loc8_;
                     }
                     addr845:
                     _loc2_ -= 16;
                     si32(_loc7_,_loc2_ + 8);
                     si32(_loc9_,_loc2_ + 4);
                     si32(2,_loc2_);
                     ESP = _loc2_;
                  }
                  continue;
                  F__write();
                  _loc2_ += 16;
                  _loc2_ = _loc3_;
                  ESP = _loc2_;
                  return;
               }
            }
            _loc1_ = _loc6_ + 4;
            while(true)
            {
               _loc10_ = (_loc7_ = li32(_loc1_)) + -16843009;
               if((_loc10_ = (_loc11_ = (_loc11_ = _loc7_ & -2139062144) ^ -2139062144) & _loc10_) == 0)
               {
                  continue;
               }
               if((_loc10_ = _loc7_ & 255) == 0)
               {
                  _loc7_ = _loc1_ - _loc8_;
               }
               else if((_loc10_ = li8(_loc1_ + 1)) == 0)
               {
                  _loc7_ = (_loc10_ = 1 - _loc8_) + _loc1_;
               }
               else if((_loc10_ = li8(_loc1_ + 2)) == 0)
               {
                  _loc7_ = (_loc10_ = 2 - _loc8_) + _loc1_;
               }
               else
               {
                  if((_loc10_ = li8(_loc1_ + 3)) != 0)
                  {
                     continue;
                  }
                  _loc7_ = (_loc10_ = 3 - _loc8_) + _loc1_;
               }
               §§goto(addr638);
            }
         }
         _loc1_ = _loc4_ + 4;
         while(true)
         {
            _loc10_ = (_loc4_ = li32(_loc1_)) + -16843009;
            if((_loc10_ = (_loc11_ = (_loc11_ = _loc4_ & -2139062144) ^ -2139062144) & _loc10_) == 0)
            {
               continue;
            }
            if((_loc10_ = _loc4_ & 255) == 0)
            {
               _loc1_ -= _loc7_;
            }
            else if((_loc10_ = li8(_loc1_ + 1)) == 0)
            {
               _loc1_ = (_loc10_ = 1 - _loc7_) + _loc1_;
            }
            else if((_loc10_ = li8(_loc1_ + 2)) == 0)
            {
               _loc1_ = (_loc10_ = 2 - _loc7_) + _loc1_;
            }
            else
            {
               if((_loc10_ = li8(_loc1_ + 3)) != 0)
               {
                  continue;
               }
               _loc1_ = (_loc10_ = 3 - _loc7_) + _loc1_;
            }
            §§goto(addr431);
         }
      }
      _loc6_ = _loc12_ + 4;
      while(true)
      {
         _loc10_ = (_loc4_ = li32(_loc6_)) + -16843009;
         if((_loc10_ = (_loc11_ = (_loc11_ = _loc4_ & -2139062144) ^ -2139062144) & _loc10_) == 0)
         {
            continue;
         }
         if((_loc10_ = _loc4_ & 255) == 0)
         {
            _loc5_ = _loc6_ - _loc1_;
         }
         else if((_loc10_ = li8(_loc6_ + 1)) == 0)
         {
            _loc5_ = (_loc10_ = 1 - _loc1_) + _loc6_;
         }
         else if((_loc10_ = li8(_loc6_ + 2)) == 0)
         {
            _loc5_ = (_loc10_ = 2 - _loc1_) + _loc6_;
         }
         else
         {
            if((_loc10_ = li8(_loc6_ + 3)) != 0)
            {
               continue;
            }
            _loc5_ = (_loc10_ = 3 - _loc1_) + _loc6_;
         }
         §§goto(addr224);
      }
   }
}
