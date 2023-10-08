package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   
   public function F_AS3_SendMetricString() : void
   {
      var _loc3_:* = 0;
      var _loc4_:String = null;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:int = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc10_ = (_loc11_ = li32(_loc12_ = _loc1_ & -4)) + -16843009;
      _loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_;
      _loc9_ = li32(_loc3_ + 4);
      if(_loc10_ != 0)
      {
         _loc8_ = _loc12_ + 4;
         _loc7_ = 0;
         while(true)
         {
            if((uint(_loc6_ = _loc1_ + _loc7_)) < uint(_loc8_))
            {
               continue;
            }
         }
         addr212:
         _loc4_ = CModule.readString(_loc1_,_loc7_);
         _loc10_ = (_loc11_ = li32(_loc8_ = _loc9_ & -4)) + -16843009;
         if((_loc10_ = (_loc11_ = (_loc11_ &= -2139062144) ^ -2139062144) & _loc10_) != 0)
         {
            _loc12_ = _loc8_ + 4;
            _loc7_ = 0;
            while(true)
            {
               _loc1_ = _loc9_ + _loc7_;
               if(uint(_loc1_) < uint(_loc12_))
               {
                  continue;
               }
            }
            §§goto(addr394);
         }
         _loc1_ = _loc8_ + 4;
         while(true)
         {
            _loc10_ = (_loc7_ = li32(_loc1_)) + -16843009;
            if((_loc10_ = (_loc11_ = (_loc11_ = _loc7_ & -2139062144) ^ -2139062144) & _loc10_) != 0)
            {
               if((_loc10_ = _loc7_ & 255) == 0)
               {
                  _loc7_ = _loc1_ - _loc9_;
               }
               else if((_loc10_ = li8(_loc1_ + 1)) == 0)
               {
                  _loc7_ = (_loc10_ = 1 - _loc9_) + _loc1_;
               }
               else if((_loc10_ = li8(_loc1_ + 2)) == 0)
               {
                  _loc7_ = (_loc10_ = 2 - _loc9_) + _loc1_;
               }
               else
               {
                  if((_loc10_ = li8(_loc1_ + 3)) != 0)
                  {
                     continue;
                  }
                  _loc7_ = (_loc10_ = 3 - _loc9_) + _loc1_;
               }
               addr394:
               var _loc5_:String = CModule.readString(_loc9_,_loc7_);
               CModule.sendMetric(_loc4_,_loc5_);
               _loc2_ = _loc3_;
            }
            continue;
            ESP = _loc2_;
            return;
         }
      }
      _loc12_ += 4;
      while(true)
      {
         _loc10_ = (_loc7_ = li32(_loc12_)) + -16843009;
         if((_loc10_ = (_loc11_ = (_loc11_ = _loc7_ & -2139062144) ^ -2139062144) & _loc10_) == 0)
         {
            continue;
         }
         if((_loc10_ = _loc7_ & 255) == 0)
         {
            _loc7_ = _loc12_ - _loc1_;
         }
         else if((_loc10_ = li8(_loc12_ + 1)) == 0)
         {
            _loc7_ = (_loc10_ = 1 - _loc1_) + _loc12_;
         }
         else if((_loc10_ = li8(_loc12_ + 2)) == 0)
         {
            _loc7_ = (_loc10_ = 2 - _loc1_) + _loc12_;
         }
         else
         {
            if((_loc10_ = li8(_loc12_ + 3)) != 0)
            {
               continue;
            }
            _loc7_ = (_loc10_ = 3 - _loc1_) + _loc12_;
         }
         §§goto(addr212);
      }
   }
}
