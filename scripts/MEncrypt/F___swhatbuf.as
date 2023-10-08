package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F___swhatbuf() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 96;
      _loc1_ = li32(_loc3_);
      _loc8_ = si16(li16(_loc1_ + 14));
      _loc7_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_ + 4);
      if(_loc8_ >= 0)
      {
         _loc2_ -= 16;
         var _loc5_:*;
         si32(_loc5_ = _loc3_ - 96,_loc2_ + 4);
         si32(_loc8_,_loc2_);
         ESP = _loc2_;
         F__fstat();
         _loc2_ += 16;
         if((_loc5_ = eax) <= -1)
         {
            addr86:
            si32(0,_loc7_);
            si32(1024,_loc6_);
            _loc1_ = 2048;
         }
         else
         {
            _loc8_ = (_loc5_ = li16(_loc3_ - 88)) & 61440;
            _loc4_ = 1;
            if(_loc8_ != 8192)
            {
               _loc4_ = 0;
            }
            si32(_loc5_ = _loc4_ & 1,_loc7_);
            if((_loc7_ = li32(_loc3_ - 32)) == 0)
            {
               si32(1024,_loc6_);
               _loc1_ = 2048;
            }
            else
            {
               si32(_loc7_,_loc6_);
               si32(_loc7_,_loc1_ + 76);
               if(_loc8_ == 32768)
               {
                  _loc1_ = 1024;
                  if(li32(_loc1_ + 40) != ___sseek)
                  {
                  }
                  §§goto(addr160);
               }
               _loc1_ = 2048;
            }
         }
         addr160:
         eax = _loc1_;
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr86);
   }
}
