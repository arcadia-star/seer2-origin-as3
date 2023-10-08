package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F___umtx_op_cv_signal() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:int = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc11_ = li32((_loc12_ = li32(_loc1_)) + 4);
      _loc1_ = int(threadId);
      _loc2_ -= 16;
      _loc1_ += 8;
      si32(_loc1_,_loc2_ + 4);
      _loc1_ = _loc12_ * -1640562687;
      _loc1_ >>>= 25;
      _loc1_ *= 44;
      si32(_loc11_ = (_loc10_ = _umtxq_chains + _loc1_) + 5632,_loc2_);
      ESP = _loc2_;
      F_avm2_lock_id();
      _loc2_ += 16;
      _loc1_ = li8(_loc10_ + 5668);
      if(_loc1_ != 0)
      {
         _loc9_ = li32(_loc10_ + 5672);
         do
         {
            _loc1_ = _loc9_ + 1;
            si32(_loc1_,_loc10_ + 5672);
            _loc2_ -= 16;
            si32(0,_loc2_ + 8);
            si32(_loc11_,_loc2_ + 4);
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F_avm2_msleep();
            _loc2_ += 16;
            _loc1_ = li32(_loc10_ + 5672);
            si32(_loc9_ = _loc1_ + -1,_loc10_ + 5672);
            _loc1_ = li8(_loc10_ + 5668);
         }
         while(_loc1_ != 0);
         
      }
      si8(1,_loc10_ + 5668);
      _loc8_ = _loc10_ + 5652;
      _loc9_ = 0;
      _loc7_ = _loc8_;
      while(true)
      {
         _loc6_ = _loc9_;
         if((_loc7_ = li32(_loc7_)) == 0)
         {
            break;
         }
         _loc9_ = _loc6_;
         if(li32(_loc7_ + 12) == 1)
         {
            _loc9_ = _loc6_;
            if(li32(_loc7_ + 20) == _loc12_)
            {
               _loc9_ = _loc6_;
               if(li32(_loc7_ + 24) == 0)
               {
                  _loc9_ = _loc6_ + 1;
                  if(_loc6_ > 0)
                  {
                     break;
                  }
               }
            }
         }
      }
      _loc7_ = li32(_loc8_);
      while(true)
      {
         _loc6_ = _loc7_;
         _loc7_ = 0;
         if(_loc6_ == 0)
         {
            break;
         }
         _loc5_ = li32(_loc6_ + 12);
         _loc7_ = li32(_loc6_);
         if(_loc5_ == 1)
         {
            if(li32(_loc6_ + 20) == _loc12_)
            {
               if(li32(_loc6_ + 24) == 0)
               {
                  _loc8_ = li32(_loc6_ + 8);
                  if(_loc5_ <= 1)
                  {
                     _loc8_ = _umtxq_chains + _loc8_ * 44 + 5632;
                  }
                  else
                  {
                     _loc8_ = _umtxq_chains + _loc8_ * 44;
                  }
                  _loc1_ = li8(_loc6_ + 28);
                  _loc1_ &= 1;
                  if(_loc1_ != 0)
                  {
                     _loc5_ = li32(_loc6_ + 4);
                     if(_loc7_ != 0)
                     {
                        si32(_loc5_,_loc7_ + 4);
                     }
                     else
                     {
                        si32(_loc5_,_loc8_ + 24);
                     }
                     var _loc4_:* = li32(_loc6_);
                     _loc1_ = li32(_loc6_ + 4);
                     si32(_loc4_,_loc1_);
                     _loc1_ = li32(_loc6_ + 28);
                     _loc1_ &= -2;
                     si32(_loc1_,_loc6_ + 28);
                  }
                  _loc1_ = li8(_sIsThreaded_2E_b);
                  _loc7_ = 1;
                  if(_loc1_ == 1)
                  {
                     _loc2_ -= 16;
                     si32(_loc6_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_wake();
                     _loc2_ += 16;
                     _loc7_ = 1;
                     break;
                  }
                  break;
               }
            }
         }
      }
      if(_loc9_ <= _loc7_)
      {
         _loc2_ -= 16;
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
         si32(0,_loc12_);
         _loc2_ -= 16;
         si32(int(threadId) + 8,_loc2_ + 4);
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
      }
      si8(0,_loc10_ + 5668);
      _loc1_ = li32(_loc10_ + 5672);
      if(_loc1_ != 0)
      {
         if(li8(_sIsThreaded_2E_b) == 1)
         {
            _loc2_ -= 16;
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F_avm2_wake_one();
            _loc2_ += 16;
         }
      }
      _loc2_ -= 16;
      si32(_loc11_,_loc2_);
      ESP = _loc2_;
      F_avm2_unlock();
      _loc2_ += 16;
      eax = 0;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
