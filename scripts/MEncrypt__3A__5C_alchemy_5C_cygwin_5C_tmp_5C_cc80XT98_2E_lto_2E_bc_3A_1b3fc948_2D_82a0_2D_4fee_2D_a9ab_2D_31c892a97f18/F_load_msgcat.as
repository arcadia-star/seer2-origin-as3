package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.F__close;
   import MEncrypt.F__fstat;
   import MEncrypt.F__open;
   import MEncrypt.F_malloc;
   import MEncrypt.F_mmap;
   import MEncrypt.F_munmap;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_load_msgcat() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 96;
      _loc2_ -= 16;
      si32(0,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      ESP = _loc2_;
      F__open();
      _loc6_ = -1;
      _loc2_ += 16;
      if((_loc5_ = eax) != -1)
      {
         _loc2_ -= 16;
         si32(_loc3_ - 96,_loc2_ + 4);
         si32(_loc5_,_loc2_);
         ESP = _loc2_;
         F__fstat();
         _loc2_ += 16;
         if(eax != 0)
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F__close();
            _loc2_ += 16;
            _loc6_ = -1;
         }
         else
         {
            _loc2_ -= 32;
            si32(0,_loc2_ + 24);
            si32(0,_loc2_ + 20);
            si32(_loc5_,_loc2_ + 16);
            si32(1,_loc2_ + 12);
            si32(1,_loc2_ + 8);
            si32(li32(_loc3_ - 48),_loc2_ + 4);
            si32(0,_loc2_);
            ESP = _loc2_;
            F_mmap();
            _loc2_ += 32;
            _loc4_ = eax;
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F__close();
            _loc2_ += 16;
            _loc6_ = -1;
            if(_loc4_ != -1)
            {
               if(li32(_loc4_) != -1979741953)
               {
                  _loc2_ -= 16;
                  si32(li32(_loc3_ - 48),_loc2_ + 4);
                  si32(_loc4_,_loc2_);
                  ESP = _loc2_;
                  F_munmap();
                  _loc2_ += 16;
                  ESP = _loc2_;
                  F___error();
                  si32(22,eax);
                  _loc6_ = -1;
               }
               else
               {
                  _loc2_ -= 16;
                  si32(8,_loc2_);
                  ESP = _loc2_;
                  F_malloc();
                  _loc2_ += 16;
                  if((_loc6_ = eax) == 0)
                  {
                     _loc2_ -= 16;
                     si32(li32(_loc3_ - 48),_loc2_ + 4);
                     si32(_loc4_,_loc2_);
                     ESP = _loc2_;
                     F_munmap();
                     _loc2_ += 16;
                     _loc6_ = -1;
                  }
                  else
                  {
                     si32(_loc4_,_loc6_);
                     si32(li32(_loc3_ - 48),_loc6_ + 4);
                  }
               }
            }
         }
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
