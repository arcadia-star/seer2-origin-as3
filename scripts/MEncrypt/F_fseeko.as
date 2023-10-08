package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_fseeko() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:int = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      _loc9_ = li32(_loc1_);
      _loc1_ = li32(___sdidinit);
      if(_loc1_ == 0)
      {
         si32(__cleanup,___cleanup);
         si32(1,___sdidinit);
      }
      _loc8_ = li32(_loc3_);
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc7_ = eax;
         if(li32(_loc8_ + 92) == _loc7_)
         {
            si32(li32(_loc8_ + 96) + 1,_loc8_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc8_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc7_,_loc8_ + 92);
            si32(1,_loc8_ + 96);
         }
      }
      var _loc6_:* = li32(_loc3_ + 8);
      _loc1_ = li32(_loc3_ + 4);
      var _loc5_:* = li32(_loc3_ + 12);
      _loc2_ -= 32;
      si32(0,_loc2_ + 16);
      si32(_loc5_,_loc2_ + 12);
      si32(_loc1_,_loc2_ + 4);
      si32(_loc8_,_loc2_);
      si32(_loc6_,_loc2_ + 8);
      ESP = _loc2_;
      F__fseeko();
      _loc2_ += 32;
      _loc7_ = eax;
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         if((_loc6_ = li32(_loc8_ + 92)) == eax)
         {
            if((_loc4_ = li32(_loc8_ + 96)) >= 2)
            {
               si32(_loc4_ + -1,_loc8_ + 96);
            }
            else
            {
               si32(0,_loc8_ + 96);
               si32(0,_loc8_ + 92);
               _loc2_ -= 16;
               si32(_loc8_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
      }
      if(_loc7_ == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(_loc9_,eax);
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
