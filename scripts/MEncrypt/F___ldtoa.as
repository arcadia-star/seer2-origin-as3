package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___ldtoa() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:int = 0;
      var _loc14_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc8_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      si32(53,_loc3_ - 24);
      _loc1_ = _loc3_ - 24;
      _loc14_ = _loc1_ | 4;
      si32(-1074,_loc14_);
      si32(971,_loc3_ - 16);
      si32(0,_loc3_ - 8);
      _loc13_ = li32(_loc14_ = li32(_loc3_));
      _loc14_ = (_loc12_ = li32(_loc14_ + 4)) >>> 31;
      _loc11_ = li32(_loc3_ + 16);
      si32(_loc14_,_loc11_);
      si32(1,_loc3_ - 12);
      si32(_loc13_,_loc3_ - 36);
      si32(_loc10_ = _loc12_ & 1048575,_loc3_ - 32);
      _loc8_ = (_loc9_ = (_loc14_ = _loc12_ >>> 20) & 2047) + -1075;
      _loc7_ = li32(_loc3_ + 20);
      _loc6_ = li32(_loc3_ + 12);
      _loc4_ = li32(_loc3_ + 8);
      _loc5_ = li32(_loc3_ + 4);
      if(_loc9_ != 2047)
      {
         if(_loc9_ == 0)
         {
            _loc13_ = 16;
            if((_loc10_ | _loc13_) != 0)
            {
               _loc13_ = 8;
            }
            §§goto(addr174);
         }
         §§goto(addr199);
      }
      else
      {
         _loc13_ = 1;
         if((_loc10_ | _loc13_) != 0)
         {
            _loc13_ = 2;
         }
      }
      addr174:
      if(_loc13_ <= 3)
      {
         if(_loc13_ != 1)
         {
            if(_loc13_ != 2)
            {
               addr248:
               ESP = _loc2_;
               F_abort();
            }
            else
            {
               si32(4,_loc3_ - 28);
            }
         }
         else
         {
            si32(3,_loc3_ - 28);
         }
      }
      else if(_loc13_ != 16)
      {
         if(_loc13_ != 8)
         {
            if(_loc13_ == 4)
            {
               addr199:
               si32(1,_loc3_ - 28);
               si32(_loc14_ = _loc10_ | 1048576,_loc3_ - 32);
            }
            else
            {
               §§goto(addr248);
            }
         }
         else
         {
            si32(2,_loc3_ - 28);
            _loc8_ = _loc9_ + -1074;
         }
      }
      else
      {
         si32(0,_loc3_ - 28);
      }
      _loc2_ -= 32;
      si32(_loc7_,_loc2_ + 28);
      si32(_loc4_,_loc2_ + 20);
      si32(_loc5_,_loc2_ + 16);
      si32(_loc14_ = _loc3_ - 28,_loc2_ + 12);
      si32(_loc14_ = _loc3_ - 36,_loc2_ + 8);
      si32(_loc8_,_loc2_ + 4);
      si32(_loc1_,_loc2_);
      si32(_loc6_,_loc2_ + 24);
      ESP = _loc2_;
      F___gdtoa();
      _loc2_ += 32;
      _loc1_ = eax;
      if((_loc14_ = li32(_loc6_)) == -32768)
      {
         si32(2147483647,_loc6_);
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
