package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_remainderf() : void
   {
      var _loc6_:int = 0;
      var _loc3_:* = NaN;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = NaN;
      var _loc12_:* = NaN;
      var _loc16_:* = NaN;
      var _loc10_:* = NaN;
      var _loc18_:* = 0;
      var _loc1_:* = NaN;
      var _loc9_:* = 0;
      var _loc14_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 32;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      _loc3_ = lf32(_loc6_ + 4);
      sf32(_loc3_,_loc6_ - 8);
      var _loc5_:*;
      if((_loc18_ = (_loc5_ = li32(_loc6_ - 8)) & 2147483647) == 0)
      {
         var _loc7_:* = _loc7_ = (_loc7_ = _loc1_) * _loc3_;
         _loc14_ = _loc7_ /= _loc7_;
      }
      else
      {
         if((uint(_loc13_ = (_loc15_ = li32(_loc6_ - 4)) & 2147483647)) <= 2139095039)
         {
            if(uint(_loc18_) < 2139095041)
            {
               if(uint(_loc18_) <= 2130706431)
               {
                  _loc4_ -= 16;
                  sf32(_loc1_,_loc4_);
                  _loc7_ = _loc3_;
                  sf32(_loc7_ += _loc7_,_loc4_ + 4);
                  ESP = _loc4_;
                  F_fmodf();
                  _loc4_ += 16;
                  _loc1_ = st0;
               }
               if(_loc13_ == _loc18_)
               {
                  var _loc17_:Number;
                  _loc14_ = _loc7_ = _loc1_ * (_loc17_ = 0);
               }
               else
               {
                  _loc15_ &= -2147483648;
                  sf32(_loc1_,_loc6_ - 12);
                  si32(_loc18_,_loc6_ - 16);
                  si32(_loc5_ = (_loc5_ = li32(_loc6_ - 12)) & 2147483647,_loc6_ - 20);
                  _loc11_ = lf32(_loc6_ - 16);
                  _loc1_ = lf32(_loc6_ - 20);
                  if(uint(_loc18_) <= 16777215)
                  {
                     _loc12_ = _loc11_;
                     _loc10_ = _loc1_;
                     if(!((_loc7_ = _loc7_ = _loc10_ + _loc10_) <= _loc12_ | _loc7_ != _loc7_ | _loc12_ != _loc12_))
                     {
                        _loc1_ = _loc7_ = _loc10_ - _loc12_;
                        _loc10_ = _loc1_;
                        if(!((_loc7_ = _loc7_ = _loc10_ + _loc10_) < _loc12_ | _loc7_ != _loc7_ | _loc12_ != _loc12_))
                        {
                           _loc1_ = _loc7_ = _loc10_ - _loc12_;
                        }
                     }
                  }
                  else
                  {
                     _loc10_ = _loc11_;
                     _loc12_ = _loc7_ = _loc10_ * 0.5;
                     if(!((_loc16_ = _loc1_) <= _loc12_ | _loc16_ != _loc16_ | _loc12_ != _loc12_))
                     {
                        _loc1_ = _loc7_ = _loc16_ - _loc10_;
                        if(!((_loc16_ = _loc1_) < _loc12_ | _loc16_ != _loc16_ | _loc12_ != _loc12_))
                        {
                           _loc1_ = _loc7_ = _loc16_ - _loc10_;
                        }
                     }
                  }
                  sf32(_loc1_,_loc6_ - 24);
                  _loc5_ = (_loc18_ = li32(_loc6_ - 24)) & 2147483647;
                  _loc9_ = 0;
                  if(_loc5_ != _loc9_)
                  {
                     _loc9_ = _loc18_;
                  }
                  si32(_loc5_ = _loc9_ ^ _loc15_,_loc6_ - 28);
                  _loc14_ = lf32(_loc6_ - 28);
               }
            }
            §§goto(addr384);
         }
         _loc7_ = _loc3_;
         var _loc8_:*;
         _loc7_ = (_loc8_ = _loc1_) * _loc7_;
         _loc14_ = _loc7_ /= _loc7_;
      }
      addr384:
      st0 = _loc14_;
      ESP = _loc4_ = _loc6_;
   }
}
