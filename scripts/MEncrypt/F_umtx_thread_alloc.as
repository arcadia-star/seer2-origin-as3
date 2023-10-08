package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si8;
   
   public function F_umtx_thread_alloc() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc1_ = li32(_loc1_ + 4);
      si8(-1,_loc1_ + 44);
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
