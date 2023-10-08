package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F__UTF8_mbsnrtowcs() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc12_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_ + 4);
      _loc12_ = li32(_loc1_);
      _loc11_ = li32(_loc3_ + 16);
      _loc10_ = li32(_loc3_ + 8);
      if((_loc9_ = li32(_loc3_)) == 0)
      {
         _loc8_ = _loc9_ = 0;
         if(_loc10_ != 0)
         {
            _loc9_ = 0;
            _loc8_ = _loc10_;
            if(li32(_loc11_ + 4) >= 1)
            {
               _loc9_ = 0;
               _loc8_ = _loc10_;
               if(si8(li8(_loc12_)) >= 1)
               {
                  ESP = _loc2_;
                  F___error();
                  si32(86,eax);
                  _loc6_ = -1;
               }
               §§goto(addr389);
            }
         }
         while(true)
         {
            if(_loc8_ != 0)
            {
               _loc10_ = 1;
               if(si8(li8(_loc12_)) > 0)
               {
                  continue;
               }
            }
            _loc2_ -= 16;
            si32(_loc11_,_loc2_ + 12);
            si32(_loc8_,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            var _loc7_:int;
            si32(_loc7_ = _loc3_ - 4,_loc2_);
            ESP = _loc2_;
            F__UTF8_mbrtowc();
            _loc6_ = -1;
            _loc2_ += 16;
            if((_loc10_ = eax) != -1)
            {
               _loc6_ = _loc9_;
               if(_loc10_ != -2)
               {
                  _loc6_ = _loc9_;
                  if(_loc10_ != 0)
                  {
                     continue;
                  }
               }
            }
         }
      }
      else
      {
         _loc5_ = 1;
         _loc8_ = 0;
         if(_loc10_ != _loc8_)
         {
            _loc5_ = _loc8_;
         }
         _loc4_ = li32(_loc3_ + 12);
         _loc6_ = _loc8_;
         if(_loc4_ != 0)
         {
            _loc6_ = _loc8_;
            if(_loc5_ == 0)
            {
               _loc6_ = _loc8_ = 0;
               if(li32(_loc11_ + 4) >= 1)
               {
                  _loc6_ = _loc8_ = 0;
                  if(si8(li8(_loc12_)) >= 1)
                  {
                     ESP = _loc2_;
                     F___error();
                     si32(86,eax);
                     _loc6_ = -1;
                  }
                  §§goto(addr389);
               }
            }
         }
         while(true)
         {
            if(_loc4_ == _loc6_)
            {
               si32(_loc12_,_loc1_);
               break;
            }
            if(_loc10_ != 0)
            {
               if((_loc5_ = si8(li8(_loc12_))) >= 1)
               {
                  si32(_loc5_,_loc9_ + (_loc6_ << 2));
                  _loc5_ = 1;
                  continue;
               }
            }
            _loc7_ = _loc9_ + _loc8_;
            _loc2_ -= 16;
            si32(_loc11_,_loc2_ + 12);
            si32(_loc10_,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            ESP = _loc2_;
            F__UTF8_mbrtowc();
            _loc2_ += 16;
            if((_loc5_ = eax) == -2)
            {
               si32(_loc7_ = _loc12_ + _loc10_,_loc1_);
               break;
            }
            if(_loc5_ == 0)
            {
               si32(0,_loc1_);
               break;
            }
            if(_loc5_ == -1)
            {
               si32(_loc12_,_loc1_);
               _loc6_ = -1;
               break;
            }
         }
      }
      addr389:
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
