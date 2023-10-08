package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_yn() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = NaN;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc12_:* = NaN;
      var _loc15_:* = 0;
      var _loc2_:* = 0;
      var _loc5_:Number = NaN;
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc14_:* = NaN;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 32;
      sf64(_loc6_ = lf64(_loc3_ + 4),_loc3_ - 8);
      _loc2_ = li32(_loc3_ - 8);
      _loc15_ = 0 - _loc2_;
      _loc15_ = (_loc15_ = _loc2_ | _loc15_) >>> 31;
      var _loc13_:*;
      _loc8_ = (_loc10_ = li32(_loc13_ = (_loc13_ = _loc3_ - 8) | 4)) & 2147483647;
      if((uint(_loc15_ |= _loc8_)) >= 2146435073)
      {
         _loc5_ = _loc6_ + _loc6_;
      }
      else
      {
         _loc5_ = -inf;
         if((_loc8_ | _loc2_) != 0)
         {
            _loc5_ = nan;
            if(_loc10_ >= 0)
            {
               _loc7_ = li32(_loc3_);
               _loc10_ = 1;
               if(_loc7_ <= -1)
               {
                  _loc10_ = 1 - ((_loc15_ = (_loc7_ = 0 - _loc7_) << 1) & 2);
               }
               if(_loc7_ != 1)
               {
                  if(_loc7_ == 0)
                  {
                     _loc1_ -= 16;
                     sf64(_loc6_,_loc1_);
                     ESP = _loc1_;
                     F_y0();
                     _loc1_ += 16;
                     _loc5_ = st0;
                  }
                  else
                  {
                     _loc5_ = 0;
                     if(_loc8_ != 2146435072)
                     {
                        if(uint(_loc8_) >= 1389363200)
                        {
                           _loc2_ = _loc7_ & 3;
                           if(_loc2_ <= 1)
                           {
                              if(_loc2_ != 0)
                              {
                                 if(_loc2_ == 1)
                                 {
                                    var _loc9_:Number = Math.cos(_loc6_);
                                    var _loc11_:Number;
                                    _loc5_ = (_loc11_ = -Math.sin(_loc6_)) - _loc9_;
                                 }
                              }
                              else
                              {
                                 _loc5_ = Math.sin(_loc6_) - Math.cos(_loc6_);
                              }
                           }
                           else if(_loc2_ != 2)
                           {
                              if(_loc2_ == 3)
                              {
                                 _loc5_ = Math.sin(_loc6_) + Math.cos(_loc6_);
                              }
                           }
                           else
                           {
                              _loc5_ = Math.cos(_loc6_) - Math.sin(_loc6_);
                           }
                           _loc9_ = Math.sqrt(_loc6_);
                           _loc5_ = (_loc11_ = _loc5_ * 0.5641895835477563) / _loc9_;
                        }
                        else
                        {
                           _loc1_ -= 16;
                           sf64(_loc6_,_loc1_);
                           ESP = _loc1_;
                           F_y0();
                           _loc1_ += 16;
                           _loc14_ = st0;
                           _loc1_ -= 16;
                           sf64(_loc6_,_loc1_);
                           ESP = _loc1_;
                           F_y1();
                           _loc1_ += 16;
                           sf64(_loc5_ = st0,_loc3_ - 16);
                           if(_loc7_ >= 2)
                           {
                              _loc8_ = 2;
                              _loc4_ = _loc8_;
                              if((0 | li32(_loc15_ = (_loc15_ = _loc3_ - 16) | 4) ^ -1048576) != 0)
                              {
                                 do
                                 {
                                    _loc12_ = _loc5_;
                                    sf64(_loc5_ = (_loc9_ = (_loc9_ = (_loc9_ = _loc8_) / _loc6_) * _loc12_) - _loc14_,_loc3_ - 24);
                                    if(_loc4_ >= _loc7_)
                                    {
                                       break;
                                    }
                                    _loc8_ += 2;
                                    _loc4_ += 1;
                                    _loc14_ = _loc12_;
                                 }
                                 while((0 | (_loc15_ = li32(_loc15_ = (_loc15_ = _loc3_ - 24) | 4)) ^ -1048576) != 0);
                                 
                              }
                           }
                        }
                        if(_loc10_ <= 0)
                        {
                           _loc5_ = -_loc5_;
                        }
                     }
                  }
               }
               else
               {
                  _loc1_ -= 16;
                  sf64(_loc6_,_loc1_);
                  ESP = _loc1_;
                  F_y1();
                  _loc1_ += 16;
                  _loc5_ = _loc10_ * st0;
               }
            }
         }
      }
      st0 = _loc5_;
      _loc1_ = _loc3_;
      ESP = _loc1_;
   }
}
