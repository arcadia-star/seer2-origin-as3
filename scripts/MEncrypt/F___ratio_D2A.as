package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___ratio_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc10_:int = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc2_:* = 0;
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = ESP;
      _loc3_ = _loc1_;
      _loc1_ -= 48;
      _loc1_ -= 16;
      _loc2_ = _loc3_ - 4;
      si32(_loc2_,_loc1_ + 4);
      _loc2_ = li32(_loc3_);
      si32(_loc2_,_loc1_);
      ESP = _loc1_;
      F___b2d_D2A();
      _loc1_ += 16;
      var _loc8_:*;
      sf64(_loc8_ = st0,_loc3_ - 16);
      _loc1_ -= 16;
      si32(_loc13_ = _loc3_ - 8,_loc1_ + 4);
      si32(_loc12_ = li32(_loc3_ + 4),_loc1_);
      ESP = _loc1_;
      F___b2d_D2A();
      _loc1_ += 16;
      sf64(_loc8_ = st0,_loc3_ - 24);
      _loc13_ = li32(_loc3_ - 8);
      var _loc11_:*;
      _loc13_ = (_loc11_ = li32(_loc3_ - 4)) - _loc13_;
      _loc12_ = li32(_loc12_ + 16);
      _loc2_ = li32(_loc2_ + 16);
      _loc2_ -= _loc12_;
      _loc2_ <<= 5;
      _loc10_ = _loc2_ + _loc13_;
      _loc2_ = _loc3_ - 16;
      _loc2_ |= 4;
      _loc9_ = li32(_loc2_);
      _loc2_ = _loc3_ - 24;
      _loc2_ |= 4;
      _loc7_ = li32(_loc2_);
      _loc5_ = li32(_loc3_ - 16);
      _loc4_ = li32(_loc3_ - 24);
      if(_loc10_ >= 1)
      {
         _loc9_ = (_loc10_ << 20) + _loc9_;
      }
      else
      {
         _loc7_ -= _loc10_ << 20;
      }
      _loc2_ = _loc3_ - 40;
      _loc2_ |= 4;
      si32(_loc7_,_loc2_);
      _loc2_ = _loc3_ - 32;
      _loc2_ |= 4;
      si32(_loc9_,_loc2_);
      si32(_loc4_,_loc3_ - 40);
      si32(_loc5_,_loc3_ - 32);
      _loc8_ = lf64(_loc3_ - 40);
      var _loc6_:*;
      st0 = _loc6_ = (_loc6_ = lf64(_loc3_ - 32)) / _loc8_;
      _loc1_ = _loc3_;
      ESP = _loc1_;
   }
}
