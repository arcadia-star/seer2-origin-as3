package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sigaddset() : void
   {
      var _loc3_:* = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      if((uint(_loc7_ = _loc1_ + -1)) >= 128)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc1_ = -1;
      }
      else
      {
         var _loc5_:* = 1 << ((_loc5_ = _loc1_ + 31) & 31);
         var _loc4_:*;
         var _loc6_:int = li32(_loc3_) + ((_loc4_ = _loc7_ >> 5) << 2);
         si32(_loc5_ = (_loc4_ = li32(_loc6_)) | _loc5_,_loc6_);
         _loc1_ = 0;
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
