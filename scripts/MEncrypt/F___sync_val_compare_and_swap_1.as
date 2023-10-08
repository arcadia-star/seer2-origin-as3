package MEncrypt
{
   public function F___sync_val_compare_and_swap_1() : void
   {
      var _loc1_:int = ESP;
      var _loc2_:* = _loc1_;
      ESP = _loc1_ & -16;
      trace(new Error().getStackTrace() + "\n");
      ESP = _loc1_ & -16;
      trace("FlasCC does not support CAS on a non-32bit values..");
      ESP = _loc1_;
      F_abort();
   }
}
