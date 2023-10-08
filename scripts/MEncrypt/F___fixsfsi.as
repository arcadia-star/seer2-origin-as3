package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___fixsfsi() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc9_:*;
      _loc8_ = (_loc9_ = _loc1_ & 8388607) | 8388608;
      _loc7_ = (_loc9_ = _loc1_ >> 31) | 1;
      _loc1_ >>>= 23;
      if((uint(_loc5_ = (_loc6_ = _loc1_ & 255) + -127)) <= 22)
      {
         _loc4_ = (_loc8_ >>> 150 - _loc6_) * _loc7_;
      }
      else
      {
         _loc4_ = 0;
         if(_loc5_ >= 0)
         {
            _loc4_ = (_loc8_ << _loc6_ + -150) * _loc7_;
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
