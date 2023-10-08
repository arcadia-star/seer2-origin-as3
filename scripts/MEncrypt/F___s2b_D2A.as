package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___s2b_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:int = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc8_ = (_loc9_ = _loc1_ + 8) / 9;
      _loc7_ = 0;
      _loc6_ = 1;
      if(_loc9_ >= 18)
      {
         do
         {
            _loc7_ += 1;
            _loc6_ <<= 1;
         }
         while(_loc8_ > _loc6_);
         
      }
      _loc5_ = li32(_loc3_ + 16);
      _loc9_ = li32(_loc3_ + 12);
      _loc8_ = li32(_loc3_ + 4);
      _loc6_ = li32(_loc3_);
      _loc2_ -= 16;
      si32(_loc7_,_loc2_);
      ESP = _loc2_;
      F___Balloc_D2A();
      _loc2_ += 16;
      _loc7_ = eax;
      si32(_loc9_,_loc7_ + 20);
      si32(1,_loc7_ + 16);
      _loc4_ = -9;
      if(_loc8_ >= 10)
      {
         do
         {
            _loc9_ = (_loc9_ = si8(li8(_loc9_ = _loc6_ - _loc4_))) + -48;
            _loc2_ -= 16;
            si32(_loc9_,_loc2_ + 8);
            si32(10,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            _loc4_ += -1;
            _loc9_ = _loc8_ + _loc4_;
            ESP = _loc2_;
            F___multadd_D2A();
            _loc2_ += 16;
            _loc7_ = eax;
         }
         while(_loc9_ != 0);
         
         _loc5_ += _loc8_;
      }
      else
      {
         _loc5_ += 9;
         _loc8_ = 9;
      }
      if(_loc8_ < _loc1_)
      {
         _loc6_ += _loc5_;
         _loc1_ -= _loc8_;
         do
         {
            _loc9_ = si8(li8(_loc6_));
            _loc2_ -= 16;
            si32(_loc9_ += -48,_loc2_ + 8);
            si32(10,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            ESP = _loc2_;
            F___multadd_D2A();
            _loc6_ += 1;
            _loc1_ += -1;
            _loc2_ += 16;
            _loc7_ = eax;
         }
         while(_loc1_ != 0);
         
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
