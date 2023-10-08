package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_asinf() : void
   {
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc14_:* = 0;
      var _loc7_:* = NaN;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 8;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc14_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 1065353216)
      {
         if(_loc14_ == 1065353216)
         {
            var _loc8_:*;
            _loc1_ = _loc8_ = (_loc8_ = _loc1_) * 1.5707963267948966;
         }
         else
         {
            _loc8_ = _loc1_;
            _loc8_ = _loc8_ -= _loc8_;
            _loc1_ = _loc8_ /= _loc8_;
         }
      }
      else if(uint(_loc14_) <= 1056964607)
      {
         _loc7_ = _loc1_;
         if(uint(_loc14_) <= 964689919)
         {
            if((_loc8_ = _loc7_ + 1.0000000150474662e+30) <= 1)
            {
            }
            §§goto(addr352);
         }
         var _loc3_:* = -0.7066296339035034;
         var _loc10_:* = _loc3_;
         _loc3_ = _loc8_ = _loc7_ * _loc7_;
         var _loc2_:* = _loc10_ = (_loc8_ = _loc3_) * _loc10_;
         _loc10_ = _loc2_;
         var _loc11_:*;
         var _loc9_:* = _loc11_ = 1;
         _loc2_ = _loc10_ += _loc9_;
         _loc10_ = _loc2_;
         _loc9_ = _loc11_ = -0.008656363002955914;
         _loc9_ = _loc11_ = _loc9_ = _loc8_ * _loc9_;
         var _loc13_:*;
         var _loc12_:* = _loc13_ = -0.04274342209100723;
         _loc9_ = _loc11_ = _loc9_ = (_loc9_ = _loc11_ = _loc9_ += _loc12_) * _loc8_;
         _loc12_ = _loc13_ = 0.16666586697101593;
         _loc3_ = _loc8_ = (_loc9_ = _loc11_ = _loc9_ += _loc12_) * _loc8_;
         _loc3_ = _loc8_ = (_loc8_ = _loc3_) / _loc10_;
         _loc3_ = _loc8_ = (_loc8_ = _loc3_) * _loc7_;
         _loc1_ = _loc8_ = (_loc8_ = _loc3_) + _loc7_;
      }
      else
      {
         si32(_loc14_,_loc6_ - 8);
         _loc8_ = 1;
         _loc10_ = _loc10_ = (_loc10_ = _loc8_ - lf32(_loc6_ - 8)) * (_loc11_ = 0.5);
         _loc1_ = _loc8_ = (_loc8_ = (_loc8_ = (_loc10_ = (_loc8_ = (_loc11_ = _loc9_ = (_loc9_ = _loc11_ = _loc9_ = (_loc11_ = _loc9_ = (_loc9_ = _loc11_ = _loc9_ = (_loc11_ = _loc9_ = _loc10_ * (_loc11_ = -0.008656363002955914)) + (_loc13_ = -0.04274342209100723)) * _loc10_) + (_loc13_ = 0.16666586697101593)) * _loc10_) / (_loc8_ = (_loc12_ = _loc13_ = _loc12_ = _loc10_ * (_loc13_ = -0.7066296339035034)) + _loc8_)) * (_loc8_ = Math.sqrt(_loc10_))) + _loc8_) * -2) + 1.5707963267948966;
         if(_loc5_ <= 0)
         {
            _loc1_ = _loc8_ = -(_loc8_ = _loc1_);
         }
      }
      addr352:
      st0 = _loc1_;
      ESP = _loc4_ = _loc6_;
   }
}
