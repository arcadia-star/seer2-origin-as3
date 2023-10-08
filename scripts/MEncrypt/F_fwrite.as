package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_fwrite() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:int = 0;
      var _loc4_:int = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 4);
      _loc9_ = (_loc10_ = li32(_loc3_ + 8)) * _loc1_;
      _loc8_ = 0;
      if(_loc9_ != 0)
      {
         _loc7_ = li32(_loc3_ + 12);
         var _loc6_:*;
         si32(_loc6_ = li32(_loc3_),_loc3_ - 24);
         var _loc5_:int;
         si32(_loc9_,(_loc5_ = _loc3_ - 24) | 4);
         si32(_loc9_,_loc3_ - 8);
         si32(_loc5_,_loc3_ - 16);
         si32(1,(_loc8_ = _loc3_ - 16) | 4);
         if((_loc6_ = li32(___isthreaded)) != 0)
         {
            ESP = _loc2_;
            F__pthread_self();
            _loc4_ = eax;
            if((_loc6_ = li32(_loc7_ + 92)) == _loc4_)
            {
               si32(_loc6_ = (_loc6_ = li32(_loc7_ + 96)) + 1,_loc7_ + 96);
            }
            else
            {
               _loc2_ -= 16;
               si32(_loc6_ = _loc7_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_lock();
               _loc2_ += 16;
               si32(_loc4_,_loc7_ + 92);
               si32(1,_loc7_ + 96);
            }
         }
         if((_loc6_ = li32(_loc7_ + 100)) == 0)
         {
            si32(-1,_loc7_ + 100);
         }
         _loc2_ -= 16;
         si32(_loc8_,_loc2_ + 4);
         si32(_loc7_,_loc2_);
         ESP = _loc2_;
         F___sfvwrite();
         _loc2_ += 16;
         if((_loc6_ = eax) != 0)
         {
            _loc10_ = (uint(_loc6_ = _loc9_ - li32(_loc3_ - 8))) / uint(_loc1_);
         }
         _loc6_ = li32(___isthreaded);
         _loc8_ = _loc10_;
         if(_loc6_ != 0)
         {
            ESP = _loc2_;
            F__pthread_self();
            _loc8_ = _loc10_;
            if(li32(_loc7_ + 92) == eax)
            {
               _loc1_ = li32(_loc7_ + 96);
               if(_loc1_ >= 2)
               {
                  si32(_loc6_ = _loc1_ + -1,_loc7_ + 96);
                  _loc8_ = _loc10_;
               }
               else
               {
                  si32(0,_loc7_ + 96);
                  si32(0,_loc7_ + 92);
                  _loc2_ -= 16;
                  si32(_loc6_ = _loc7_ + 88,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_unlock();
                  _loc2_ += 16;
                  _loc8_ = _loc10_;
               }
            }
         }
      }
      eax = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
