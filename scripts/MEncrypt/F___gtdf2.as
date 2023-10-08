package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___gtdf2() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc13_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc12_ = (_loc13_ = li32(_loc1_)) & 2147483647;
      _loc10_ = _loc11_ = 1;
      if(uint(_loc12_) <= 2146435072)
      {
         _loc10_ = 0;
      }
      if((_loc9_ = li32(_loc3_)) == 0)
      {
         _loc11_ = 0;
      }
      if(_loc12_ != 2146435072)
      {
         _loc11_ = _loc10_;
      }
      _loc8_ = -1;
      if(_loc11_ == 0)
      {
         _loc7_ = (_loc11_ = li32(_loc3_ + 8 | 4)) & 2147483647;
         _loc5_ = _loc6_ = 1;
         if(uint(_loc7_) <= 2146435072)
         {
            _loc5_ = 0;
         }
         if((_loc10_ = li32(_loc3_ + 8)) == 0)
         {
            _loc6_ = 0;
         }
         if(_loc7_ != 2146435072)
         {
            _loc6_ = _loc5_;
         }
         if(_loc6_ == 0)
         {
            _loc8_ = 0;
            if((_loc10_ | _loc9_ | (_loc7_ | _loc12_)) != 0)
            {
               if((_loc11_ & _loc13_) >= 0)
               {
                  _loc12_ = _loc8_ = 1;
                  if(uint(_loc9_) >= uint(_loc10_))
                  {
                     _loc12_ = 0;
                  }
                  if(_loc13_ >= _loc11_)
                  {
                     _loc8_ = 0;
                  }
                  if(_loc13_ != _loc11_)
                  {
                     _loc12_ = _loc8_;
                  }
                  _loc8_ = -1;
                  if(_loc12_ == 0)
                  {
                     _loc9_ = 1;
                     if((_loc9_ ^ _loc10_ | _loc13_ ^ _loc11_) == 0)
                     {
                        _loc9_ = 0;
                     }
                     _loc8_ = _loc9_ & 1;
                  }
               }
               else
               {
                  _loc12_ = _loc8_ = 1;
                  if(uint(_loc9_) <= uint(_loc10_))
                  {
                     _loc12_ = 0;
                  }
                  if(_loc13_ <= _loc11_)
                  {
                     _loc8_ = 0;
                  }
                  if(_loc13_ != _loc11_)
                  {
                     _loc12_ = _loc8_;
                  }
                  _loc8_ = -1;
                  if(_loc12_ == 0)
                  {
                     _loc9_ = 1;
                     if((_loc9_ ^ _loc10_ | _loc13_ ^ _loc11_) == 0)
                     {
                        _loc9_ = 0;
                     }
                     _loc8_ = _loc9_ & 1;
                  }
               }
            }
         }
      }
      eax = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
