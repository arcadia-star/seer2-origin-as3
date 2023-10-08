package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___b2d_D2A() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc17_:* = 0;
      var _loc12_:* = 0;
      var _loc15_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc18_:* = 0;
      var _loc14_:* = 0;
      var _loc16_:* = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 8;
      _loc18_ = (_loc4_ = li32(_loc5_)) + 20;
      _loc15_ = (_loc16_ = (_loc17_ = li32(_loc4_ + 16)) + -1) << 2;
      _loc11_ = (_loc12_ = li32(_loc14_ = _loc18_ + _loc15_)) << 16;
      if(uint(_loc12_) >= 65536)
      {
         _loc11_ = _loc12_;
      }
      _loc10_ = _loc11_ << 8;
      if(uint(_loc11_) >= 16777216)
      {
         _loc10_ = _loc11_;
      }
      _loc1_ = _loc10_ << 4;
      if(uint(_loc10_) >= 268435456)
      {
         _loc1_ = _loc10_;
      }
      _loc6_ = _loc1_ << 2;
      if(uint(_loc1_) >= 1073741824)
      {
         _loc6_ = _loc1_;
      }
      _loc7_ = 16;
      if(uint(_loc12_) >= 65536)
      {
         _loc7_ = 0;
      }
      _loc8_ = _loc7_ | 8;
      if(uint(_loc11_) >= 16777216)
      {
         _loc8_ = _loc7_;
      }
      _loc7_ = _loc8_ | 4;
      if(uint(_loc10_) >= 268435456)
      {
         _loc7_ = _loc8_;
      }
      _loc10_ = _loc7_ | 2;
      if(uint(_loc1_) >= 1073741824)
      {
         _loc10_ = _loc7_;
      }
      _loc1_ = li32(_loc5_ + 4);
      if(_loc6_ >= 0)
      {
         _loc10_ += 1;
         if((_loc15_ = _loc6_ & 1073741824) == 0)
         {
            si32(0,_loc1_);
            _loc10_ = 32;
         }
         else
         {
            §§goto(addr186);
         }
         §§goto(addr257);
      }
      addr186:
      si32(_loc15_ = 32 - _loc10_,_loc1_);
      if(_loc10_ <= 10)
      {
         _loc18_ = 0;
         if(_loc16_ >= 1)
         {
            _loc18_ = li32((_loc15_ = (_loc15_ = _loc17_ << 2) + _loc4_) + 12);
         }
         _loc15_ = 11 - _loc10_;
         var _loc9_:*;
         _loc14_ = (_loc9_ = _loc12_ >>> _loc15_) | 1072693248;
         _loc15_ = _loc18_ >>> _loc15_;
         _loc9_ = _loc10_ + 21;
         _loc9_ = _loc12_ << _loc9_;
         _loc6_ = (_loc15_ |= _loc9_) | 0;
      }
      else
      {
         addr257:
         _loc6_ = 0;
         if(_loc16_ >= 1)
         {
            _loc6_ = li32((_loc15_ = (_loc15_ = _loc17_ << 2) + _loc4_) + 12);
            _loc14_ = _loc15_ + 12;
         }
         if((_loc4_ = _loc10_ + -11) != 0)
         {
            _loc16_ = 0;
            if(uint(_loc14_) > uint(_loc18_))
            {
               _loc16_ = li32(_loc14_ - 4);
            }
            var _loc2_:* = _loc12_ << _loc4_;
            _loc15_ = 43 - _loc10_;
            _loc9_ = _loc6_ >>> _loc15_;
            _loc14_ = (_loc9_ = _loc2_ | _loc9_) | 1072693248;
            _loc9_ = _loc6_ << _loc4_;
            _loc6_ = (_loc15_ = (_loc15_ = _loc16_ >>> _loc15_) | _loc9_) | 0;
         }
         else
         {
            _loc14_ = _loc12_ | 1072693248;
         }
      }
      _loc15_ = (_loc15_ = _loc5_ - 8) | 4;
      si32(_loc14_,_loc15_);
      si32(_loc6_,_loc5_ - 8);
      var _loc13_:*;
      st0 = _loc13_ = lf64(_loc5_ - 8);
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
