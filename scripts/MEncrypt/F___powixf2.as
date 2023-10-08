package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   
   public function F___powixf2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = NaN;
      var _loc5_:Number = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc5_ = 1;
      _loc1_ = li32(_loc3_ + 8);
      _loc4_ = lf64(_loc3_);
      _loc7_ = _loc1_;
      while(true)
      {
         var _loc6_:*;
         if((_loc6_ = _loc7_ & 1) != 0)
         {
            _loc5_ *= _loc4_;
         }
         if((uint(_loc6_ = _loc7_ + 1)) < 3)
         {
            break;
         }
         _loc7_ = (_loc6_ = _loc7_ + (_loc7_ >>> 31)) >> 1;
         _loc4_ *= _loc4_;
      }
      if(_loc1_ <= -1)
      {
         _loc5_ = 1 / _loc5_;
      }
      st0 = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
