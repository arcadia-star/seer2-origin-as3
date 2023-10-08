package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___mulosi4() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      si32(0,_loc1_);
      _loc9_ = li32(_loc3_);
      _loc7_ = (_loc8_ = li32(_loc3_ + 4)) * _loc9_;
      if(_loc9_ == -2147483648)
      {
         if(uint(_loc8_) >= 2)
         {
            si32(1,_loc1_);
         }
      }
      else if(_loc8_ == -2147483648)
      {
         if(uint(_loc9_) >= 2)
         {
            si32(1,_loc1_);
         }
      }
      else
      {
         var _loc5_:*;
         if((_loc9_ = (_loc5_ = (_loc6_ = _loc9_ >> 31) ^ _loc9_) - _loc6_) >= 2)
         {
            if((_loc8_ = (_loc5_ = (_loc4_ = _loc8_ >> 31) ^ _loc8_) - _loc4_) >= 2)
            {
               if(_loc6_ == _loc4_)
               {
                  if((_loc5_ = 2147483647 / _loc8_) < _loc9_)
                  {
                     si32(1,_loc1_);
                  }
               }
               else if((_loc5_ = -2147483648 / (0 - _loc8_)) < _loc9_)
               {
                  si32(1,_loc1_);
               }
            }
         }
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
