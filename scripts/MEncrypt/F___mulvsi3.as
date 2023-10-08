package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___mulvsi3() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      if((_loc9_ = li32(_loc3_)) == -2147483648)
      {
         if(uint(_loc1_) >= 2)
         {
            ESP = _loc2_;
            F_abort();
            addr46:
            if(_loc1_ == -2147483648)
            {
               if(uint(_loc9_) >= 2)
               {
                  ESP = _loc2_;
                  F_abort();
               }
               §§goto(addr137);
            }
            var _loc7_:*;
            if((_loc6_ = (_loc7_ = (_loc8_ = _loc9_ >> 31) ^ _loc9_) - _loc8_) >= 2)
            {
               if((_loc4_ = (_loc7_ = (_loc5_ = _loc1_ >> 31) ^ _loc1_) - _loc5_) >= 2)
               {
                  if(_loc8_ == _loc5_)
                  {
                     if((_loc7_ = 2147483647 / _loc4_) < _loc6_)
                     {
                        ESP = _loc2_;
                        F_abort();
                     }
                     §§goto(addr137);
                  }
                  _loc7_ = 0 - _loc4_;
                  if((_loc7_ = -2147483648 / _loc7_) < _loc6_)
                  {
                     ESP = _loc2_;
                     F_abort();
                  }
               }
            }
         }
         addr137:
         eax = _loc7_ = _loc1_ * _loc9_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr46);
   }
}
