package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F_rewind() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc7_ = li32(_loc1_);
      _loc1_ = li32(___sdidinit);
      if(_loc1_ == 0)
      {
         si32(__cleanup,___cleanup);
         si32(1,___sdidinit);
      }
      _loc6_ = li32(_loc3_);
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc5_ = eax;
         if(li32(_loc6_ + 92) == _loc5_)
         {
            si32(li32(_loc6_ + 96) + 1,_loc6_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc6_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc5_,_loc6_ + 92);
            si32(1,_loc6_ + 96);
         }
      }
      _loc2_ -= 32;
      si32(1,_loc2_ + 16);
      si32(0,_loc2_ + 12);
      si32(0,_loc2_ + 8);
      si32(0,_loc2_ + 4);
      si32(_loc6_,_loc2_);
      ESP = _loc2_;
      F__fseeko();
      _loc2_ += 32;
      _loc1_ = eax;
      if(_loc1_ == 0)
      {
         si16(li16(_loc6_ + 12) & 65439,_loc6_ + 12);
         ESP = _loc2_;
         F___error();
         si32(_loc7_,eax);
      }
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         var _loc4_:*;
         if((_loc4_ = li32(_loc6_ + 92)) == eax)
         {
            if((_loc7_ = li32(_loc6_ + 96)) >= 2)
            {
               si32(_loc7_ + -1,_loc6_ + 96);
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
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
