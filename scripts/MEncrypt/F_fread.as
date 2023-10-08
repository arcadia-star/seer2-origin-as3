package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_fread() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:int = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      var _loc12_:*;
      if((_loc12_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc11_ = eax;
         if((_loc12_ = li32(_loc1_ + 92)) == _loc11_)
         {
            si32(_loc12_ = (_loc12_ = li32(_loc1_ + 96)) + 1,_loc1_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc12_ = _loc1_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc11_,_loc1_ + 92);
            si32(1,_loc1_ + 96);
         }
      }
      _loc10_ = li32(_loc3_ + 8);
      _loc11_ = li32(_loc3_ + 4);
      _loc9_ = _loc10_ * _loc11_;
      _loc8_ = 0;
      if(_loc9_ != 0)
      {
         if((_loc12_ = li32(_loc1_ + 100)) == 0)
         {
            si32(-1,_loc1_ + 100);
         }
         if((_loc7_ = li32(_loc1_ + 4)) <= -1)
         {
            si32(_loc7_ = 0,_loc1_ + 4);
         }
         _loc8_ = li32(_loc3_);
         _loc6_ = _loc9_;
         while(true)
         {
            _loc5_ = li32(_loc1_);
            if(uint(_loc7_) >= uint(_loc6_))
            {
               _loc2_ -= 16;
               si32(_loc5_,_loc2_ + 4);
               si32(_loc8_,_loc2_);
               si32(_loc6_,_loc2_ + 8);
               ESP = _loc2_;
               Fmemcpy();
               _loc2_ += 16;
               si32(_loc12_ = (_loc12_ = li32(_loc1_ + 4)) - _loc6_,_loc1_ + 4);
               si32(_loc12_ = (_loc12_ = li32(_loc1_)) + _loc6_,_loc1_);
               _loc8_ = _loc10_;
               break;
            }
            _loc2_ -= 16;
            si32(_loc5_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            si32(_loc7_,_loc2_ + 8);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            si32(_loc12_ = (_loc12_ = li32(_loc1_)) + _loc7_,_loc1_);
            _loc2_ -= 16;
            si32(_loc1_,_loc2_);
            _loc6_ -= _loc7_;
            ESP = _loc2_;
            F___srefill();
            _loc2_ += 16;
            if((_loc12_ = eax) != 0)
            {
               _loc8_ = (uint(_loc12_ = _loc9_ - _loc6_)) / uint(_loc11_);
               break;
            }
            _loc8_ += _loc7_;
            _loc7_ = li32(_loc1_ + 4);
         }
      }
      if((_loc12_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         var _loc4_:*;
         if((_loc4_ = li32(_loc1_ + 92)) == eax)
         {
            if((_loc11_ = li32(_loc1_ + 96)) >= 2)
            {
               si32(_loc12_ = _loc11_ + -1,_loc1_ + 96);
            }
            else
            {
               si32(0,_loc1_ + 96);
               si32(0,_loc1_ + 92);
               _loc2_ -= 16;
               si32(_loc12_ = _loc1_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_unlock();
               _loc2_ += 16;
            }
         }
      }
      eax = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
