package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_nexttowardf() : void
   {
      var _loc4_:* = 0;
      var _loc7_:* = NaN;
      var _loc3_:* = 0;
      var _loc11_:* = NaN;
      var _loc10_:* = 0;
      var _loc13_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = NaN;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 32;
      sf64(_loc7_ = lf64(_loc4_ + 4),_loc4_ - 16);
      _loc1_ = lf32(_loc4_);
      sf32(_loc1_,_loc4_ - 20);
      _loc3_ = li32(_loc4_ - 20);
      if((uint(_loc13_ = _loc3_ & 2147483647)) <= 2139095040)
      {
         var _loc12_:*;
         if((_loc12_ = (_loc12_ = (_loc10_ = li32(_loc12_ = (_loc12_ = _loc4_ - 16) | 4)) >>> 20) & 2047) == 2047)
         {
            var _loc8_:*;
            if((_loc12_ = (_loc8_ = _loc10_ & 1048575) | li32(_loc4_ - 16)) != 0)
            {
               addr102:
               var _loc5_:*;
               _loc1_ = _loc5_ = (_loc5_ = _loc1_) + _loc7_;
            }
            else
            {
               addr113:
               if(!((_loc11_ = _loc1_) != _loc7_ | _loc11_ != _loc11_ | _loc7_ != _loc7_))
               {
                  _loc1_ = _loc7_;
               }
               else if(_loc13_ == 0)
               {
                  si32(_loc12_ = (_loc12_ = _loc10_ & -2147483648) | 1,_loc4_ - 32);
                  _loc1_ = lf32(_loc4_ - 32);
                  _loc5_ = _loc1_;
                  var _loc9_:*;
                  sf32(_loc9_ = _loc5_ * _loc5_,_loc4_ - 4);
                  if(!((_loc9_ = lf32(_loc4_ - 4)) != _loc5_ | _loc9_ != _loc9_ | _loc5_ != _loc5_))
                  {
                     _loc1_ = lf32(_loc4_ - 4);
                  }
               }
               else
               {
                  _loc10_ = 1;
                  if(_loc11_ >= _loc7_)
                  {
                     _loc10_ = 0;
                  }
                  _loc6_ = -1;
                  _loc13_ = 1;
                  if(_loc3_ <= _loc6_)
                  {
                     _loc13_ = 0;
                  }
                  if((_loc12_ = _loc13_ ^ _loc10_) == 0)
                  {
                     _loc6_ = 1;
                  }
                  _loc3_ = _loc6_ + _loc3_;
                  if((_loc6_ = _loc3_ & 2139095040) == 2139095040)
                  {
                     _loc1_ = _loc5_ = _loc11_ + _loc11_;
                  }
                  else
                  {
                     if(uint(_loc6_) <= 8388607)
                     {
                        sf32(_loc5_ = _loc11_ * _loc11_,_loc4_ - 4);
                        if((_loc5_ = lf32(_loc4_ - 4)) != _loc11_)
                        {
                           si32(_loc3_,_loc4_ - 28);
                           _loc1_ = lf32(_loc4_ - 28);
                        }
                        §§goto(addr294);
                     }
                     si32(_loc3_,_loc4_ - 24);
                     _loc1_ = lf32(_loc4_ - 24);
                  }
               }
            }
            addr294:
            st0 = _loc1_;
            _loc2_ = _loc4_;
            ESP = _loc2_;
            return;
         }
         §§goto(addr113);
      }
      §§goto(addr102);
   }
}
