package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___ctzsi2() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc9_:* = 0;
      var _loc8_:int = 0;
      var _loc1_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc9_ = _loc1_ & 65535;
      _loc8_ = 16;
      if(_loc9_ != 0)
      {
         _loc8_ = 0;
      }
      _loc9_ = (_loc7_ = _loc1_ >>> _loc8_) & 255;
      _loc1_ = 8;
      if(_loc9_ != 0)
      {
         _loc1_ = 0;
      }
      _loc9_ = (_loc6_ = _loc7_ >>> _loc1_) & 15;
      _loc7_ = 4;
      if(_loc9_ != 0)
      {
         _loc7_ = 0;
      }
      _loc9_ = (_loc5_ = _loc6_ >>> _loc7_) & 3;
      _loc6_ = 2;
      if(_loc9_ != 0)
      {
         _loc6_ = 0;
      }
      var _loc4_:*;
      _loc9_ = (_loc9_ = (_loc4_ = _loc5_ >>> _loc6_) & 1) ^ 1;
      _loc9_ = 0 - _loc9_;
      _loc4_ = (_loc4_ >>>= 1) & 1;
      _loc9_ = (_loc4_ = 2 - _loc4_) & _loc9_;
      _loc4_ = (_loc4_ = (_loc4_ = _loc1_ | _loc8_) | _loc7_) | _loc6_;
      eax = _loc9_ += _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
