package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___divxc3() : void
   {
      var _loc10_:int = 0;
      var _loc18_:* = 0;
      var _loc23_:* = NaN;
      var _loc25_:* = NaN;
      var _loc21_:* = 0;
      var _loc20_:* = NaN;
      var _loc17_:* = NaN;
      var _loc15_:* = NaN;
      var _loc19_:* = NaN;
      var _loc22_:* = 0;
      var _loc24_:int = 0;
      var _loc16_:* = 0;
      var _loc13_:int = 0;
      var _loc12_:int = 0;
      var _loc6_:int = 0;
      var _loc11_:int = 0;
      var _loc5_:Number = NaN;
      var _loc7_:Number = NaN;
      var _loc8_:* = (_loc10_ = ESP) - 160;
      _loc15_ = _loc17_ = lf64(_loc10_ + 20);
      if(!(_loc17_ >= 0 | _loc17_ != _loc17_ | false))
      {
         _loc15_ = -_loc17_;
      }
      _loc19_ = _loc20_ = lf64(_loc10_ + 28);
      if(!(_loc20_ >= 0 | _loc20_ != _loc20_ | false))
      {
         _loc19_ = -_loc20_;
      }
      sf64(_loc19_,_loc10_ - 16);
      sf64(_loc15_,_loc10_ - 8);
      var _loc9_:* = li32(_loc9_ = (_loc9_ = _loc10_ - 16) | 4);
      _loc22_ = _loc24_ = 1;
      if(_loc9_ >= 0)
      {
         _loc22_ = 0;
      }
      if((_loc21_ = li32(_loc9_ = (_loc9_ = _loc10_ - 8) | 4)) >= 0)
      {
         _loc24_ = 0;
      }
      _loc25_ = lf64(_loc10_ + 12);
      _loc23_ = lf64(_loc10_ + 4);
      _loc18_ = li32(_loc10_);
      if((_loc9_ = (_loc9_ = _loc24_ ^ _loc22_) & 1) != 0)
      {
         if(_loc21_ >= 0)
         {
            _loc19_ = _loc15_;
         }
      }
      else
      {
         if(_loc15_ <= _loc19_)
         {
            _loc15_ = _loc19_;
         }
         _loc19_ = _loc15_;
      }
      sf64(_loc19_,_loc10_ - 24);
      _loc16_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 24) | 4)) & 2147483647;
      _loc9_ = li32(_loc10_ - 24);
      if((_loc9_ = _loc16_ | _loc9_) == 0)
      {
         if(!(_loc19_ >= 0 | _loc19_ != _loc19_ | false))
         {
            _loc19_ = -_loc19_;
         }
         _loc19_ = -1 / _loc19_;
      }
      else if(uint(_loc16_) >= 2146435072)
      {
         _loc19_ *= _loc19_;
      }
      else if(uint(_loc16_) <= 1048575)
      {
         sf64(_loc19_ * 18014398509481984,_loc10_ - 32);
         _loc19_ = _loc9_ = (_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 32) | 4)) >>> 20) & 2047) + -1077;
      }
      else
      {
         _loc19_ = _loc9_ = (_loc9_ = _loc16_ >>> 20) + -1023;
      }
      sf64(_loc19_,_loc10_ - 40);
      _loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 40) | 4)) >>> 20) & 2047;
      _loc16_ = 0;
      if(_loc9_ != 2047)
      {
         _loc8_ -= 16;
         sf64(_loc17_,_loc8_);
         _loc16_ = _loc19_;
         si32(_loc9_ = 0 - _loc16_,_loc8_ + 8);
         ESP = _loc8_;
         F_scalbn();
         _loc8_ += 16;
         _loc17_ = st0;
         _loc8_ -= 16;
         si32(_loc9_,_loc8_ + 8);
         sf64(_loc20_,_loc8_);
         ESP = _loc8_;
         F_scalbn();
         _loc8_ += 16;
         _loc20_ = st0;
      }
      _loc8_ -= 16;
      si32(_loc9_ = 0 - _loc16_,_loc8_ + 8);
      var _loc2_:Number = _loc20_ * _loc25_;
      var _loc3_:* = _loc17_ * _loc23_;
      _loc3_ += _loc2_;
      _loc2_ = _loc20_ * _loc20_;
      var _loc4_:Number;
      _loc15_ = (_loc4_ = _loc17_ * _loc17_) + _loc2_;
      _loc3_ /= _loc15_;
      sf64(_loc3_,_loc8_);
      ESP = _loc8_;
      F_scalbn();
      _loc8_ += 16;
      _loc7_ = st0;
      _loc8_ -= 16;
      si32(_loc9_,_loc8_ + 8);
      _loc3_ = _loc20_ * _loc23_;
      var _loc1_:* = _loc17_ * _loc25_;
      _loc1_ -= _loc3_;
      _loc1_ /= _loc15_;
      sf64(_loc1_,_loc8_);
      ESP = _loc8_;
      F_scalbn();
      _loc8_ += 16;
      _loc5_ = st0;
      if(!(_loc7_ == _loc7_ & _loc7_ == _loc7_))
      {
         if(!(_loc5_ == _loc5_ & _loc5_ == _loc5_))
         {
            if(!(_loc15_ != 0 | _loc15_ != _loc15_ | false))
            {
               if(!(_loc23_ == _loc23_ & _loc23_ == _loc23_))
               {
                  if(_loc25_ != _loc25_ | _loc25_ != _loc25_)
                  {
                     addr636:
                     _loc8_ -= 16;
                     sf64(_loc23_,_loc8_);
                     ESP = _loc8_;
                     F_isinf();
                     _loc8_ += 16;
                     if((_loc16_ = eax) == 0)
                     {
                        _loc8_ -= 16;
                        sf64(_loc25_,_loc8_);
                        ESP = _loc8_;
                        F_isinf();
                        _loc8_ += 16;
                        if((_loc9_ = eax) != 0)
                        {
                           addr692:
                           sf64(_loc17_,_loc10_ - 64);
                           if((_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 64) | 4)) >>> 20) & 2047) != 2047)
                           {
                              sf64(_loc20_,_loc10_ - 72);
                              if((_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 72) | 4)) >>> 20) & 2047) != 2047)
                              {
                                 sf64(_loc23_,_loc10_ - 80);
                                 _loc13_ = 0;
                                 if(_loc16_ != 0)
                                 {
                                    _loc13_ = 1072693248;
                                 }
                                 _loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 80) | 4)) & -2147483648;
                                 _loc9_ = _loc13_ | _loc9_;
                                 var _loc14_:* = (_loc14_ = _loc10_ - 88) | 4;
                                 si32(_loc9_,_loc14_);
                                 _loc8_ -= 16;
                                 sf64(_loc25_,_loc8_);
                                 sf64(_loc25_,_loc10_ - 96);
                                 ESP = _loc8_;
                                 F_isinf();
                                 _loc8_ += 16;
                                 _loc9_ = eax;
                                 _loc12_ = 0;
                                 if(_loc9_ != 0)
                                 {
                                    _loc12_ = 1072693248;
                                 }
                                 _loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 96) | 4)) & -2147483648;
                                 _loc9_ = _loc12_ | _loc9_;
                                 _loc14_ = (_loc14_ = _loc10_ - 104) | 4;
                                 si32(_loc9_,_loc14_);
                                 si32(0,_loc10_ - 88);
                                 si32(0,_loc10_ - 104);
                                 _loc3_ = lf64(_loc10_ - 88);
                                 _loc2_ = _loc3_ * _loc20_;
                                 _loc1_ = lf64(_loc10_ - 104);
                                 _loc2_ = (_loc4_ = _loc1_ * _loc17_) - _loc2_;
                                 _loc5_ = _loc2_ * inf;
                                 _loc3_ *= _loc17_;
                                 _loc1_ *= _loc20_;
                                 _loc1_ = _loc3_ + _loc1_;
                                 _loc7_ = _loc1_ * inf;
                              }
                              §§goto(addr1225);
                           }
                        }
                        _loc8_ -= 16;
                        sf64(_loc19_,_loc8_);
                        ESP = _loc8_;
                        F_isinf();
                        _loc8_ += 16;
                        if((_loc9_ = eax) != 0)
                        {
                           if(!(_loc19_ <= 0 | _loc19_ != _loc19_ | false))
                           {
                              sf64(_loc23_,_loc10_ - 112);
                              if((_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 112) | 4)) >>> 20) & 2047) != 2047)
                              {
                                 sf64(_loc25_,_loc10_ - 120);
                                 if((_loc9_ = (_loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 120) | 4)) >>> 20) & 2047) != 2047)
                                 {
                                    _loc8_ -= 16;
                                    sf64(_loc17_,_loc8_);
                                    sf64(_loc17_,_loc10_ - 128);
                                    ESP = _loc8_;
                                    F_isinf();
                                    _loc8_ += 16;
                                    _loc6_ = 0;
                                    if(eax != 0)
                                    {
                                       _loc6_ = 1072693248;
                                    }
                                    _loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 128) | 4)) & -2147483648;
                                    _loc9_ = _loc6_ | _loc9_;
                                    _loc14_ = (_loc14_ = _loc10_ - 136) | 4;
                                    si32(_loc9_,_loc14_);
                                    sf64(_loc20_,_loc10_ - 144);
                                    _loc8_ -= 16;
                                    sf64(_loc20_,_loc8_);
                                    ESP = _loc8_;
                                    F_isinf();
                                    _loc8_ += 16;
                                    _loc9_ = eax;
                                    _loc11_ = 0;
                                    if(_loc9_ != 0)
                                    {
                                       _loc11_ = 1072693248;
                                    }
                                    _loc9_ = (_loc9_ = li32(_loc9_ = (_loc9_ = _loc10_ - 144) | 4)) & -2147483648;
                                    _loc9_ = _loc11_ | _loc9_;
                                    _loc14_ = (_loc14_ = _loc10_ - 152) | 4;
                                    si32(_loc9_,_loc14_);
                                    si32(0,_loc10_ - 136);
                                    si32(0,_loc10_ - 152);
                                    _loc3_ = lf64(_loc10_ - 136);
                                    _loc2_ = _loc3_ * _loc25_;
                                    _loc1_ = lf64(_loc10_ - 152);
                                    _loc4_ = _loc1_ * _loc23_;
                                    _loc2_ -= _loc4_;
                                    _loc5_ = _loc2_ * 0;
                                    _loc3_ *= _loc23_;
                                    _loc1_ *= _loc25_;
                                    _loc1_ = _loc3_ + _loc1_;
                                    _loc7_ = _loc1_ * 0;
                                 }
                              }
                           }
                        }
                        §§goto(addr1225);
                     }
                     §§goto(addr692);
                  }
                  §§goto(addr1225);
               }
               sf64(_loc17_,_loc10_ - 48);
               _loc9_ = (_loc9_ = _loc10_ - 56) | 4;
               si32(_loc14_ = (_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 48) | 4)) & -2147483648) | 2146435072,_loc9_);
               si32(0,_loc10_ - 56);
               _loc1_ = lf64(_loc10_ - 56);
               _loc5_ = _loc1_ * _loc25_;
               _loc7_ = _loc1_ * _loc23_;
               §§goto(addr1225);
            }
            §§goto(addr636);
         }
      }
      addr1225:
      sf64(_loc7_,_loc18_);
      sf64(_loc5_,_loc18_ + 8);
      ESP = _loc8_ = _loc10_;
   }
}
