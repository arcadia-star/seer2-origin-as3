package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___nrv_alloc_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 4;
      _loc7_ = 0;
      if((uint(_loc6_ = li32(_loc3_ + 8))) >= 20)
      {
         var _loc5_:*;
         do
         {
            _loc7_ += 1;
            _loc1_ <<= 1;
         }
         while((uint(_loc5_ = _loc1_ + 16)) <= uint(_loc6_));
         
      }
      _loc1_ = li32(_loc3_);
      _loc2_ -= 16;
      si32(_loc7_,_loc2_);
      ESP = _loc2_;
      F___Balloc_D2A();
      _loc2_ += 16;
      _loc4_ = eax;
      si32(_loc7_,_loc4_);
      si8(_loc5_ = li8(_loc1_),_loc4_ + 4);
      _loc7_ = _loc6_ = _loc4_ + 4;
      if(_loc5_ != 0)
      {
         _loc7_ = _loc4_ + 4;
         _loc1_ += 1;
         do
         {
            si8(_loc5_ = li8(_loc1_),_loc7_ + 1);
            _loc7_ += 1;
            _loc1_ += 1;
         }
         while(_loc5_ != 0);
         
      }
      _loc1_ = li32(_loc3_ + 4);
      if(_loc1_ != 0)
      {
         si32(_loc7_,_loc1_);
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
