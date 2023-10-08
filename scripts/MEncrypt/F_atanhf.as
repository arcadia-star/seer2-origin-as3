package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_atanhf() : void
   {
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = NaN;
      var _loc11_:* = NaN;
      var _loc9_:Number = NaN;
      var _loc1_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 16;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc13_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 1065353217)
      {
         var _loc8_:* = _loc1_;
         _loc8_ = _loc8_ -= _loc8_;
         _loc1_ = _loc8_ /= _loc8_;
      }
      else if(_loc13_ == 1065353216)
      {
         _loc1_ = _loc8_ = _loc1_ / 0;
      }
      else
      {
         if(uint(_loc13_) <= 830472191)
         {
            if((_loc8_ = _loc1_ + 1.0000000150474662e+30) <= 0)
            {
            }
            §§goto(addr232);
         }
         si32(_loc13_,_loc6_ - 8);
         var _loc3_:* = lf32(_loc6_ - 8);
         _loc11_ = _loc3_;
         _loc12_ = _loc8_ = _loc11_ + _loc11_;
         if(uint(_loc13_) <= 1056964607)
         {
            var _loc7_:*;
            var _loc14_:*;
            var _loc10_:*;
            sf32((_loc7_ = _loc7_ = (_loc7_ = (_loc8_ = _loc12_) * _loc11_) / (_loc14_ = _loc10_ = (_loc10_ = _loc14_ = 1) - _loc11_)) + _loc8_,_loc4_ -= 16);
            ESP = _loc4_;
            F_log1pf();
            _loc4_ += 16;
            _loc9_ = st0;
         }
         else
         {
            sf32((_loc8_ = _loc12_) / (_loc8_ = (_loc8_ = 1) - _loc11_),_loc4_ -= 16);
            ESP = _loc4_;
            F_log1pf();
            _loc4_ += 16;
            _loc9_ = st0;
         }
         _loc8_ = _loc9_;
         var _loc2_:Number = 0.5;
         _loc7_ = _loc2_;
         _loc1_ = _loc8_ *= _loc7_;
         if(_loc5_ <= -1)
         {
            _loc1_ = _loc8_ = -(_loc8_ = _loc1_);
         }
      }
      addr232:
      st0 = _loc1_;
      ESP = _loc4_ = _loc6_;
   }
}
