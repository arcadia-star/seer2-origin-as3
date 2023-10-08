package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__umtx_op() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc3_ - 24);
      _loc6_ = (_loc7_ = _loc3_ - 24) | 4;
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc1_,_loc6_);
      _loc1_ = li32(_loc3_ + 8);
      si32(_loc1_,_loc3_ - 16);
      _loc1_ = li32(_loc3_ + 12);
      si32(_loc1_,_loc3_ - 12);
      _loc1_ = li32(_loc3_ + 16);
      si32(_loc1_,_loc3_ - 8);
      _loc1_ = tcbp;
      _loc1_ = li32(_loc5_ = li32(_loc1_ + 12));
      if(_loc1_ == 0)
      {
         si32(int(threadId) + 8,_loc5_);
      }
      _loc4_ = li32(_loc6_);
      _loc6_ = 22;
      if(uint(_loc4_) <= 18)
      {
         _loc2_ -= 16;
         si32(_loc7_,_loc2_ + 4);
         si32(_loc5_,_loc2_);
         _loc1_ = li32(_op_table + (_loc4_ << 2));
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
         _loc6_ = eax;
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
