package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sigismember() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      if((uint(_loc7_ = _loc1_ + -1)) >= 128)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc7_ = -1;
      }
      else
      {
         _loc1_ = 1;
         var _loc5_:* = _loc1_ << ((_loc5_ = _loc1_ + 31) & 31);
         var _loc6_:*;
         var _loc4_:*;
         if((_loc6_ = (_loc6_ = li32(_loc6_ = li32(_loc3_) + ((_loc4_ = _loc7_ >> 5) << 2))) & _loc5_) == 0)
         {
            _loc1_ = 0;
         }
         _loc7_ = _loc1_ & 1;
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
