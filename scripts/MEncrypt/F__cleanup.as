package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F__cleanup() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = ___sglue;
      do
      {
         if((_loc9_ = li32(_loc1_ + 4)) >= 1)
         {
            _loc8_ = li32(_loc1_ + 8);
            do
            {
               if((_loc7_ = si16(li16(_loc8_ + 12))) >= 1)
               {
                  var _loc6_:*;
                  if((_loc6_ = _loc7_ & 8) != 0)
                  {
                     if((_loc5_ = li32(_loc8_ + 16)) != 0)
                     {
                        _loc4_ = li32(_loc8_);
                        si32(_loc5_,_loc8_);
                        _loc7_ = 0;
                        if((_loc7_ & 3) == 0)
                        {
                           _loc7_ = li32(_loc8_ + 20);
                        }
                        _loc4_ -= _loc5_;
                        si32(_loc7_,_loc8_ + 8);
                        while(_loc4_ > 0)
                        {
                           _loc2_ -= 16;
                           si32(_loc4_,_loc2_ + 8);
                           si32(_loc5_,_loc2_ + 4);
                           si32(_loc8_,_loc2_);
                           ESP = _loc2_;
                           F__swrite();
                           _loc2_ += 16;
                           if((_loc7_ = eax) <= 0)
                           {
                              si16(_loc6_ = (_loc6_ = li16(_loc8_ + 12)) | 64,_loc8_ + 12);
                              break;
                           }
                           _loc5_ += _loc7_;
                           _loc4_ -= _loc7_;
                        }
                     }
                  }
               }
               _loc8_ += 232;
            }
            while((_loc9_ += -1) != 0);
            
         }
         _loc1_ = li32(_loc1_);
      }
      while(_loc1_ != 0);
      
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
