package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si8;
   
   public function F___sync_lock_release_1() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      si8(0,_loc1_);
      ESP = _loc2_;
      F_avm2_mfence();
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
