package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_pages_map() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 64;
      _loc2_ -= 32;
      _loc1_ = 0;
      si32(_loc1_,_loc2_ + 24);
      si32(_loc1_,_loc2_ + 20);
      si32(-1,_loc2_ + 16);
      si32(4098,_loc2_ + 12);
      si32(3,_loc2_ + 8);
      si32(_loc9_ = li32(_loc3_ + 4),_loc2_ + 4);
      si32(_loc8_ = li32(_loc3_),_loc2_);
      ESP = _loc2_;
      F_mmap();
      _loc2_ += 32;
      if((_loc7_ = eax) != -1)
      {
         _loc1_ = _loc7_;
         if(_loc8_ != 0)
         {
            _loc1_ = _loc7_;
            if(_loc7_ != _loc8_)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_ + 4);
               si32(_loc7_,_loc2_);
               ESP = _loc2_;
               F_munmap();
               _loc1_ = 0;
               _loc2_ += 16;
               var _loc6_:*;
               if((_loc6_ = eax) == -1)
               {
                  ESP = _loc2_;
                  F___error();
                  _loc2_ -= 16;
                  si32(64,_loc2_ + 8);
                  si32(_loc6_ = _loc3_ - 64,_loc2_ + 4);
                  si32(li32(_loc6_ = eax),_loc2_);
                  ESP = _loc2_;
                  F_strerror_r();
                  _loc2_ += 16;
                  var _loc5_:* = li32(__malloc_message);
                  _loc2_ -= 16;
                  si32(L__2E_str545,_loc2_ + 12);
                  si32(_loc6_,_loc2_ + 8);
                  si32(L__2E_str39,_loc2_ + 4);
                  si32(li32(___progname),_loc2_);
                  ESP = _loc2_;
                  ptr2fun[_loc5_]();
                  _loc2_ += 16;
                  _loc1_ = 0;
                  if((_loc6_ = li8(_opt_abort_2E_b)) == 1)
                  {
                     ESP = _loc2_;
                     F_abort();
                  }
               }
            }
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
