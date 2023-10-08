package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___cmp_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc10_ = li32(_loc1_ + 16);
      if((_loc8_ = li32((_loc9_ = li32(_loc3_)) + 16)) != _loc10_)
      {
         _loc9_ = _loc8_ - _loc10_;
      }
      else
      {
         var _loc6_:int;
         var _loc7_:*;
         _loc1_ = (_loc6_ = (_loc7_ = _loc10_ << 2) + _loc1_) + 16;
         _loc8_ = (_loc6_ = _loc7_ + _loc9_) + 20;
         _loc10_ = _loc9_ + 20;
         do
         {
            _loc5_ = li32(_loc1_);
            if((_loc4_ = li32(_loc8_ - 4)) != _loc5_)
            {
               _loc9_ = -1;
               if(uint(_loc4_) >= uint(_loc5_))
               {
                  _loc9_ = 1;
               }
               break;
            }
            _loc1_ += -4;
            _loc8_ += -4;
            _loc9_ = 0;
         }
         while(uint(_loc8_) > uint(_loc10_));
         
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
