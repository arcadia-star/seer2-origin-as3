package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___sync_fetch_and_nand_2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc4_ = li16(_loc1_);
      _loc2_ -= 16;
      si32(0,_loc2_ + 8);
      si32(0,_loc2_ + 4);
      si32(_loc4_,_loc2_);
      ESP = _loc2_;
      F___sync_val_compare_and_swap_2();
      _loc2_ += 16;
   }
}
