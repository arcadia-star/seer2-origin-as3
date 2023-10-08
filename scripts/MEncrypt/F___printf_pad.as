package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._blanks312;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._zeroes311;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___printf_pad() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc1_:int = 0;
      var _loc13_:int = 0;
      var _loc9_:int = 0;
      var _loc7_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _blanks312;
      _loc13_ = 0;
      var _loc12_:*;
      if((_loc12_ = li32(_loc3_ + 8)) != _loc13_)
      {
         _loc1_ = _zeroes311;
      }
      if((_loc11_ = li32(_loc3_ + 4)) >= 1)
      {
         _loc9_ = (_loc12_ = (_loc12_ = li8((_loc12_ = li32(_loc10_ = li32(_loc3_))) + 12)) & 64) >>> 6;
         _loc7_ = _loc8_ = 0;
         if(_loc11_ >= 17)
         {
            _loc6_ = _loc10_ + 16;
            _loc5_ = _loc10_ + 4;
            _loc7_ = 0;
            do
            {
               _loc13_ = 0;
               if(_loc9_ == 0)
               {
                  si32(_loc1_,li32(_loc10_ + 80));
                  si32(_loc13_ = 16,li32(_loc10_ + 80) + 4);
                  si32(_loc12_ = (_loc12_ = li32(_loc10_ + 12)) + 16,_loc10_ + 12);
                  si32(_loc12_ = (_loc12_ = li32(_loc10_ + 80)) + 8,_loc10_ + 80);
                  si32(_loc12_ = (_loc12_ = li32(_loc10_ + 8)) + 1,_loc10_ + 8);
                  if(_loc12_ >= 8)
                  {
                     _loc2_ -= 16;
                     si32(_loc5_,_loc2_ + 4);
                     si32(li32(_loc10_),_loc2_);
                     ESP = _loc2_;
                     F___sfvwrite();
                     _loc2_ += 16;
                     si32(_loc6_,_loc10_ + 80);
                     si32(_loc6_,_loc10_ + 4);
                     si32(0,_loc10_ + 12);
                     si32(0,_loc10_ + 8);
                     _loc13_ = 16;
                  }
               }
               _loc7_ = _loc13_ + _loc7_;
               _loc11_ += -16;
               _loc9_ = (_loc12_ = (_loc12_ = li8((_loc12_ = li32(_loc10_)) + 12)) & 64) >>> 6;
            }
            while(_loc11_ > 16);
            
         }
         if(_loc9_ == 0)
         {
            if(_loc11_ != 0)
            {
               si32(_loc1_,li32(_loc10_ + 80));
               si32(_loc11_,li32(_loc10_ + 80) + 4);
               si32(_loc12_ = (_loc12_ = li32(_loc10_ + 12)) + _loc11_,_loc10_ + 12);
               si32(_loc12_ = (_loc12_ = li32(_loc10_ + 80)) + 8,_loc10_ + 80);
               si32(_loc12_ = (_loc12_ = li32(_loc10_ + 8)) + 1,_loc10_ + 8);
               _loc8_ = _loc11_;
               if(_loc12_ >= 8)
               {
                  _loc2_ -= 16;
                  si32(_loc12_ = _loc10_ + 4,_loc2_ + 4);
                  si32(li32(_loc10_),_loc2_);
                  ESP = _loc2_;
                  F___sfvwrite();
                  _loc2_ += 16;
                  si32(_loc12_ = _loc10_ + 16,_loc10_ + 80);
                  si32(_loc12_,_loc10_ + 4);
                  si32(0,_loc10_ + 12);
                  si32(0,_loc10_ + 8);
                  _loc8_ = _loc11_;
               }
            }
         }
         _loc13_ = _loc8_ + _loc7_;
      }
      eax = _loc13_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
