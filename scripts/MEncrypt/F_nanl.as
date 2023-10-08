package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_nanl() : void
   {
      var _loc4_:* = 0;
      var _loc14_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc3_:* = 0;
      var _loc15_:* = 0;
      var _loc1_:int = 0;
      var _loc12_:int = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 8;
      _loc3_ = _loc4_ - 8;
      _loc15_ = _loc3_ | 4;
      si32(0,_loc15_);
      si32(0,_loc4_ - 8);
      var _loc13_:*;
      if((_loc13_ = li8(_loc14_ = li32(_loc4_))) == 48)
      {
         if((_loc13_ = (_loc13_ = (_loc13_ = li8(_loc14_ + 1)) | 32) & 255) == 120)
         {
            _loc14_ += 2;
         }
      }
      _loc14_ += -1;
      _loc12_ = 15;
      _loc11_ = -1;
      while((_loc9_ = si8(li8(_loc14_ + 1))) >= 0)
      {
         if((_loc13_ = (_loc13_ = li8((_loc13_ = __DefaultRuneLocale + (_loc9_ << 2)) + 54)) & 1) == 0)
         {
            break;
         }
         _loc14_ += 1;
         _loc11_ += 1;
         _loc12_ += 1;
      }
      if(_loc11_ <= -1)
      {
         _loc3_ = 2146959360;
      }
      else
      {
         if(uint(_loc11_) <= 15)
         {
            _loc11_ = 15;
         }
         _loc12_ -= _loc11_;
         _loc8_ = li32(__CurrentRuneLocale);
         _loc7_ = li32(___mb_sb_limit);
         _loc9_ = 0;
         do
         {
            _loc13_ = (_loc13_ = _loc9_ >> 31) >>> 27;
            _loc13_ = (_loc13_ = (_loc13_ = _loc9_ + _loc13_) >> 5) << 2;
            _loc1_ = _loc3_ + _loc13_;
            _loc5_ = li32(_loc1_);
            _loc11_ = si8(li8(_loc14_));
            _loc6_ = 0;
            if(_loc11_ >= 0)
            {
               _loc6_ = 0;
               if(_loc7_ > _loc11_)
               {
                  _loc6_ = li8((_loc13_ = _loc8_ + (_loc11_ << 2)) + 52);
               }
            }
            _loc13_ = _loc9_ & 28;
            si32(_loc13_ = (_loc13_ = _loc6_ << _loc13_) | _loc5_,_loc1_);
            _loc9_ += 4;
            _loc14_ += -1;
         }
         while((_loc12_ += -1) != 0);
         
         _loc3_ = (_loc13_ = li32(_loc15_)) | 2146959360;
      }
      si32(_loc3_,_loc15_);
      var _loc10_:*;
      st0 = _loc10_ = lf64(_loc4_ - 8);
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
