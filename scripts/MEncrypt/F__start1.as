package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F__start1() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li32(_loc3_ + 4);
      _loc8_ = _loc1_ << 2;
      _loc7_ = li32(_loc3_ + 8);
      si32(_loc8_ = (_loc8_ += _loc7_) + 4,_environ);
      if(_loc1_ >= 1)
      {
         if((_loc6_ = li32(_loc7_)) != 0)
         {
            si32(_loc6_,___progname);
            _loc5_ = 0;
            while(true)
            {
               _loc1_ = _loc6_ + _loc5_;
               if((_loc7_ = li8(_loc1_)) == 0)
               {
                  break;
               }
               if(_loc7_ != 47)
               {
                  _loc5_ += 1;
               }
               else
               {
                  _loc5_ += 1;
                  si32(_loc6_ + _loc5_,___progname);
               }
            }
         }
      }
      ESP = _loc2_;
      F__init_tls();
      si32(1,_loc3_ - 16);
      si32(__fini,(_loc8_ = _loc3_ - 16) | 4);
      si32(0,_loc3_ - 8);
      si32(0,_loc3_ - 4);
      _loc2_ -= 16;
      si32(_loc8_,_loc2_);
      ESP = _loc2_;
      F_atexit_register();
      _loc2_ += 16;
      ESP = _loc2_;
      F__init();
      _loc7_ = _sLock_2E_3947;
      if((_loc6_ = tcbp) != -1)
      {
         _loc7_ = _loc6_ + 16;
      }
      if((_loc6_ = li32(_sLock_2E_3947)) == -1)
      {
         si32(_loc6_ = int(realThreadId) + 1,_sLock_2E_3947);
      }
      if(_loc6_ != 0)
      {
         if(_loc7_ != _sLock_2E_3947)
         {
            si32(_loc6_,_loc7_);
            si32(0,_sLock_2E_3947);
         }
      }
      if((_loc6_ = tcbp) == -1)
      {
         _loc6_ = li32(_sCounter_2E_3962);
         _loc6_ = _sCounter_2E_3962;
      }
      else
      {
         _loc6_ += 20;
         if(li32(_sCounter_2E_3962) != 0)
         {
            if(_loc6_ != _sCounter_2E_3962)
            {
               si32(li32(_sCounter_2E_3962),_loc6_);
               si32(0,_sCounter_2E_3962);
            }
         }
      }
      _loc1_ = li32(_loc6_);
      _loc1_ += -1;
      si32(_loc1_,_loc6_);
      if(_loc1_ == 0)
      {
         _loc2_ -= 16;
         si32(_loc7_,_loc2_);
         ESP = _loc2_;
         F_avm2_unlock();
         _loc2_ += 16;
      }
      throw new GoingAsync();
   }
}
