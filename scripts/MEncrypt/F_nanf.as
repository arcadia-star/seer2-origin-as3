package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_nanf() : void
   {
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:int = 0;
      var _loc2_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:int = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      si32(0,_loc4_ - 8);
      _loc2_ = li32(_loc4_);
      var _loc14_:*;
      if((_loc14_ = li8(_loc2_)) == 48)
      {
         if((_loc14_ = (_loc14_ = (_loc14_ = li8(_loc2_ + 1)) | 32) & 255) == 120)
         {
            _loc2_ += 2;
         }
      }
      _loc2_ += -1;
      _loc13_ = 7;
      _loc12_ = -1;
      while((_loc11_ = si8(li8(_loc2_ + 1))) >= 0)
      {
         if((_loc14_ = (_loc14_ = li8((_loc14_ = __DefaultRuneLocale + (_loc11_ << 2)) + 54)) & 1) == 0)
         {
            break;
         }
         _loc2_ += 1;
         _loc12_ += 1;
         _loc13_ += 1;
      }
      _loc1_ = nan;
      if(_loc12_ >= 0)
      {
         if(uint(_loc12_) <= 7)
         {
            _loc12_ = 7;
         }
         _loc11_ = _loc13_ - _loc12_;
         _loc10_ = li32(__CurrentRuneLocale);
         _loc13_ = li32(___mb_sb_limit);
         _loc9_ = 0;
         do
         {
            _loc14_ = (_loc14_ = _loc9_ >> 31) >>> 27;
            var _loc8_:* = (_loc14_ = (_loc14_ = _loc9_ + _loc14_) >> 5) << 2;
            _loc6_ = li32(_loc7_ = (_loc14_ = _loc4_ - 8) + _loc8_);
            _loc5_ = si8(li8(_loc2_));
            _loc12_ = 0;
            if(_loc5_ >= 0)
            {
               _loc12_ = 0;
               if(_loc13_ > _loc5_)
               {
                  _loc12_ = li8((_loc14_ = _loc10_ + (_loc5_ << 2)) + 52);
               }
            }
            si32(_loc14_ = (_loc14_ = _loc12_ << _loc9_) | _loc6_,_loc7_);
            _loc9_ += 4;
            _loc2_ += -1;
         }
         while((_loc11_ += -1) != 0);
         
         si32(_loc14_ = (_loc14_ = li32(_loc4_ - 8)) | 2143289344,_loc4_ - 12);
         _loc1_ = lf32(_loc4_ - 12);
      }
      st0 = _loc1_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
