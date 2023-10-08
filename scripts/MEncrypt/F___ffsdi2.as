package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___ffsdi2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if(_loc1_ == 0)
      {
         _loc1_ = li32(_loc3_ + 4);
         _loc6_ = 0;
         if(_loc1_ != 0)
         {
            var _loc5_:*;
            var _loc4_:* = ((_loc4_ = _loc5_ - ((_loc4_ = (_loc5_ = (_loc4_ = _loc1_ ^ -1) & _loc1_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc4_ >>>= 2) & 858993459);
            _loc6_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ = _loc4_ + (_loc4_ >>> 4)) & 252645135) * 16843009) >>> 24) + 33;
         }
      }
      else
      {
         _loc6_ = (_loc5_ = (_loc5_ = (_loc5_ = (_loc5_ += (_loc5_ = ((_loc4_ = _loc5_ - ((_loc4_ = (_loc5_ = (_loc5_ = _loc1_ ^ -1) & _loc1_ + -1) >>> 1) & 1431655765)) & 858993459) + ((_loc4_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) + 1;
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
