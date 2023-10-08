package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_nextafter() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = NaN;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc14_:* = 0;
      var _loc10_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = NaN;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 48;
      sf64(_loc8_ = lf64(_loc3_ + 8),_loc3_ - 24);
      sf64(_loc6_ = lf64(_loc3_),_loc3_ - 16);
      _loc2_ = _loc3_ - 24;
      _loc2_ |= 4;
      _loc14_ = li32(_loc2_);
      _loc2_ = _loc3_ - 16;
      _loc2_ |= 4;
      _loc12_ = (_loc13_ = li32(_loc2_)) & 2147483647;
      _loc10_ = li32(_loc3_ - 24);
      _loc9_ = li32(_loc3_ - 16);
      if(uint(_loc12_) >= 2146435072)
      {
         if((_loc12_ + -2146435072 | _loc9_) == 0)
         {
            addr105:
            if((uint(_loc7_ = _loc14_ & 2147483647)) >= 2146435072)
            {
               if((_loc7_ + -2146435072 | _loc10_) != 0)
               {
                  addr123:
                  _loc8_ = _loc6_ + _loc8_;
               }
               else
               {
                  addr130:
                  if(_loc6_ != _loc8_)
                  {
                     if((_loc12_ | _loc9_) == 0)
                     {
                        var _loc5_:*;
                        si32(_loc5_ = _loc14_ & -2147483648,_loc3_ - 48 | 4);
                        si32(1,_loc3_ - 48);
                        _loc8_ = lf64(_loc3_ - 48);
                        var _loc11_:*;
                        sf64(_loc11_ = _loc8_ * _loc8_,_loc3_ - 8);
                        if(!((_loc11_ = lf64(_loc3_ - 8)) != _loc8_ | _loc11_ != _loc11_ | _loc8_ != _loc8_))
                        {
                           _loc8_ = lf64(_loc3_ - 8);
                        }
                     }
                     else if(_loc13_ >= 0)
                     {
                        if(_loc13_ <= _loc14_)
                        {
                           if(_loc13_ == _loc14_)
                           {
                              if(uint(_loc9_) > uint(_loc10_))
                              {
                                 addr219:
                                 _loc4_ = -1;
                                 if(_loc9_ != 0)
                                 {
                                    _loc4_ = 0;
                                 }
                                 _loc9_ += -1;
                              }
                              §§goto(addr304);
                           }
                           _loc9_ += 1;
                           _loc4_ = 1;
                           if(_loc9_ != 0)
                           {
                              _loc4_ = 0;
                           }
                           _loc4_ &= 1;
                           addr304:
                           if((_loc13_ = (_loc4_ += _loc13_) & 2146435072) == 2146435072)
                           {
                              _loc8_ = _loc6_ + _loc6_;
                           }
                           else
                           {
                              if(uint(_loc13_) <= 1048575)
                              {
                                 sf64(_loc11_ = _loc6_ * _loc6_,_loc3_ - 8);
                                 if((_loc11_ = lf64(_loc3_ - 8)) != _loc6_)
                                 {
                                    si32(_loc4_,_loc3_ - 40 | 4);
                                    si32(_loc9_,_loc3_ - 40);
                                    _loc8_ = lf64(_loc3_ - 40);
                                 }
                                 §§goto(addr392);
                              }
                              _loc2_ = _loc3_ - 32;
                              _loc2_ |= 4;
                              si32(_loc4_,_loc2_);
                              si32(_loc9_,_loc3_ - 32);
                              _loc8_ = lf64(_loc3_ - 32);
                           }
                           §§goto(addr392);
                        }
                        §§goto(addr219);
                     }
                     else
                     {
                        if(_loc14_ <= -1)
                        {
                           if(_loc13_ <= _loc14_)
                           {
                              if(_loc13_ == _loc14_)
                              {
                                 if(uint(_loc9_) > uint(_loc10_))
                                 {
                                    addr271:
                                    _loc4_ = -1;
                                    if(_loc9_ != 0)
                                    {
                                       _loc4_ = 0;
                                    }
                                    _loc9_ += -1;
                                 }
                                 §§goto(addr219);
                              }
                              _loc9_ += 1;
                              _loc4_ = 1;
                              if(_loc9_ != 0)
                              {
                                 _loc4_ = 0;
                              }
                              _loc4_ &= 1;
                              §§goto(addr219);
                           }
                        }
                        §§goto(addr271);
                     }
                  }
               }
               addr392:
               st0 = _loc8_;
               _loc1_ = _loc3_;
               ESP = _loc1_;
               return;
            }
            §§goto(addr130);
         }
         §§goto(addr123);
      }
      §§goto(addr105);
   }
}
