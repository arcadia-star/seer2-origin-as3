package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   
   public function F_acoshf() : void
   {
      var _loc6_:* = 0;
      var _loc2_:* = NaN;
      var _loc1_:* = 0;
      var _loc4_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 4);
      _loc1_ = li32(_loc6_ - 4);
      if(_loc1_ <= 1065353215)
      {
         var _loc8_:* = _loc2_;
         var _loc5_:*;
         _loc8_ = _loc5_ = _loc8_ -= _loc8_;
         _loc4_ = _loc8_ /= _loc8_;
      }
      else if(_loc1_ >= 1300234240)
      {
         if(_loc1_ >= 2139095040)
         {
            _loc8_ = _loc2_;
            _loc4_ = _loc8_ += _loc8_;
         }
         else
         {
            _loc3_ -= 16;
            sf32(_loc2_,_loc3_);
            ESP = _loc3_;
            F_logf();
            _loc3_ += 16;
            var _loc7_:*;
            var _loc10_:*;
            _loc4_ = _loc8_ = (_loc7_ = _loc10_ = st0) + (_loc5_ = 0.6931471824645996);
         }
      }
      else
      {
         _loc4_ = 0;
         if(_loc1_ != 1065353216)
         {
            if(_loc1_ >= 1073741825)
            {
               _loc7_ = _loc5_ = -1;
               _loc8_ = _loc2_;
               _loc3_ -= 16;
               var _loc11_:*;
               var _loc9_:*;
               sf32((_loc8_ = _loc5_ = _loc8_ += _loc8_) + (_loc10_ = _loc7_ /= _loc11_ = _loc9_ = (_loc9_ = _loc11_ = _loc9_ = Math.sqrt(_loc11_ = _loc9_ = (_loc9_ = _loc11_ = _loc9_ = _loc8_ * _loc8_) + _loc7_)) + _loc8_),_loc3_);
               ESP = _loc3_;
               F_logf();
               _loc3_ += 16;
               _loc4_ = st0;
            }
            else
            {
               _loc8_ = _loc5_ = _loc8_ = _loc2_ + (_loc10_ = -1);
               _loc3_ -= 16;
               sf32((_loc7_ = _loc10_ = _loc7_ = Math.sqrt(_loc10_ = _loc7_ = (_loc9_ = _loc11_ = _loc9_ = _loc8_ + _loc8_) + (_loc10_ = _loc7_ = _loc8_ * _loc8_))) + _loc8_,_loc3_);
               ESP = _loc3_;
               F_log1pf();
               _loc3_ += 16;
               _loc4_ = st0;
            }
         }
      }
      st0 = _loc4_;
      _loc3_ = _loc6_;
      ESP = _loc3_;
   }
}
