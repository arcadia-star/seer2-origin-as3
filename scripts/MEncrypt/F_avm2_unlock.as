package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_unlock() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if((_loc9_ = li32(_loc1_)) >= 0)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 8);
         si32(_loc9_,_loc2_ + 4);
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F_avm2_cmpSwapUns();
         _loc2_ += 16;
         var _loc8_:*;
         if((_loc8_ = eax) != _loc9_)
         {
            addr68:
            if((_loc8_ = li8(_sIsThreaded_2E_b)) == 1)
            {
               threadArbMutexLock();
            }
            _loc9_ = 0;
            _loc7_ = li32(_sArbRequestHead);
            _loc6_ = _loc9_;
            if(_loc7_ != 0)
            {
               do
               {
                  if((_loc8_ = li32(_loc7_ + 8)) == 1)
                  {
                     _loc5_ = li32(_loc7_ + 16);
                     _loc4_ = 1;
                     if(_loc5_ != _loc1_)
                     {
                        _loc4_ = 0;
                     }
                     _loc9_ = (_loc8_ = _loc4_ & 1) + _loc9_;
                     if(_loc5_ == _loc1_)
                     {
                        _loc6_ = _loc7_;
                     }
                  }
               }
               while((_loc7_ = li32(_loc7_)) != 0);
               
               if(_loc6_ != 0)
               {
                  _loc4_ = (_loc5_ = li32(_loc6_ + 20)) | -2147483648;
                  if(_loc9_ <= 1)
                  {
                     _loc4_ = _loc5_;
                  }
                  si32(_loc4_,_loc1_);
                  ESP = _loc2_;
                  F__sync_synchronize();
                  si32(0,_loc6_ + 8);
                  _loc1_ = li32(_loc6_ + 24);
                  if((_loc8_ = li8(_sIsThreaded_2E_b)) == 1)
                  {
                     ESP = _loc2_;
                     F__sync_synchronize();
                     threadArbCondsNotify(1 << (_loc1_ & 31));
                  }
                  §§goto(addr216);
               }
               else
               {
                  addr196:
                  si32(0,_loc1_);
                  ESP = _loc2_;
                  F__sync_synchronize();
               }
               if((_loc8_ = li8(_sIsThreaded_2E_b)) == 1)
               {
                  threadArbMutexUnlock();
               }
               §§goto(addr216);
            }
            §§goto(addr196);
         }
         addr216:
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr68);
   }
}
