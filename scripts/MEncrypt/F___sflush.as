package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi16;
   
   public function F___sflush() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc7_ = (_loc8_ = si16(li16(_loc1_ + 12))) & 8;
      _loc6_ = 0;
      if(_loc7_ != 0)
      {
         _loc5_ = li32(_loc1_ + 16);
         _loc6_ = 0;
         if(_loc5_ != 0)
         {
            _loc4_ = li32(_loc1_);
            si32(_loc5_,_loc1_);
            _loc6_ = 0;
            if((_loc8_ & 3) == 0)
            {
               _loc6_ = li32(_loc1_ + 20);
            }
            _loc8_ = _loc4_ - _loc5_;
            si32(_loc6_,_loc1_ + 8);
            while(true)
            {
               _loc6_ = 0;
               if(_loc8_ <= 0)
               {
                  break;
               }
               _loc2_ -= 16;
               si32(_loc8_,_loc2_ + 8);
               si32(_loc5_,_loc2_ + 4);
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               F__swrite();
               _loc2_ += 16;
               if((_loc6_ = eax) <= 0)
               {
                  si16(_loc7_ = (_loc7_ = li16(_loc1_ + 12)) | 64,_loc1_ + 12);
                  _loc6_ = -1;
                  break;
               }
               _loc5_ += _loc6_;
               _loc8_ -= _loc6_;
            }
         }
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
