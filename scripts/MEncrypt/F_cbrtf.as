package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_cbrtf() : void
   {
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 12;
      _loc1_ = lf32(_loc5_);
      sf32(_loc1_,_loc5_ - 4);
      if((_loc11_ = (_loc13_ = (_loc4_ = li32(_loc5_ - 4)) & -2147483648) ^ _loc4_) >= 2139095040)
      {
         var _loc7_:* = _loc1_;
         _loc1_ = _loc7_ += _loc7_;
      }
      else
      {
         if(_loc11_ <= 8388607)
         {
            if(_loc4_ != _loc13_)
            {
               sf32(_loc7_ = _loc1_ * 16777216,_loc5_ - 8);
               var _loc9_:*;
               _loc11_ = (_loc9_ = (uint(_loc9_ = (_loc9_ = li32(_loc5_ - 8)) & 2147483647)) / 3) + 642849266;
            }
            §§goto(addr204);
         }
         else
         {
            _loc11_ = (_loc9_ = _loc11_ / 3) + 709958130;
         }
         si32(_loc9_ = _loc11_ | _loc13_,_loc5_ - 12);
         var _loc10_:* = lf32(_loc5_ - 12);
         var _loc8_:Number = (_loc7_ = _loc10_ * _loc10_) * _loc10_;
         var _loc6_:*;
         var _loc12_:Number = (_loc7_ = (_loc6_ = _loc1_) + _loc8_) + _loc8_;
         _loc10_ = (_loc10_ = (_loc8_ = (_loc7_ = _loc6_ + _loc6_) + _loc8_) * _loc10_) / _loc12_;
         _loc12_ = (_loc12_ = _loc10_ * _loc10_) * _loc10_;
         _loc6_ = (_loc6_ += _loc12_) + _loc12_;
         _loc1_ = _loc7_ = (_loc7_ = (_loc7_ += _loc12_) * _loc10_) / _loc6_;
      }
      addr204:
      st0 = _loc1_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
