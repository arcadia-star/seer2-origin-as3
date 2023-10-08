package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_msleep() : void
   {
      var _loc4_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc6_:int = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc14_:Number = NaN;
      var _loc16_:Number = NaN;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc9_:* = NaN;
      var _loc3_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 32;
      _loc9_ = new Date().time;
      _loc3_ = 0;
      var _loc17_:*;
      if((_loc17_ = li8(_sIsThreaded_2E_b)) == 1)
      {
         _loc13_ = (_loc17_ = li32(_loc15_ = li32(_loc4_ + 4))) & 2147483647;
         si32(2,_loc4_ - 24);
         si32(li32(_loc4_),_loc4_ - 20);
         si32(_loc15_,_loc4_ - 16);
         si32(_loc13_,_loc4_ - 12);
         si32(_loc17_ = int(threadId),_loc4_ - 8);
         if((_loc17_ = li8(_sIsThreaded_2E_b)) == 1)
         {
            threadArbMutexLock();
         }
         var _loc7_:Number;
         _loc14_ = (_loc7_ = _loc17_ = li32(_loc4_ + 8)) + _loc9_;
         var _loc12_:*;
         si32(_loc12_ = li32(_sArbRequestHead),_loc4_ - 32);
         _loc3_ = _loc4_ - 32;
         si32(_loc3_,_sArbRequestHead);
         _loc2_ -= 16;
         si32(_loc15_,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         if(_loc17_ == 0)
         {
            _loc10_ = _sArbRequestHead;
            if((_loc17_ = li32(_loc4_ - 24)) != 0)
            {
               while(true)
               {
                  if((_loc17_ = li8(_sIsThreaded_2E_b)) != 0)
                  {
                     ESP = _loc2_;
                     F__sync_synchronize();
                     _loc8_ = int(threadArbCondWait(3000));
                     ESP = _loc2_;
                     F__sync_synchronize();
                  }
                  _loc14_ = new Date().time;
                  _loc10_ = _sArbRequestHead;
                  if((_loc17_ = li32(_loc4_ - 24)) != 0)
                  {
                     continue;
                  }
               }
            }
         }
         else
         {
            while(true)
            {
               _loc10_ = _sArbRequestHead;
               if(_loc9_ >= _loc14_)
               {
                  break;
               }
               _loc10_ = _sArbRequestHead;
               if((_loc17_ = li32(_loc4_ - 24)) == 0)
               {
                  break;
               }
               if((_loc17_ = li8(_sIsThreaded_2E_b)) == 1)
               {
                  var _loc11_:Number;
                  _loc6_ = _loc11_ = _loc14_ - _loc9_;
                  _loc16_ = -1;
                  if(_loc6_ != 0)
                  {
                     _loc16_ = _loc6_;
                  }
                  _loc5_ = 1;
                  _loc9_ = 3000;
                  _loc1_ = _loc5_;
                  if(_loc16_ <= _loc9_)
                  {
                     _loc1_ = 0;
                  }
                  if(_loc16_ >= 0)
                  {
                     _loc5_ = 0;
                  }
                  if((_loc17_ = _loc5_ | _loc1_) == 0)
                  {
                     _loc9_ = _loc16_;
                  }
                  ESP = _loc2_;
                  F__sync_synchronize();
                  _loc10_ = int(threadArbCondWait(_loc9_));
                  ESP = _loc2_;
                  F__sync_synchronize();
               }
               _loc9_ = new Date().time;
            }
         }
         while((_loc10_ = li32(_loc8_ = _loc10_)) != 0)
         {
            if(_loc10_ == _loc3_)
            {
               si32(_loc17_ = li32(_loc10_),_loc8_);
               break;
            }
         }
         if((_loc17_ = li32(_loc4_ - 24)) != 0)
         {
            _loc2_ -= 16;
            si32(_loc13_,_loc2_ + 4);
            si32(_loc15_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
         }
         if((_loc17_ = li8(_sIsThreaded_2E_b)) == 1)
         {
            threadArbMutexUnlock();
         }
         _loc3_ = 1;
         if((_loc17_ = li32(_loc4_ - 24)) != 0)
         {
            _loc3_ = 0;
         }
         _loc3_ &= 1;
      }
      eax = _loc3_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
