package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.__CurrentRuneLocale;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__EUC_wcrtomb() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc1_ = li32(_loc1_ + 8);
      if(_loc1_ != 0)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc9_ = -1;
      }
      else
      {
         _loc8_ = li32(_loc3_);
         _loc9_ = 1;
         if(_loc8_ != 0)
         {
            _loc1_ = li32(_loc3_ + 4);
            var _loc7_:*;
            _loc5_ = (_loc6_ = (_loc7_ = li32((_loc9_ = li32((_loc7_ = li32(__CurrentRuneLocale)) + 3148)) + 32)) & _loc1_) ^ _loc1_;
            if(li32(_loc9_ + 20) != _loc6_)
            {
               if(li32(_loc9_ + 16) == _loc6_)
               {
                  _loc9_ = _loc4_ = li32(_loc9_);
                  §§goto(addr225);
               }
               else if(li32(_loc9_ + 24) == _loc6_)
               {
                  _loc9_ = li32(_loc9_ + 8);
                  si8(-114,_loc8_);
                  _loc5_ |= -2139062144;
                  _loc8_ += 1;
                  _loc4_ = _loc9_ + -1;
                  §§goto(addr225);
               }
               else
               {
                  if(li32(_loc9_ + 28) == _loc6_)
                  {
                     _loc9_ = li32(_loc9_ + 12);
                     si8(-113,_loc8_);
                     _loc5_ |= -2139062144;
                     _loc8_ += 1;
                     _loc4_ = _loc9_ + -1;
                     addr225:
                     if(_loc4_ >= 1)
                     {
                        _loc6_ = (_loc4_ << 3) + -8;
                        do
                        {
                           _loc1_ = _loc5_ >> _loc6_;
                           si8(_loc1_,_loc8_);
                           _loc6_ += -8;
                           _loc8_ += 1;
                        }
                        while((_loc4_ += -1) != 0);
                        
                     }
                  }
                  §§goto(addr263);
               }
               §§goto(addr263);
            }
            if((_loc9_ = li32(_loc9_ + 4)) >= 1)
            {
               _loc4_ = (_loc9_ << 3) + -8;
               _loc6_ = 0;
               while(true)
               {
                  _loc1_ = _loc8_ - _loc6_;
                  si8(_loc7_ = (_loc7_ = _loc5_ >> _loc4_) | 128,_loc1_);
                  _loc6_ += -1;
                  _loc1_ = _loc9_ + _loc6_;
                  _loc4_ += -8;
                  if(_loc1_ != 0)
                  {
                     continue;
                  }
               }
            }
         }
      }
      addr263:
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
