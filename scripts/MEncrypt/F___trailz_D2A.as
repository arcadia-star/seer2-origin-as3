package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___trailz_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc10_ = li32(_loc1_ + 16);
      _loc8_ = _loc9_ = 0;
      for(; _loc8_ < _loc10_; _loc9_ += 32,_loc8_ += 1)
      {
         var _loc7_:*;
         if((_loc6_ = li32((_loc7_ = _loc1_ + (_loc8_ << 2)) + 20)) == 0)
         {
            continue;
         }
         if((_loc7_ = _loc6_ & 7) != 0)
         {
            _loc10_ = 0;
            if((_loc6_ & 1) == 0)
            {
               _loc10_ = 1;
               if((_loc6_ & 2) == 0)
               {
                  _loc10_ = 2;
               }
            }
         }
         else
         {
            _loc8_ = _loc6_ >>> 16;
            _loc1_ = _loc6_ & 65535;
            if(_loc1_ != 0)
            {
               _loc8_ = _loc6_;
            }
            _loc6_ = _loc8_ >>> 8;
            if((_loc10_ = _loc8_ & 255) != 0)
            {
               _loc6_ = _loc8_;
            }
            _loc5_ = _loc6_ >>> 4;
            if((_loc4_ = _loc6_ & 15) != 0)
            {
               _loc5_ = _loc6_;
            }
            _loc6_ = _loc5_ >>> 2;
            if((_loc8_ = _loc5_ & 3) != 0)
            {
               _loc6_ = _loc5_;
            }
            _loc5_ = 16;
            if(_loc1_ != 0)
            {
               _loc5_ = 0;
            }
            _loc1_ = _loc5_ | 8;
            if(_loc10_ != 0)
            {
               _loc1_ = _loc5_;
            }
            _loc10_ = _loc1_ | 4;
            if(_loc4_ != 0)
            {
               _loc10_ = _loc1_;
            }
            _loc1_ = _loc10_ | 2;
            if(_loc8_ != 0)
            {
               _loc1_ = _loc10_;
            }
            if((_loc7_ = _loc6_ & 1) == 0)
            {
               _loc1_ += 1;
               _loc10_ = 32;
               if(uint(_loc6_) >= 2)
               {
               }
               addr219:
               _loc9_ = _loc10_ + _loc9_;
               break;
            }
            _loc10_ = _loc1_;
         }
         §§goto(addr219);
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
