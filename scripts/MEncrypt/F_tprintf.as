package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_tprintf() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16624;
      _loc1_ = li32(_avm2_haveWorkers_2E_4273);
      if(_loc1_ == -1)
      {
         _loc1_ = int(Boolean(workerClass));
         si32(_loc1_,_avm2_haveWorkers_2E_4273);
      }
      if(_loc1_ != 0)
      {
         var _loc9_:*;
         _loc1_ = (_loc9_ = (_loc9_ = int(threadId)) + 8) & 255;
         _loc8_ = -1;
         if(int(ram.atomicCompareAndSwapIntAt(_sEntered_2E_5493 + (_loc1_ << 2),0,1)) == 0)
         {
            addr72:
            var _loc7_:* = li32(_loc3_);
            si32(_loc9_ = _loc3_ + 4,_loc3_ - 16620);
            _loc2_ -= 16;
            si32(232,_loc2_ + 8);
            si32(0,_loc2_ + 4);
            var _loc6_:int;
            si32(_loc6_ = _loc3_ - 232,_loc2_);
            ESP = _loc2_;
            Fmemset();
            _loc2_ += 16;
            si16(-1,_loc3_ - 218);
            si16(520,_loc3_ - 220);
            si32(_loc5_ = _loc3_ - 16616,_loc3_ - 232);
            si32(_loc5_,_loc3_ - 216);
            si32(16383,_loc3_ - 224);
            si32(16383,_loc3_ - 212);
            _loc2_ -= 16;
            si32(_loc9_,_loc2_ + 8);
            si32(_loc7_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F___vfprintf();
            _loc2_ += 16;
            _loc8_ = eax;
            _loc9_ = li32(_loc3_ - 232);
            si8(0,_loc9_);
            if(_loc8_ >= 1)
            {
               _loc4_ = _loc8_ + -1;
               if((_loc9_ = li8(_loc9_ = _loc5_ + _loc4_)) != 10)
               {
                  _loc4_ = _loc8_;
               }
               _loc8_ = _loc4_;
               if(_loc4_ >= 1)
               {
                  trace(CModule.readString(_loc5_,_loc4_));
                  _loc8_ = _loc4_;
               }
            }
            _loc9_ = _loc1_ << 2;
            _loc9_ = _sEntered_2E_5493 + _loc9_;
            si32(0,_loc9_);
         }
         eax = _loc8_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr72);
   }
}
