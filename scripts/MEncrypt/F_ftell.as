package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_ftell() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:int = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_);
      var _loc8_:*;
      if((_loc8_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc7_ = eax;
         if((_loc8_ = li32(_loc1_ + 92)) == _loc7_)
         {
            si32(_loc8_ = (_loc8_ = li32(_loc1_ + 96)) + 1,_loc1_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc8_ = _loc1_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc7_,_loc1_ + 92);
            si32(1,_loc1_ + 96);
         }
      }
      _loc2_ -= 16;
      si32(_loc7_ = _loc3_ - 8,_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F__ftello();
      _loc2_ += 16;
      _loc6_ = eax;
      if((_loc8_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         if((_loc8_ = li32(_loc1_ + 92)) == eax)
         {
            if((_loc4_ = li32(_loc1_ + 96)) >= 2)
            {
               si32(_loc8_ = _loc4_ + -1,_loc1_ + 96);
            }
            else
            {
               si32(0,_loc1_ + 96);
               si32(0,_loc1_ + 92);
               _loc2_ -= 16;
               si32(_loc8_ = _loc1_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
      }
      _loc1_ = -1;
      if(_loc6_ == 0)
      {
         if((_loc6_ = li32(_loc8_ = _loc7_ | 4)) <= -1)
         {
            ESP = _loc2_;
            F___error();
            si32(29,eax);
            _loc1_ = -1;
         }
         else
         {
            _loc1_ = li32(_loc3_ - 8);
            _loc4_ = _loc7_ = 1;
            if(_loc1_ <= -1)
            {
               _loc4_ = 0;
            }
            if(_loc6_ >= 0)
            {
               _loc7_ = 0;
            }
            if(_loc6_ != 0)
            {
               _loc4_ = _loc7_;
            }
            if(_loc4_ == 0)
            {
               ESP = _loc2_;
               F___error();
               si32(84,eax);
               _loc1_ = -1;
            }
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
