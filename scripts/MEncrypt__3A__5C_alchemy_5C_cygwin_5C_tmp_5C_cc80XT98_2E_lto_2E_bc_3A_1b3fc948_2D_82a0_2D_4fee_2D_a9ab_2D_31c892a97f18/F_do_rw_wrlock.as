package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_do_rw_wrlock() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc13_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:int = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc13_ = li32(_loc1_ + 4);
      _loc13_ = li32(_loc3_);
      si32(6,_loc13_ + 12);
      si32(0,_loc13_ + 16);
      si32(_loc1_,_loc13_ + 20);
      si32(0,_loc13_ + 24);
      var _loc12_:*;
      si32(_loc12_ = (_loc12_ = _loc1_ * -1640562687) >>> 25,_loc13_ + 8);
      _loc11_ = li32(_loc3_ + 8);
      _loc10_ = 0;
      _loc9_ = 0;
      while(true)
      {
         loop1:
         while(true)
         {
            _loc8_ = li32(_loc1_);
            while((_loc7_ = _loc8_) >= 0)
            {
               if((_loc12_ = _loc7_ & 536870911) != 0)
               {
                  break;
               }
               _loc2_ -= 16;
               si32(_loc7_,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               si32(_loc12_ = _loc7_ | -2147483648,_loc2_ + 8);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc6_ = 0;
               _loc2_ += 16;
               if((_loc8_ = eax) == _loc7_)
               {
                  §§goto(addr2235);
               }
            }
            if(_loc9_ != 0)
            {
               _loc6_ = _loc9_;
               if(uint(_loc7_) <= 1073741823)
               {
                  _loc6_ = _loc9_;
                  if(_loc10_ != 0)
                  {
                     _loc1_ = li32(_loc13_ + 8);
                     if((_loc12_ = li32(_loc13_ + 12)) <= 1)
                     {
                        _loc1_ = (_loc12_ = _umtxq_chains + _loc1_ * 44) + 5632;
                     }
                     else
                     {
                        _loc1_ = _umtxq_chains + _loc1_ * 44;
                     }
                     _loc12_ = int(threadId);
                     _loc2_ -= 16;
                     si32(_loc12_ += 8,_loc2_ + 4);
                     si32(_loc1_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     _loc1_ = li32(_loc13_ + 8);
                     if((_loc12_ = li32(_loc13_ + 12)) <= 1)
                     {
                        _loc11_ = (_loc12_ = _umtxq_chains + _loc1_ * 44) + 5632;
                     }
                     else
                     {
                        _loc11_ = _umtxq_chains + _loc1_ * 44;
                     }
                     if((_loc12_ = li8(_loc11_ + 36)) != 0)
                     {
                        _loc1_ = li32(_loc11_ + 40);
                        do
                        {
                           si32(_loc12_ = _loc1_ + 1,_loc11_ + 40);
                           _loc2_ -= 16;
                           si32(0,_loc2_ + 8);
                           si32(_loc11_,_loc2_ + 4);
                           si32(_loc11_,_loc2_);
                           ESP = _loc2_;
                           F_avm2_msleep();
                           _loc2_ += 16;
                           _loc1_ = (_loc12_ = li32(_loc11_ + 40)) + -1;
                           si32(_loc1_,_loc11_ + 40);
                        }
                        while((_loc12_ = li8(_loc11_ + 36)) != 0);
                        
                     }
                     si8(1,_loc11_ + 36);
                     _loc1_ = li32(_loc13_ + 8);
                     if((_loc12_ = li32(_loc13_ + 12)) <= 1)
                     {
                        _loc1_ = (_loc12_ = _umtxq_chains + _loc1_ * 44) + 5632;
                     }
                     else
                     {
                        _loc1_ = _umtxq_chains + _loc1_ * 44;
                     }
                     _loc11_ = li32(_loc1_ + 20);
                     _loc1_ = 2147483647;
                     loop9:
                     while(true)
                     {
                        while((_loc10_ = _loc11_) != 0)
                        {
                           _loc7_ = li32(_loc10_ + 12);
                           _loc11_ = li32(_loc10_);
                           if(_loc7_ == li32(_loc13_ + 12))
                           {
                              var _loc5_:*;
                              if((_loc5_ = li32(_loc10_ + 20)) == li32(_loc13_ + 20))
                              {
                                 if((_loc12_ = li32(_loc10_ + 24)) != li32(_loc13_ + 24))
                                 {
                                    continue;
                                 }
                                 continue loop9;
                              }
                           }
                        }
                        addr591:
                        _loc1_ = li32(_loc13_ + 8);
                        if((_loc12_ = li32(_loc13_ + 12)) <= 1)
                        {
                           _loc1_ = (_loc12_ = _umtxq_chains + _loc1_ * 44) + 5632;
                        }
                        else
                        {
                           _loc1_ = _umtxq_chains + _loc1_ * 44;
                        }
                        si8(0,_loc1_ + 36);
                        if((_loc12_ = li32(_loc1_ + 40)) != 0)
                        {
                           if((_loc12_ = li8(_sIsThreaded_2E_b)) == 1)
                           {
                              _loc2_ -= 16;
                              si32(_loc1_,_loc2_);
                              ESP = _loc2_;
                              F_avm2_wake_one();
                              _loc2_ += 16;
                           }
                        }
                        _loc1_ = li32(_loc13_ + 8);
                        if((_loc12_ = li32(_loc13_ + 12)) <= 1)
                        {
                           _loc13_ = (_loc12_ = _umtxq_chains + _loc1_ * 44) + 5632;
                        }
                        else
                        {
                           _loc13_ = _umtxq_chains + _loc1_ * 44;
                        }
                        _loc2_ -= 16;
                        si32(_loc13_,_loc2_);
                        ESP = _loc2_;
                        F_avm2_unlock();
                        _loc2_ += 16;
                        _loc6_ = _loc9_;
                     }
                  }
               }
               addr2235:
               eax = _loc6_;
               _loc2_ = _loc3_;
            }
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc6_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc12_ = int(threadId);
            _loc2_ -= 16;
            si32(_loc12_ += 8,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc7_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc7_ = _umtxq_chains + _loc6_ * 44;
            }
            if((_loc12_ = li8(_loc7_ + 36)) != 0)
            {
               _loc6_ = li32(_loc7_ + 40);
               do
               {
                  si32(_loc12_ = _loc6_ + 1,_loc7_ + 40);
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 8);
                  si32(_loc7_,_loc2_ + 4);
                  si32(_loc7_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_msleep();
                  _loc2_ += 16;
                  si32(_loc6_ = (_loc12_ = li32(_loc7_ + 40)) + -1,_loc7_ + 40);
               }
               while((_loc12_ = li8(_loc7_ + 36)) != 0);
               
            }
            si8(1,_loc7_ + 36);
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc6_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc2_ -= 16;
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            _loc7_ = li32(_loc1_);
            while(true)
            {
               _loc6_ = _loc7_;
               _loc8_ = 1;
               if(_loc6_ >= 0)
               {
                  _loc8_ = 0;
               }
               _loc7_ = _loc6_ & 536870911;
               _loc4_ = 1;
               if(_loc7_ == 0)
               {
                  _loc4_ = 0;
               }
               if((_loc12_ = _loc6_ & 1073741824) != 0)
               {
                  break;
               }
               if((_loc12_ = _loc8_ | _loc4_) == 0)
               {
                  break;
               }
               _loc2_ -= 16;
               si32(_loc6_,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               si32(_loc12_ = _loc6_ | 1073741824,_loc2_ + 8);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc2_ += 16;
               if((_loc7_ = eax) == _loc6_)
               {
                  break loop1;
               }
            }
            if(_loc6_ < 0)
            {
               break;
            }
            if(_loc7_ != 0)
            {
               break;
            }
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc6_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc12_ = int(threadId);
            _loc2_ -= 16;
            si32(_loc12_ += 8,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc6_ = _umtxq_chains + _loc6_ * 44;
            }
            si8(0,_loc6_ + 36);
            if((_loc12_ = li32(_loc6_ + 40)) != 0)
            {
               if((_loc12_ = li8(_sIsThreaded_2E_b)) == 1)
               {
                  _loc2_ -= 16;
                  si32(_loc6_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_wake_one();
                  _loc2_ += 16;
               }
            }
            _loc6_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc6_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc2_ -= 16;
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            continue;
            ESP = _loc2_;
            return;
         }
         si32(_loc12_ = (_loc12_ = li32(_loc1_ + 12)) + 1,_loc1_ + 12);
         while(true)
         {
            if(_loc6_ >= 0)
            {
               if((_loc12_ = _loc6_ & 536870911) == 0)
               {
                  break;
               }
            }
            _loc9_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc9_ = (_loc12_ = _umtxq_chains + _loc9_ * 44) + 5632;
            }
            else
            {
               _loc9_ = _umtxq_chains + _loc9_ * 44;
            }
            _loc12_ = int(threadId);
            _loc2_ -= 16;
            si32(_loc12_ += 8,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_avm2_lock_id();
            _loc2_ += 16;
            _loc9_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc9_ = (_loc12_ = _umtxq_chains + _loc9_ * 44) + 5632;
            }
            else
            {
               _loc9_ = _umtxq_chains + _loc9_ * 44;
            }
            si32(0,_loc13_);
            si32(_loc12_ = li32(_loc9_ + 32),_loc13_ + 4);
            _loc12_ = li32(_loc9_ + 32);
            si32(_loc13_,_loc12_);
            si32(_loc13_,_loc9_ + 32);
            si32(_loc12_ = (_loc12_ = li32(_loc13_ + 28)) | 1,_loc13_ + 28);
            _loc9_ = li32(_loc13_ + 8);
            if((_loc12_ = li32(_loc13_ + 12)) <= 1)
            {
               _loc9_ = (_loc12_ = _umtxq_chains + _loc9_ * 44) + 5632;
            }
            else
            {
               _loc9_ = _umtxq_chains + _loc9_ * 44;
            }
            si8(0,_loc9_ + 36);
            if((_loc12_ = li32(_loc9_ + 40)) != 0)
            {
               if((_loc12_ = li8(_sIsThreaded_2E_b)) == 1)
               {
                  _loc2_ -= 16;
                  si32(_loc9_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_wake_one();
                  _loc2_ += 16;
               }
            }
            _loc10_ = li32(_loc13_ + 12);
            _loc6_ = li32(_loc13_ + 8);
            if(_loc10_ <= 1)
            {
               _loc7_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc7_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc12_ = (_loc12_ = li8(_loc13_ + 28)) & 1;
            _loc9_ = 0;
            if(_loc12_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc11_,_loc2_ + 8);
               si32(_loc7_,_loc2_ + 4);
               si32(_loc13_,_loc2_);
               ESP = _loc2_;
               F_avm2_msleep();
               _loc9_ = 60;
               _loc2_ += 16;
               if((_loc12_ = eax) != 0)
               {
                  _loc9_ = 0;
               }
               _loc10_ = li32(_loc13_ + 12);
               _loc6_ = li32(_loc13_ + 8);
            }
            if(_loc10_ <= 1)
            {
               _loc10_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc10_ = _umtxq_chains + _loc6_ * 44;
            }
            if((_loc12_ = li8(_loc10_ + 36)) != 0)
            {
               _loc6_ = li32(_loc10_ + 40);
               do
               {
                  si32(_loc12_ = _loc6_ + 1,_loc10_ + 40);
                  _loc2_ -= 16;
                  si32(0,_loc2_ + 8);
                  si32(_loc10_,_loc2_ + 4);
                  si32(_loc10_,_loc2_);
                  ESP = _loc2_;
                  F_avm2_msleep();
                  _loc2_ += 16;
                  si32(_loc6_ = (_loc12_ = li32(_loc10_ + 40)) + -1,_loc10_ + 40);
               }
               while((_loc12_ = li8(_loc10_ + 36)) != 0);
               
            }
            si8(1,_loc10_ + 36);
            _loc7_ = li32(_loc13_ + 12);
            _loc6_ = li32(_loc13_ + 8);
            if(_loc7_ <= 1)
            {
               _loc10_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc10_ = _umtxq_chains + _loc6_ * 44;
            }
            if((_loc12_ = (_loc12_ = li8(_loc13_ + 28)) & 1) != 0)
            {
               _loc6_ = li32(_loc13_ + 4);
               if((_loc7_ = li32(_loc13_)) != 0)
               {
                  si32(_loc6_,_loc7_ + 4);
               }
               else
               {
                  si32(_loc6_,_loc10_ + 32);
               }
               _loc5_ = li32(_loc13_);
               _loc12_ = li32(_loc13_ + 4);
               si32(_loc5_,_loc12_);
               si32(_loc12_ = (_loc12_ = li32(_loc13_ + 28)) & -2,_loc13_ + 28);
               _loc7_ = li32(_loc13_ + 12);
               _loc6_ = li32(_loc13_ + 8);
            }
            if(_loc7_ <= 1)
            {
               _loc10_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
            }
            else
            {
               _loc10_ = _umtxq_chains + _loc6_ * 44;
            }
            _loc2_ -= 16;
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F_avm2_unlock();
            _loc2_ += 16;
            if(_loc9_ != 0)
            {
               break;
            }
            _loc6_ = li32(_loc1_);
            _loc9_ = 0;
         }
         si32(_loc5_ = (_loc12_ = li32(_loc1_ + 12)) + -1,_loc1_ + 12);
         _loc10_ = 0;
         if(_loc12_ == 1)
         {
            _loc10_ = li32(_loc1_);
            do
            {
               _loc5_ = _loc10_;
               _loc2_ -= 16;
               si32(_loc5_,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               si32(_loc12_ = _loc5_ & -1073741825,_loc2_ + 8);
               ESP = _loc2_;
               F_avm2_cmpSwapUns();
               _loc2_ += 16;
            }
            while((_loc10_ = eax) != _loc5_);
            
            _loc10_ = li32(_loc1_ + 8);
         }
         _loc6_ = li32(_loc13_ + 8);
         if((_loc12_ = li32(_loc13_ + 12)) <= 1)
         {
            _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
         }
         else
         {
            _loc6_ = _umtxq_chains + _loc6_ * 44;
         }
         _loc12_ = int(threadId);
         _loc2_ -= 16;
         si32(_loc12_ += 8,_loc2_ + 4);
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         F_avm2_lock_id();
         _loc2_ += 16;
         _loc6_ = li32(_loc13_ + 8);
         if((_loc12_ = li32(_loc13_ + 12)) <= 1)
         {
            _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
         }
         else
         {
            _loc6_ = _umtxq_chains + _loc6_ * 44;
         }
         si8(0,_loc6_ + 36);
         if((_loc12_ = li32(_loc6_ + 40)) != 0)
         {
            if((_loc12_ = li8(_sIsThreaded_2E_b)) == 1)
            {
               _loc2_ -= 16;
               si32(_loc6_,_loc2_);
               ESP = _loc2_;
               F_avm2_wake_one();
               _loc2_ += 16;
            }
         }
         _loc6_ = li32(_loc13_ + 8);
         if((_loc12_ = li32(_loc13_ + 12)) <= 1)
         {
            _loc6_ = (_loc12_ = _umtxq_chains + _loc6_ * 44) + 5632;
         }
         else
         {
            _loc6_ = _umtxq_chains + _loc6_ * 44;
         }
         _loc2_ -= 16;
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
      }
   }
}
