package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___truncdfsf2() : void
   {
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = _loc4_;
      _loc2_ |= 4;
      _loc2_ = (_loc9_ = (_loc10_ = li32(_loc2_)) & 2147483647) + -1206910976;
      _loc8_ = _loc9_ + -940572672;
      _loc7_ = li32(_loc4_);
      if(uint(_loc8_) < uint(_loc2_))
      {
         _loc6_ = _loc7_ >>> 29 | _loc10_ << 3;
         if((uint(_loc7_ &= 536870911)) >= 268435457)
         {
            _loc6_ += 1073741825;
         }
         else
         {
            _loc6_ += 1073741824;
            if((_loc7_ ^ 268435456 | 0) == 0)
            {
               _loc6_ = (_loc6_ & 1) + _loc6_;
            }
         }
      }
      else
      {
         _loc5_ = _loc6_ = 1;
         if(uint(_loc9_) >= 2146435072)
         {
            _loc5_ = 0;
         }
         if(_loc7_ != 0)
         {
            _loc6_ = 0;
         }
         if(_loc9_ != 2146435072)
         {
            _loc6_ = _loc5_;
         }
         if(_loc6_ == 0)
         {
            _loc6_ = _loc7_ & 4194303 | 2143289344;
         }
         else
         {
            _loc6_ = _loc5_ = 1;
            if(uint(_loc9_) <= 1206910976)
            {
               _loc6_ = 0;
            }
            if(_loc7_ == 0)
            {
               _loc5_ = 0;
            }
            if(_loc9_ != 1206910976)
            {
               _loc5_ = _loc6_;
            }
            _loc6_ = 2139095040;
            if(_loc5_ == 0)
            {
               _loc5_ = 897 - (_loc9_ >>> 20);
               _loc6_ = 0;
               if(_loc5_ <= 52)
               {
                  _loc3_ -= 16;
                  si32(_loc7_,_loc3_);
                  si32(_loc10_ & 1048575 | 1048576,_loc3_ + 4);
                  si32(_loc5_,_loc3_ + 8);
                  ESP = _loc3_;
                  F___lshrdi3();
                  _loc3_ += 16;
                  _loc6_ = eax;
                  _loc9_ = edx;
                  _loc3_ -= 16;
                  si32(_loc8_ = 64 - _loc5_,_loc3_ + 8);
                  si32(_loc10_ & 1048575 | 1048576,_loc3_ + 4);
                  si32(_loc7_,_loc3_);
                  ESP = _loc3_;
                  F___ashldi3();
                  _loc3_ += 16;
                  _loc7_ = 1;
                  if((eax | edx) == 0)
                  {
                     _loc7_ = 0;
                  }
                  _loc2_ = _loc7_ & 1;
                  _loc8_ = _loc6_ & 536870911;
                  _loc7_ = _loc2_ | _loc8_;
                  _loc8_ = _loc9_ << 3;
                  _loc2_ = _loc6_ >>> 29;
                  _loc6_ = _loc2_ | _loc8_;
                  if(uint(_loc7_) >= 268435457)
                  {
                     _loc6_ += 1;
                  }
                  else if((_loc7_ ^ 268435456 | 0) == 0)
                  {
                     _loc6_ = (_loc6_ & 1) + _loc6_;
                  }
               }
            }
         }
      }
      _loc2_ = _loc10_ & -2147483648;
      _loc2_ = _loc6_ | _loc2_;
      si32(_loc2_,_loc4_ - 4);
      var _loc1_:* = lf32(_loc4_ - 4);
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
