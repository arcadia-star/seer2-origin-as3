package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___fixdfsi() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc1_ = (_loc11_ = li32(_loc1_)) & 1048575;
      _loc10_ = _loc1_ | 1048576;
      _loc8_ = (_loc9_ = _loc11_ >> 31) | 1;
      _loc1_ = _loc11_ >>> 20;
      _loc6_ = (_loc7_ = _loc1_ & 2047) + -1023;
      _loc5_ = li32(_loc3_);
      if(uint(_loc6_) <= 51)
      {
         _loc2_ -= 16;
         si32(_loc5_,_loc2_);
         si32(1075 - _loc7_,_loc2_ + 8);
         si32(_loc10_,_loc2_ + 4);
         ESP = _loc2_;
         F___lshrdi3();
         _loc2_ += 16;
         _loc2_ -= 16;
         si32(_loc9_,_loc2_ + 12);
         si32(_loc8_,_loc2_ + 8);
         si32(edx,_loc2_ + 4);
         si32(eax,_loc2_);
         ESP = _loc2_;
         F___muldi3();
         _loc2_ += 16;
         _loc4_ = eax;
      }
      else
      {
         _loc4_ = 0;
         if(_loc6_ >= 0)
         {
            _loc2_ -= 16;
            si32(_loc5_,_loc2_);
            si32(_loc7_ + -1075,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___ashldi3();
            _loc2_ += 16;
            _loc2_ -= 16;
            si32(_loc9_,_loc2_ + 12);
            si32(_loc8_,_loc2_ + 8);
            si32(edx,_loc2_ + 4);
            si32(eax,_loc2_);
            ESP = _loc2_;
            F___muldi3();
            _loc2_ += 16;
            _loc4_ = eax;
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
