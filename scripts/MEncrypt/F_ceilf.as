package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_ceilf() : void
   {
      var _loc6_:* = 0;
      var _loc11_:int = 0;
      var _loc9_:int = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 8;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 4);
      _loc1_ = li32(_loc6_ - 4);
      var _loc12_:*;
      if((_loc11_ = (_loc12_ = (_loc12_ = _loc1_ >>> 23) & 255) + -127) <= 22)
      {
         if(_loc11_ <= -1)
         {
            var _loc4_:*;
            var _loc5_:Number;
            var _loc8_:* = _loc4_ = _loc8_ = _loc2_ + (_loc5_ = 1.0000000150474662e+30);
            var _loc7_:* = _loc5_ = 0;
            _loc10_ = _loc1_;
            if(!(_loc8_ <= _loc7_ | _loc8_ != _loc8_ | _loc7_ != _loc7_))
            {
               _loc10_ = -2147483648;
               if(_loc1_ >= 0)
               {
                  _loc10_ = 0;
                  if(_loc1_ != 0)
                  {
                     _loc10_ = 1065353216;
                  }
               }
            }
            addr193:
            si32(_loc10_,_loc6_ - 8);
            _loc2_ = lf32(_loc6_ - 8);
         }
         else if((_loc12_ = (_loc9_ = 8388607 >>> _loc11_) & _loc1_) != 0)
         {
            _loc8_ = _loc4_ = _loc8_ = _loc2_ + (_loc5_ = 1.0000000150474662e+30);
            _loc7_ = _loc5_ = 0;
            _loc10_ = _loc1_;
            if(!(_loc8_ <= _loc7_ | _loc8_ != _loc8_ | _loc7_ != _loc7_))
            {
               if(_loc1_ >= 1)
               {
                  _loc1_ = (_loc12_ = 8388608 >>> _loc11_) + _loc1_;
               }
               _loc12_ = _loc9_ ^ -1;
               _loc10_ = _loc1_ & _loc12_;
            }
            §§goto(addr193);
         }
      }
      else if(_loc11_ == 128)
      {
         _loc8_ = _loc2_;
         _loc2_ = _loc8_ += _loc8_;
      }
      st0 = _loc2_;
      _loc3_ = _loc6_;
      ESP = _loc3_;
   }
}
