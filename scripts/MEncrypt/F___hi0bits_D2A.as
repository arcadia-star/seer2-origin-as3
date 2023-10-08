package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___hi0bits_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 16;
      if((uint(_loc6_ = li32(_loc3_))) >= 65536)
      {
         _loc1_ = 0;
      }
      _loc5_ = _loc6_ << 16;
      if(uint(_loc6_) >= 65536)
      {
         _loc5_ = _loc6_;
      }
      _loc6_ = _loc1_ | 8;
      if(uint(_loc5_) >= 16777216)
      {
         _loc6_ = _loc1_;
      }
      _loc1_ = _loc5_ << 8;
      if(uint(_loc5_) >= 16777216)
      {
         _loc1_ = _loc5_;
      }
      _loc5_ = _loc6_ | 4;
      if(uint(_loc1_) >= 268435456)
      {
         _loc5_ = _loc6_;
      }
      _loc6_ = _loc1_ << 4;
      if(uint(_loc1_) >= 268435456)
      {
         _loc6_ = _loc1_;
      }
      _loc1_ = _loc5_ | 2;
      if(uint(_loc6_) >= 1073741824)
      {
         _loc1_ = _loc5_;
      }
      _loc5_ = _loc6_ << 2;
      if(uint(_loc6_) >= 1073741824)
      {
         _loc5_ = _loc6_;
      }
      if(_loc5_ >= 0)
      {
         _loc1_ += 1;
         _loc5_ = 32;
         if((_loc5_ & 1073741824) != 0)
         {
            addr122:
            _loc5_ = _loc1_;
         }
         eax = _loc5_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr122);
   }
}
