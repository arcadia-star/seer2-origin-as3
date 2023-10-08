package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_wake_one() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li8(_sIsThreaded_2E_b);
      if(_loc1_ == 1)
      {
         threadArbMutexLock();
      }
      _loc8_ = li32(_loc3_);
      _loc7_ = 0;
      _loc6_ = li32(_sArbRequestHead);
      _loc5_ = _loc7_;
      if(_loc6_ != 0)
      {
         do
         {
            _loc1_ = li32(_loc6_ + 8);
            if(_loc1_ == 2)
            {
               if(li32(_loc6_ + 12) == _loc8_)
               {
                  _loc7_ = _loc6_;
               }
            }
         }
         while((_loc6_ = li32(_loc6_)) != 0);
         
         _loc5_ = 0;
         if(_loc7_ != 0)
         {
            _loc6_ = li32(_loc5_ = li32(_loc7_ + 16));
            do
            {
               _loc8_ = _loc6_;
               _loc2_ -= 16;
               si32(_loc8_,_loc2_ + 4);
               si32(_loc5_,_loc2_);
               _loc1_ = _loc8_ | -2147483648;
               si32(_loc1_,_loc2_ + 8);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc2_ += 16;
            }
            while((_loc6_ = eax) != _loc8_);
            
            if(_loc8_ != 0)
            {
               si32(1,_loc7_ + 8);
               ESP = _loc2_;
               F__sync_synchronize();
               _loc5_ = _loc7_;
               addr199:
               _loc1_ = li8(_sIsThreaded_2E_b);
               if(_loc1_ == 1)
               {
                  threadArbMutexUnlock();
               }
            }
            else
            {
               var _loc4_:*;
               si32(_loc4_ = li32(_loc7_ + 20),li32(_loc7_ + 16));
               ESP = _loc2_;
               F__sync_synchronize();
               si32(0,_loc7_ + 8);
               _loc8_ = li32(_loc7_ + 24);
               _loc5_ = _loc7_;
               if(li8(_sIsThreaded_2E_b) == 1)
               {
                  ESP = _loc2_;
                  F__sync_synchronize();
                  threadArbCondsNotify(1 << (_loc8_ & 31));
                  _loc5_ = _loc7_;
                  §§goto(addr199);
               }
            }
            _loc7_ = 1;
            if(_loc5_ == 0)
            {
               _loc7_ = 0;
            }
            _loc1_ = _loc7_ & 1;
            eax = _loc1_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr199);
   }
}
