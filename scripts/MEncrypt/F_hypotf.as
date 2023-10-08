package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_hypotf() : void
   {
      var _loc10_:int = 0;
      var _loc2_:* = NaN;
      var _loc7_:* = NaN;
      var _loc21_:* = 0;
      var _loc18_:* = 0;
      var _loc12_:* = NaN;
      var _loc19_:* = NaN;
      var _loc13_:* = NaN;
      var _loc3_:* = NaN;
      var _loc17_:* = NaN;
      var _loc1_:* = NaN;
      var _loc5_:* = NaN;
      var _loc20_:* = NaN;
      var _loc24_:* = 0;
      var _loc8_:* = (_loc10_ = ESP) - 72;
      _loc2_ = lf32(_loc10_);
      sf32(_loc2_,_loc10_ - 4);
      sf32(_loc7_ = lf32(_loc10_ + 4),_loc10_ - 8);
      _loc13_ = _loc7_;
      _loc12_ = _loc2_;
      var _loc9_:*;
      _loc24_ = (_loc9_ = li32(_loc10_ - 4)) & 2147483647;
      _loc21_ = (_loc9_ = li32(_loc10_ - 8)) & 2147483647;
      _loc17_ = _loc12_;
      if(uint(_loc21_) <= uint(_loc24_))
      {
         _loc17_ = _loc13_;
      }
      sf32(_loc17_,_loc10_ - 12);
      if(uint(_loc21_) <= uint(_loc24_))
      {
         _loc13_ = _loc12_;
      }
      sf32(_loc13_,_loc10_ - 16);
      si32(_loc9_ = (_loc9_ = li32(_loc10_ - 12)) & 2147483647,_loc10_ - 20);
      si32(_loc9_ = (_loc9_ = li32(_loc10_ - 16)) & 2147483647,_loc10_ - 24);
      _loc18_ = _loc24_;
      if(uint(_loc21_) <= uint(_loc24_))
      {
         _loc18_ = _loc21_;
      }
      if(uint(_loc21_) <= uint(_loc24_))
      {
         _loc21_ = _loc24_;
      }
      _loc9_ = _loc21_ - _loc18_;
      _loc5_ = lf32(_loc10_ - 20);
      _loc20_ = lf32(_loc10_ - 24);
      if(_loc9_ >= 251658241)
      {
         var _loc15_:*;
         var _loc23_:*;
         _loc20_ = _loc15_ = (_loc23_ = _loc20_) + _loc5_;
      }
      else
      {
         _loc24_ = 0;
         if(uint(_loc21_) >= 1484783617)
         {
            if(uint(_loc21_) >= 2139095040)
            {
               var _loc22_:*;
               sf32(_loc23_ = _loc7_ + (_loc15_ = _loc22_ = 0),_loc10_ - 64);
               sf32(_loc15_ = (_loc23_ = _loc2_) + _loc15_,_loc10_ - 60);
               si32(_loc9_ = (_loc9_ = li32(_loc10_ - 64)) & 2147483647,_loc10_ - 72);
               si32(_loc9_ = (_loc9_ = li32(_loc10_ - 60)) & 2147483647,_loc10_ - 68);
               _loc19_ = _loc20_;
               if(_loc21_ != 2139095040)
               {
                  _loc19_ = _loc22_ = _loc15_ = (_loc23_ = lf32(_loc10_ - 68)) - lf32(_loc10_ - 72);
               }
               _loc1_ = _loc5_;
               if(_loc18_ != 2139095040)
               {
                  _loc1_ = _loc22_ = _loc19_;
               }
               _loc20_ = _loc1_;
               §§goto(addr676);
            }
            else
            {
               si32(_loc18_ += -570425344,_loc10_ - 32);
               si32(_loc21_ += -570425344,_loc10_ - 28);
               _loc24_ = 68;
               _loc5_ = lf32(_loc10_ - 32);
               _loc20_ = lf32(_loc10_ - 28);
            }
            §§goto(addr676);
         }
         if(_loc18_ <= 645922815)
         {
            if(_loc18_ <= 8388607)
            {
               if(_loc18_ != 0)
               {
                  _loc20_ = _loc23_ = _loc20_ * (_loc15_ = _loc22_ = 8.507059173023462e+37);
                  _loc5_ = _loc15_ = (_loc23_ = _loc5_) * _loc15_;
                  _loc24_ |= -126;
               }
               §§goto(addr676);
            }
            else
            {
               si32(_loc18_ += 570425344,_loc10_ - 40);
               si32(_loc21_ += 570425344,_loc10_ - 36);
               _loc24_ += -68;
               _loc5_ = lf32(_loc10_ - 40);
               _loc20_ = lf32(_loc10_ - 36);
            }
         }
         _loc19_ = _loc5_;
         _loc3_ = _loc22_ = _loc15_ = (_loc13_ = _loc20_) - _loc19_;
         if(!(_loc3_ <= _loc19_ | _loc3_ != _loc3_ | _loc19_ != _loc19_))
         {
            si32(_loc9_ = _loc21_ & -4096,_loc10_ - 52);
            _loc15_ = lf32(_loc10_ - 52);
            var _loc14_:*;
            var _loc4_:*;
            var _loc16_:*;
            _loc20_ = _loc15_ = Math.sqrt(_loc22_ = _loc15_ = (_loc15_ = _loc22_ = _loc15_ *= _loc15_) - (_loc14_ = _loc23_ = (_loc4_ = _loc16_ = _loc4_ = _loc19_ * (_loc16_ = _loc4_ = -_loc19_)) - (_loc14_ = _loc23_ = (_loc4_ = _loc16_ = _loc4_ = _loc13_ + _loc15_) * (_loc14_ = _loc23_ = _loc13_ - _loc15_))));
         }
         else
         {
            si32(_loc9_ = _loc18_ & -4096,_loc10_ - 44);
            si32(_loc9_ = (_loc9_ = _loc21_ + 8388608) & -4096,_loc10_ - 48);
            _loc15_ = lf32(_loc10_ - 44);
            _loc23_ = lf32(_loc10_ - 48);
            _loc23_ = _loc19_ - _loc15_;
            var _loc6_:*;
            var _loc11_:*;
            _loc20_ = _loc15_ = Math.sqrt(_loc22_ = _loc15_ = (_loc15_ = _loc22_ = _loc15_ = _loc23_ * _loc15_) - (_loc16_ = _loc4_ = (_loc6_ = _loc11_ = _loc6_ = _loc3_ * (_loc11_ = _loc6_ = -_loc3_)) - (_loc16_ = _loc4_ = (_loc16_ = _loc4_ = _loc23_ * (_loc14_ = _loc23_)) + (_loc11_ = _loc6_ = (_loc6_ = _loc11_ = _loc6_ = (_loc6_ = _loc11_ = _loc6_ = _loc13_ + _loc13_) - _loc23_) * _loc19_))));
         }
         if(_loc24_ != 0)
         {
            si32(_loc9_ = (_loc9_ = _loc24_ << 23) + 1065353216,_loc10_ - 56);
            _loc20_ = _loc15_ = (_loc23_ = lf32(_loc10_ - 56)) * _loc20_;
         }
      }
      addr676:
      st0 = _loc20_;
      ESP = _loc8_ = _loc10_;
   }
}
