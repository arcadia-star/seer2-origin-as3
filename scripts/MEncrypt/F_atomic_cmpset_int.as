package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_atomic_cmpset_int() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_ + 8);
      si32(_loc1_,_loc2_ + 8);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc1_,_loc2_ + 4);
      ESP = _loc2_;
      F_avm2_cmpSwapUns();
      _loc5_ = 1;
      _loc2_ += 16;
      var _loc4_:int;
      if((_loc4_ = eax) != _loc1_)
      {
         _loc5_ = 0;
      }
      _loc1_ = _loc5_ & 1;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
