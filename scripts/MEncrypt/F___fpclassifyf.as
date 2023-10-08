package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___fpclassifyf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc6_:int;
      if((_loc5_ = (_loc6_ = _loc1_ >>> 23) & 255) != 255)
      {
         _loc4_ = 4;
         if(_loc5_ == 0)
         {
            _loc4_ = 16;
            if((_loc1_ & 8388607) != 0)
            {
               _loc4_ = 8;
            }
         }
      }
      else
      {
         _loc4_ = 1;
         if((_loc1_ & 8388607) != 0)
         {
            _loc4_ = 2;
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
