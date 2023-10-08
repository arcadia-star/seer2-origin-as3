package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___decrement_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc6_ = _loc1_ + 20;
      _loc1_ = li32(_loc1_ + 16);
      _loc1_ <<= 2;
      _loc5_ = _loc6_ + _loc1_;
      do
      {
         if((_loc4_ = li32(_loc6_)) != 0)
         {
            si32(_loc4_ + -1,_loc6_);
            break;
         }
         si32(-1,_loc6_);
      }
      while((uint(_loc6_ += 4)) < uint(_loc5_));
      
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
