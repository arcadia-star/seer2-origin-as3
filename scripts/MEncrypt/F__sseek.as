package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__sseek() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc12_:* = 0;
      var _loc4_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc12_ = li32(_loc1_);
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      si32(0,_loc1_);
      _loc10_ = li32((_loc11_ = li32(_loc3_)) + 40);
      _loc1_ = li32(_loc11_ + 28);
      _loc2_ -= 16;
      si32(_loc9_ = li32(_loc3_ + 12),_loc2_ + 12);
      si32(_loc8_ = li32(_loc3_ + 8),_loc2_ + 8);
      si32(_loc7_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      ptr2fun[_loc10_]();
      _loc2_ += 16;
      _loc6_ = eax;
      _loc5_ = edx;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc4_ = li32(_loc1_);
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc1_ = li32(_loc1_);
      if(_loc1_ == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(_loc12_,eax);
      }
      if(_loc5_ <= -1)
      {
         if(_loc4_ != 0)
         {
            if(_loc4_ != 29)
            {
               _loc11_ += 12;
            }
            else
            {
               si16(li16(_loc11_ + 12) & 65279,_loc11_ + 12);
               _loc11_ += 12;
            }
         }
         else
         {
            if((_loc7_ | _loc8_) == 0)
            {
               if(_loc9_ == 1)
               {
                  _loc5_ = li16(_loc11_ + 12);
               }
               else
               {
                  addr213:
                  if((_loc5_ = li32(_loc11_ + 48)) != 0)
                  {
                     if(_loc5_ != _loc11_ + 64)
                     {
                        _loc2_ -= 16;
                        si32(_loc5_,_loc2_);
                        ESP = _loc2_;
                        F_idalloc();
                        _loc2_ += 16;
                     }
                     si32(0,_loc11_ + 48);
                  }
                  _loc1_ = li32(_loc11_ + 16);
                  si32(_loc1_,_loc11_);
                  si32(0,_loc11_ + 4);
                  _loc1_ = li16(_loc11_ + 12);
                  si16(_loc5_ = _loc1_ & -33,_loc11_ + 12);
               }
               _loc1_ = _loc5_ | 64;
               si16(_loc1_,_loc11_ + 12);
               ESP = _loc2_;
               F___error();
               _loc1_ = eax;
               si32(22,_loc1_);
               _loc11_ += 12;
               §§goto(addr330);
            }
            §§goto(addr213);
         }
         §§goto(addr330);
      }
      else if(((_loc4_ = li16(_loc11_ + 12)) & 1024) != 0)
      {
         si16(_loc4_ | 4096,_loc11_ + 12);
         si32(_loc5_,_loc11_ + 84);
         si32(_loc6_,_loc11_ + 80);
      }
      addr330:
      _loc1_ = li16(_loc11_);
      _loc1_ &= 61439;
      si16(_loc1_,_loc11_);
      _loc5_ = _loc6_ = -1;
      eax = _loc6_;
      edx = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
