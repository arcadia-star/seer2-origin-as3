package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__fwalk() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      _loc8_ = ___sglue;
      _loc7_ = li32(_loc3_);
      do
      {
         if((_loc6_ = li32(_loc8_ + 4)) >= 1)
         {
            _loc5_ = li32(_loc8_ + 8);
            do
            {
               var _loc4_:*;
               if((_loc4_ = si16(li16(_loc5_ + 12))) >= 1)
               {
                  _loc2_ -= 16;
                  si32(_loc5_,_loc2_);
                  ESP = _loc2_;
                  ptr2fun[_loc7_]();
                  _loc2_ += 16;
                  _loc1_ = (_loc4_ = eax) | _loc1_;
               }
               _loc5_ += 232;
            }
            while((_loc6_ += -1) != 0);
            
         }
      }
      while((_loc8_ = li32(_loc8_)) != 0);
      
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
