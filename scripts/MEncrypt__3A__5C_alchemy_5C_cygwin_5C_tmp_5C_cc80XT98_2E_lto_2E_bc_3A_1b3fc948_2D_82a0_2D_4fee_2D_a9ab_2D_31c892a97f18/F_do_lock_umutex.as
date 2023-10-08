package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_do_lock_umutex() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc7_:int = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:int = 0;
      var _loc9_:* = 0;
      var _loc13_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc14_ = li32(_loc1_ + 4);
      _loc13_ = 14;
      if(_loc14_ != -1)
      {
         _loc12_ = li32(_loc3_ + 12);
         _loc11_ = li32(_loc3_ + 8);
         _loc10_ = li32(_loc3_);
         if(_loc11_ == 0)
         {
            _loc2_ -= 32;
            si32(_loc12_,_loc2_ + 16);
            si32(0,_loc2_ + 12);
            si32(_loc14_,_loc2_ + 8);
            si32(_loc1_,_loc2_ + 4);
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F__do_lock_umutex();
            _loc2_ += 32;
            if((_loc13_ = eax) == 4)
            {
               if(_loc12_ != 2)
               {
                  _loc13_ = -1;
               }
            }
         }
         else
         {
            _loc13_ = new Date().time - clockStart;
            _loc9_ = li32(_loc11_ + 4);
            var _loc8_:*;
            _loc6_ = (_loc7_ = _loc9_ + (_loc8_ = _loc13_ % 1000) * 1000000) + -1000000000;
            if(_loc7_ <= 999999999)
            {
               _loc6_ = _loc7_;
            }
            _loc11_ = li32(_loc11_);
            _loc4_ = 1;
            if(_loc7_ <= 999999999)
            {
               _loc4_ = 0;
            }
            _loc8_ = _loc13_ / 1000;
            var _loc5_:int = _loc11_ + _loc8_;
            _loc8_ = _loc4_ & 1;
            _loc7_ = _loc5_ + _loc8_;
            while(true)
            {
               _loc2_ -= 32;
               si32(_loc12_,_loc2_ + 16);
               si32(_loc14_,_loc2_ + 8);
               si32(_loc1_,_loc2_ + 4);
               si32(_loc10_,_loc2_);
               _loc5_ = _loc11_ * 1000;
               si32(_loc8_ = (_loc8_ = _loc9_ / 1000000) + _loc5_,_loc2_ + 12);
               ESP = _loc2_;
               F__do_lock_umutex();
               _loc13_ = 4;
               _loc2_ += 32;
               if((_loc9_ = eax) != -1)
               {
                  if(_loc9_ == 60)
                  {
                     _loc13_ = (_loc8_ = new Date().time - clockStart) / 1000;
                     _loc11_ = (_loc8_ %= 1000) * 1000000;
                     if(_loc13_ == _loc7_)
                     {
                        _loc9_ = 60;
                        if(_loc11_ < _loc6_)
                        {
                           continue;
                        }
                     }
                     else
                     {
                        _loc9_ = 60;
                        if(_loc13_ < _loc7_)
                        {
                           continue;
                        }
                     }
                  }
                  _loc13_ = _loc9_;
                  break;
               }
               break;
            }
         }
      }
      eax = _loc13_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
