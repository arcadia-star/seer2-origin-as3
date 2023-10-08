package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___divdc3() : void
   {
      var _loc10_:int = 0;
      var _loc9_:* = 0;
      var _loc24_:* = NaN;
      var _loc26_:* = NaN;
      var _loc18_:* = 0;
      var _loc16_:* = 0;
      var _loc15_:* = 0;
      var _loc22_:* = NaN;
      var _loc19_:* = NaN;
      var _loc5_:Number = NaN;
      var _loc17_:* = NaN;
      var _loc21_:* = NaN;
      var _loc23_:* = 0;
      var _loc25_:* = 0;
      var _loc1_:* = NaN;
      var _loc14_:int = 0;
      var _loc6_:int = 0;
      var _loc11_:int = 0;
      var _loc12_:int = 0;
      var _loc13_:int = 0;
      var _loc8_:* = (_loc10_ = ESP) - 176;
      _loc17_ = _loc19_ = lf64(_loc10_ + 20);
      if(!(_loc19_ >= 0 | _loc19_ != _loc19_ | false))
      {
         _loc17_ = -_loc19_;
      }
      _loc21_ = _loc22_ = lf64(_loc10_ + 28);
      if(!(_loc22_ >= 0 | _loc22_ != _loc22_ | false))
      {
         _loc21_ = -_loc22_;
      }
      _loc26_ = lf64(_loc10_ + 12);
      _loc24_ = lf64(_loc10_ + 4);
      _loc9_ = li32(_loc10_);
      sf64(_loc17_,_loc10_ - 16);
      sf64(_loc17_,_loc10_ - 24);
      sf64(_loc21_,_loc10_ - 32);
      sf64(_loc21_,_loc10_ - 8);
      var _loc27_:* = (_loc27_ = (_loc25_ = li32(_loc27_ = (_loc27_ = _loc10_ - 24) | 4)) >>> 20) & 2047;
      _loc23_ = li32(_loc10_ - 32);
      if(_loc27_ == 2047)
      {
         _loc1_ = _loc21_;
         if(((_loc27_ = _loc25_ & 1048575) | li32(_loc10_ - 24)) == 0)
         {
            addr180:
            if((_loc27_ = (_loc27_ = (_loc18_ = li32(_loc10_ - 4)) >>> 20) & 2047) == 2047)
            {
               _loc1_ = _loc17_;
               if(((_loc27_ = _loc18_ & 1048575) | _loc23_) == 0)
               {
               }
               §§goto(addr277);
            }
            _loc23_ = _loc25_ = 1;
            if(_loc18_ >= 0)
            {
               _loc23_ = 0;
            }
            if((_loc16_ = li32(_loc27_ = (_loc18_ = _loc10_ - 16) | 4)) >= 0)
            {
               _loc25_ = 0;
            }
            if((_loc27_ = (_loc27_ = _loc25_ ^ _loc23_) & 1) != 0)
            {
               _loc1_ = lf64(_loc27_ = _loc18_ + ((_loc27_ = _loc16_ & -2147483648) >>> 28));
            }
            else
            {
               if(_loc17_ <= _loc21_)
               {
                  _loc17_ = _loc21_;
               }
               _loc1_ = _loc17_;
            }
         }
         addr277:
         sf64(_loc1_,_loc10_ - 40);
         _loc15_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 40) | 4)) & 2147483647;
         _loc27_ = li32(_loc10_ - 40);
         if((_loc27_ = _loc15_ | _loc27_) == 0)
         {
            if(!(_loc1_ >= 0 | _loc1_ != _loc1_ | false))
            {
               _loc1_ = -_loc1_;
            }
            _loc21_ = -1 / _loc1_;
         }
         else if(uint(_loc15_) >= 2146435072)
         {
            _loc21_ = _loc1_ * _loc1_;
         }
         else if(uint(_loc15_) <= 1048575)
         {
            sf64(_loc1_ * 18014398509481984,_loc10_ - 48);
            _loc21_ = _loc27_ = (_loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 48) | 4)) >>> 20) & 2047) + -1077;
         }
         else
         {
            _loc21_ = _loc27_ = (_loc27_ = _loc15_ >>> 20) + -1023;
         }
         sf64(_loc21_,_loc10_ - 56);
         _loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 56) | 4)) >>> 20) & 2047;
         _loc14_ = 0;
         if(_loc27_ != 2047)
         {
            _loc8_ -= 16;
            sf64(_loc19_,_loc8_);
            _loc14_ = _loc21_;
            si32(_loc27_ = 0 - _loc14_,_loc8_ + 8);
            ESP = _loc8_;
            F_scalbn();
            _loc8_ += 16;
            _loc19_ = st0;
            _loc8_ -= 16;
            si32(_loc27_,_loc8_ + 8);
            sf64(_loc22_,_loc8_);
            ESP = _loc8_;
            F_scalbn();
            _loc8_ += 16;
            _loc22_ = st0;
         }
         _loc8_ -= 16;
         si32(_loc27_ = 0 - _loc14_,_loc8_ + 8);
         var _loc3_:Number = _loc22_ * _loc26_;
         var _loc4_:* = (_loc4_ = _loc19_ * _loc24_) + _loc3_;
         _loc3_ = _loc22_ * _loc22_;
         var _loc7_:Number;
         _loc5_ = (_loc7_ = _loc19_ * _loc19_) + _loc3_;
         sf64(_loc4_ /= _loc5_,_loc8_);
         ESP = _loc8_;
         F_scalbn();
         _loc8_ += 16;
         _loc17_ = st0;
         _loc8_ -= 16;
         si32(_loc27_,_loc8_ + 8);
         var _loc2_:* = _loc22_ * _loc24_;
         _loc2_ = (_loc4_ = _loc19_ * _loc26_) - _loc2_;
         _loc2_ /= _loc5_;
         sf64(_loc2_,_loc8_);
         ESP = _loc8_;
         F_scalbn();
         _loc8_ += 16;
         _loc1_ = st0;
         if(!(_loc17_ == _loc17_ & _loc17_ == _loc17_))
         {
            if(!(_loc1_ == _loc1_ & _loc1_ == _loc1_))
            {
               if(!(_loc5_ != 0 | _loc5_ != _loc5_ | false))
               {
                  if(!(_loc24_ == _loc24_ & _loc24_ == _loc24_))
                  {
                     if(_loc26_ != _loc26_ | _loc26_ != _loc26_)
                     {
                        addr724:
                        _loc8_ -= 16;
                        sf64(_loc24_,_loc8_);
                        ESP = _loc8_;
                        F_isinf();
                        _loc8_ += 16;
                        if((_loc18_ = eax) == 0)
                        {
                           _loc8_ -= 16;
                           sf64(_loc26_,_loc8_);
                           ESP = _loc8_;
                           F_isinf();
                           _loc8_ += 16;
                           if((_loc27_ = eax) != 0)
                           {
                              addr780:
                              sf64(_loc19_,_loc10_ - 80);
                              if((_loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 80) | 4)) >>> 20) & 2047) != 2047)
                              {
                                 sf64(_loc22_,_loc10_ - 88);
                                 if((_loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 88) | 4)) >>> 20) & 2047) != 2047)
                                 {
                                    sf64(_loc24_,_loc10_ - 96);
                                    _loc6_ = 0;
                                    if(_loc18_ != 0)
                                    {
                                       _loc6_ = 1072693248;
                                    }
                                    _loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 96) | 4)) & -2147483648;
                                    _loc27_ = _loc6_ | _loc27_;
                                    var _loc20_:* = (_loc20_ = _loc10_ - 104) | 4;
                                    si32(_loc27_,_loc20_);
                                    _loc8_ -= 16;
                                    sf64(_loc26_,_loc8_);
                                    sf64(_loc26_,_loc10_ - 112);
                                    ESP = _loc8_;
                                    F_isinf();
                                    _loc8_ += 16;
                                    _loc27_ = eax;
                                    _loc11_ = 0;
                                    if(_loc27_ != 0)
                                    {
                                       _loc11_ = 1072693248;
                                    }
                                    _loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 112) | 4)) & -2147483648;
                                    _loc27_ = _loc11_ | _loc27_;
                                    _loc20_ = (_loc20_ = _loc10_ - 120) | 4;
                                    si32(_loc27_,_loc20_);
                                    si32(0,_loc10_ - 104);
                                    si32(0,_loc10_ - 120);
                                    _loc7_ = (_loc4_ = lf64(_loc10_ - 104)) * _loc22_;
                                    _loc2_ = lf64(_loc10_ - 120);
                                    _loc3_ = _loc2_ * _loc19_;
                                    _loc3_ -= _loc7_;
                                    _loc1_ = _loc3_ * inf;
                                    _loc4_ *= _loc19_;
                                    _loc2_ *= _loc22_;
                                    _loc2_ = _loc4_ + _loc2_;
                                    _loc17_ = _loc2_ * inf;
                                 }
                                 §§goto(addr1313);
                              }
                           }
                           _loc8_ -= 16;
                           sf64(_loc21_,_loc8_);
                           ESP = _loc8_;
                           F_isinf();
                           _loc8_ += 16;
                           if((_loc27_ = eax) != 0)
                           {
                              if(!(_loc21_ <= 0 | _loc21_ != _loc21_ | false))
                              {
                                 sf64(_loc24_,_loc10_ - 128);
                                 if((_loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 128) | 4)) >>> 20) & 2047) != 2047)
                                 {
                                    sf64(_loc26_,_loc10_ - 136);
                                    if((_loc27_ = (_loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 136) | 4)) >>> 20) & 2047) != 2047)
                                    {
                                       _loc8_ -= 16;
                                       sf64(_loc19_,_loc8_);
                                       sf64(_loc19_,_loc10_ - 144);
                                       ESP = _loc8_;
                                       F_isinf();
                                       _loc8_ += 16;
                                       _loc12_ = 0;
                                       if(eax != 0)
                                       {
                                          _loc12_ = 1072693248;
                                       }
                                       _loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 144) | 4)) & -2147483648;
                                       _loc27_ = _loc12_ | _loc27_;
                                       _loc20_ = (_loc20_ = _loc10_ - 152) | 4;
                                       si32(_loc27_,_loc20_);
                                       sf64(_loc22_,_loc10_ - 160);
                                       _loc8_ -= 16;
                                       sf64(_loc22_,_loc8_);
                                       ESP = _loc8_;
                                       F_isinf();
                                       _loc8_ += 16;
                                       _loc27_ = eax;
                                       _loc13_ = 0;
                                       if(_loc27_ != 0)
                                       {
                                          _loc13_ = 1072693248;
                                       }
                                       _loc27_ = (_loc27_ = li32(_loc27_ = (_loc27_ = _loc10_ - 160) | 4)) & -2147483648;
                                       _loc27_ = _loc13_ | _loc27_;
                                       _loc20_ = (_loc20_ = _loc10_ - 168) | 4;
                                       si32(_loc27_,_loc20_);
                                       si32(0,_loc10_ - 152);
                                       si32(0,_loc10_ - 168);
                                       _loc7_ = (_loc4_ = lf64(_loc10_ - 152)) * _loc26_;
                                       _loc2_ = lf64(_loc10_ - 168);
                                       _loc3_ = _loc2_ * _loc24_;
                                       _loc3_ = _loc7_ - _loc3_;
                                       _loc1_ = _loc3_ * 0;
                                       _loc4_ *= _loc24_;
                                       _loc2_ *= _loc26_;
                                       _loc2_ = _loc4_ + _loc2_;
                                       _loc17_ = _loc2_ * 0;
                                    }
                                 }
                              }
                           }
                           §§goto(addr1313);
                        }
                        §§goto(addr780);
                     }
                     §§goto(addr1313);
                  }
                  sf64(_loc19_,_loc10_ - 64);
                  _loc27_ = (_loc27_ = _loc10_ - 72) | 4;
                  si32(_loc20_ = (_loc20_ = (_loc20_ = li32(_loc20_ = (_loc20_ = _loc10_ - 64) | 4)) & -2147483648) | 2146435072,_loc27_);
                  si32(0,_loc10_ - 72);
                  _loc2_ = lf64(_loc10_ - 72);
                  _loc1_ = _loc2_ * _loc26_;
                  _loc17_ = _loc2_ * _loc24_;
                  §§goto(addr1313);
               }
               §§goto(addr724);
            }
         }
         addr1313:
         sf64(_loc17_,_loc9_);
         sf64(_loc1_,_loc9_ + 8);
         ESP = _loc8_ = _loc10_;
         return;
      }
      §§goto(addr180);
   }
}
