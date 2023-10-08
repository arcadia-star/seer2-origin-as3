package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F___umtx_op_set_ceiling() : void
   {
      var _loc3_:* = 0;
      var _loc14_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:* = 0;
      var _loc13_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc13_ = (_loc13_ = li32((_loc14_ = li32(_loc1_)) + 4)) & 8;
      _loc12_ = 22;
      if(_loc13_ != 0)
      {
         if((uint(_loc11_ = li32(_loc1_ + 8))) <= 31)
         {
            _loc1_ = li32(_loc1_ + 12);
            _loc10_ = li32(_loc13_ = li32(_loc3_));
            _loc9_ = li32(_loc13_ + 4);
            si32(5,_loc9_ + 12);
            si32(0,_loc9_ + 16);
            si32(_loc14_,_loc9_ + 20);
            si32(0,_loc9_ + 24);
            si32(_loc8_ = (_loc13_ = _loc14_ * -1640562687) >>> 25,_loc9_ + 8);
            _loc7_ = _loc10_ | -2147483648;
            _loc12_ = 0;
            _loc6_ = 0;
            while(true)
            {
               if((_loc13_ = _loc12_ & 1) != 0)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc8_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc8_ * 44;
               }
               _loc13_ = int(threadId);
               _loc2_ -= 16;
               si32(_loc13_ += 8,_loc2_ + 4);
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               F_avm2_lock_id();
               _loc2_ += 16;
               _loc12_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc8_ = (_loc13_ = _umtxq_chains + _loc12_ * 44) + 5632;
               }
               else
               {
                  _loc8_ = _umtxq_chains + _loc12_ * 44;
               }
               if((_loc13_ = li8(_loc8_ + 36)) != 0)
               {
                  _loc12_ = li32(_loc8_ + 40);
                  do
                  {
                     si32(_loc13_ = _loc12_ + 1,_loc8_ + 40);
                     _loc2_ -= 16;
                     si32(0,_loc2_ + 8);
                     si32(_loc8_,_loc2_ + 4);
                     si32(_loc8_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_msleep();
                     _loc2_ += 16;
                     si32(_loc12_ = (_loc13_ = li32(_loc8_ + 40)) + -1,_loc8_ + 40);
                  }
                  while((_loc13_ = li8(_loc8_ + 36)) != 0);
                  
               }
               si8(1,_loc8_ + 36);
               _loc12_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc12_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc12_ * 44;
               }
               _loc2_ -= 16;
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               F_avm2_unlock();
               _loc2_ += 16;
               _loc8_ = li32(_loc14_ + 8);
               _loc2_ -= 16;
               si32(_loc7_,_loc2_ + 8);
               si32(-2147483648,_loc2_ + 4);
               si32(_loc14_,_loc2_);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc12_ = 14;
               _loc2_ += 16;
               if((_loc4_ = eax) == -1)
               {
                  break;
               }
               if(_loc4_ == -2147483648)
               {
                  si32(_loc11_,_loc14_ + 8);
                  si32(-2147483648,_loc14_);
                  _loc12_ = 0;
                  break;
               }
               if((_loc13_ = _loc4_ & 2147483647) == _loc10_)
               {
                  si32(_loc11_,_loc14_ + 8);
                  _loc12_ = 0;
                  break;
               }
               _loc12_ = _loc6_;
               if(_loc6_ != 0)
               {
                  break;
               }
               _loc12_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc12_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc12_ * 44;
               }
               _loc13_ = int(threadId);
               _loc2_ -= 16;
               si32(_loc13_ += 8,_loc2_ + 4);
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               F_avm2_lock_id();
               _loc2_ += 16;
               _loc12_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc12_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc12_ * 44;
               }
               si32(0,_loc9_);
               si32(_loc13_ = li32(_loc12_ + 24),_loc9_ + 4);
               _loc13_ = li32(_loc12_ + 24);
               si32(_loc9_,_loc13_);
               si32(_loc9_,_loc12_ + 24);
               si32(_loc13_ = (_loc13_ = li32(_loc9_ + 28)) | 1,_loc9_ + 28);
               _loc12_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc12_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc12_ * 44;
               }
               si8(0,_loc12_ + 36);
               if((_loc13_ = li32(_loc12_ + 40)) != 0)
               {
                  if((_loc13_ = li8(_sIsThreaded_2E_b)) == 1)
                  {
                     _loc2_ -= 16;
                     si32(_loc12_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_wake_one();
                     _loc2_ += 16;
                  }
               }
               _loc8_ = li32(_loc9_ + 12);
               _loc4_ = li32(_loc9_ + 8);
               if(_loc8_ <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc4_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc4_ * 44;
               }
               _loc13_ = (_loc13_ = li8(_loc9_ + 28)) & 1;
               _loc6_ = 0;
               if(_loc13_ != 0)
               {
                  _loc2_ -= 16;
                  si32(_loc12_,_loc2_ + 4);
                  si32(_loc9_,_loc2_);
                  si32(0,_loc2_ + 8);
                  ESP = _loc2_;
                  F_avm2_msleep();
                  _loc6_ = 60;
                  _loc2_ += 16;
                  if((_loc13_ = eax) != 0)
                  {
                     _loc6_ = 0;
                  }
                  _loc8_ = li32(_loc9_ + 12);
                  _loc4_ = li32(_loc9_ + 8);
               }
               if(_loc8_ <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc4_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc4_ * 44;
               }
               if((_loc13_ = (_loc13_ = li8(_loc9_ + 28)) & 1) != 0)
               {
                  _loc8_ = li32(_loc9_ + 4);
                  if((_loc4_ = li32(_loc9_)) != 0)
                  {
                     si32(_loc8_,_loc4_ + 4);
                  }
                  else
                  {
                     si32(_loc8_,_loc12_ + 24);
                  }
                  var _loc5_:* = li32(_loc9_);
                  _loc13_ = li32(_loc9_ + 4);
                  si32(_loc5_,_loc13_);
                  si32(_loc13_ = (_loc13_ = li32(_loc9_ + 28)) & -2,_loc9_ + 28);
                  _loc8_ = li32(_loc9_ + 12);
                  _loc4_ = li32(_loc9_ + 8);
               }
               if(_loc8_ <= 1)
               {
                  _loc12_ = (_loc13_ = _umtxq_chains + _loc4_ * 44) + 5632;
               }
               else
               {
                  _loc12_ = _umtxq_chains + _loc4_ * 44;
               }
               _loc2_ -= 16;
               si32(_loc12_,_loc2_);
               ESP = _loc2_;
               F_avm2_unlock();
               _loc2_ += 16;
               _loc13_ = li32(_loc9_ + 12);
               _loc12_ = 1;
               if(_loc13_ >= 2)
               {
                  _loc12_ = 0;
               }
               _loc8_ = li32(_loc9_ + 8);
            }
            _loc11_ = li32(_loc9_ + 8);
            if((_loc13_ = li32(_loc9_ + 12)) <= 1)
            {
               _loc11_ = (_loc13_ = _umtxq_chains + _loc11_ * 44) + 5632;
            }
            else
            {
               _loc11_ = _umtxq_chains + _loc11_ * 44;
            }
            _loc13_ = int(threadId);
            _loc2_ -= 16;
            si32(_loc13_ += 8,_loc2_ + 4);
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            if(_loc12_ == 0)
            {
               _loc11_ = li32(_loc9_ + 8);
               if((_loc13_ = li32(_loc9_ + 12)) <= 1)
               {
                  _loc11_ = (_loc13_ = _umtxq_chains + _loc11_ * 44) + 5632;
               }
               else
               {
                  _loc11_ = _umtxq_chains + _loc11_ * 44;
               }
               _loc7_ = li32(_loc11_ + 20);
               _loc11_ = 2147483647;
               loop2:
               while(true)
               {
                  while((_loc14_ = _loc7_) != 0)
                  {
                     _loc6_ = li32(_loc14_ + 12);
                     _loc7_ = li32(_loc14_);
                     if(_loc6_ == li32(_loc9_ + 12))
                     {
                        if((_loc5_ = li32(_loc14_ + 20)) == li32(_loc9_ + 20))
                        {
                           if((_loc5_ = li32(_loc14_ + 24)) != li32(_loc9_ + 24))
                           {
                              continue;
                           }
                           continue loop2;
                        }
                     }
                  }
               }
            }
            _loc11_ = li32(_loc9_ + 8);
            if((_loc13_ = li32(_loc9_ + 12)) <= 1)
            {
               _loc11_ = (_loc13_ = _umtxq_chains + _loc11_ * 44) + 5632;
            }
            else
            {
               _loc11_ = _umtxq_chains + _loc11_ * 44;
            }
            si8(0,_loc11_ + 36);
            if((_loc13_ = li32(_loc11_ + 40)) != 0)
            {
               if((_loc13_ = li8(_sIsThreaded_2E_b)) == 1)
               {
                  _loc2_ -= 16;
                  si32(_loc11_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_wake_one();
                  _loc2_ += 16;
               }
            }
            _loc11_ = li32(_loc9_ + 8);
            if((_loc13_ = li32(_loc9_ + 12)) <= 1)
            {
               _loc9_ = (_loc13_ = _umtxq_chains + _loc11_ * 44) + 5632;
            }
            else
            {
               _loc9_ = _umtxq_chains + _loc11_ * 44;
            }
            _loc2_ -= 16;
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            if(_loc12_ == 0)
            {
               if(_loc1_ != 0)
               {
                  si32(_loc8_,_loc1_);
               }
            }
         }
      }
      eax = _loc12_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
