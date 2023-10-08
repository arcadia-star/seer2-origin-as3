package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   
   public function F_strlen() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:int = 0;
      var _loc4_:int = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc7_ = (_loc8_ = li32(_loc9_ = _loc1_ & -4)) + -16843009;
      if((_loc7_ = (_loc8_ = (_loc8_ &= -2139062144) ^ -2139062144) & _loc7_) != 0)
      {
         _loc6_ = _loc9_ + 4;
         _loc5_ = 0;
         while(true)
         {
            if((uint(_loc4_ = _loc1_ + _loc5_)) < uint(_loc6_))
            {
               continue;
            }
         }
         §§goto(addr203);
      }
      _loc9_ += 4;
      while(true)
      {
         _loc7_ = (_loc5_ = li32(_loc9_)) + -16843009;
         if((_loc7_ = (_loc8_ = (_loc8_ = _loc5_ & -2139062144) ^ -2139062144) & _loc7_) != 0)
         {
            if((_loc7_ = _loc5_ & 255) == 0)
            {
               _loc5_ = _loc9_ - _loc1_;
            }
            else if((_loc7_ = li8(_loc9_ + 1)) == 0)
            {
               _loc5_ = (_loc7_ = 1 - _loc1_) + _loc9_;
            }
            else if((_loc7_ = li8(_loc9_ + 2)) == 0)
            {
               _loc5_ = (_loc7_ = 2 - _loc1_) + _loc9_;
            }
            else
            {
               if((_loc7_ = li8(_loc9_ + 3)) != 0)
               {
                  continue;
               }
               _loc5_ = (_loc7_ = 3 - _loc1_) + _loc9_;
            }
            addr203:
            eax = _loc5_;
            _loc2_ = _loc3_;
         }
         continue;
         ESP = _loc2_;
         return;
      }
   }
}
