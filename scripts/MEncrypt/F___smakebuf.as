package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F___smakebuf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 144;
      _loc1_ = li32(_loc3_);
      var _loc10_:*;
      if((_loc10_ = (_loc10_ = li8(_loc1_ + 12)) & 2) != 0)
      {
         si32(_loc10_ = _loc1_ + 67,_loc1_);
         si32(_loc10_,_loc1_ + 16);
         si32(1,_loc1_ + 20);
      }
      else
      {
         _loc9_ = si16(li16(_loc1_ + 14));
         _loc8_ = 2048;
         _loc7_ = 1024;
         _loc6_ = 0;
         if(_loc9_ >= 0)
         {
            _loc2_ -= 16;
            si32(_loc10_ = _loc3_ - 144,_loc2_ + 4);
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F__fstat();
            _loc8_ = 2048;
            _loc7_ = 1024;
            _loc6_ = 0;
            _loc2_ += 16;
            if((_loc10_ = eax) >= 0)
            {
               _loc9_ = (_loc10_ = li16(_loc3_ - 136)) & 61440;
               _loc6_ = 1;
               if(_loc9_ != 8192)
               {
                  _loc6_ = 0;
               }
               _loc6_ &= 1;
               _loc8_ = 2048;
               _loc7_ = 1024;
               if((_loc5_ = li32(_loc3_ - 80)) != 0)
               {
                  si32(_loc5_,_loc1_ + 76);
                  if(_loc9_ == 32768)
                  {
                     _loc8_ = 1024;
                     _loc7_ = _loc5_;
                     if(li32(_loc1_ + 40) != ___sseek)
                     {
                     }
                     §§goto(addr182);
                  }
                  _loc8_ = 2048;
                  _loc7_ = _loc5_;
               }
            }
         }
         addr182:
         _loc2_ -= 16;
         si32(_loc7_,_loc2_);
         ESP = _loc2_;
         F_malloc();
         _loc2_ += 16;
         if((_loc9_ = eax) == 0)
         {
            si16(_loc10_ = (_loc10_ = li16(_loc1_ + 12)) | 2,_loc1_ + 12);
            si32(_loc10_ = _loc1_ + 67,_loc1_);
            si32(_loc10_,_loc1_ + 16);
            si32(1,_loc1_ + 20);
         }
         else
         {
            si32(__cleanup,___cleanup);
            si32(_loc9_,_loc1_);
            si32(_loc9_,_loc1_ + 16);
            si32(_loc7_,_loc1_ + 20);
            _loc7_ = _loc8_ | 128;
            if(_loc6_ != 0)
            {
               _loc2_ -= 16;
               si32(_loc10_ = _loc3_ - 48,_loc2_ + 8);
               si32(1076655123,_loc2_ + 4);
               si32(si16(li16(_loc1_ + 14)),_loc2_);
               ESP = _loc2_;
               F__ioctl();
               _loc2_ += 16;
               if((_loc10_ = eax) != -1)
               {
                  _loc7_ = _loc8_ | 129;
               }
            }
            si16(_loc10_ = (_loc10_ = li16(_loc1_ + 12)) | _loc7_,_loc1_ + 12);
         }
         §§goto(addr333);
      }
      addr333:
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
