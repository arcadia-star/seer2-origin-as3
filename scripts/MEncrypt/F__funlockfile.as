package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__funlockfile() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F__pthread_self();
      _loc1_ = eax;
      var _loc5_:*;
      if((_loc5_ = li32((_loc6_ = li32(_loc3_)) + 92)) == _loc1_)
      {
         if((_loc4_ = li32(_loc6_ + 96)) >= 2)
         {
            si32(_loc4_ + -1,_loc6_ + 96);
         }
         else
         {
            si32(0,_loc6_ + 96);
            si32(0,_loc6_ + 92);
            _loc2_ -= 16;
            si32(_loc6_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_unlock();
            _loc2_ += 16;
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
