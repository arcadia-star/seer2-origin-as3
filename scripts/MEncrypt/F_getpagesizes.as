package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str187;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._nops_2E_1562;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ps_2E_1561;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_getpagesizes() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 128;
      _loc1_ = li32(_loc3_ + 4);
      if(_loc1_ >= 0)
      {
         _loc8_ = li32(_loc3_);
         if(_loc1_ >= 1)
         {
            if(_loc8_ == 0)
            {
               addr43:
               ESP = _loc2_;
               F___error();
               var _loc7_:* = eax;
               si32(22,_loc7_);
               _loc6_ = -1;
            }
            else
            {
               addr61:
               if((_loc5_ = li32(_nops_2E_1562)) == 0)
               {
                  si32(8,_loc3_ - 120);
                  si32(0,_loc3_ - 8);
                  si32(3,_loc3_ - 4);
                  si32(104,_loc3_ - 116);
                  _loc2_ -= 32;
                  si32(_loc8_,_loc2_ + 20);
                  si32(L__2E_str187,_loc2_ + 16);
                  si32(_loc7_ = _loc3_ - 116,_loc2_ + 12);
                  si32(_loc6_ = _loc3_ - 112,_loc2_ + 8);
                  si32(2,_loc2_ + 4);
                  si32(_loc7_ = _loc3_ - 8,_loc2_);
                  ESP = _loc2_;
                  F_sysctl();
                  _loc2_ += 32;
                  if((_loc5_ = eax) >= 0)
                  {
                     var _loc4_:int;
                     si32(_loc4_ = (_loc7_ = li32(_loc3_ - 116)) >>> 2,_loc3_ - 116);
                     _loc2_ -= 32;
                     si32(_loc8_,_loc2_ + 20);
                     si32(0,_loc2_ + 16);
                     si32(_loc7_ = _loc3_ - 120,_loc2_ + 12);
                     si32(_ps_2E_1561,_loc2_ + 8);
                     si32(_loc4_,_loc2_ + 4);
                     si32(_loc6_,_loc2_);
                     ESP = _loc2_;
                     F_sysctl();
                     _loc2_ += 32;
                     _loc5_ = eax;
                  }
                  _loc6_ = -1;
                  if(_loc5_ != -1)
                  {
                     _loc6_ = (_loc7_ = li32(_loc3_ - 120)) >>> 2;
                     while((_loc5_ = _loc6_) >= 1)
                     {
                        _loc6_ = _loc5_ + -1;
                        if(li32((_loc7_ = _ps_2E_1561 + (_loc5_ << 2)) - 4) != 0)
                        {
                           break;
                        }
                     }
                     si32(_loc5_,_nops_2E_1562);
                  }
                  §§goto(addr334);
               }
               _loc6_ = _loc5_;
               if(_loc8_ != 0)
               {
                  _loc6_ = _loc5_;
                  if(_loc5_ >= _loc1_)
                  {
                     _loc6_ = _loc1_;
                  }
                  if(_loc6_ >= 1)
                  {
                     _loc1_ ^= -1;
                     if((_loc5_ ^= -1) <= _loc1_)
                     {
                        _loc5_ = _loc1_;
                     }
                     _loc1_ = _loc5_ ^ -1;
                     _loc5_ = _ps_2E_1561;
                     do
                     {
                        si32(_loc7_ = li32(_loc5_),_loc8_);
                        _loc8_ += 4;
                        _loc5_ += 4;
                        _loc1_ += -1;
                     }
                     while(_loc1_ != 0);
                     
                  }
               }
            }
            addr334:
            eax = _loc6_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
         §§goto(addr61);
      }
      §§goto(addr43);
   }
}
