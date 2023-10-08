package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___sync_nand_and_fetch_4() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc8_ = li32(_loc1_);
      _loc7_ = li32(_loc3_ + 4);
      do
      {
         var _loc6_:* = _loc8_;
         _loc2_ -= 16;
         si32(_loc6_,_loc2_ + 4);
         si32(_loc1_,_loc2_);
         var _loc5_:*;
         si32(_loc4_ = (_loc5_ = _loc6_ ^ -1) & _loc7_,_loc2_ + 8);
         ESP = _loc2_;
         F_avm2_cmpSwapUns();
         _loc2_ += 16;
      }
      while((_loc8_ = eax) != _loc6_);
      
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
