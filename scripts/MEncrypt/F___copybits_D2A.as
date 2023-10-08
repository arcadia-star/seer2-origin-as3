package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___copybits_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc7_ = li32(_loc1_ + 16);
      _loc5_ = _loc6_ = li32(_loc3_);
      if(_loc7_ >= 1)
      {
         var _loc4_:*;
         _loc7_ = (_loc4_ = _loc1_ + (_loc7_ << 2)) + 20;
         _loc1_ += 20;
         _loc5_ = _loc6_;
         do
         {
            si32(_loc4_ = li32(_loc1_),_loc5_);
            _loc1_ += 4;
            _loc5_ += 4;
         }
         while(uint(_loc1_) < uint(_loc7_));
         
      }
      _loc6_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = li32(_loc3_ + 4)) + -1) >> 5) << 2) + _loc6_) + 4;
      if(uint(_loc5_) < uint(_loc6_))
      {
         do
         {
            si32(0,_loc5_);
         }
         while((uint(_loc5_ += 4)) < uint(_loc6_));
         
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
