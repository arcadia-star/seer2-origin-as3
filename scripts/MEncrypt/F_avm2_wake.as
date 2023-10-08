package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_wake() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:int = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li8(_sIsThreaded_2E_b);
      if(_loc1_ == 1)
      {
         threadArbMutexLock();
      }
      _loc10_ = li32(_loc3_);
      _loc9_ = 0;
      _loc8_ = li32(_sArbRequestHead);
      _loc7_ = _loc9_;
      _loc6_ = _loc9_;
      if(_loc8_ != 0)
      {
         do
         {
            _loc1_ = li32(_loc8_ + 8);
            if(_loc1_ == 2)
            {
               if(li32(_loc8_ + 12) == _loc10_)
               {
                  si32(_loc7_,_loc8_ + 4);
                  _loc9_ = 1;
                  _loc7_ = _loc8_;
               }
            }
         }
         while((_loc8_ = li32(_loc8_)) != 0);
         
         _loc8_ = 0;
         if(_loc7_ != 0)
         {
            do
            {
               _loc10_ = li32(_loc5_ = li32(_loc7_ + 16));
               do
               {
                  _loc6_ = _loc10_;
                  _loc2_ -= 16;
                  si32(_loc6_,_loc2_ + 4);
                  si32(_loc5_,_loc2_);
                  _loc1_ = _loc6_ | -2147483648;
                  si32(_loc1_,_loc2_ + 8);
                  ESP = _loc2_;
                  F_avm2_cmpSwapUns();
                  _loc2_ += 16;
               }
               while((_loc10_ = eax) != _loc6_);
               
               if(_loc6_ == 0)
               {
                  var _loc4_:*;
                  si32(_loc4_ = li32(_loc7_ + 20),li32(_loc7_ + 16));
                  ESP = _loc2_;
                  F__sync_synchronize();
                  si32(0,_loc7_ + 8);
                  _loc8_ = 1 << (li32(_loc7_ + 24) & 31) | _loc8_;
               }
               else
               {
                  si32(1,_loc7_ + 8);
               }
            }
            while((_loc7_ = li32(_loc7_ + 4)) != 0);
            
            if(_loc8_ != 0)
            {
               _loc6_ = _loc9_;
               if(li8(_sIsThreaded_2E_b) == 1)
               {
                  ESP = _loc2_;
                  F__sync_synchronize();
                  threadArbCondsNotify(_loc8_);
                  _loc6_ = _loc9_;
                  addr239:
                  _loc1_ = li8(_sIsThreaded_2E_b);
                  if(_loc1_ == 1)
                  {
                     threadArbMutexUnlock();
                  }
               }
               _loc1_ = _loc6_ & 255;
               eax = _loc1_;
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
            §§goto(addr239);
         }
         _loc1_ = _loc9_ & 255;
         _loc6_ = 0;
         if(_loc1_ != 0)
         {
            ESP = _loc2_;
            F__sync_synchronize();
            _loc6_ = _loc9_;
         }
      }
      §§goto(addr239);
   }
}
