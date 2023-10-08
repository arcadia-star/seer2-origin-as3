package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F__BIG5_mbrtowc() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      if((uint(_loc10_ = li32(_loc1_))) >= 256)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc8_ = -1;
      }
      else
      {
         _loc7_ = li32(_loc3_ + 4);
         _loc6_ = 1;
         if(_loc7_ != 0)
         {
            _loc6_ = li32(_loc3_ + 8);
         }
         _loc5_ = 0;
         if(_loc7_ != 0)
         {
            _loc5_ = li32(_loc3_);
         }
         _loc4_ = L__2E_str461;
         if(_loc7_ != 0)
         {
            _loc4_ = _loc7_;
         }
         _loc8_ = -2;
         if(_loc6_ != 0)
         {
            _loc7_ = li8(_loc4_);
            if(_loc10_ != 0)
            {
               if(_loc7_ == 0)
               {
                  ESP = _loc2_;
                  F___error();
                  si32(86,eax);
                  _loc8_ = -1;
               }
               else
               {
                  if(_loc5_ != 0)
                  {
                     var _loc9_:*;
                     si32(_loc9_ = _loc7_ | _loc10_ << 8,_loc5_);
                  }
                  si32(0,_loc1_);
                  _loc8_ = 1;
               }
            }
            else if((uint(_loc9_ = _loc7_ + -161)) <= 93)
            {
               if(uint(_loc6_) <= 1)
               {
                  si32(_loc7_,_loc1_);
                  _loc8_ = -2;
               }
               else if((_loc6_ = li8(_loc4_ + 1)) == 0)
               {
                  ESP = _loc2_;
                  F___error();
                  si32(86,eax);
                  _loc8_ = -1;
               }
               else
               {
                  _loc8_ = 2;
                  if(_loc5_ != 0)
                  {
                     si32(_loc9_ = _loc6_ | _loc7_ << 8,_loc5_);
                     _loc8_ = 2;
                  }
               }
            }
            else
            {
               if(_loc5_ != 0)
               {
                  si32(_loc7_,_loc5_);
               }
               _loc5_ = 1;
               if(_loc7_ == 0)
               {
                  _loc5_ = 0;
               }
               _loc8_ = _loc5_ & 1;
            }
         }
      }
      eax = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
