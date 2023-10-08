package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___mbsnrtowcs_std() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:int = 0;
      var _loc12_:* = 0;
      var _loc11_:int = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = li32(_loc3_ + 4);
      _loc12_ = li32(_loc1_);
      _loc11_ = 0;
      _loc10_ = li32(_loc3_ + 16);
      _loc9_ = li32(_loc3_ + 12);
      _loc8_ = li32(_loc3_ + 8);
      if((_loc7_ = li32(_loc3_)) == 0)
      {
         while(true)
         {
            var _loc6_:* = li32(___mbrtowc);
            _loc2_ -= 16;
            si32(_loc10_,_loc2_ + 12);
            si32(_loc8_,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            var _loc5_:int;
            si32(_loc5_ = _loc3_ - 4,_loc2_);
            ESP = _loc2_;
            ptr2fun[_loc6_]();
            _loc7_ = -1;
            _loc2_ += 16;
            _loc1_ = eax;
            if(_loc1_ != -1)
            {
               _loc7_ = _loc11_;
               if(_loc1_ != -2)
               {
                  _loc7_ = _loc11_;
                  if(_loc1_ != 0)
                  {
                     continue;
                  }
               }
            }
         }
      }
      else
      {
         while(true)
         {
            if(_loc9_ == _loc11_)
            {
               si32(_loc12_,_loc1_);
               _loc7_ = _loc11_;
               break;
            }
            _loc6_ = li32(___mbrtowc);
            _loc2_ -= 16;
            si32(_loc10_,_loc2_ + 12);
            si32(_loc8_,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            ESP = _loc2_;
            ptr2fun[_loc6_]();
            _loc2_ += 16;
            if((_loc4_ = eax) == -2)
            {
               si32(_loc6_ = _loc12_ + _loc8_,_loc1_);
               _loc7_ = _loc11_;
               break;
            }
            if(_loc4_ == 0)
            {
               si32(0,_loc1_);
               _loc7_ = _loc11_;
               break;
            }
            if(_loc4_ == -1)
            {
               si32(_loc12_,_loc1_);
               _loc7_ = -1;
               break;
            }
            _loc8_ -= _loc4_;
            _loc12_ += _loc4_;
            _loc7_ += 4;
            _loc11_ += 1;
         }
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
