package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_tcsetattr() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 48;
      _loc1_ = li32(_loc3_ + 4);
      _loc6_ = _loc1_ & 16;
      _loc5_ = li32(_loc3_ + 8);
      if(_loc6_ != 0)
      {
         _loc2_ -= 16;
         si32(44,_loc2_ + 8);
         si32(_loc5_,_loc2_ + 4);
         si32(_loc5_ = _loc3_ - 48,_loc2_);
         ESP = _loc2_;
         Fmemcpy();
         _loc2_ += 16;
         si32(_loc6_ = (_loc6_ = li32(_loc3_ - 40)) | 1,_loc3_ - 40);
      }
      _loc4_ = li32(_loc3_);
      _loc1_ &= -17;
      if(_loc1_ != 2)
      {
         if(_loc1_ != 1)
         {
            if(_loc1_ == 0)
            {
               _loc2_ -= 16;
               si32(_loc5_,_loc2_ + 8);
               si32(-2144570348,_loc2_ + 4);
               si32(_loc4_,_loc2_);
               ESP = _loc2_;
               F__ioctl();
               _loc2_ += 16;
               _loc4_ = eax;
            }
            else
            {
               ESP = _loc2_;
               F___error();
               si32(22,eax);
               _loc4_ = -1;
            }
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_ + 8);
            si32(-2144570347,_loc2_ + 4);
            si32(_loc4_,_loc2_);
            ESP = _loc2_;
            F__ioctl();
            _loc2_ += 16;
            _loc4_ = eax;
         }
      }
      else
      {
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 8);
         si32(-2144570346,_loc2_ + 4);
         si32(_loc4_,_loc2_);
         ESP = _loc2_;
         F__ioctl();
         _loc2_ += 16;
         _loc4_ = eax;
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
