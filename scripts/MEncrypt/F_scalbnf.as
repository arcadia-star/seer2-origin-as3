package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_scalbnf() : void
   {
      var _loc6_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 36;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 4);
      _loc1_ = li32(_loc6_ - 4);
      var _loc12_:*;
      _loc11_ = (_loc12_ = _loc1_ >>> 23) & 255;
      _loc10_ = li32(_loc6_ + 4);
      if(_loc11_ == 0)
      {
         if((_loc12_ = _loc1_ & 2147483647) != 0)
         {
            var _loc8_:*;
            var _loc5_:Number;
            _loc2_ = _loc8_ = _loc2_ * (_loc5_ = 33554432);
            sf32(_loc2_,_loc6_ - 8);
            _loc1_ = li32(_loc6_ - 8);
            _loc11_ = (_loc12_ = (_loc12_ = _loc1_ >>> 23) & 255) + -25;
            if(_loc10_ <= -50001)
            {
               _loc2_ = _loc8_ = _loc2_ * (_loc5_ = 1.0000000031710769e-30);
            }
            else
            {
               addr110:
               if(_loc11_ == 255)
               {
                  _loc8_ = _loc2_;
                  _loc2_ = _loc8_ += _loc8_;
               }
               else if((_loc11_ += _loc10_) >= 255)
               {
                  sf32(_loc2_,_loc6_ - 32);
                  si32(_loc12_ = (_loc12_ = (_loc12_ = li32(_loc6_ - 32)) & -2147483648) | 1900671690,_loc6_ - 36);
                  var _loc7_:*;
                  var _loc4_:Number;
                  _loc2_ = _loc8_ = (_loc7_ = lf32(_loc6_ - 36)) * (_loc4_ = 1.0000000150474662e+30);
               }
               else if(_loc11_ >= 1)
               {
                  si32(_loc12_ = (_loc12_ = _loc1_ & -2139095041) | _loc11_ << 23,_loc6_ - 28);
                  _loc2_ = lf32(_loc6_ - 28);
               }
               else if(_loc11_ <= -25)
               {
                  sf32(_loc2_,_loc6_ - 16);
                  _loc1_ = (_loc12_ = li32(_loc6_ - 16)) & -2147483648;
                  if(_loc10_ >= 50001)
                  {
                     si32(_loc12_ = _loc1_ | 1900671690,_loc6_ - 24);
                     _loc2_ = _loc8_ = (_loc8_ = lf32(_loc6_ - 24)) * (_loc4_ = 1.0000000150474662e+30);
                  }
                  else
                  {
                     si32(_loc12_ = _loc1_ | 228737632,_loc6_ - 20);
                     _loc2_ = _loc8_ = (_loc7_ = lf32(_loc6_ - 20)) * (_loc4_ = 1.0000000031710769e-30);
                  }
               }
               else
               {
                  var _loc9_:*;
                  si32(_loc12_ = (_loc9_ = (_loc9_ = _loc11_ << 23) + 209715200) | _loc1_ & -2139095041,_loc6_ - 12);
                  _loc2_ = _loc8_ = (_loc7_ = lf32(_loc6_ - 12)) * (_loc4_ = 2.9802322387695312e-8);
               }
            }
         }
         st0 = _loc2_;
         _loc3_ = _loc6_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr110);
   }
}
