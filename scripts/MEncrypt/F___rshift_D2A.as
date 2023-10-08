package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___rshift_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc10_:int = 0;
      var _loc13_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc13_ = li32(_loc1_ + 16);
      _loc11_ = (_loc12_ = li32(_loc3_ + 4)) >> 5;
      _loc9_ = _loc10_ = _loc1_ + 20;
      if(_loc13_ > _loc11_)
      {
         var _loc8_:*;
         _loc7_ = (_loc8_ = _loc1_ + (_loc13_ << 2)) + 20;
         if((_loc6_ = _loc12_ & 31) == 0)
         {
            _loc9_ = _loc10_;
            if(_loc11_ < _loc13_)
            {
               _loc12_ = _loc11_ << 2;
               _loc9_ = _loc1_ + 20;
               do
               {
                  si32(_loc8_ = li32(_loc8_ = _loc9_ + _loc12_),_loc9_);
               }
               while((uint(_loc8_ = (_loc9_ += 4) + _loc12_)) < uint(_loc7_));
               
            }
         }
         else
         {
            _loc5_ = _loc11_ << 2;
            _loc12_ = (_loc8_ = li32((_loc8_ = _loc1_ + _loc5_) + 20)) >>> _loc6_;
            _loc9_ = _loc10_;
            if(_loc11_ + 1 < _loc13_)
            {
               _loc9_ = 32 - _loc6_;
               _loc5_ += 24;
               _loc11_ = _loc1_;
               do
               {
                  var _loc4_:*;
                  si32(_loc4_ = (_loc4_ = (_loc4_ = li32(_loc8_ = _loc11_ + _loc5_)) << _loc9_) | _loc12_,_loc11_ + 20);
                  _loc4_ = (_loc11_ += 4) + _loc5_;
                  _loc12_ = (_loc8_ = li32(_loc8_)) >>> _loc6_;
               }
               while(uint(_loc4_) < uint(_loc7_));
               
               _loc9_ = _loc11_ + 20;
            }
            si32(_loc12_,_loc9_);
            if(_loc12_ != 0)
            {
               _loc9_ += 4;
            }
         }
      }
      si32(_loc8_ = (_loc8_ = _loc9_ - _loc10_) >> 2,_loc1_ + 16);
      if(_loc8_ == 0)
      {
         si32(0,_loc10_);
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
