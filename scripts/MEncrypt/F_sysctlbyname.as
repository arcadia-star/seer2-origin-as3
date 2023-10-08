package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sysctlbyname() : void
   {
      var _loc3_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 128;
      si32(0,_loc3_ - 8);
      si32(3,_loc3_ - 4);
      si32(104,_loc3_ - 116);
      _loc2_ -= 32;
      si32(_loc1_,_loc2_ + 20);
      var _loc8_:*;
      si32(_loc8_ = li32(_loc3_),_loc2_ + 16);
      si32(_loc8_ = _loc3_ - 116,_loc2_ + 12);
      si32(_loc7_ = _loc3_ - 112,_loc2_ + 8);
      si32(2,_loc2_ + 4);
      si32(_loc8_ = _loc3_ - 8,_loc2_);
      ESP = _loc2_;
      F_sysctl();
      _loc2_ += 32;
      _loc1_ = eax;
      if(_loc1_ >= 0)
      {
         var _loc5_:* = li32(_loc3_ + 8);
         _loc8_ = li32(_loc3_ + 4);
         var _loc4_:*;
         si32(_loc4_ = (_loc4_ = li32(_loc3_ - 116)) >>> 2,_loc3_ - 116);
         _loc2_ -= 32;
         si32(_loc1_,_loc2_ + 20);
         si32(li32(_loc3_ + 12),_loc2_ + 16);
         si32(_loc5_,_loc2_ + 12);
         si32(_loc8_,_loc2_ + 8);
         si32(_loc4_,_loc2_ + 4);
         si32(_loc7_,_loc2_);
         ESP = _loc2_;
         F_sysctl();
         _loc2_ += 32;
         _loc1_ = eax;
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
