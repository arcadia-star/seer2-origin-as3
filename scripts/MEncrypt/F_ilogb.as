package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F_ilogb() : void
   {
      var _loc3_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      if((uint(_loc6_ = (_loc7_ = li32(_loc1_)) & 2147483647)) <= 1048575)
      {
         _loc5_ = li32(_loc3_);
         _loc4_ = -2147483647;
         if((_loc6_ | _loc5_) != 0)
         {
            if(_loc6_ == 0)
            {
               _loc4_ = -1043;
               if(_loc5_ >= 1)
               {
                  do
                  {
                     _loc4_ += -1;
                  }
                  while((_loc5_ <<= 1) > 0);
                  
               }
            }
            else
            {
               _loc7_ <<= 11;
               _loc4_ = -1022;
               if(_loc7_ >= 1)
               {
                  do
                  {
                     _loc4_ += -1;
                  }
                  while((_loc7_ <<= 1) > 0);
                  
               }
            }
         }
      }
      else
      {
         _loc4_ = 2147483647;
         if(uint(_loc6_) <= 2146435071)
         {
            _loc4_ = (_loc6_ >>> 20) + -1023;
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
