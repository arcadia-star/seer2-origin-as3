package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F__ftrylockfile() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:int = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F__pthread_self();
      _loc1_ = eax;
      var _loc5_:*;
      if((_loc5_ = li32((_loc6_ = li32(_loc3_)) + 92)) == _loc1_)
      {
         si32(_loc5_ = (_loc5_ = li32(_loc6_ + 96)) + 1,_loc6_ + 96);
         _loc4_ = 0;
      }
      else
      {
         _loc2_ -= 16;
         si32(_loc5_ = _loc6_ + 88,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_trylock();
         _loc4_ = -1;
         _loc2_ += 16;
         if((_loc5_ = eax) == 0)
         {
            si32(_loc1_,_loc6_ + 92);
            si32(1,_loc6_ + 96);
            _loc4_ = 0;
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
