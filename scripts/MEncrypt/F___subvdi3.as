package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___subvdi3() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 1;
      _loc7_ = li32(_loc3_ + 8);
      if((uint(_loc6_ = li32(_loc3_))) >= uint(_loc7_))
      {
         _loc1_ = 0;
      }
      var _loc5_:* = li32(_loc5_ = (_loc5_ = _loc3_ + 8) | 4);
      var _loc4_:*;
      _loc5_ = (_loc5_ = (_loc4_ = li32(_loc4_ = (_loc4_ = _loc3_) | 4)) - _loc5_) - _loc1_;
      eax = _loc4_ = _loc6_ - _loc7_;
      edx = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
