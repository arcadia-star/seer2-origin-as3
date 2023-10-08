package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_do_unlock_umutex() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc11_ = li32(_loc1_ + 4);
      _loc10_ = 14;
      if(_loc11_ != -1)
      {
         _loc11_ &= 12;
         _loc10_ = 22;
         if(uint(_loc11_) <= 8)
         {
            var _loc9_:*;
            if((_loc9_ = (_loc9_ = 1 << _loc11_) & 273) != 0)
            {
               _loc8_ = li32(_loc1_);
               _loc10_ = 14;
               if(_loc8_ != -1)
               {
                  _loc10_ = 1;
                  if((_loc8_ & 2147483647) == li32(_loc9_ = li32(_loc3_)))
                  {
                     _loc11_ = _loc8_;
                     if(_loc8_ >= 0)
                     {
                        _loc2_ -= 16;
                        si32(0,_loc2_ + 8);
                        si32(_loc8_,_loc2_ + 4);
                        si32(_loc1_,_loc2_);
                        ESP = _loc2_;
                        F_avm2_cmpSwapUns();
                        _loc10_ = 14;
                        _loc2_ += 16;
                        if((_loc11_ = eax) != -1)
                        {
                           _loc10_ = 0;
                           if(_loc11_ != _loc8_)
                           {
                           }
                        }
                        §§goto(addr660);
                     }
                     _loc9_ = int(threadId);
                     _loc2_ -= 16;
                     si32(_loc9_ += 8,_loc2_ + 4);
                     _loc9_ = (_loc9_ = (_loc9_ = _loc1_ * -1640562687) >>> 25) * 44;
                     si32(_loc10_ = _umtxq_chains + _loc9_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     if((_loc9_ = li8(_loc10_ + 36)) != 0)
                     {
                        _loc8_ = li32(_loc10_ + 40);
                        do
                        {
                           si32(_loc9_ = _loc8_ + 1,_loc10_ + 40);
                           _loc2_ -= 16;
                           si32(0,_loc2_ + 8);
                           si32(_loc10_,_loc2_ + 4);
                           si32(_loc10_,_loc2_);
                           ESP = _loc2_;
                           F_avm2_msleep();
                           _loc2_ += 16;
                           si32(_loc8_ = (_loc9_ = li32(_loc10_ + 40)) + -1,_loc10_ + 40);
                        }
                        while((_loc9_ = li8(_loc10_ + 36)) != 0);
                        
                     }
                     si8(1,_loc10_ + 36);
                     _loc6_ = _loc10_ + 20;
                     _loc8_ = 0;
                     _loc5_ = _loc6_;
                     while(true)
                     {
                        _loc4_ = _loc8_;
                        if((_loc5_ = li32(_loc5_)) == 0)
                        {
                           break;
                        }
                        _loc8_ = _loc4_;
                        if(li32(_loc5_ + 12) == 3)
                        {
                           _loc8_ = _loc4_;
                           if(li32(_loc5_ + 20) == _loc1_)
                           {
                              _loc8_ = _loc4_;
                              if(li32(_loc5_ + 24) == 0)
                              {
                                 _loc8_ = _loc4_ + 1;
                                 if(_loc4_ > 0)
                                 {
                                    break;
                                 }
                              }
                           }
                        }
                     }
                     _loc2_ -= 16;
                     si32(_loc10_,_loc2_);
                     _loc4_ = 0;
                     if(_loc8_ >= 2)
                     {
                        _loc4_ = -2147483648;
                     }
                     ESP = _loc2_;
                     F_avm2_unlock();
                     _loc2_ += 16;
                     _loc2_ -= 16;
                     si32(_loc4_,_loc2_ + 8);
                     si32(_loc11_,_loc2_ + 4);
                     si32(_loc1_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_cmpSwapUns();
                     _loc2_ += 16;
                     _loc8_ = eax;
                     _loc9_ = int(threadId);
                     _loc2_ -= 16;
                     si32(_loc9_ += 8,_loc2_ + 4);
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_lock_id();
                     _loc2_ += 16;
                     _loc4_ = li32(_loc6_);
                     while((_loc6_ = _loc4_) != 0)
                     {
                        _loc5_ = li32(_loc6_ + 12);
                        _loc4_ = li32(_loc6_);
                        if(_loc5_ == 3)
                        {
                           if((_loc9_ = li32(_loc6_ + 20)) == _loc1_)
                           {
                              if((_loc9_ = li32(_loc6_ + 24)) == 0)
                              {
                                 _loc1_ = li32(_loc6_ + 8);
                                 if(_loc5_ <= 1)
                                 {
                                    _loc5_ = (_loc9_ = _umtxq_chains + _loc1_ * 44) + 5632;
                                 }
                                 else
                                 {
                                    _loc5_ = _umtxq_chains + _loc1_ * 44;
                                 }
                                 if((_loc9_ = (_loc9_ = li8(_loc6_ + 28)) & 1) != 0)
                                 {
                                    _loc1_ = li32(_loc6_ + 4);
                                    if(_loc4_ != 0)
                                    {
                                       si32(_loc1_,_loc4_ + 4);
                                    }
                                    else
                                    {
                                       si32(_loc1_,_loc5_ + 24);
                                    }
                                    _loc9_ = li32(_loc6_);
                                    var _loc7_:* = li32(_loc6_ + 4);
                                    si32(_loc9_,_loc7_);
                                    si32(_loc9_ = (_loc9_ = li32(_loc6_ + 28)) & -2,_loc6_ + 28);
                                 }
                                 if((_loc9_ = li8(_sIsThreaded_2E_b)) == 1)
                                 {
                                    _loc2_ -= 16;
                                    si32(_loc6_,_loc2_);
                                    ESP = _loc2_;
                                    F_avm2_wake();
                                    _loc2_ += 16;
                                    break;
                                 }
                                 break;
                              }
                           }
                        }
                     }
                     _loc1_ = 0;
                     si8(_loc1_,_loc10_ + 36);
                     if((_loc9_ = li32(_loc10_ + 40)) != 0)
                     {
                        if((_loc9_ = li8(_sIsThreaded_2E_b)) == 1)
                        {
                           _loc2_ -= 16;
                           si32(_loc10_,_loc2_);
                           ESP = _loc2_;
                           F_avm2_wake_one();
                           _loc2_ += 16;
                        }
                     }
                     _loc2_ -= 16;
                     si32(_loc10_,_loc2_);
                     ESP = _loc2_;
                     F_avm2_unlock();
                     _loc2_ += 16;
                     _loc10_ = 14;
                     if(_loc8_ != -1)
                     {
                        if(_loc8_ != _loc11_)
                        {
                           _loc1_ = 22;
                        }
                        _loc10_ = _loc1_;
                     }
                  }
               }
            }
         }
      }
      addr660:
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
