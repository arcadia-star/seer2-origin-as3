package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___nesf2() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc8_ = _loc1_ & 2147483647;
      _loc7_ = 1;
      if(uint(_loc8_) <= 2139095040)
      {
         if((uint(_loc5_ = (_loc6_ = li32(_loc3_ + 4)) & 2147483647)) <= 2139095040)
         {
            _loc7_ = 0;
            if((_loc5_ | _loc8_) != 0)
            {
               var _loc4_:*;
               if((_loc4_ = _loc6_ & _loc1_) >= 0)
               {
                  _loc7_ = -1;
                  if(_loc1_ >= _loc6_)
                  {
                     _loc7_ = 1;
                     if(_loc1_ == _loc6_)
                     {
                        _loc7_ = 0;
                     }
                     _loc7_ &= 1;
                  }
               }
               else
               {
                  _loc7_ = -1;
                  if(_loc1_ <= _loc6_)
                  {
                     _loc7_ = 1;
                     if(_loc1_ == _loc6_)
                     {
                        _loc7_ = 0;
                     }
                     _loc7_ &= 1;
                  }
               }
            }
         }
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
