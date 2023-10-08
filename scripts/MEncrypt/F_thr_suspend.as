package MEncrypt
{
   import avm2.intrinsics.memory.si32;
   
   public function F_thr_suspend() : void
   {
      var _loc3_:* = 0;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      ESP = _loc2_;
      F___error();
      _loc1_ = eax;
      si32(78,_loc1_);
      eax = -1;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
