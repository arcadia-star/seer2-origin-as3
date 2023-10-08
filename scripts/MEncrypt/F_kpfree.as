package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sFreeHead;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageHash;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageHashSize;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._sPageSize;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_kpfree() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc4_:int = 0;
      var _loc7_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc11_ = _loc1_ >>> 12;
      var _loc9_:*;
      _loc11_ = (_loc9_ = (_loc10_ = _loc1_ & -4096) >>> 11) + _loc11_;
      _loc11_ = (_loc7_ = (_loc8_ = (_loc9_ = li32(_sPageHashSize)) + -1) & _loc11_) << 2;
      if((_loc5_ = li32(_loc11_ = (_loc6_ = li32(_sPageHash)) + _loc11_)) != 0)
      {
         _loc4_ = 7;
         if(_loc5_ != _loc10_)
         {
            do
            {
               _loc11_ = (_loc7_ = (_loc11_ = _loc7_ + _loc4_) & _loc8_) << 2;
               if((_loc5_ = li32(_loc11_ = _loc6_ + _loc11_)) == 0)
               {
                  break;
               }
               _loc4_ += 1;
            }
            while(_loc5_ != _loc10_);
            
         }
      }
      _loc9_ = _loc7_ << 2;
      _loc8_ = li32(_loc11_ = (_loc11_ = li32(_sPageSize)) + _loc9_);
      _loc6_ = 0;
      if(_loc8_ != 0)
      {
         _loc6_ = 4;
         _loc10_ = 0;
         if(uint(_loc8_) >= 5)
         {
            do
            {
               _loc6_ <<= 1;
               _loc10_ += 1;
            }
            while(uint(_loc6_) < uint(_loc8_));
            
         }
         _loc11_ = _loc10_ << 2;
         si32(_loc11_ = li32(_loc9_ = _sFreeHead + _loc11_),_loc1_);
         si32(_loc1_,_loc9_);
         _loc6_ = 1;
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
