package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___umtx_op_rw_rdlock() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc13_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:int = 0;
      var _loc4_:int = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc12_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc13_ = li32(_loc1_ + 16);
      _loc12_ = li32(_loc3_);
      if(_loc13_ == 0)
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 12);
         si32(li32(_loc1_ + 8),_loc2_ + 8);
         si32(li32(_loc1_),_loc2_ + 4);
         si32(li32(_loc12_ + 4),_loc2_);
         ESP = _loc2_;
         F_do_rw_rdlock();
         _loc2_ += 16;
         _loc12_ = eax;
      }
      else
      {
         si32(0,_loc13_ + 4);
         si32(0,_loc13_);
         _loc13_ = li32(_loc1_ + 8);
         _loc8_ = li32(_loc1_);
         var _loc9_:*;
         _loc7_ = (_loc9_ = new Date().time - clockStart) / 1000;
         _loc1_ = (_loc9_ %= 1000) * 1000000;
         _loc6_ = 0;
         _loc5_ = 0;
         while(true)
         {
            var _loc10_:int = _loc5_ + _loc6_;
            _loc9_ = li32(_loc12_ + 4);
            _loc2_ -= 16;
            si32(_loc10_,_loc2_ + 12);
            si32(_loc13_,_loc2_ + 8);
            si32(_loc8_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_do_rw_rdlock();
            _loc2_ += 16;
            if((_loc4_ = eax) != 60)
            {
               break;
            }
            _loc6_ = (_loc9_ = new Date().time - clockStart) / 1000;
            _loc5_ = (_loc9_ %= 1000) * 1000000;
            if(_loc6_ == _loc7_)
            {
               _loc4_ = 60;
               if(_loc5_ >= _loc1_)
               {
                  break;
               }
            }
            else
            {
               _loc4_ = 60;
               if(_loc6_ >= _loc7_)
               {
                  break;
               }
            }
            _loc5_ = (_loc4_ = _loc1_ - _loc5_) + 1000000000;
            if(_loc4_ >= 0)
            {
               _loc5_ = _loc4_;
            }
            _loc5_ /= 1000000;
            _loc10_ = _loc7_ - _loc6_;
            _loc9_ = _loc4_ >> 31;
            _loc6_ = (_loc9_ = _loc10_ + _loc9_) * 1000;
         }
         _loc12_ = 4;
         if(_loc4_ != -1)
         {
            _loc12_ = _loc4_;
         }
      }
      eax = _loc12_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
