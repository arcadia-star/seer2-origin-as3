package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__Z15MEncrypt_x86_32PKhiS0_iPi() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc13_:* = 0;
      var _loc10_:int = 0;
      var _loc5_:* = 0;
      var _loc14_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32((_loc4_ = _loc2_) + 4);
      _loc15_ = _loc3_ + 1;
      _loc14_ = li32(_loc4_ + 16);
      si32(_loc15_,_loc14_);
      _loc2_ -= 16;
      si32(_loc15_,_loc2_);
      ESP = _loc2_;
      F_malloc();
      _loc13_ = li32(_loc4_ + 12);
      _loc12_ = li32(_loc4_ + 8);
      _loc11_ = li32(_loc4_);
      _loc2_ += 16;
      _loc9_ = _loc10_ = eax;
      _loc8_ = _loc3_;
      _loc1_ = 0;
      if(_loc3_ >= 1)
      {
         do
         {
            _loc5_ = li8(_loc11_);
            _loc6_ = 0;
            _loc7_ = _loc12_;
            if(_loc1_ != _loc13_)
            {
               _loc7_ = _loc12_ + _loc1_;
               _loc6_ = _loc1_ + 1;
            }
            si8(_loc14_ = (_loc14_ = li8(_loc7_)) ^ _loc5_,_loc9_);
            _loc9_ += 1;
            _loc11_ += 1;
            _loc8_ += -1;
            _loc1_ = _loc6_;
         }
         while(_loc8_ != 0);
         
      }
      _loc13_ = _loc10_ + _loc3_;
      si8(0,_loc13_);
      if((_loc14_ = _loc3_ + -1) >= 0)
      {
         _loc1_ = 0 - _loc3_;
         if(_loc1_ <= -1)
         {
            _loc1_ = -1;
         }
         _loc3_ = (_loc14_ = _loc3_ + _loc1_) + 1;
         do
         {
            _loc14_ = li8(_loc13_);
            si8(_loc14_ = (_loc15_ = (_loc15_ = li8(_loc13_ - 1)) >>> 3) | _loc14_,_loc13_);
            si8(_loc14_ = (_loc14_ = li8(_loc13_ - 1)) << 5,_loc13_ - 1);
            _loc13_ += -1;
            _loc3_ += -1;
         }
         while(_loc3_ != 0);
         
      }
      si8(_loc14_ = (_loc14_ = li8(_loc10_)) | 3,_loc10_);
      eax = _loc10_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
