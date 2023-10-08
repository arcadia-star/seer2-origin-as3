package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___addvdi3() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:int = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc7_ = (_loc8_ = li32(_loc3_ + 8)) + _loc1_;
      _loc5_ = _loc6_ = 1;
      if(uint(_loc7_) >= uint(_loc8_))
      {
         _loc5_ = 0;
      }
      if(uint(_loc7_) >= uint(_loc1_))
      {
         _loc6_ = _loc5_;
      }
      _loc8_ = li32(_loc8_ = (_loc8_ = _loc3_) | 4);
      var _loc4_:*;
      _loc8_ = (_loc8_ = (_loc4_ = li32(_loc4_ = (_loc4_ = _loc3_ + 8) | 4)) + _loc8_) + _loc6_;
      eax = _loc7_;
      edx = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
