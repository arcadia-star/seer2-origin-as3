package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___clzsi2() : void
   {
      var _loc3_:* = 0;
      var _loc5_:int = 0;
      var _loc1_:int = 0;
      var _loc9_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 16;
      if((uint(_loc9_ = li32(_loc3_))) >= 65536)
      {
         _loc1_ = 0;
      }
      var _loc8_:* = 16 - _loc1_;
      _loc8_ = (_loc7_ = _loc9_ >>> _loc8_) & 65280;
      _loc9_ = 8;
      if(_loc8_ != 0)
      {
         _loc9_ = 0;
      }
      _loc8_ = 8 - _loc9_;
      _loc8_ = (_loc6_ = _loc7_ >>> _loc8_) & 240;
      _loc7_ = 4;
      if(_loc8_ != 0)
      {
         _loc7_ = 0;
      }
      _loc8_ = 4 - _loc7_;
      _loc8_ = (_loc5_ = _loc6_ >>> _loc8_) & 12;
      _loc6_ = 2;
      if(_loc8_ != 0)
      {
         _loc6_ = 0;
      }
      _loc8_ = 2 - _loc6_;
      var _loc4_:* = _loc5_ >>> _loc8_;
      _loc8_ = 2 - _loc4_;
      _loc4_ = (_loc4_ = (_loc4_ >>>= 1) & 1) ^ 1;
      _loc4_ = 0 - _loc4_;
      _loc8_ &= _loc4_;
      _loc4_ = (_loc4_ = (_loc4_ = _loc9_ | _loc1_) | _loc7_) | _loc6_;
      eax = _loc8_ += _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
