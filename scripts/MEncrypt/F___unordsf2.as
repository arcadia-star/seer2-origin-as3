package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   
   public function F___unordsf2() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc5_:int = 0;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 4;
      _loc2_ = li32(_loc4_);
      _loc2_ &= 2147483647;
      _loc5_ = 1;
      if(uint(_loc2_) <= 2139095040)
      {
         sf32(lf32(_loc4_ + 4),_loc4_ - 4);
         _loc5_ = 1;
         if((uint(li32(_loc4_ - 4) & 2147483647)) <= 2139095040)
         {
            _loc5_ = 0;
         }
      }
      eax = _loc5_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
