package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___isinff() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc6_ = (_loc6_ = _loc1_ >>> 23) & 255;
      _loc4_ = _loc5_ = 1;
      if(_loc6_ != 255)
      {
         _loc4_ = 0;
      }
      if((_loc6_ = _loc1_ & 8388607) != 0)
      {
         _loc5_ = 0;
      }
      eax = _loc6_ = (_loc6_ = _loc4_ & _loc5_) & 1;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
