package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___rv_alloc_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 4;
      _loc6_ = 0;
      if((uint(_loc5_ = li32(_loc3_))) >= 20)
      {
         var _loc4_:int;
         do
         {
            _loc6_ += 1;
            _loc1_ <<= 1;
         }
         while((uint(_loc4_ = _loc1_ + 16)) <= uint(_loc5_));
         
      }
      _loc2_ -= 16;
      si32(_loc6_,_loc2_);
      ESP = _loc2_;
      F___Balloc_D2A();
      _loc2_ += 16;
      _loc4_ = eax;
      si32(_loc6_,_loc4_);
      eax = _loc4_ += 4;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
