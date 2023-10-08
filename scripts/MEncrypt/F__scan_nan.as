package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F__scan_nan() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc13_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:int = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      si32(0,_loc2_ + 4);
      _loc1_ = li32(_loc3_);
      si32(_loc1_,_loc2_);
      var _loc12_:*;
      si32(_loc12_ = (_loc13_ = li32(_loc3_ + 4)) << 2,_loc2_ + 8);
      ESP = _loc2_;
      Fmemset();
      _loc2_ += 16;
      if((_loc12_ = li8(_loc11_ = li32(_loc3_ + 8))) == 48)
      {
         if((_loc12_ = (_loc12_ = (_loc12_ = li8(_loc11_ + 1)) | 32) & 255) == 120)
         {
            _loc11_ += 2;
         }
      }
      _loc10_ = -2;
      _loc9_ = -1;
      while((_loc8_ = si8(li8((_loc12_ = _loc11_ + _loc10_) + 2))) >= 0)
      {
         if((_loc12_ = (_loc12_ = li8((_loc12_ = __DefaultRuneLocale + (_loc8_ << 2)) + 54)) & 1) == 0)
         {
            break;
         }
         _loc9_ += 1;
         _loc10_ += 1;
      }
      if((_loc8_ = _loc13_ << 5) >= 1)
      {
         _loc13_ = 0;
         if(_loc9_ >= 0)
         {
            do
            {
               _loc9_ = _loc10_;
               _loc7_ = si8(li8((_loc12_ = _loc11_ + _loc9_) + 1));
               _loc12_ = (_loc12_ = _loc13_ >> 31) >>> 27;
               _loc12_ = (_loc12_ = (_loc12_ = _loc13_ + _loc12_) >> 5) << 2;
               _loc10_ = li32(_loc6_ = _loc1_ + _loc12_);
               _loc5_ = 0;
               if(_loc7_ >= 0)
               {
                  _loc5_ = 0;
                  if(li32(___mb_sb_limit) > _loc7_)
                  {
                     var _loc4_:*;
                     _loc5_ = li8((_loc12_ = (_loc4_ = li32(__CurrentRuneLocale)) + (_loc7_ << 2)) + 52);
                  }
               }
               _loc7_ = _loc13_ + 4;
               _loc12_ = _loc13_ & 28;
               si32(_loc12_ = (_loc12_ = _loc5_ << _loc12_) | _loc10_,_loc6_);
               if(_loc8_ <= _loc7_)
               {
                  break;
               }
               _loc10_ = _loc9_ + -1;
               _loc13_ = _loc7_;
            }
            while(_loc9_ > -1);
            
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
