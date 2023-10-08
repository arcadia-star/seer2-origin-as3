package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F___mulsc3() : void
   {
      var _loc4_:* = 0;
      var _loc10_:* = NaN;
      var _loc8_:* = NaN;
      var _loc12_:* = NaN;
      var _loc20_:* = NaN;
      var _loc26_:* = 0;
      var _loc32_:* = 0;
      var _loc31_:* = 0;
      var _loc9_:* = NaN;
      var _loc7_:* = NaN;
      var _loc18_:* = NaN;
      var _loc44_:* = 0;
      var _loc28_:* = 0;
      var _loc29_:* = 0;
      var _loc24_:* = 0;
      var _loc23_:* = 0;
      var _loc11_:* = NaN;
      var _loc13_:* = NaN;
      var _loc41_:* = 0;
      var _loc39_:* = 0;
      var _loc35_:* = 0;
      var _loc42_:* = 0;
      var _loc30_:* = 0;
      var _loc22_:int = 0;
      var _loc37_:* = 0;
      var _loc40_:* = 0;
      var _loc25_:* = 0;
      var _loc27_:* = 0;
      var _loc33_:int = 0;
      var _loc17_:* = NaN;
      var _loc21_:* = NaN;
      var _loc19_:* = NaN;
      var _loc15_:* = NaN;
      var _loc5_:* = NaN;
      var _loc14_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 112;
      _loc9_ = _loc19_ = lf32(_loc4_ + 8);
      _loc11_ = _loc20_ = _loc13_ = (_loc7_ = _loc21_ = lf32(_loc4_ + 4)) * _loc9_;
      _loc18_ = _loc15_ = lf32(_loc4_ + 12);
      var _loc16_:*;
      _loc14_ = _loc11_ = (_loc16_ = _loc12_ = _loc16_ = (_loc13_ = _loc17_ = lf32(_loc4_)) * _loc18_) + _loc11_;
      _loc7_ = _loc8_ = _loc7_ *= _loc18_;
      _loc13_ = _loc5_ = _loc13_ = (_loc13_ = _loc10_ = _loc13_ *= _loc9_) - _loc7_;
      if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
      {
         _loc13_ = _loc14_;
         if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
         {
            sf32(_loc21_,_loc4_ - 8);
            sf32(_loc17_,_loc4_ - 4);
            var _loc46_:*;
            _loc44_ = (_loc46_ = (_loc26_ = li32(_loc4_ - 8)) >>> 23) & 255;
            _loc41_ = _loc42_ = 1;
            if(_loc44_ != 255)
            {
               _loc41_ = 0;
            }
            _loc40_ = _loc26_ & 8388607;
            _loc39_ = _loc42_;
            if(_loc40_ != 0)
            {
               _loc39_ = 0;
            }
            _loc46_ = (_loc46_ = (_loc37_ = li32(_loc4_ - 4)) >>> 23) & 255;
            _loc35_ = _loc42_;
            if(_loc46_ != 255)
            {
               _loc35_ = 0;
            }
            if((_loc46_ = _loc37_ & 8388607) != 0)
            {
               _loc42_ = 0;
            }
            if((_loc42_ = _loc35_ & _loc42_) == 0)
            {
               _loc39_ = 0;
               if(((_loc46_ = _loc41_ & _loc39_) & 1) != 0)
               {
                  addr279:
                  _loc22_ = 0;
                  _loc30_ = 1065353216;
                  if(_loc42_ == _loc22_)
                  {
                     _loc30_ = _loc22_;
                  }
                  _loc46_ = _loc37_ & -2147483648;
                  si32(_loc46_ = _loc30_ | _loc46_,_loc4_ - 12);
                  _loc39_ = _loc30_ = 1;
                  if(_loc44_ == 255)
                  {
                     _loc39_ = _loc22_;
                  }
                  if(_loc40_ == _loc22_)
                  {
                     _loc30_ = _loc22_;
                  }
                  _loc46_ = _loc39_ | _loc30_;
                  if((_loc46_ = _loc42_ & _loc46_) == _loc22_)
                  {
                     _loc22_ = 1065353216;
                  }
                  _loc46_ = _loc26_ & -2147483648;
                  si32(_loc46_ = _loc22_ | _loc46_,_loc4_ - 16);
                  _loc17_ = lf32(_loc4_ - 12);
                  _loc21_ = lf32(_loc4_ - 16);
                  if(!(_loc9_ == _loc9_ & _loc9_ == _loc9_))
                  {
                     sf32(_loc19_,_loc4_ - 20);
                     si32(_loc46_ = (_loc46_ = li32(_loc4_ - 20)) & -2147483648,_loc4_ - 24);
                     _loc19_ = lf32(_loc4_ - 24);
                  }
                  _loc39_ = 1;
                  if(!(_loc18_ == _loc18_ & _loc18_ == _loc18_))
                  {
                     sf32(_loc15_,_loc4_ - 28);
                     si32(_loc46_ = (_loc46_ = li32(_loc4_ - 28)) & -2147483648,_loc4_ - 32);
                     _loc39_ = 1;
                     _loc15_ = lf32(_loc4_ - 32);
                  }
               }
               sf32(_loc15_,_loc4_ - 40);
               sf32(_loc19_,_loc4_ - 36);
               _loc44_ = (_loc46_ = (_loc31_ = li32(_loc4_ - 40)) >>> 23) & 255;
               _loc42_ = _loc41_ = 1;
               if(_loc44_ != 255)
               {
                  _loc42_ = 0;
               }
               _loc26_ = _loc31_ & 8388607;
               _loc37_ = _loc41_;
               if(_loc26_ != 0)
               {
                  _loc37_ = 0;
               }
               _loc46_ = (_loc46_ = (_loc32_ = li32(_loc4_ - 36)) >>> 23) & 255;
               _loc40_ = _loc41_;
               if(_loc46_ != 255)
               {
                  _loc40_ = 0;
               }
               if((_loc46_ = _loc32_ & 8388607) != 0)
               {
                  _loc41_ = 0;
               }
               if((_loc40_ &= _loc41_) == 0)
               {
                  if((_loc46_ = (_loc46_ = _loc42_ & _loc37_) & 1) != 0)
                  {
                     addr525:
                     _loc33_ = 0;
                     _loc25_ = 1065353216;
                     if(_loc40_ == _loc33_)
                     {
                        _loc25_ = _loc33_;
                     }
                     _loc46_ = _loc32_ & -2147483648;
                     si32(_loc46_ = _loc25_ | _loc46_,_loc4_ - 84);
                     _loc25_ = _loc27_ = 1;
                     if(_loc44_ == 255)
                     {
                        _loc25_ = _loc33_;
                     }
                     if(_loc26_ == _loc33_)
                     {
                        _loc27_ = _loc33_;
                     }
                     _loc46_ = _loc25_ | _loc27_;
                     if((_loc46_ = _loc40_ & _loc46_) == _loc33_)
                     {
                        _loc33_ = 1065353216;
                     }
                     _loc46_ = _loc31_ & -2147483648;
                     si32(_loc46_ = _loc33_ | _loc46_,_loc4_ - 88);
                     _loc13_ = _loc17_;
                     _loc19_ = lf32(_loc4_ - 84);
                     _loc15_ = lf32(_loc4_ - 88);
                     if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                     {
                        sf32(_loc17_,_loc4_ - 92);
                        si32(_loc46_ = (_loc46_ = li32(_loc4_ - 92)) & -2147483648,_loc4_ - 96);
                        _loc17_ = lf32(_loc4_ - 96);
                     }
                     _loc13_ = _loc21_;
                     if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                     {
                        sf32(_loc21_,_loc4_ - 100);
                        si32(_loc46_ = (_loc46_ = li32(_loc4_ - 100)) & -2147483648,_loc4_ - 104);
                        _loc21_ = lf32(_loc4_ - 104);
                     }
                  }
                  else if(_loc39_ == 0)
                  {
                     sf32(_loc10_,_loc4_ - 44);
                     if((_loc46_ = (_loc46_ = (_loc28_ = li32(_loc4_ - 44)) >>> 23) & 255) == 255)
                     {
                        if((_loc46_ = _loc28_ & 8388607) != 0)
                        {
                           §§goto(addr709);
                        }
                        §§goto(addr802);
                     }
                     addr709:
                     sf32(_loc8_,_loc4_ - 48);
                     if((_loc46_ = (_loc46_ = (_loc29_ = li32(_loc4_ - 48)) >>> 23) & 255) == 255)
                     {
                        if((_loc46_ = _loc29_ & 8388607) != 0)
                        {
                        }
                        §§goto(addr802);
                     }
                     sf32(_loc12_,_loc4_ - 52);
                     if((_loc46_ = (_loc46_ = (_loc24_ = li32(_loc4_ - 52)) >>> 23) & 255) == 255)
                     {
                        if((_loc46_ = _loc24_ & 8388607) != 0)
                        {
                        }
                        addr802:
                        _loc13_ = _loc17_;
                        if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                        {
                           sf32(_loc17_,_loc4_ - 60);
                           si32(_loc46_ = (_loc46_ = li32(_loc4_ - 60)) & -2147483648,_loc4_ - 64);
                           _loc17_ = lf32(_loc4_ - 64);
                        }
                        _loc13_ = _loc21_;
                        if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                        {
                           sf32(_loc21_,_loc4_ - 68);
                           si32(_loc46_ = (_loc46_ = li32(_loc4_ - 68)) & -2147483648,_loc4_ - 72);
                           _loc21_ = lf32(_loc4_ - 72);
                        }
                        _loc13_ = _loc19_;
                        if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                        {
                           si32(_loc46_ = _loc32_ & -2147483648,_loc4_ - 76);
                           _loc19_ = lf32(_loc4_ - 76);
                        }
                        _loc13_ = _loc15_;
                        if(!(_loc13_ == _loc13_ & _loc13_ == _loc13_))
                        {
                           si32(_loc46_ = _loc31_ & -2147483648,_loc4_ - 80);
                           _loc15_ = lf32(_loc4_ - 80);
                        }
                        §§goto(addr926);
                     }
                     sf32(_loc20_,_loc4_ - 56);
                     if((_loc46_ = (_loc46_ = (_loc23_ = li32(_loc4_ - 56)) >>> 23) & 255) == 255)
                     {
                        if((_loc46_ = _loc23_ & 8388607) == 0)
                        {
                        }
                     }
                     §§goto(addr926);
                  }
                  §§goto(addr926);
               }
               §§goto(addr525);
            }
            §§goto(addr279);
         }
      }
      addr926:
      _loc13_ = _loc19_;
      var _loc43_:*;
      _loc11_ = _loc43_ = _loc7_ = (_loc16_ = _loc21_) * _loc13_;
      var _loc1_:* = _loc15_;
      var _loc2_:* = (_loc7_ = _loc17_) * _loc1_;
      var _loc45_:*;
      _loc2_ = _loc45_ = _loc2_;
      var _loc34_:*;
      _loc2_ = _loc34_ = _loc11_ = _loc2_ + _loc11_;
      _loc11_ = _loc34_ = inf;
      _loc2_ *= _loc11_;
      _loc14_ = _loc2_;
      var _loc36_:*;
      _loc16_ = _loc36_ = _loc16_ *= _loc1_;
      var _loc38_:*;
      _loc5_ = _loc13_ = (_loc13_ = _loc38_ = _loc13_ = (_loc13_ = _loc38_ = _loc13_ = _loc7_ * _loc13_) - _loc16_) * _loc11_;
      sf32(_loc5_,_loc4_ - 108);
      sf32(_loc14_,_loc4_ - 112);
      _loc46_ = li32(_loc4_ - 108);
      var _loc6_:* = li32(_loc4_ - 112);
      eax = _loc46_;
      edx = _loc6_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
