package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_verrx() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_err_file);
      if(_loc1_ == 0)
      {
         _loc1_ = li32(___stderrp);
         si32(_loc1_,_err_file);
      }
      _loc6_ = li32(_loc3_ + 4);
      var _loc5_:* = li32(___progname);
      _loc2_ -= 16;
      si32(_loc5_,_loc2_ + 8);
      si32(L__2E_str410,_loc2_ + 4);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F_fprintf();
      _loc2_ += 16;
      if(_loc6_ != 0)
      {
         _loc5_ = li32(_err_file);
         _loc2_ -= 16;
         si32(li32(_loc3_ + 8),_loc2_ + 8);
         si32(_loc6_,_loc2_ + 4);
         si32(_loc5_,_loc2_);
         ESP = _loc2_;
         F_vfprintf();
         _loc2_ += 16;
      }
      _loc6_ = li32(_loc3_);
      _loc5_ = li32(_err_file);
      _loc2_ -= 16;
      si32(_loc5_,_loc2_ + 4);
      si32(10,_loc2_);
      ESP = _loc2_;
      F_fputc();
      _loc2_ += 16;
      _loc1_ = li32(_err_exit);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
      }
      _loc2_ -= 16;
      si32(_loc6_,_loc2_);
      ESP = _loc2_;
      F_exit();
      _loc2_ += 16;
   }
}
