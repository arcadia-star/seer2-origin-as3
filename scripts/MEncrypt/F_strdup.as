package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_strdup() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:int = 0;
      var _loc4_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc9_:* = 0;
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
      _loc6_ = _loc9_ + 4;
      while(true)
      {
         _loc7_ = (_loc4_ = li32(_loc6_)) + -16843009;
         if((_loc7_ = (_loc8_ = (_loc8_ = _loc4_ & -2139062144) ^ -2139062144) & _loc7_) != 0)
         {
            if((_loc7_ = _loc4_ & 255) == 0)
            {
               _loc5_ = _loc6_ - _loc1_;
            }
            else if((_loc7_ = li8(_loc6_ + 1)) == 0)
            {
               _loc5_ = (_loc7_ = 1 - _loc1_) + _loc6_;
            }
            else if((_loc7_ = li8(_loc6_ + 2)) == 0)
            {
               _loc5_ = (_loc7_ = 2 - _loc1_) + _loc6_;
            }
            else
            {
               if((_loc7_ = li8(_loc6_ + 3)) != 0)
               {
                  continue;
               }
               _loc5_ = (_loc7_ = 3 - _loc1_) + _loc6_;
            }
            addr203:
            _loc2_ -= 16;
            si32(_loc6_ = _loc5_ + 1,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc9_ = 0;
            _loc2_ += 16;
         }
         continue;
         if((_loc4_ = eax) != 0)
         {
            _loc2_ -= 16;
            si32(_loc6_,_loc2_ + 8);
            si32(_loc1_,_loc2_ + 4);
            si32(_loc4_,_loc2_);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            _loc9_ = _loc4_;
         }
         eax = _loc9_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
   }
}
