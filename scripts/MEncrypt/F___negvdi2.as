package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___negvdi2() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc7_ = _loc1_ ^ -2147483648;
      if((_loc7_ = (_loc6_ = li32(_loc3_)) | _loc7_) == 0)
      {
         ESP = _loc2_;
         F_abort();
      }
      _loc5_ = 1;
      if(_loc6_ == 0)
      {
         _loc5_ = 0;
      }
      var _loc4_:int = (_loc7_ = 0 - _loc1_) - _loc5_;
      eax = _loc7_ = 0 - _loc6_;
      edx = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
