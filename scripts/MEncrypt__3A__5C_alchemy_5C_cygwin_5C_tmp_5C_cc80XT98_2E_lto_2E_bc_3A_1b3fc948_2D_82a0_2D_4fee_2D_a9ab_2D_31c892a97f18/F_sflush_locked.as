package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F__pthread_mutex_lock;
   import MEncrypt.F__pthread_mutex_unlock;
   import MEncrypt.F__pthread_self;
   import MEncrypt.F__swrite;
   import MEncrypt.___isthreaded;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F_sflush_locked() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc9_:*;
      if((_loc9_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         _loc8_ = eax;
         if((_loc9_ = li32(_loc1_ + 92)) == _loc8_)
         {
            si32(_loc9_ = (_loc9_ = li32(_loc1_ + 96)) + 1,_loc1_ + 96);
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc9_ = _loc1_ + 88,_loc2_);
            ESP = _loc2_;
            F__pthread_mutex_lock();
            _loc2_ += 16;
            si32(_loc8_,_loc1_ + 92);
            si32(1,_loc1_ + 96);
         }
      }
      _loc9_ = (_loc7_ = si16(li16(_loc1_ + 12))) & 8;
      _loc6_ = 0;
      if(_loc9_ != 0)
      {
         _loc8_ = li32(_loc1_ + 16);
         _loc6_ = 0;
         if(_loc8_ != 0)
         {
            _loc5_ = li32(_loc1_);
            si32(_loc8_,_loc1_);
            _loc6_ = 0;
            if((_loc7_ & 3) == 0)
            {
               _loc6_ = li32(_loc1_ + 20);
            }
            _loc5_ -= _loc8_;
            si32(_loc6_,_loc1_ + 8);
            while(true)
            {
               _loc6_ = 0;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc2_ -= 16;
               si32(_loc5_,_loc2_ + 8);
               si32(_loc8_,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               F__swrite();
               _loc2_ += 16;
               if((_loc6_ = eax) <= 0)
               {
                  si16(_loc9_ = (_loc9_ = li16(_loc1_ + 12)) | 64,_loc1_ + 12);
                  _loc6_ = -1;
                  break;
               }
               _loc8_ += _loc6_;
               _loc5_ -= _loc6_;
            }
         }
      }
      if((_loc9_ = li32(___isthreaded)) != 0)
      {
         ESP = _loc2_;
         F__pthread_self();
         if((_loc9_ = li32(_loc1_ + 92)) == eax)
         {
            if((_loc8_ = li32(_loc1_ + 96)) >= 2)
            {
               si32(_loc9_ = _loc8_ + -1,_loc1_ + 96);
            }
            else
            {
               si32(0,_loc1_ + 96);
               si32(0,_loc1_ + 92);
               _loc2_ -= 16;
               si32(_loc9_ = _loc1_ + 88,_loc2_);
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
