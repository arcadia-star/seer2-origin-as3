package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_gdb_printf() : void
   {
      var _loc3_:* = 0;
      var _loc7_:int = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc9_:* = 0;
      var _loc8_:int = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16880;
      _loc1_ = _loc3_ + 4;
      si32(_loc1_,_loc3_ - 16876);
      _loc2_ -= 16;
      si32(232,_loc2_ + 8);
      si32(_loc10_ = 0,_loc2_ + 4);
      si32(_loc9_ = _loc3_ - 232,_loc2_);
      ESP = _loc2_;
      Fmemset();
      _loc2_ += 16;
      si16(-1,_loc3_ - 218);
      si16(520,_loc3_ - 220);
      si32(_loc8_ = _loc3_ - 16872,_loc3_ - 232);
      si32(_loc8_,_loc3_ - 216);
      si32(16383,_loc3_ - 224);
      si32(16383,_loc3_ - 212);
      _loc2_ -= 16;
      si32(_loc1_,_loc2_ + 8);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_ + 4);
      si32(_loc9_,_loc2_);
      ESP = _loc2_;
      F___vfprintf();
      _loc2_ += 16;
      _loc7_ = eax;
      _loc9_ = li32(_loc3_ - 232);
      si8(_loc10_,_loc9_);
      si8(_loc10_,_loc3_ - 489);
      _loc1_ = li32(_loc6_ = _loc8_ & -4);
      _loc9_ = _loc1_ + -16843009;
      _loc1_ &= -2139062144;
      _loc1_ ^= -2139062144;
      if((_loc9_ = _loc1_ & _loc9_) != 0)
      {
         _loc5_ = _loc6_ + 4;
         while(true)
         {
            if((uint(_loc4_ = _loc8_ + _loc10_)) < uint(_loc5_))
            {
               continue;
            }
         }
         addr334:
         _loc2_ -= 16;
         si32(_loc10_,_loc2_ + 12);
         si32(_loc8_,_loc2_ + 8);
         si32(L__2E_str10,_loc2_ + 4);
         si32(_loc8_ = _loc3_ - 488,_loc2_);
         ESP = _loc2_;
         F_sprintf();
         _loc2_ += 16;
         ESP = _loc2_ & -16;
         _loc1_ = li32(_loc5_ = _loc8_ & -4);
         _loc9_ = _loc1_ + -16843009;
         _loc1_ &= -2139062144;
         _loc1_ ^= -2139062144;
         if((_loc9_ = _loc1_ & _loc9_) != 0)
         {
            _loc4_ = _loc5_ + 4;
            _loc6_ = 0;
            while(true)
            {
               if((uint(_loc10_ = _loc8_ + _loc6_)) < uint(_loc4_))
               {
                  continue;
               }
            }
            §§goto(addr555);
         }
         _loc4_ = _loc5_ + 4;
         while(true)
         {
            _loc9_ = (_loc10_ = li32(_loc4_)) + -16843009;
            _loc1_ = _loc10_ & -2139062144;
            _loc1_ ^= -2139062144;
            if((_loc9_ = _loc1_ & _loc9_) != 0)
            {
               if((_loc9_ = _loc10_ & 255) == 0)
               {
                  _loc6_ = _loc4_ - _loc8_;
               }
               else if((_loc9_ = li8(_loc4_ + 1)) == 0)
               {
                  _loc6_ = (_loc9_ = 1 - _loc8_) + _loc4_;
               }
               else if((_loc9_ = li8(_loc4_ + 2)) == 0)
               {
                  _loc6_ = (_loc9_ = 2 - _loc8_) + _loc4_;
               }
               else
               {
                  if((_loc9_ = li8(_loc4_ + 3)) != 0)
                  {
                     continue;
                  }
                  _loc6_ = (_loc9_ = 3 - _loc8_) + _loc4_;
               }
               addr555:
               ESP = _loc2_ & -16;
               AlcDbgHelper.gdb(CModule.readString(_loc8_,_loc6_),/^F/);
               eax = _loc7_;
            }
            continue;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      _loc4_ = _loc6_ + 4;
      while(true)
      {
         _loc9_ = (_loc10_ = li32(_loc4_)) + -16843009;
         _loc1_ = _loc10_ & -2139062144;
         _loc1_ ^= -2139062144;
         if((_loc9_ = _loc1_ & _loc9_) == 0)
         {
            continue;
         }
         if((_loc9_ = _loc10_ & 255) == 0)
         {
            _loc10_ = _loc4_ - _loc8_;
         }
         else if((_loc9_ = li8(_loc4_ + 1)) == 0)
         {
            _loc10_ = (_loc9_ = 1 - _loc8_) + _loc4_;
         }
         else if((_loc9_ = li8(_loc4_ + 2)) == 0)
         {
            _loc10_ = (_loc9_ = 2 - _loc8_) + _loc4_;
         }
         else
         {
            if((_loc9_ = li8(_loc4_ + 3)) != 0)
            {
               continue;
            }
            _loc10_ = (_loc9_ = 3 - _loc8_) + _loc4_;
         }
         §§goto(addr334);
      }
   }
}
