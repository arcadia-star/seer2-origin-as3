package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__Z15MDecrypt_x86_32PKhiS0_iPi() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:int = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc13_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc13_ = _loc1_ + -1;
      _loc12_ = li32(_loc3_ + 16);
      si32(_loc13_,_loc12_);
      _loc2_ -= 16;
      si32(_loc13_,_loc2_);
      ESP = _loc2_;
      F_malloc();
      _loc2_ += 16;
      _loc11_ = eax;
      if(_loc13_ >= 1)
      {
         _loc10_ = li32(_loc3_ + 12);
         _loc9_ = li32(_loc3_ + 8);
         _loc8_ = (_loc12_ = li32(_loc3_)) + 1;
         _loc7_ = li8(_loc12_);
         _loc6_ = _loc13_;
         _loc5_ = _loc11_;
         do
         {
            var _loc4_:int = (_loc12_ = _loc7_ & 224) >>> 5;
            si8(_loc12_ = (_loc12_ = (_loc7_ = li8(_loc8_)) << 3) | _loc4_,_loc5_);
            _loc8_ += 1;
            _loc6_ += -1;
            _loc5_ += 1;
         }
         while(_loc6_ != 0);
         
         if(_loc13_ >= 1)
         {
            _loc1_ += -1;
            _loc7_ = _loc11_;
            _loc13_ = 0;
            do
            {
               _loc8_ = li8(_loc7_);
               _loc5_ = 0;
               _loc6_ = _loc9_;
               if(_loc13_ != _loc10_)
               {
                  _loc6_ = _loc9_ + _loc13_;
                  _loc5_ = _loc13_ + 1;
               }
               si8(_loc12_ = (_loc12_ = li8(_loc6_)) ^ _loc8_,_loc7_);
               _loc7_ += 1;
               _loc1_ += -1;
               _loc13_ = _loc5_;
            }
            while(_loc1_ != 0);
            
         }
      }
      eax = _loc11_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
