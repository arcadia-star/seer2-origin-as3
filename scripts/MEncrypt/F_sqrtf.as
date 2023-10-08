package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sqrtf() : void
   {
      var _loc7_:int = 0;
      var _loc17_:* = 0;
      var _loc9_:int = 0;
      var _loc16_:int = 0;
      var _loc11_:int = 0;
      var _loc13_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = NaN;
      var _loc5_:* = (_loc7_ = ESP) - 8;
      _loc1_ = lf32(_loc7_);
      sf32(_loc1_,_loc7_ - 4);
      var _loc18_:*;
      if((_loc18_ = (_loc6_ = li32(_loc7_ - 4)) & 2139095040) == 2139095040)
      {
         var _loc14_:* = _loc1_;
         var _loc12_:*;
         _loc1_ = _loc14_ = (_loc12_ = _loc12_ = _loc14_ * _loc14_) + _loc14_;
      }
      else
      {
         if(_loc6_ <= 0)
         {
            if((_loc18_ = _loc6_ & 2147483647) != 0)
            {
               if(_loc6_ <= -1)
               {
                  _loc14_ = _loc1_;
                  _loc14_ = _loc14_ -= _loc14_;
                  _loc1_ = _loc14_ /= _loc14_;
               }
            }
            §§goto(addr291);
         }
         if((_loc17_ = _loc6_ >> 23) == 0)
         {
            _loc16_ = 0;
            if((_loc6_ & 8388608) == 0)
            {
               do
               {
                  _loc16_ += 1;
               }
               while((_loc18_ = (_loc6_ <<= 1) & 8388608) == 0);
               
            }
            _loc17_ = (_loc18_ = _loc17_ + 1) - _loc16_;
         }
         _loc18_ = (_loc17_ += -127) & 1;
         var _loc15_:*;
         _loc13_ = (_loc18_ = (_loc15_ = (_loc15_ = _loc6_ & 8388607) | 8388608) << _loc18_) << 1;
         _loc6_ = 0;
         _loc16_ = 16777216;
         _loc11_ = 25;
         _loc10_ = _loc6_;
         do
         {
            if((_loc9_ = _loc6_ + _loc16_) <= _loc13_)
            {
               _loc6_ = _loc9_ + _loc16_;
            }
            _loc8_ = _loc4_ = 0;
            if(_loc9_ <= _loc13_)
            {
               _loc8_ = _loc16_;
            }
            if(_loc9_ <= _loc13_)
            {
               _loc4_ = _loc9_;
            }
            _loc10_ = _loc8_ + _loc10_;
            _loc13_ = (_loc18_ = _loc13_ - _loc4_) << 1;
            _loc11_ += -1;
            _loc16_ >>>= 1;
         }
         while(_loc11_ != 0);
         
         if(_loc13_ != 0)
         {
            _loc10_ = (_loc18_ = _loc10_ & 1) + _loc10_;
         }
         _loc18_ = _loc10_ >> 1;
         _loc15_ = (_loc15_ = (_loc15_ = _loc17_ << 22) + 1056964608) & -8388608;
         si32(_loc18_ += _loc15_,_loc7_ - 8);
         _loc1_ = lf32(_loc7_ - 8);
      }
      addr291:
      st0 = _loc1_;
      ESP = _loc5_ = _loc7_;
   }
}
