package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___sync_fetch_and_and_4() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc7_ = li32(_loc1_);
      _loc6_ = li32(_loc3_ + 4);
      do
      {
         _loc5_ = _loc7_;
         _loc2_ -= 16;
         si32(_loc5_,_loc2_ + 4);
         si32(_loc1_,_loc2_);
         var _loc4_:*;
         si32(_loc4_ = _loc5_ & _loc6_,_loc2_ + 8);
         ESP = _loc2_;
         F_avm2_cmpSwapUns();
         _loc2_ += 16;
      }
      while((_loc7_ = eax) != _loc5_);
      
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
