package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___swbuf() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      si32(_loc8_ = li32(_loc1_ + 24),_loc1_ + 8);
      _loc8_ = (_loc7_ = li16(_loc1_ + 12)) & 8;
      _loc6_ = li32(_loc3_);
      if(_loc8_ != 0)
      {
         if((_loc8_ = li32(_loc1_ + 16)) == 0)
         {
            if((_loc8_ = _loc7_ & 512) == 0)
            {
               addr70:
               _loc2_ -= 16;
               si32(_loc1_,_loc2_);
               ESP = _loc2_;
               F___swsetup();
               _loc5_ = -1;
               _loc2_ += 16;
               if((_loc8_ = eax) == 0)
               {
                  addr98:
                  if((_loc8_ = li32(_loc1_ + 100)) == 0)
                  {
                     si32(-1,_loc1_ + 100);
                  }
                  _loc7_ = _loc6_ & 255;
                  _loc8_ = li32(_loc1_ + 16);
                  _loc4_ = (_loc5_ = li32(_loc1_)) - _loc8_;
                  if((_loc8_ = li32(_loc1_ + 20)) > _loc4_)
                  {
                     _loc4_ += 1;
                     addr180:
                     si32(_loc8_ = (_loc8_ = li32(_loc1_ + 8)) + -1,_loc1_ + 8);
                     si8(_loc6_,_loc5_);
                     si32(_loc8_ = _loc5_ + 1,_loc1_);
                     _loc8_ = li32(_loc1_ + 20);
                     if(_loc4_ != _loc8_)
                     {
                        if((_loc8_ = (_loc8_ = li16(_loc1_ + 12)) & 1) != 0)
                        {
                           if(_loc7_ == 10)
                           {
                              addr232:
                              _loc2_ -= 16;
                              si32(_loc1_,_loc2_);
                              ESP = _loc2_;
                              F___fflush();
                              _loc5_ = -1;
                              _loc2_ += 16;
                              if((_loc8_ = eax) == 0)
                              {
                              }
                              §§goto(addr263);
                           }
                        }
                        _loc5_ = _loc7_;
                        addr263:
                        eax = _loc5_;
                        _loc2_ = _loc3_;
                        ESP = _loc2_;
                        return;
                     }
                     §§goto(addr232);
                  }
                  else
                  {
                     _loc2_ -= 16;
                     si32(_loc1_,_loc2_);
                     ESP = _loc2_;
                     F___fflush();
                     _loc5_ = -1;
                     _loc2_ += 16;
                     if((_loc8_ = eax) == 0)
                     {
                        _loc5_ = li32(_loc1_);
                        _loc4_ = 1;
                        §§goto(addr180);
                     }
                  }
               }
               §§goto(addr232);
            }
         }
         §§goto(addr98);
      }
      §§goto(addr70);
   }
}
