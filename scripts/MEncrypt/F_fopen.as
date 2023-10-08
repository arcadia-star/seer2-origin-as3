package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_fopen() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:int = 0;
      var _loc7_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc9_ = si8(li8(_loc1_));
      _loc8_ = li32(_loc3_);
      if(_loc9_ != 97)
      {
         _loc7_ = 0;
         _loc6_ = 4;
         _loc5_ = _loc7_;
         if(_loc9_ != 114)
         {
            if(_loc9_ == 119)
            {
               _loc5_ = 1536;
               _loc7_ = 1;
               _loc6_ = 8;
               addr85:
               if((_loc9_ = li8(_loc1_ + 1)) != 43)
               {
                  if(_loc9_ == 98)
                  {
                     var _loc4_:*;
                     if((_loc4_ = li8(_loc1_ + 2)) == 43)
                     {
                        addr107:
                        _loc7_ = 2;
                        _loc6_ = 16;
                     }
                  }
                  ESP = _loc2_;
                  F___sfp();
                  _loc9_ = 0;
                  _loc1_ = eax;
                  if(_loc1_ != 0)
                  {
                     _loc5_ = _loc7_ | _loc5_;
                     _loc2_ -= 16;
                     si32(438,_loc2_ + 8);
                     si32(_loc5_,_loc2_ + 4);
                     si32(_loc8_,_loc2_);
                     ESP = _loc2_;
                     F__open();
                     _loc2_ += 16;
                     if((_loc8_ = eax) <= -1)
                     {
                        si16(_loc9_ = 0,_loc1_ + 12);
                     }
                     else if(_loc8_ >= 32768)
                     {
                        si16(_loc9_ = 0,_loc1_ + 12);
                        _loc2_ -= 16;
                        si32(_loc8_,_loc2_);
                        ESP = _loc2_;
                        F__close();
                        _loc2_ += 16;
                        ESP = _loc2_;
                        F___error();
                        si32(24,eax);
                     }
                     else
                     {
                        si16(_loc8_,_loc1_ + 14);
                        si16(_loc6_,_loc1_ + 12);
                        si32(_loc1_,_loc1_ + 28);
                        si32(___sread,_loc1_ + 36);
                        si32(___swrite,_loc1_ + 44);
                        si32(___sseek,_loc1_ + 40);
                        si32(___sclose,_loc1_ + 32);
                        _loc9_ = _loc1_;
                        if((_loc5_ & 8) != 0)
                        {
                           _loc2_ -= 16;
                           si32(2,_loc2_ + 12);
                           si32(0,_loc2_ + 8);
                           si32(0,_loc2_ + 4);
                           si32(_loc1_,_loc2_);
                           ESP = _loc2_;
                           F__sseek();
                           _loc2_ += 16;
                           _loc9_ = _loc1_;
                        }
                     }
                  }
                  §§goto(addr305);
               }
               §§goto(addr107);
            }
            else
            {
               ESP = _loc2_;
               F___error();
               si32(22,eax);
               _loc9_ = 0;
            }
            addr305:
            eax = _loc9_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      else
      {
         _loc5_ = 520;
         _loc7_ = 1;
         _loc6_ = 8;
      }
      §§goto(addr85);
   }
}
