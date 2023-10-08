package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._lastglue;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._thread_lock;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_f_prealloc() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc4_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F_getdtablesize();
      _loc1_ = ___sglue;
      _loc7_ = eax;
      while(true)
      {
         var _loc6_:* = li32(_loc1_ + 4);
         if((_loc7_ -= _loc6_) < 1)
         {
            break;
         }
         _loc1_ = li32(_loc1_);
         if(_loc1_ == 0)
         {
            if(_loc7_ >= 1)
            {
               _loc2_ -= 16;
               _loc1_ = _loc7_ * 232;
               si32(_loc6_ = _loc1_ + 15,_loc2_);
               ESP = _loc2_;
               F_malloc();
               _loc2_ += 16;
               if((_loc5_ = eax) != 0)
               {
                  si32(0,_loc5_);
                  si32(_loc7_,_loc5_ + 4);
                  si32(_loc4_ = (_loc6_ = _loc5_ + 15) & -4,_loc5_ + 8);
                  if(_loc7_ >= 1)
                  {
                     _loc2_ -= 16;
                     si32(_loc1_,_loc2_ + 8);
                     si32(0,_loc2_ + 4);
                     si32(_loc4_,_loc2_);
                     ESP = _loc2_;
                     Fmemset();
                     _loc2_ += 16;
                  }
                  if((_loc6_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_thread_lock,_loc2_);
                     ESP = _loc2_;
                     F__spinlock();
                     _loc2_ += 16;
                  }
                  _loc6_ = li32(_lastglue);
                  si32(_loc5_,_loc6_);
                  si32(_loc5_,_lastglue);
                  if((_loc6_ = li32(___isthreaded)) != 0)
                  {
                     _loc2_ -= 16;
                     si32(_thread_lock,_loc2_);
                     ESP = _loc2_;
                     F__spinunlock();
                     _loc2_ += 16;
                     break;
                  }
                  break;
               }
               break;
            }
            break;
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
