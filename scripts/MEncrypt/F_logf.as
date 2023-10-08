package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_logf() : void
   {
      var _loc6_:int = 0;
      var _loc16_:* = 0;
      var _loc9_:int = 0;
      var _loc21_:* = NaN;
      var _loc3_:* = NaN;
      var _loc7_:* = NaN;
      var _loc20_:* = NaN;
      var _loc15_:* = NaN;
      var _loc5_:int = 0;
      var _loc22_:* = 0;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 12;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      _loc5_ = -127;
      if((_loc22_ = li32(_loc6_ - 4)) <= 8388607)
      {
         _loc3_ = -inf;
         var _loc18_:*;
         if((_loc18_ = _loc22_ & 2147483647) != 0)
         {
            if(_loc22_ <= -1)
            {
               var _loc8_:* = _loc1_;
               var _loc10_:*;
               var _loc19_:*;
               _loc3_ = _loc10_ = (_loc8_ = _loc19_ = _loc8_ -= _loc8_) / 0;
            }
            else
            {
               _loc1_ = _loc10_ = _loc1_ * (_loc19_ = 33554432);
               sf32(_loc1_,_loc6_ - 8);
               _loc5_ = -152;
               _loc22_ = li32(_loc6_ - 8);
               addr113:
               if(_loc22_ >= 2139095040)
               {
                  _loc10_ = _loc1_;
                  _loc3_ = _loc10_ += _loc10_;
               }
               else
               {
                  var _loc13_:*;
                  si32(_loc13_ = (_loc13_ = (_loc18_ = (_loc18_ = (_loc16_ = _loc22_ & 8388607) + 4913952) & 8388608) | _loc16_) ^ 1065353216,_loc6_ - 12);
                  _loc9_ = (_loc13_ = _loc22_ >> 23) + _loc5_ + (_loc18_ >>> 23);
                  _loc21_ = _loc10_ = (_loc8_ = lf32(_loc6_ - 12)) + -1;
                  if((uint(_loc18_ = (_loc18_ = _loc22_ + 32768) & 8372224)) <= 49151)
                  {
                     _loc15_ = _loc21_;
                     _loc3_ = 0;
                     _loc10_ = _loc3_;
                     if(!(_loc15_ != _loc10_ | _loc15_ != _loc15_ | _loc10_ != _loc10_))
                     {
                        if(_loc9_ != 0)
                        {
                           var _loc12_:*;
                           _loc3_ = _loc10_ = (_loc10_ = _loc10_ *= _loc12_ = 0.6931381225585938) + (_loc19_ = _loc8_ = (_loc10_ = _loc9_) * 0.00000905800061445916);
                        }
                     }
                     else
                     {
                        _loc3_ = _loc10_ = (_loc8_ = _loc19_ = _loc8_ = _loc15_ * _loc15_) * (_loc10_ = (_loc10_ = _loc15_ * -0.3333333432674408) + (_loc19_ = 0.5));
                        if(_loc9_ == 0)
                        {
                           _loc3_ = _loc10_ = _loc15_ - _loc3_;
                        }
                        else
                        {
                           _loc3_ = _loc10_ = (_loc10_ = (_loc8_ = _loc19_ = _loc9_) * 0.6931381225585938) - (_loc19_ = _loc8_ = (_loc8_ = _loc19_ = _loc8_ = (_loc19_ = _loc8_ *= _loc12_ = -0.00000905800061445916) + _loc3_) - _loc15_);
                        }
                     }
                  }
                  else
                  {
                     _loc20_ = _loc21_;
                     _loc15_ = _loc10_ = _loc20_ / (_loc10_ = _loc20_ + 2);
                     _loc10_ = _loc10_ = _loc15_ * _loc15_;
                     _loc8_ = _loc19_ = _loc8_ = _loc10_ * _loc10_;
                     var _loc14_:*;
                     var _loc11_:*;
                     _loc21_ = _loc10_ = (_loc10_ = _loc10_ = (_loc8_ = _loc19_ = _loc8_ = (_loc19_ = _loc8_ *= _loc14_ = 0.2849878668785095) + (_loc14_ = 0.6666666269302368)) * _loc10_) + (_loc12_ = _loc11_ = (_loc11_ = _loc12_ = _loc11_ = (_loc12_ = _loc11_ = _loc8_ * (_loc12_ = 0.24279078841209412)) + (_loc14_ = 0.40000972151756287)) * _loc8_);
                     _loc3_ = _loc9_;
                     if(((_loc13_ = _loc16_ + -3187664) | 3523208 - _loc16_) >= 1)
                     {
                        _loc7_ = _loc10_ = (_loc10_ = _loc10_ = _loc20_ * 0.5) * _loc20_;
                        if(_loc9_ == 0)
                        {
                           _loc3_ = _loc10_ = _loc20_ - (_loc10_ -= _loc19_ = _loc8_ = (_loc8_ = _loc19_ = _loc8_ = (_loc10_ = _loc7_) + _loc21_) * _loc15_);
                        }
                        else
                        {
                           _loc8_ = _loc19_ = 0.00000905800061445916;
                           var _loc17_:*;
                           _loc8_ = _loc19_ = _loc8_ = (_loc8_ = _loc19_ = _loc8_ -= _loc12_ = _loc11_ = (_loc17_ = _loc14_ = _loc17_ = (_loc17_ = _loc14_ = _loc17_ = (_loc8_ = _loc7_) + _loc21_) * _loc15_) + (_loc19_ = _loc8_ = _loc3_ * _loc8_)) - _loc20_;
                           _loc3_ = _loc10_ = (_loc10_ = _loc10_ = _loc3_ * (_loc12_ = 0.6931381225585938)) - _loc8_;
                        }
                     }
                     else if(_loc9_ == 0)
                     {
                        _loc3_ = _loc10_ = _loc20_ - (_loc10_ = (_loc10_ = _loc10_ = _loc20_ - _loc21_) * _loc15_);
                     }
                     else
                     {
                        _loc8_ = _loc19_ = -0.00000905800061445916;
                        _loc8_ = _loc19_ = _loc8_ = (_loc8_ = _loc19_ = _loc8_ = (_loc11_ = _loc12_ = _loc11_ = (_loc11_ = _loc12_ = _loc11_ = _loc20_ - _loc21_) * _loc15_) + (_loc19_ = _loc8_ = _loc3_ * _loc8_)) - _loc20_;
                        _loc3_ = _loc10_ = (_loc10_ = _loc10_ = _loc3_ * (_loc12_ = 0.6931381225585938)) - _loc8_;
                     }
                  }
               }
            }
         }
         st0 = _loc3_;
         ESP = _loc4_ = _loc6_;
         return;
      }
      §§goto(addr113);
   }
}
