package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_sflush_locked;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F___fflush() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      _loc8_ = ___sglue;
      if((_loc7_ = li32(_loc3_)) == 0)
      {
         while(true)
         {
            if((_loc7_ = li32(_loc8_ + 4)) >= 1)
            {
               _loc6_ = li32(_loc8_ + 8);
               do
               {
                  var _loc5_:*;
                  if((_loc5_ = si16(li16(_loc6_ + 12))) >= 1)
                  {
                     _loc2_ -= 16;
                     si32(_loc6_,_loc2_);
                     ESP = _loc2_;
                     F_sflush_locked();
                     _loc2_ += 16;
                     _loc1_ = (_loc5_ = eax) | _loc1_;
                  }
                  _loc6_ += 232;
               }
               while((_loc7_ += -1) != 0);
               
            }
            if((_loc8_ = li32(_loc8_)) != 0)
            {
               continue;
            }
         }
      }
      else if((_loc5_ = (_loc6_ = si16(li16(_loc7_ + 12))) & 24) == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(9,eax);
         _loc1_ = -1;
      }
      else
      {
         _loc1_ = 0;
         if((_loc6_ & 8) != 0)
         {
            _loc8_ = li32(_loc7_ + 16);
            _loc1_ = 0;
            if(_loc8_ != 0)
            {
               _loc4_ = li32(_loc7_);
               si32(_loc8_,_loc7_);
               _loc1_ = 0;
               if((_loc6_ & 3) == 0)
               {
                  _loc1_ = li32(_loc7_ + 20);
               }
               _loc6_ = _loc4_ - _loc8_;
               si32(_loc1_,_loc7_ + 8);
               while(true)
               {
                  _loc1_ = 0;
                  if(_loc6_ <= 0)
                  {
                     break;
                  }
                  _loc2_ -= 16;
                  si32(_loc6_,_loc2_ + 8);
                  si32(_loc8_,_loc2_ + 4);
                  si32(_loc7_,_loc2_);
                  ESP = _loc2_;
                  F__swrite();
                  _loc2_ += 16;
                  _loc1_ = eax;
                  if(_loc1_ <= 0)
                  {
                     si16(_loc5_ = (_loc5_ = li16(_loc7_ + 12)) | 64,_loc7_ + 12);
                     _loc1_ = -1;
                     break;
                  }
                  _loc8_ += _loc1_;
                  _loc6_ -= _loc1_;
               }
            }
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
