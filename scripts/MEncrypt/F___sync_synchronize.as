package MEncrypt
{
   public function F___sync_synchronize() : void
   {
      var _loc2_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      ESP = _loc1_;
      F_avm2_mfence();
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
