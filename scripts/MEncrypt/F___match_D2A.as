package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___match_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:int = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc9_:*;
      _loc8_ = (_loc9_ = li32(_loc1_)) + 1;
      _loc7_ = li32(_loc3_ + 4);
      do
      {
         if((_loc4_ = li8(_loc7_)) == 0)
         {
            si32(_loc8_,_loc1_);
            _loc4_ = 1;
            break;
         }
         _loc5_ = (_loc6_ = si8(li8(_loc8_))) + 32;
         if((uint(_loc9_ = (_loc9_ = _loc6_ + -65) & 255)) >= 26)
         {
            _loc5_ = _loc6_;
         }
         _loc9_ = (_loc9_ = _loc4_ << 24) >> 24;
         _loc8_ += 1;
         _loc7_ += 1;
         _loc4_ = 0;
      }
      while(_loc5_ == _loc9_);
      
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
