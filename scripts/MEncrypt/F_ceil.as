package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_ceil() : void
   {
      var _loc3_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:int = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc8_:* = NaN;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      sf64(_loc8_ = lf64(_loc3_),_loc3_ - 8);
      _loc1_ = _loc3_ - 8;
      _loc1_ |= 4;
      _loc1_ = (_loc12_ = li32(_loc1_)) >>> 20;
      _loc10_ = (_loc11_ = _loc1_ & 2047) + -1023;
      _loc9_ = li32(_loc3_ - 8);
      if(_loc10_ <= 19)
      {
         if(_loc10_ <= -1)
         {
            var _loc6_:Number = _loc8_ + 1e+300;
            _loc7_ = _loc9_;
            _loc5_ = _loc12_;
            if(!(_loc6_ <= 0 | _loc6_ != _loc6_ | false))
            {
               _loc5_ = -2147483648;
               _loc7_ = 0;
               if(_loc12_ >= 0)
               {
                  _loc7_ = _loc9_;
                  _loc5_ = _loc12_;
                  if((_loc12_ | _loc9_) != 0)
                  {
                     _loc5_ = 1072693248;
                     _loc7_ = 0;
                  }
               }
            }
            addr294:
            _loc1_ = _loc3_ - 16;
            _loc1_ |= 4;
            si32(_loc5_,_loc1_);
            si32(_loc7_,_loc3_ - 16);
            _loc8_ = lf64(_loc3_ - 16);
         }
         else if(((_loc4_ = 1048575 >>> _loc10_) & _loc12_ | _loc9_) != 0)
         {
            _loc6_ = _loc8_ + 1e+300;
            _loc7_ = _loc9_;
            _loc5_ = _loc12_;
            if(!(_loc6_ <= 0 | _loc6_ != _loc6_ | false))
            {
               if(_loc12_ >= 1)
               {
                  _loc12_ = (1048576 >>> _loc10_) + _loc12_;
               }
               _loc1_ = _loc4_ ^ -1;
               _loc5_ = _loc12_ & _loc1_;
               _loc7_ = 0;
            }
            §§goto(addr294);
         }
      }
      else if(_loc10_ >= 52)
      {
         if(_loc10_ == 1024)
         {
            _loc8_ += _loc8_;
         }
      }
      else if(((_loc4_ = -1 >>> _loc11_ + -1043) & _loc9_) != 0)
      {
         _loc6_ = _loc8_ + 1e+300;
         _loc7_ = _loc9_;
         _loc5_ = _loc12_;
         if(!(_loc6_ <= 0 | _loc6_ != _loc6_ | false))
         {
            if(_loc12_ >= 1)
            {
               if(_loc10_ == 20)
               {
                  _loc12_ += 1;
               }
               else
               {
                  _loc1_ = (_loc10_ = 1) << 1075 - _loc11_;
                  if((uint(_loc9_ = _loc1_ + _loc9_)) >= uint(_loc1_))
                  {
                     _loc10_ = 0;
                  }
                  _loc1_ = _loc10_ & 1;
                  _loc12_ = _loc1_ + _loc12_;
               }
            }
            _loc1_ = _loc4_ ^ -1;
            _loc7_ = _loc9_ & _loc1_;
            _loc5_ = _loc12_;
         }
         §§goto(addr294);
      }
      st0 = _loc8_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
