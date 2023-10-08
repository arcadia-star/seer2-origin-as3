package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_nextafterf() : void
   {
      var _loc5_:* = 0;
      var _loc2_:* = NaN;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = NaN;
      var _loc4_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 24;
      _loc2_ = lf32(_loc5_);
      sf32(_loc2_,_loc5_ - 8);
      sf32(_loc4_ = lf32(_loc5_ + 4),_loc5_ - 12);
      _loc1_ = li32(_loc5_ - 8);
      if((uint(_loc12_ = _loc1_ & 2147483647)) <= 2139095040)
      {
         var _loc10_:*;
         if((uint(_loc10_ = (_loc11_ = li32(_loc5_ - 12)) & 2147483647)) >= 2139095041)
         {
            addr75:
            var _loc7_:* = _loc4_;
            var _loc6_:*;
            _loc4_ = _loc6_ = (_loc6_ = _loc2_) + _loc7_;
         }
         else if((_loc9_ = _loc2_) != _loc4_)
         {
            if(_loc12_ == 0)
            {
               si32(_loc10_ = (_loc10_ = _loc11_ & -2147483648) | 1,_loc5_ - 24);
               _loc6_ = _loc4_ = lf32(_loc5_ - 24);
               sf32(_loc7_ = _loc6_ * _loc6_,_loc5_ - 4);
               if(!((_loc7_ = lf32(_loc5_ - 4)) != _loc6_ | _loc7_ != _loc7_ | _loc6_ != _loc6_))
               {
                  _loc4_ = lf32(_loc5_ - 4);
               }
            }
            else
            {
               if(_loc1_ >= 0)
               {
                  if(_loc1_ > _loc11_)
                  {
                     _loc1_ += -1;
                  }
                  else
                  {
                     _loc1_ += 1;
                  }
               }
               else
               {
                  if(_loc11_ <= -1)
                  {
                     if(_loc1_ <= _loc11_)
                     {
                        _loc1_ += 1;
                     }
                     §§goto(addr200);
                  }
                  _loc1_ += -1;
               }
               addr200:
               if((_loc8_ = _loc1_ & 2139095040) == 2139095040)
               {
                  _loc4_ = _loc6_ = _loc9_ + _loc9_;
               }
               else
               {
                  if(uint(_loc8_) <= 8388607)
                  {
                     sf32(_loc6_ = _loc9_ * _loc9_,_loc5_ - 4);
                     if((_loc6_ = lf32(_loc5_ - 4)) != _loc9_)
                     {
                        si32(_loc1_,_loc5_ - 20);
                        _loc4_ = lf32(_loc5_ - 20);
                     }
                     §§goto(addr264);
                  }
                  si32(_loc1_,_loc5_ - 16);
                  _loc4_ = lf32(_loc5_ - 16);
               }
               §§goto(addr264);
            }
         }
         addr264:
         st0 = _loc4_;
         _loc3_ = _loc5_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr75);
   }
}
