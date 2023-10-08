package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F_lroundl() : void
   {
      var _loc3_:* = 0;
      var _loc4_:Number = NaN;
      var _loc5_:* = NaN;
      var _loc1_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 16;
      _loc1_ = 2147483647;
      if(!((_loc5_ = lf64(_loc3_)) <= -2147483648.5 | _loc5_ != _loc5_ | false))
      {
         if(!(_loc5_ >= 2147483647.5 | _loc5_ != _loc5_ | false))
         {
            sf64(_loc5_,_loc3_ - 8);
            var _loc7_:*;
            if((_loc7_ = (_loc7_ = (_loc7_ = li32(_loc7_ = (_loc7_ = _loc3_ - 8) | 4)) >>> 20) & 2047) != 2047)
            {
               if(!(_loc5_ < 0 | _loc5_ != _loc5_ | false))
               {
                  _loc2_ -= 16;
                  sf64(_loc5_,_loc2_);
                  ESP = _loc2_;
                  F_floor();
                  _loc2_ += 16;
                  var _loc6_:Number = (_loc4_ = st0) - _loc5_;
                  _loc5_ = _loc4_;
                  if(!(_loc6_ > -0.5 | _loc6_ != _loc6_ | false))
                  {
                     _loc5_ = _loc4_ + 1;
                  }
               }
               else
               {
                  _loc2_ -= 16;
                  sf64(_loc6_ = -_loc5_,_loc2_);
                  ESP = _loc2_;
                  F_floor();
                  _loc2_ += 16;
                  if(!((_loc6_ = (_loc4_ = st0) + _loc5_) > -0.5 | _loc6_ != _loc6_ | false))
                  {
                     _loc4_ += 1;
                  }
                  _loc5_ = -_loc4_;
               }
            }
            _loc1_ = _loc5_;
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
