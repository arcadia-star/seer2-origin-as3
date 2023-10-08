package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__swrite() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc14_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc12_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32(_loc4_ = _loc2_);
      var _loc15_:*;
      if((_loc15_ = (_loc15_ = li8(_loc3_ + 13)) & 1) != 0)
      {
         ESP = _loc2_;
         F___error();
         _loc14_ = li32(_loc15_ = eax);
         _loc2_ -= 16;
         si32(2,_loc2_ + 12);
         si32(0,_loc2_ + 8);
         si32(0,_loc2_ + 4);
         si32(_loc3_,_loc2_);
         ESP = _loc2_;
         F__sseek();
         _loc2_ += 16;
         if((_loc15_ = eax & edx) == -1)
         {
            _loc12_ = -1;
            if(((_loc15_ = li8(_loc3_ + 13)) & 4) == 0)
            {
               addr115:
               ESP = _loc2_;
               F___error();
               _loc15_ = eax;
               si32(_loc14_,_loc15_);
               var _loc11_:* = li32(_loc4_ + 8);
               var _loc10_:* = li32(_loc4_ + 4);
               var _loc13_:* = li32(_loc3_ + 44);
               _loc15_ = li32(_loc3_ + 28);
               _loc2_ -= 16;
               si32(_loc11_,_loc2_ + 8);
               si32(_loc10_,_loc2_ + 4);
               si32(_loc15_,_loc2_);
               ESP = _loc2_;
               ptr2fun[_loc13_]();
               _loc2_ += 16;
               _loc12_ = eax;
               _loc9_ = li16(_loc3_ + 12);
               if(_loc12_ >= 0)
               {
                  if((_loc15_ = _loc9_ & 4352) == 4352)
                  {
                     _loc8_ = li32(_loc3_ + 80);
                     _loc1_ = 1;
                     _loc5_ = _loc1_;
                     if(uint(_loc8_) <= (uint(_loc12_ ^ -1)))
                     {
                        _loc5_ = 0;
                     }
                     _loc6_ = li32(_loc3_ + 84);
                     _loc14_ = _loc12_ >> 31;
                     _loc7_ = 2147483647 - _loc14_;
                     if(_loc6_ <= _loc7_)
                     {
                        _loc1_ = 0;
                     }
                     if(_loc6_ != _loc7_)
                     {
                        _loc5_ = _loc1_;
                     }
                     if(_loc5_ == 0)
                     {
                        si32(_loc7_ = _loc8_ + _loc12_,_loc3_ + 80);
                        _loc1_ = 1;
                        _loc9_ = _loc1_;
                        if(uint(_loc7_) >= uint(_loc8_))
                        {
                           _loc9_ = 0;
                        }
                        if(uint(_loc7_) >= uint(_loc12_))
                        {
                           _loc1_ = _loc9_;
                        }
                        si32(_loc15_ = (_loc15_ = _loc6_ + _loc14_) + _loc1_,_loc3_ + 84);
                     }
                     §§goto(addr322);
                  }
                  si16(_loc15_ = _loc9_ & 61439,_loc3_ + 12);
               }
               else
               {
                  si16(_loc15_ = _loc9_ & 61439,_loc3_ + 12);
               }
            }
            addr322:
            eax = _loc12_;
            _loc2_ = _loc4_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr115);
   }
}
