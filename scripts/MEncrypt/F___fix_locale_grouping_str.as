package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._nogrouping;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___fix_locale_grouping_str() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _nogrouping;
      if((_loc9_ = li32(_loc3_)) != 0)
      {
         _loc8_ = li8(_loc9_);
         _loc1_ = _nogrouping;
         _loc7_ = _loc9_;
         _loc6_ = _loc9_;
         if(_loc8_ != 0)
         {
            while(true)
            {
               if((_loc4_ = _loc8_ & 255) != 59)
               {
                  if(_loc4_ != 45)
                  {
                     if(_loc4_ == 0)
                     {
                        si8(0,_loc6_);
                        _loc1_ = _loc9_;
                        break;
                     }
                     _loc1_ = _nogrouping;
                     var _loc5_:*;
                     if((_loc5_ = _loc8_ << 24) >> 24 >= 0)
                     {
                     }
                     break;
                  }
                  if((_loc5_ = li8(_loc7_ + 1)) != 49)
                  {
                     _loc5_ = _loc4_ << 2;
                     _loc5_ = (_loc5_ = li8((_loc5_ = __DefaultRuneLocale + _loc5_) + 53)) & 4;
                     _loc1_ = _nogrouping;
                  }
                  _loc7_ += 1;
                  si8(127,_loc6_);
                  _loc6_ += 1;
                  continue;
                  if(_loc5_ == 0)
                  {
                     break;
                  }
                  _loc1_ = _loc8_ + -48;
                  if((_loc8_ = si8(li8(_loc7_ + 1))) >= 0)
                  {
                     if((_loc5_ = (_loc5_ = li8((_loc5_ = __DefaultRuneLocale + ((_loc5_ = _loc8_ & 255) << 2)) + 53)) & 4) != 0)
                     {
                        _loc7_ += 1;
                        _loc1_ = (_loc5_ = (_loc5_ = _loc1_ * 10) + _loc8_) + -48;
                     }
                  }
                  si8(_loc1_,_loc6_);
                  if((_loc5_ = _loc1_ & 255) == 0)
                  {
                     _loc1_ = _nogrouping;
                     if(_loc6_ != _loc9_)
                     {
                        _loc1_ = _loc9_;
                     }
                     break;
                  }
                  _loc6_ += 1;
               }
            }
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
