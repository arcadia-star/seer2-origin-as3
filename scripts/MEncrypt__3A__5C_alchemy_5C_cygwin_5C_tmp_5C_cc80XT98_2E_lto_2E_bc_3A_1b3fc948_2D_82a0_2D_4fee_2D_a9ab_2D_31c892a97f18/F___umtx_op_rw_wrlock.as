package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___umtx_op_rw_wrlock() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:int = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc11_ = li32(_loc1_ + 16);
      _loc10_ = li32(_loc3_);
      if(_loc11_ == 0)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 8);
         si32(li32(_loc1_),_loc2_ + 4);
         si32(li32(_loc10_ + 4),_loc2_);
         ESP = _loc2_;
         F_do_rw_wrlock();
         _loc2_ += 16;
         _loc10_ = eax;
      }
      else
      {
         si32(0,_loc11_ + 4);
         si32(0,_loc11_);
         _loc7_ = li32(_loc1_);
         var _loc8_:*;
         _loc1_ = (_loc8_ = new Date().time - clockStart) / 1000;
         _loc11_ = (_loc8_ %= 1000) * 1000000;
         _loc6_ = 0;
         _loc5_ = 0;
         while(true)
         {
            var _loc9_:int = _loc5_ + _loc6_;
            _loc8_ = li32(_loc10_ + 4);
            _loc2_ -= 16;
            si32(_loc9_,_loc2_ + 8);
            si32(_loc7_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F_do_rw_wrlock();
            _loc2_ += 16;
            if((_loc4_ = eax) != 60)
            {
               break;
            }
            _loc6_ = (_loc8_ = new Date().time - clockStart) / 1000;
            _loc5_ = (_loc8_ %= 1000) * 1000000;
            if(_loc6_ == _loc1_)
            {
               _loc4_ = 60;
               if(_loc5_ >= _loc11_)
               {
                  break;
               }
            }
            else
            {
               _loc4_ = 60;
               if(_loc6_ >= _loc1_)
               {
                  break;
               }
            }
            _loc5_ = (_loc4_ = _loc11_ - _loc5_) + 1000000000;
            if(_loc4_ >= 0)
            {
               _loc5_ = _loc4_;
            }
            _loc5_ /= 1000000;
            _loc9_ = _loc1_ - _loc6_;
            _loc8_ = _loc4_ >> 31;
            _loc6_ = (_loc8_ = _loc9_ + _loc8_) * 1000;
         }
         _loc10_ = 4;
         if(_loc4_ != -1)
         {
            _loc10_ = _loc4_;
         }
      }
      eax = _loc10_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
