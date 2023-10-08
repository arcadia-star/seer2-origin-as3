package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F__ascii_mbsnrtowcs() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc12_ = li32(_loc1_);
      _loc11_ = li32(_loc3_ + 8);
      if((_loc10_ = li32(_loc3_)) == 0)
      {
         _loc10_ = 0 - _loc11_;
         _loc1_ = 0;
         while(_loc10_ != _loc1_)
         {
            var _loc9_:*;
            if((_loc8_ = li8(_loc9_ = _loc12_ - _loc1_)) == 0)
            {
               break;
            }
            if((_loc9_ = (_loc9_ = _loc8_ << 24) >> 24) <= -1)
            {
               ESP = _loc2_;
               F___error();
               si32(86,eax);
               _loc6_ = -1;
               §§goto(addr217);
            }
            _loc1_ += -1;
         }
         _loc6_ = 0 - _loc1_;
      }
      else
      {
         _loc8_ = 0 - li32(_loc3_ + 12);
         _loc11_ = 0 - _loc11_;
         _loc7_ = 0;
         for(; _loc8_ != _loc7_; _loc7_ += -1)
         {
            if(_loc11_ == _loc7_)
            {
               break;
            }
            if((_loc5_ = si8(li8(_loc9_ = _loc12_ - _loc7_))) <= -1)
            {
               ESP = _loc2_;
               F___error();
               si32(86,eax);
               _loc6_ = -1;
            }
            else
            {
               _loc6_ = 0 - _loc7_;
               var _loc4_:int = _loc10_ + (_loc6_ << 2);
               si32(_loc5_ & 255,_loc4_);
               if((_loc5_ & 255) != 0)
               {
                  continue;
               }
               si32(0,_loc1_);
            }
            §§goto(addr217);
         }
         si32(_loc9_ = _loc12_ - _loc7_,_loc1_);
         _loc6_ = 0 - _loc7_;
      }
      addr217:
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
