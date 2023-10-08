package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_uiThunkTickProc() : void
   {
      var _loc3_:* = 0;
      var _loc16_:* = 0;
      var _loc10_:Number = NaN;
      var _loc11_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      si32(_sEnterFrame,_loc2_);
      ESP = _loc2_;
      F_avm2_wake();
      _loc2_ += 16;
      _loc1_ = eax;
      if((_loc16_ = li32(_sOldUiTickProc)) != 0)
      {
         ESP = _loc2_;
         ptr2fun[_loc16_]();
      }
      var _loc12_:Number;
      _loc10_ = (_loc12_ = new Date().time) + 5000;
      while((_loc12_ = new Date().time) < _loc10_)
      {
         _loc2_ -= 16;
         var _loc15_:*;
         si32(_loc15_ = int(threadId) + 8,_loc2_ + 4);
         si32(_sThunkTickLock,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
         _loc14_ = li32(_sThunkTickHead);
         si32(_loc13_ = 0,_sThunkTickHead);
         _loc2_ -= 16;
         si32(_sThunkTickLock,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         if(_loc14_ == 0)
         {
            if(_loc1_ == 0)
            {
               break;
            }
            _loc2_ -= 16;
            si32(_loc15_ = int(threadId) + 8,_loc2_ + 4);
            si32(_sThunkTickLock,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            if((_loc15_ = li32(_sThunkTickHead)) == 0)
            {
               _loc2_ -= 16;
               si32(1,_loc2_ + 8);
               si32(_sThunkTickLock,_loc2_ + 4);
               si32(_sThunkTickHead,_loc2_);
               ESP = _loc2_;
               F_avm2_msleep();
               _loc2_ += 16;
            }
            _loc2_ -= 16;
            si32(_sThunkTickLock,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            _loc1_ = 0;
         }
         else
         {
            do
            {
               _loc11_ = _loc14_;
               _loc9_ = _loc13_;
               _loc14_ = li32(_loc11_ + 20);
               si32(_loc9_,_loc11_ + 20);
               _loc13_ = _loc11_;
            }
            while(_loc14_ != 0);
            
            _loc2_ -= 32;
            var _loc4_:*;
            si32(_loc4_ = _loc11_ + 16,_loc2_ + 16);
            si32(li32(_loc11_ + 4),_loc2_ + 12);
            si32(li32(_loc11_),_loc2_ + 8);
            si32(li32(_loc11_ + 12),_loc2_ + 4);
            si32(li32(_loc11_ + 8),_loc2_);
            ESP = _loc2_;
            F_thrImpersonate();
            _loc2_ += 32;
            si32(_loc15_ = eax,_loc11_ + 4);
            _loc2_ -= 16;
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F_avm2_wake_one();
            _loc2_ += 16;
            _loc1_ = 1;
            if(_loc9_ != 0)
            {
               do
               {
                  var _loc5_:* = li32(_loc9_ + 20);
                  var _loc8_:* = li32(_loc9_ + 8);
                  var _loc7_:* = li32(_loc9_ + 12);
                  var _loc6_:* = li32(_loc9_);
                  _loc4_ = li32(_loc9_ + 4);
                  _loc2_ -= 32;
                  si32(_loc15_ = _loc9_ + 16,_loc2_ + 16);
                  si32(_loc4_,_loc2_ + 12);
                  si32(_loc6_,_loc2_ + 8);
                  si32(_loc7_,_loc2_ + 4);
                  si32(_loc8_,_loc2_);
                  ESP = _loc2_;
                  F_thrImpersonate();
                  _loc2_ += 32;
                  si32(_loc15_ = eax,_loc9_ + 4);
                  _loc2_ -= 16;
                  si32(_loc9_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_wake_one();
                  _loc2_ += 16;
                  _loc1_ = 1;
                  _loc9_ = _loc5_;
               }
               while(_loc5_ != 0);
               
            }
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
