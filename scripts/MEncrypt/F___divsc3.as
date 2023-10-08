package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F___divsc3() : void
   {
      var _loc6_:int = 0;
      var _loc16_:* = NaN;
      var _loc21_:* = NaN;
      var _loc12_:* = NaN;
      var _loc18_:* = NaN;
      var _loc38_:* = 0;
      var _loc37_:* = 0;
      var _loc20_:* = NaN;
      var _loc22_:* = NaN;
      var _loc35_:* = 0;
      var _loc31_:* = 0;
      var _loc25_:* = 0;
      var _loc10_:* = NaN;
      var _loc36_:* = 0;
      var _loc19_:* = NaN;
      var _loc17_:* = NaN;
      var _loc1_:* = NaN;
      var _loc4_:* = NaN;
      var _loc33_:* = 0;
      var _loc42_:* = 0;
      var _loc29_:* = 0;
      var _loc40_:* = 0;
      var _loc8_:* = NaN;
      var _loc14_:* = NaN;
      var _loc11_:* = NaN;
      var _loc23_:* = 0;
      var _loc28_:* = 0;
      var _loc27_:int = 0;
      var _loc24_:* = 0;
      var _loc30_:int = 0;
      var _loc32_:* = NaN;
      var _loc34_:* = NaN;
      var _loc5_:* = (_loc6_ = ESP) - 96;
      sf32(_loc20_ = lf32(_loc6_ + 12),_loc6_ - 8);
      sf32(_loc22_ = lf32(_loc6_ + 8),_loc6_ - 4);
      si32(_loc42_ = (_loc25_ = li32(_loc6_ - 8)) & 2147483647,_loc6_ - 16);
      si32(_loc42_ = (_loc40_ = li32(_loc6_ - 4)) & 2147483647,_loc6_ - 12);
      _loc42_ = (_loc42_ = _loc40_ >>> 23) & 255;
      _loc21_ = lf32(_loc6_ + 4);
      _loc16_ = lf32(_loc6_);
      _loc18_ = lf32(_loc6_ - 16);
      _loc12_ = lf32(_loc6_ - 12);
      if(_loc42_ == 255)
      {
         _loc14_ = _loc18_;
         if((_loc40_ & 8388607) == 0)
         {
            addr164:
            if((_loc42_ = (_loc42_ = _loc25_ >>> 23) & 255) == 255)
            {
               _loc14_ = _loc12_;
               if((_loc25_ & 8388607) == 0)
               {
               }
               §§goto(addr198);
            }
            _loc10_ = _loc18_;
            if((_loc8_ = _loc12_) <= _loc10_)
            {
               _loc8_ = _loc10_;
            }
            _loc14_ = _loc8_;
         }
         addr198:
         sf32(_loc14_,_loc6_ - 20);
         if((_loc38_ = (_loc42_ = li32(_loc6_ - 20)) & 2147483647) == 0)
         {
            si32(_loc38_,_loc6_ - 28);
            var _loc13_:*;
            var _loc9_:*;
            _loc11_ = _loc13_ = (_loc9_ = -1) / lf32(_loc6_ - 28);
         }
         else if(uint(_loc38_) >= 2139095040)
         {
            _loc13_ = _loc14_;
            _loc11_ = _loc13_ *= _loc13_;
         }
         else if(uint(_loc38_) <= 8388607)
         {
            var _loc7_:*;
            sf32(_loc13_ = _loc14_ * (_loc7_ = 33554432),_loc6_ - 24);
            _loc11_ = _loc42_ = (_loc42_ = (_loc42_ = (_loc42_ = li32(_loc6_ - 24)) >>> 23) & 255) + -152;
         }
         else
         {
            _loc11_ = _loc42_ = (_loc42_ = _loc38_ >>> 23) + -127;
         }
         sf32(_loc11_,_loc6_ - 32);
         _loc36_ = (_loc42_ = (_loc37_ = li32(_loc6_ - 32)) >>> 23) & 255;
         _loc38_ = 0;
         if(_loc36_ != 255)
         {
            _loc5_ -= 16;
            sf32(_loc22_,_loc5_);
            _loc38_ = _loc11_;
            si32(_loc42_ = 0 - _loc38_,_loc5_ + 4);
            ESP = _loc5_;
            F_scalbnf();
            _loc5_ += 16;
            _loc22_ = st0;
            _loc5_ -= 16;
            si32(_loc42_,_loc5_ + 4);
            sf32(_loc20_,_loc5_);
            ESP = _loc5_;
            F_scalbnf();
            _loc5_ += 16;
            _loc20_ = st0;
         }
         _loc5_ -= 16;
         si32(_loc42_ = 0 - _loc38_,_loc5_ + 4);
         _loc8_ = _loc21_;
         var _loc15_:* = _loc7_ = _loc15_ = (_loc19_ = _loc20_) * _loc8_;
         _loc17_ = _loc16_;
         _loc1_ = _loc22_;
         var _loc2_:* = _loc1_ * _loc17_;
         var _loc39_:*;
         _loc2_ = _loc39_ = _loc2_;
         _loc15_ = _loc7_ = _loc15_ = _loc2_ + _loc15_;
         _loc2_ = _loc19_ * _loc19_;
         _loc2_ = _loc39_ = _loc2_;
         var _loc3_:* = _loc1_ * _loc1_;
         var _loc41_:*;
         _loc3_ = _loc41_ = _loc3_;
         _loc2_ = _loc3_ + _loc2_;
         _loc4_ = _loc39_ = _loc2_;
         sf32(_loc15_ /= _loc4_,_loc5_);
         ESP = _loc5_;
         F_scalbnf();
         _loc5_ += 16;
         _loc32_ = st0;
         _loc5_ -= 16;
         si32(_loc42_,_loc5_ + 4);
         _loc13_ = _loc9_ = _loc13_ = _loc19_ * _loc17_;
         sf32(_loc13_ = (_loc13_ = _loc9_ = _loc13_ = (_loc15_ = _loc7_ = _loc15_ = _loc1_ * _loc8_) - _loc13_) / _loc4_,_loc5_);
         ESP = _loc5_;
         F_scalbnf();
         _loc13_ = _loc32_;
         _loc5_ += 16;
         _loc34_ = st0;
         if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
         {
            _loc13_ = _loc34_;
            if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
            {
               _loc10_ = _loc9_ = 0;
               if(!(_loc4_ != _loc10_ | _loc4_ != _loc4_ | _loc10_ != _loc10_))
               {
                  if(!(_loc17_ == _loc17_ & _loc17_ == _loc17_))
                  {
                     if(_loc8_ != _loc8_ | _loc8_ != _loc8_)
                     {
                        addr658:
                        sf32(_loc16_,_loc6_ - 44);
                        _loc33_ = (_loc42_ = (_loc35_ = li32(_loc6_ - 44)) >>> 23) & 255;
                        _loc23_ = _loc31_ = 1;
                        if(_loc33_ != 255)
                        {
                           _loc23_ = 0;
                        }
                        if((_loc42_ = _loc35_ & 8388607) != 0)
                        {
                           _loc31_ = 0;
                        }
                        if((_loc31_ = _loc23_ & _loc31_) == 0)
                        {
                           sf32(_loc21_,_loc6_ - 48);
                           if((_loc42_ = (_loc42_ = (_loc23_ = li32(_loc6_ - 48)) >>> 23) & 255) == 255)
                           {
                              if((_loc42_ = _loc23_ & 8388607) == 0)
                              {
                                 addr736:
                                 sf32(_loc22_,_loc6_ - 52);
                                 if((_loc42_ = (_loc42_ = (_loc42_ = li32(_loc6_ - 52)) >>> 23) & 255) != 255)
                                 {
                                    sf32(_loc20_,_loc6_ - 56);
                                    if((_loc42_ = (_loc42_ = (_loc42_ = li32(_loc6_ - 56)) >>> 23) & 255) != 255)
                                    {
                                       sf32(_loc21_,_loc6_ - 60);
                                       _loc28_ = _loc27_ = 1065353216;
                                       if(_loc31_ == 0)
                                       {
                                          _loc28_ = 0;
                                       }
                                       _loc42_ = _loc35_ & -2147483648;
                                       si32(_loc42_ = _loc28_ | _loc42_,_loc6_ - 64);
                                       _loc42_ = (_loc42_ = (_loc38_ = li32(_loc6_ - 60)) >>> 23) & 255;
                                       _loc29_ = _loc28_ = 1;
                                       if(_loc42_ != 255)
                                       {
                                          _loc29_ = 0;
                                       }
                                       if((_loc42_ = _loc38_ & 8388607) != 0)
                                       {
                                          _loc28_ = 0;
                                       }
                                       if((_loc42_ = _loc29_ & _loc28_) == 0)
                                       {
                                          _loc27_ = 0;
                                       }
                                       _loc42_ = _loc38_ & -2147483648;
                                       si32(_loc42_ = _loc27_ | _loc42_,_loc6_ - 68);
                                       _loc2_ = lf32(_loc6_ - 64);
                                       _loc15_ = _loc9_ = _loc13_ = _loc2_ * _loc19_;
                                       _loc3_ = (_loc13_ = lf32(_loc6_ - 68)) * _loc1_;
                                       _loc3_ = _loc41_ = _loc3_;
                                       _loc3_ = _loc7_ = _loc15_ = _loc3_ - _loc15_;
                                       _loc15_ = _loc7_ = inf;
                                       _loc3_ *= _loc15_;
                                       _loc34_ = _loc3_;
                                       _loc2_ *= _loc1_;
                                       _loc2_ = _loc39_ = _loc2_;
                                       _loc13_ = _loc9_ = _loc13_ *= _loc19_;
                                       _loc32_ = _loc13_ = (_loc13_ = _loc9_ = _loc13_ = _loc2_ + _loc13_) * _loc15_;
                                    }
                                    §§goto(addr1237);
                                 }
                              }
                           }
                           _loc13_ = _loc11_;
                           _loc40_ = _loc30_ = 1;
                           if(!(_loc13_ <= _loc10_ | _loc13_ != _loc13_ | _loc10_ != _loc10_))
                           {
                              _loc40_ = 0;
                           }
                           _loc24_ = _loc30_;
                           if(_loc36_ == 255)
                           {
                              _loc24_ = 0;
                           }
                           if((_loc42_ = _loc37_ & 8388607) == 0)
                           {
                              _loc30_ = 0;
                           }
                           if(_loc33_ != 255)
                           {
                              if((_loc42_ = (_loc42_ = _loc24_ | _loc30_) | _loc40_) == 0)
                              {
                                 sf32(_loc21_,_loc6_ - 72);
                                 if((_loc42_ = (_loc42_ = (_loc42_ = li32(_loc6_ - 72)) >>> 23) & 255) != 255)
                                 {
                                    sf32(_loc20_,_loc6_ - 80);
                                    sf32(_loc22_,_loc6_ - 76);
                                    _loc40_ = _loc27_ = 1;
                                    if(((_loc42_ = (_loc29_ = li32(_loc6_ - 80)) >>> 23) & 255) != 255)
                                    {
                                       _loc40_ = 0;
                                    }
                                    _loc42_ = _loc29_ & 8388607;
                                    _loc28_ = _loc27_;
                                    if(_loc42_ != 0)
                                    {
                                       _loc28_ = 0;
                                    }
                                    _loc42_ = _loc40_ & _loc28_;
                                    _loc40_ = _loc28_ = 1065353216;
                                    if(_loc42_ == 0)
                                    {
                                       _loc40_ = 0;
                                    }
                                    _loc42_ = _loc29_ & -2147483648;
                                    si32(_loc42_ = _loc40_ | _loc42_,_loc6_ - 88);
                                    _loc42_ = (_loc42_ = (_loc40_ = li32(_loc6_ - 76)) >>> 23) & 255;
                                    _loc29_ = _loc27_;
                                    if(_loc42_ != 255)
                                    {
                                       _loc29_ = 0;
                                    }
                                    if((_loc42_ = _loc40_ & 8388607) != 0)
                                    {
                                       _loc27_ = 0;
                                    }
                                    if((_loc42_ = _loc29_ & _loc27_) == 0)
                                    {
                                       _loc28_ = 0;
                                    }
                                    _loc42_ = _loc40_ & -2147483648;
                                    si32(_loc42_ = _loc28_ | _loc42_,_loc6_ - 84);
                                    _loc2_ = _loc9_ = _loc13_ = (_loc15_ = lf32(_loc6_ - 88)) * _loc17_;
                                    _loc3_ = (_loc13_ = lf32(_loc6_ - 84)) * _loc8_;
                                    _loc3_ = _loc41_ = _loc3_;
                                    _loc2_ = _loc3_ - _loc2_;
                                    _loc2_ = _loc39_ = _loc2_;
                                    _loc2_ *= _loc10_;
                                    _loc34_ = _loc2_;
                                    _loc15_ = _loc7_ = _loc15_ *= _loc8_;
                                    _loc32_ = _loc13_ = (_loc13_ = _loc9_ = _loc13_ = (_loc13_ = _loc9_ = _loc13_ *= _loc17_) + _loc15_) * _loc10_;
                                 }
                              }
                           }
                           §§goto(addr1237);
                        }
                        §§goto(addr736);
                     }
                     §§goto(addr1237);
                  }
                  sf32(_loc22_,_loc6_ - 36);
                  si32(_loc42_ = (_loc42_ = (_loc42_ = li32(_loc6_ - 36)) & -2147483648) | 2139095040,_loc6_ - 40);
                  _loc34_ = _loc15_ = (_loc13_ = lf32(_loc6_ - 40)) * _loc8_;
                  _loc32_ = _loc13_ *= _loc17_;
                  §§goto(addr1237);
               }
               §§goto(addr658);
            }
         }
         addr1237:
         sf32(_loc32_,_loc6_ - 92);
         sf32(_loc34_,_loc6_ - 96);
         _loc42_ = li32(_loc6_ - 92);
         var _loc26_:* = li32(_loc6_ - 96);
         eax = _loc42_;
         edx = _loc26_;
         ESP = _loc5_ = _loc6_;
         return;
      }
      §§goto(addr164);
   }
}
