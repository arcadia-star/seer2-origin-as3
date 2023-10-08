package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_asinhf() : void
   {
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:* = NaN;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 4);
      _loc1_ = li32(_loc6_ - 4);
      if((uint(_loc12_ = _loc1_ & 2147483647)) >= 2139095040)
      {
         var _loc8_:* = _loc2_;
         _loc2_ = _loc8_ += _loc8_;
      }
      else
      {
         _loc7_ = _loc2_;
         if(uint(_loc12_) <= 830472191)
         {
            var _loc5_:*;
            var _loc4_:*;
            if((_loc5_ = _loc8_ = _loc7_ + (_loc5_ = 1.0000000150474662e+30)) <= (_loc4_ = 1))
            {
            }
            §§goto(addr310);
         }
         if(uint(_loc12_) >= 1300234241)
         {
            _loc3_ -= 16;
            si32(_loc12_,_loc3_);
            ESP = _loc3_;
            F_logf();
            _loc3_ += 16;
            var _loc10_:*;
            _loc2_ = _loc8_ = (_loc10_ = _loc4_ = st0) + (_loc5_ = 0.6931471824645996);
         }
         else if(uint(_loc12_) >= 1073741825)
         {
            si32(_loc12_,_loc6_ - 12);
            _loc8_ = _loc5_ = 1;
            _loc3_ -= 16;
            var _loc11_:*;
            var _loc9_:*;
            sf32((_loc10_ = _loc4_ = _loc10_ += _loc10_) + (_loc5_ = _loc8_ /= _loc11_ = _loc9_ = (_loc4_ = _loc10_ = Math.sqrt(_loc4_ = _loc10_ = (_loc10_ = _loc4_ = _loc10_ = _loc7_ * _loc7_) + _loc8_)) + (_loc10_ = lf32(_loc6_ - 12))),_loc3_);
            ESP = _loc3_;
            F_logf();
            _loc3_ += 16;
            _loc2_ = st0;
         }
         else
         {
            si32(_loc12_,_loc6_ - 8);
            _loc10_ = _loc5_ = 1;
            _loc3_ -= 16;
            sf32((_loc10_ = lf32(_loc6_ - 8)) + (_loc5_ = _loc8_ /= _loc4_ = _loc10_ = (_loc9_ = _loc11_ = _loc9_ = Math.sqrt(_loc11_ = _loc9_ = (_loc8_ = _loc5_ = _loc8_ = _loc7_ * _loc7_) + _loc10_)) + _loc10_),_loc3_);
            ESP = _loc3_;
            F_log1pf();
            _loc3_ += 16;
            _loc2_ = st0;
         }
         if(_loc1_ <= 0)
         {
            _loc2_ = _loc8_ = -(_loc8_ = _loc2_);
         }
      }
      addr310:
      st0 = _loc2_;
      _loc3_ = _loc6_;
      ESP = _loc3_;
   }
}
