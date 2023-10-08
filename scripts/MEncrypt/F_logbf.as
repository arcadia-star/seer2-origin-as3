package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_logbf() : void
   {
      var _loc6_:* = 0;
      var _loc2_:* = NaN;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 12;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 4);
      _loc1_ = li32(_loc6_ - 4);
      if((_loc9_ = _loc1_ & 2147483647) == 0)
      {
         si32(_loc9_,_loc6_ - 12);
         var _loc8_:*;
         var _loc5_:Number;
         _loc2_ = _loc8_ = (_loc5_ = -1) / lf32(_loc6_ - 12);
      }
      else if(uint(_loc9_) >= 2139095040)
      {
         _loc8_ = _loc2_;
         _loc2_ = _loc8_ *= _loc8_;
      }
      else if(uint(_loc9_) <= 8388607)
      {
         var _loc4_:Number;
         sf32(_loc8_ = _loc2_ * (_loc4_ = 33554432),_loc6_ - 8);
         _loc2_ = (li32(_loc6_ - 8) >>> 23 & 255) + -152;
      }
      else
      {
         _loc2_ = (_loc9_ >>> 23) + -127;
      }
      st0 = _loc2_;
      _loc3_ = _loc6_;
      ESP = _loc3_;
   }
}
