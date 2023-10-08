package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___printf_render_chr() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 144;
      _loc1_ = li32(___mb_cur_max);
      _loc1_ += 15;
      _loc10_ = _loc1_ & -16;
      _loc1_ = _loc2_;
      _loc1_ -= _loc10_;
      _loc2_ = _loc9_ = _loc1_ & -16;
      _loc1_ = li32((_loc8_ = li32(_loc3_ + 4)) + 24);
      _loc7_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_);
      if(_loc1_ == 0)
      {
         if(li32(_loc8_ + 8) == 67)
         {
            addr83:
            _loc1_ = li32(_loc7_);
            var _loc5_:* = li32(_loc1_);
            _loc2_ -= 16;
            si32(128,_loc2_ + 8);
            si32(0,_loc2_ + 4);
            si32(_loc10_ = _loc3_ - 136,_loc2_);
            ESP = _loc2_;
            Fmemset();
            _loc2_ += 16;
            _loc1_ = li32(___wcrtomb);
            _loc2_ -= 16;
            si32(_loc10_,_loc2_ + 8);
            si32(_loc5_,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            ptr2fun[_loc1_]();
            _loc7_ = -1;
            _loc2_ += 16;
            if((_loc4_ = eax) != -1)
            {
               _loc2_ -= 16;
               si32(_loc4_,_loc2_ + 12);
               si32(_loc9_,_loc2_ + 8);
               si32(_loc8_,_loc2_ + 4);
               si32(_loc6_,_loc2_);
               ESP = _loc2_;
               F___printf_out();
               _loc2_ += 16;
               _loc7_ = eax;
            }
         }
         else
         {
            si8(li32(li32(_loc7_)),_loc3_ - 1);
            _loc2_ -= 16;
            si32(1,_loc2_ + 12);
            si32(_loc3_ - 1,_loc2_ + 8);
            si32(_loc8_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F___printf_out();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc2_ -= 16;
            si32(_loc6_ + 4,_loc2_ + 4);
            si32(li32(_loc6_),_loc2_);
            ESP = _loc2_;
            F___sfvwrite();
            _loc2_ += 16;
            si32(_loc6_ + 16,_loc6_ + 80);
            si32(_loc6_ + 16,_loc6_ + 4);
            si32(0,_loc6_ + 12);
            si32(0,_loc6_ + 8);
         }
         eax = _loc7_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr83);
   }
}
