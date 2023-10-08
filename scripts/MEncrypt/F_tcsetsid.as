package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_tcsetsid() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      si32(0,_loc2_);
      ESP = _loc2_;
      F_getsid();
      _loc2_ += 16;
      _loc1_ = eax;
      _loc5_ = li32(_loc3_ + 4);
      if(_loc1_ != _loc5_)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc4_ = -1;
      }
      else
      {
         _loc2_ -= 16;
         si32(0,_loc2_ + 8);
         si32(536900705,_loc2_ + 4);
         si32(li32(_loc3_),_loc2_);
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
