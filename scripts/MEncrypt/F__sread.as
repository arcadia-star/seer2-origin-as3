package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__sread() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:int = 0;
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc14_:* = 0;
      var _loc8_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc14_ = li32(_loc1_ + 36);
      _loc13_ = li32(_loc1_ + 28);
      _loc2_ -= 16;
      var _loc12_:*;
      si32(_loc12_ = li32(_loc3_ + 8),_loc2_ + 8);
      si32(_loc12_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc13_,_loc2_);
      ESP = _loc2_;
      ptr2fun[_loc14_]();
      _loc2_ += 16;
      if((_loc11_ = eax) >= 1)
      {
         if((_loc14_ = (_loc10_ = li16(_loc1_ + 12)) & 4096) != 0)
         {
            _loc9_ = li32(_loc1_ + 80);
            _loc7_ = _loc8_ = 1;
            if(uint(_loc9_) <= (uint(_loc11_ ^ -1)))
            {
               _loc7_ = 0;
            }
            _loc6_ = li32(_loc1_ + 84);
            _loc4_ = _loc11_ >> 31;
            _loc5_ = 2147483647 - _loc4_;
            if(_loc6_ <= _loc5_)
            {
               _loc8_ = 0;
            }
            if(_loc6_ != _loc5_)
            {
               _loc7_ = _loc8_;
            }
            if(_loc7_ == 0)
            {
               si32(_loc10_ = _loc9_ + _loc11_,_loc1_ + 80);
               _loc5_ = _loc7_ = 1;
               if(uint(_loc10_) >= uint(_loc9_))
               {
                  _loc5_ = 0;
               }
               if(uint(_loc10_) >= uint(_loc11_))
               {
                  _loc7_ = _loc5_;
               }
               si32(_loc14_ = (_loc14_ = _loc6_ + _loc4_) + _loc7_,_loc1_ + 84);
            }
            else
            {
               si16(_loc14_ = _loc10_ & 61439,_loc1_ + 12);
            }
         }
      }
      else if(_loc11_ <= -1)
      {
         si16(_loc14_ = (_loc14_ = li16(_loc1_ + 12)) & 61439,_loc1_ + 12);
      }
      eax = _loc11_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
