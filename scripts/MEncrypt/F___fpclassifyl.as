package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___fpclassifyl() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc1_ = (_loc6_ = li32(_loc1_)) >>> 20;
      _loc1_ &= 2047;
      _loc5_ = 4;
      if(_loc1_ == 0)
      {
         _loc5_ = 16;
         if((_loc6_ & 1048575 | li32(_loc3_)) != 0)
         {
            _loc5_ = 8;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
