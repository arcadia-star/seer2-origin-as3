package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F___sbprintf;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F_vfprintf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
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
      _loc5_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_ + 4);
      if((_loc7_ = (_loc7_ = li16(_loc1_ + 12)) & 26) == 10)
      {
         if((_loc7_ = si16(li16(_loc1_ + 14))) >= 0)
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_ + 8);
            si32(_loc6_,_loc2_ + 4);
            si32(_loc1_,_loc2_);
            ESP = _loc2_;
            F___sbprintf();
            _loc2_ += 16;
            _loc6_ = eax;
         }
         else
         {
            addr167:
            _loc2_ -= 16;
            si32(_loc5_,_loc2_ + 8);
            si32(_loc6_,_loc2_ + 4);
            si32(_loc1_,_loc2_);
            ESP = _loc2_;
            F___vfprintf();
            _loc2_ += 16;
            _loc6_ = eax;
         }
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
         return;
      }
      §§goto(addr167);
   }
}
