package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___isnormalf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc1_ >>>= 23;
      _loc1_ += -1;
      _loc1_ &= 255;
      _loc4_ = 1;
      if(uint(_loc1_) >= 254)
      {
         _loc4_ = 0;
      }
      _loc1_ = _loc4_ & 1;
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
