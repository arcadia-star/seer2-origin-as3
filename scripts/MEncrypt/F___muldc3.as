package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___muldc3() : void
   {
      var _loc10_:int = 0;
      var _loc3_:Number = NaN;
      var _loc2_:Number = NaN;
      var _loc23_:Number = NaN;
      var _loc21_:Number = NaN;
      var _loc8_:int = 0;
      var _loc20_:int = 0;
      var _loc24_:int = 0;
      var _loc16_:int = 0;
      var _loc13_:int = 0;
      var _loc22_:* = 0;
      var _loc12_:int = 0;
      var _loc7_:int = 0;
      var _loc11_:int = 0;
      var _loc25_:* = NaN;
      var _loc15_:* = NaN;
      var _loc17_:* = NaN;
      var _loc19_:* = NaN;
      var _loc1_:Number = NaN;
      var _loc4_:Number = NaN;
      var _loc9_:* = (_loc10_ = ESP) - 192;
      _loc17_ = lf64(_loc10_ + 20);
      _loc21_ = (_loc15_ = lf64(_loc10_ + 12)) * _loc17_;
      _loc19_ = lf64(_loc10_ + 28);
      _loc1_ = (_loc23_ = (_loc25_ = lf64(_loc10_ + 4)) * _loc19_) + _loc21_;
      _loc2_ = _loc15_ * _loc19_;
      _loc3_ = _loc25_ * _loc17_;
      _loc4_ = _loc3_ - _loc2_;
      if(!(_loc4_ == _loc4_ & _loc4_ == _loc4_))
      {
         if(!(_loc1_ == _loc1_ & _loc1_ == _loc1_))
         {
            _loc9_ -= 16;
            sf64(_loc25_,_loc9_);
            ESP = _loc9_;
            F_isinf();
            _loc9_ += 16;
            _loc8_ = eax;
            _loc9_ -= 16;
            sf64(_loc15_,_loc9_);
            _loc22_ = _loc24_ = 1;
            if(_loc8_ == 0)
            {
               _loc22_ = 0;
            }
            ESP = _loc9_;
            F_isinf();
            _loc9_ += 16;
            if((_loc20_ = eax) == 0)
            {
               _loc24_ = 0;
            }
            if(_loc8_ == 0)
            {
               _loc24_ = 0;
               if((_loc24_ & 1) != 0)
               {
                  addr197:
                  sf64(_loc15_,_loc10_ - 24);
                  _loc16_ = 1;
                  if(_loc20_ != 0)
                  {
                     _loc16_ = 0;
                  }
                  var _loc18_:* = _loc16_ & _loc22_;
                  _loc16_ = 0;
                  if(_loc18_ == 0)
                  {
                     _loc16_ = 1072693248;
                  }
                  _loc18_ = (_loc18_ = li32(_loc18_ = (_loc18_ = _loc10_ - 24) | 4)) & -2147483648;
                  _loc18_ = _loc16_ | _loc18_;
                  var _loc14_:* = (_loc14_ = _loc10_ - 32) | 4;
                  si32(_loc18_,_loc14_);
                  sf64(_loc25_,_loc10_ - 8);
                  _loc13_ = 0;
                  if(_loc8_ != 0)
                  {
                     _loc13_ = 1072693248;
                  }
                  _loc18_ = (_loc18_ = li32(_loc18_ = (_loc18_ = _loc10_ - 8) | 4)) & -2147483648;
                  _loc18_ = _loc13_ | _loc18_;
                  _loc14_ = (_loc14_ = _loc10_ - 16) | 4;
                  si32(_loc18_,_loc14_);
                  si32(0,_loc10_ - 32);
                  si32(0,_loc10_ - 16);
                  _loc15_ = lf64(_loc10_ - 32);
                  _loc25_ = lf64(_loc10_ - 16);
                  if(!(_loc17_ == _loc17_ & _loc17_ == _loc17_))
                  {
                     sf64(_loc17_,_loc10_ - 40);
                     si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 40) | 4)) & -2147483648,(_loc18_ = _loc10_ - 48) | 4);
                     si32(0,_loc10_ - 48);
                     _loc17_ = lf64(_loc10_ - 48);
                  }
                  _loc24_ = 1;
                  if(!(_loc19_ == _loc19_ & _loc19_ == _loc19_))
                  {
                     sf64(_loc19_,_loc10_ - 56);
                     si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 56) | 4)) & -2147483648,(_loc18_ = _loc10_ - 64) | 4);
                     si32(0,_loc10_ - 64);
                     _loc24_ = 1;
                     _loc19_ = lf64(_loc10_ - 64);
                  }
               }
               _loc9_ -= 16;
               sf64(_loc17_,_loc9_);
               ESP = _loc9_;
               F_isinf();
               _loc9_ += 16;
               _loc8_ = eax;
               _loc9_ -= 16;
               sf64(_loc19_,_loc9_);
               _loc22_ = _loc12_ = 1;
               if(_loc8_ == 0)
               {
                  _loc22_ = 0;
               }
               ESP = _loc9_;
               F_isinf();
               _loc9_ += 16;
               if((_loc20_ = eax) == 0)
               {
                  _loc12_ = 0;
               }
               if(_loc8_ == 0)
               {
                  if((_loc18_ = _loc12_ & 1) != 0)
                  {
                     addr503:
                     sf64(_loc19_,_loc10_ - 152);
                     _loc7_ = 1;
                     if(_loc20_ != 0)
                     {
                        _loc7_ = 0;
                     }
                     _loc18_ = _loc7_ & _loc22_;
                     _loc7_ = 0;
                     if(_loc18_ == 0)
                     {
                        _loc7_ = 1072693248;
                     }
                     _loc18_ = (_loc18_ = li32(_loc18_ = (_loc18_ = _loc10_ - 152) | 4)) & -2147483648;
                     _loc18_ = _loc7_ | _loc18_;
                     _loc14_ = (_loc14_ = _loc10_ - 160) | 4;
                     si32(_loc18_,_loc14_);
                     sf64(_loc17_,_loc10_ - 136);
                     _loc11_ = 0;
                     if(_loc8_ != 0)
                     {
                        _loc11_ = 1072693248;
                     }
                     _loc18_ = (_loc18_ = li32(_loc18_ = (_loc18_ = _loc10_ - 136) | 4)) & -2147483648;
                     _loc18_ = _loc11_ | _loc18_;
                     _loc14_ = (_loc14_ = _loc10_ - 144) | 4;
                     si32(_loc18_,_loc14_);
                     si32(0,_loc10_ - 160);
                     si32(0,_loc10_ - 144);
                     _loc19_ = lf64(_loc10_ - 160);
                     _loc17_ = lf64(_loc10_ - 144);
                     if(!(_loc25_ == _loc25_ & _loc25_ == _loc25_))
                     {
                        sf64(_loc25_,_loc10_ - 168);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 168) | 4)) & -2147483648,(_loc18_ = _loc10_ - 176) | 4);
                        si32(0,_loc10_ - 176);
                        _loc25_ = lf64(_loc10_ - 176);
                     }
                     if(!(_loc15_ == _loc15_ & _loc15_ == _loc15_))
                     {
                        sf64(_loc15_,_loc10_ - 184);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 184) | 4)) & -2147483648,(_loc18_ = _loc10_ - 192) | 4);
                        si32(0,_loc10_ - 192);
                        _loc15_ = lf64(_loc10_ - 192);
                     }
                  }
                  else if(_loc24_ == 0)
                  {
                     _loc9_ -= 16;
                     sf64(_loc3_,_loc9_);
                     ESP = _loc9_;
                     F_isinf();
                     _loc9_ += 16;
                     if((_loc18_ = eax) == 0)
                     {
                        _loc9_ -= 16;
                        sf64(_loc2_,_loc9_);
                        ESP = _loc9_;
                        F_isinf();
                        _loc9_ += 16;
                        if((_loc18_ = eax) == 0)
                        {
                           _loc9_ -= 16;
                           sf64(_loc23_,_loc9_);
                           ESP = _loc9_;
                           F_isinf();
                           _loc9_ += 16;
                           if((_loc18_ = eax) == 0)
                           {
                              _loc9_ -= 16;
                              sf64(_loc21_,_loc9_);
                              ESP = _loc9_;
                              F_isinf();
                              _loc9_ += 16;
                              if((_loc18_ = eax) != 0)
                              {
                              }
                              §§goto(addr1095);
                           }
                        }
                     }
                     if(!(_loc25_ == _loc25_ & _loc25_ == _loc25_))
                     {
                        sf64(_loc25_,_loc10_ - 72);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 72) | 4)) & -2147483648,(_loc18_ = _loc10_ - 80) | 4);
                        si32(0,_loc10_ - 80);
                        _loc25_ = lf64(_loc10_ - 80);
                     }
                     if(!(_loc15_ == _loc15_ & _loc15_ == _loc15_))
                     {
                        sf64(_loc15_,_loc10_ - 88);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 88) | 4)) & -2147483648,(_loc18_ = _loc10_ - 96) | 4);
                        si32(0,_loc10_ - 96);
                        _loc15_ = lf64(_loc10_ - 96);
                     }
                     if(!(_loc17_ == _loc17_ & _loc17_ == _loc17_))
                     {
                        sf64(_loc17_,_loc10_ - 104);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 104) | 4)) & -2147483648,(_loc18_ = _loc10_ - 112) | 4);
                        si32(0,_loc10_ - 112);
                        _loc17_ = lf64(_loc10_ - 112);
                     }
                     if(!(_loc19_ == _loc19_ & _loc19_ == _loc19_))
                     {
                        sf64(_loc19_,_loc10_ - 120);
                        si32(_loc14_ = (_loc14_ = li32(_loc14_ = (_loc14_ = _loc10_ - 120) | 4)) & -2147483648,(_loc18_ = _loc10_ - 128) | 4);
                        si32(0,_loc10_ - 128);
                        _loc19_ = lf64(_loc10_ - 128);
                     }
                  }
                  var _loc6_:Number = _loc15_ * _loc17_;
                  var _loc5_:Number;
                  _loc1_ = (_loc6_ = (_loc5_ = _loc25_ * _loc19_) + _loc6_) * inf;
                  _loc6_ = _loc15_ * _loc19_;
                  _loc4_ = (_loc6_ = (_loc5_ = _loc25_ * _loc17_) - _loc6_) * inf;
                  §§goto(addr1095);
               }
               §§goto(addr503);
            }
            §§goto(addr197);
         }
      }
      addr1095:
      _loc18_ = li32(_loc10_);
      sf64(_loc4_,_loc18_);
      sf64(_loc1_,_loc18_ + 8);
      ESP = _loc9_ = _loc10_;
   }
}
