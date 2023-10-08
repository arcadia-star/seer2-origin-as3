package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_strvis() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc8_ = li8(_loc1_);
      _loc6_ = _loc7_ = li32(_loc3_);
      if(_loc8_ != 0)
      {
         _loc5_ = li32(_loc3_ + 8);
         _loc1_ += 1;
         _loc6_ = _loc7_;
         do
         {
            var _loc4_:* = si8(li8(_loc1_));
            _loc2_ -= 16;
            si32(_loc4_,_loc2_ + 12);
            si32(_loc5_,_loc2_ + 8);
            si32(_loc4_ = (_loc4_ = _loc8_ << 24) >> 24,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_vis();
            _loc4_ = _loc1_ + 1;
            _loc2_ += 16;
            _loc6_ = eax;
            _loc8_ = li8(_loc1_);
            _loc1_ = _loc4_;
         }
         while(_loc8_ != 0);
         
      }
      si8(0,_loc6_);
      eax = _loc4_ = _loc6_ - _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
