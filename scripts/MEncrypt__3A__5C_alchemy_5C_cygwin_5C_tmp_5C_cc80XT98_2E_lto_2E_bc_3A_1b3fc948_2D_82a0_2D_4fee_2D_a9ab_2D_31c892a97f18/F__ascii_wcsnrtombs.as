package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__ascii_wcsnrtombs() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc9_:int = 0;
      var _loc4_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc10_ = li32(_loc1_);
      _loc9_ = 0;
      _loc8_ = li32(_loc3_ + 8);
      if((_loc7_ = li32(_loc3_)) != 0)
      {
         _loc9_ = 0 - li32(_loc3_ + 12);
         _loc5_ = 0 - _loc8_;
         _loc8_ = 0;
         for(; _loc9_ != _loc8_; _loc10_ += 4,_loc8_ += -1)
         {
            if(_loc5_ == _loc8_)
            {
               break;
            }
            if((uint(_loc4_ = li32(_loc10_))) >= 128)
            {
               ESP = _loc2_;
               F___error();
               si32(86,eax);
               _loc10_ = -1;
               §§goto(addr202);
            }
            si8(_loc4_,_loc7_ - _loc8_);
            var _loc6_:*;
            if((_loc6_ = _loc4_ & 255) != 0)
            {
               continue;
            }
            si32(0,_loc1_);
            _loc10_ = 0 - _loc8_;
            addr202:
            eax = _loc10_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
            §§goto(addr202);
         }
         si32(_loc10_,_loc1_);
         _loc10_ = 0 - _loc8_;
      }
      else
      {
         for(; _loc8_ != 0; _loc8_ += -1,_loc9_ += -4)
         {
            if((_loc7_ = li32(_loc6_ = _loc10_ - _loc9_)) == 0)
            {
               break;
            }
            if(uint(_loc7_) < 128)
            {
               continue;
            }
            ESP = _loc2_;
            F___error();
            si32(86,eax);
            _loc10_ = -1;
            §§goto(addr202);
         }
         _loc10_ = (_loc6_ = 0 - _loc9_) >> 2;
      }
      §§goto(addr202);
   }
}
