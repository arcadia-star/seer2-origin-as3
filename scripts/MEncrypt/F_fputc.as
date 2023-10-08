package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_fputc() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      var _loc7_:*;
      if((_loc7_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc6_ = eax;
         if((_loc7_ = li32(_loc1_ + 92)) == _loc6_)
         {
            si32(_loc7_ = (_loc7_ = li32(_loc1_ + 96)) + 1,_loc1_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc7_ = _loc1_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc6_,_loc1_ + 92);
            si32(1,_loc1_ + 96);
         }
      }
      _loc6_ = li32(_loc3_);
      si32(_loc5_ = (_loc7_ = li32(_loc1_ + 8)) + -1,_loc1_ + 8);
      if(_loc7_ >= 1)
      {
         _loc5_ = _loc6_;
         addr144:
         _loc7_ = li32(_loc1_);
         si8(_loc5_,_loc7_);
         si32(_loc7_ += 1,_loc1_);
         _loc6_ &= 255;
      }
      else
      {
         if(_loc5_ >= li32(_loc1_ + 24))
         {
            _loc5_ = _loc6_;
            if((_loc6_ & 255) != 10)
            {
               §§goto(addr144);
            }
            §§goto(addr192);
         }
         _loc2_ -= 16;
         si32(_loc1_,_loc2_ + 4);
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         F___swbuf();
         _loc2_ += 16;
         _loc6_ = eax;
      }
      addr192:
      if((_loc7_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         var _loc4_:*;
         if((_loc4_ = li32(_loc1_ + 92)) == eax)
         {
            if((_loc5_ = li32(_loc1_ + 96)) >= 2)
            {
               si32(_loc7_ = _loc5_ + -1,_loc1_ + 96);
            }
            else
            {
               si32(0,_loc1_ + 96);
               si32(0,_loc1_ + 92);
               _loc2_ -= 16;
               si32(_loc7_ = _loc1_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
