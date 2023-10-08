package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si8;
   
   public function F_strlcat() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:int = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      _loc12_ = li32(_loc3_ + 8);
      _loc11_ = li32(_loc3_ + 4);
      _loc10_ = li32(_loc3_);
      loop0:
      while(true)
      {
         if((_loc9_ = _loc12_ + _loc1_) != 0)
         {
            var _loc7_:*;
            if((_loc7_ = li8(_loc8_ = _loc10_ - _loc1_)) == 0)
            {
               _loc6_ = li8(_loc11_);
               _loc10_ = _loc11_;
               if(_loc6_ != 0)
               {
                  _loc5_ = _loc11_;
                  do
                  {
                     _loc12_ = 1;
                     if(_loc9_ != 1)
                     {
                        si8(_loc6_,_loc8_);
                        _loc12_ = _loc9_ + -1;
                        _loc8_ += 1;
                     }
                     _loc10_ = _loc5_ + 1;
                     _loc6_ = li8(_loc5_ + 1);
                     _loc5_ = _loc10_;
                     _loc9_ = _loc12_;
                  }
                  while(_loc6_ != 0);
                  
               }
               si8(0,_loc8_);
               _loc9_ = _loc10_ - _loc11_;
               break;
            }
            continue;
         }
         var _loc4_:*;
         if((_loc7_ = (_loc4_ = (_loc4_ &= -2139062144) ^ -2139062144) & (_loc4_ = li32(_loc8_ = _loc11_ & -4)) + -16843009) != 0)
         {
            _loc12_ = _loc8_ + 4;
            _loc9_ = 0;
            while(true)
            {
               if((uint(_loc10_ = _loc11_ + _loc9_)) < uint(_loc12_))
               {
                  if((_loc7_ = li8(_loc10_)) == 0)
                  {
                     break loop0;
                  }
                  continue;
               }
            }
         }
         _loc9_ = _loc8_ + 4;
         while(true)
         {
            _loc7_ = (_loc8_ = li32(_loc9_)) + -16843009;
            if((_loc7_ = (_loc4_ = (_loc4_ = _loc8_ & -2139062144) ^ -2139062144) & _loc7_) != 0)
            {
               if((_loc7_ = _loc8_ & 255) == 0)
               {
                  _loc9_ -= _loc11_;
                  break loop0;
               }
               if((_loc7_ = li8(_loc9_ + 1)) == 0)
               {
                  _loc9_ = (_loc7_ = 1 - _loc11_) + _loc9_;
                  break loop0;
               }
               if((_loc7_ = li8(_loc9_ + 2)) == 0)
               {
                  _loc9_ = (_loc7_ = 2 - _loc11_) + _loc9_;
                  break loop0;
               }
               if((_loc7_ = li8(_loc9_ + 3)) == 0)
               {
                  _loc9_ = (_loc7_ = 3 - _loc11_) + _loc9_;
                  break loop0;
               }
            }
            _loc9_ += 4;
         }
      }
      eax = _loc7_ = _loc9_ - _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
