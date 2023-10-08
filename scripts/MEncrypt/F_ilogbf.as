package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F_ilogbf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if((uint(_loc6_ = _loc1_ & 2147483647)) <= 8388607)
      {
         _loc5_ = -2147483647;
         if(_loc6_ != 0)
         {
            _loc1_ <<= 8;
            _loc5_ = -126;
            if(_loc1_ >= 1)
            {
               do
               {
                  _loc5_ += -1;
                  _loc1_ <<= 1;
               }
               while(_loc1_ > 0);
               
            }
         }
      }
      else
      {
         _loc5_ = 2147483647;
         if(uint(_loc6_) <= 2139095039)
         {
            var _loc4_:int;
            _loc5_ = (_loc4_ = _loc6_ >>> 23) + -127;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
