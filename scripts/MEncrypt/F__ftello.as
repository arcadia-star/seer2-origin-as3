package MEncrypt
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public function F__ftello() : void
   {
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      var _loc12_:*;
      if((_loc12_ = li32(_loc1_ + 40)) == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(29,eax);
         _loc11_ = 1;
      }
      else
      {
         _loc10_ = li32(_loc3_ + 4);
         if((_loc12_ = (_loc9_ = li16(_loc1_ + 12)) & 4096) != 0)
         {
            _loc8_ = li32(_loc1_ + 84);
            _loc7_ = li32(_loc1_ + 80);
            addr143:
            if((_loc12_ = _loc9_ & 4) != 0)
            {
               _loc11_ = _loc1_ + 4;
               _loc6_ = li32(_loc1_ + 48);
               _loc5_ = _loc11_;
               if(_loc6_ != 0)
               {
                  _loc5_ = _loc1_ + 60;
               }
               _loc5_ = li32(_loc5_);
               _loc4_ = 1;
               if(uint(_loc7_) >= uint(_loc5_))
               {
                  _loc4_ = 0;
               }
               _loc12_ = _loc5_ >> 31;
               if((_loc8_ = (_loc12_ = _loc8_ - _loc12_) - _loc4_) <= -1)
               {
                  si16(_loc12_ = _loc9_ | 64,_loc1_ + 12);
                  ESP = _loc2_;
                  F___error();
                  si32(5,eax);
                  _loc11_ = 1;
                  §§goto(addr388);
               }
               else
               {
                  _loc7_ -= _loc5_;
                  if(_loc6_ != 0)
                  {
                     _loc11_ = li32(_loc11_);
                     _loc1_ = 1;
                     if(uint(_loc7_) >= uint(_loc11_))
                     {
                        _loc1_ = 0;
                     }
                     _loc12_ = _loc11_ >> 31;
                     _loc8_ = (_loc12_ = _loc8_ - _loc12_) - _loc1_;
                     _loc7_ -= _loc11_;
                  }
               }
               §§goto(addr388);
            }
            else if((_loc12_ = (_loc12_ = _loc9_ & 65535) & 8) != 0)
            {
               if((_loc11_ = li32(_loc1_)) != 0)
               {
                  _loc1_ = _loc11_ - li32(_loc1_ + 16);
                  _loc11_ = 1;
                  if((uint(_loc1_ ^ -1)) < uint(_loc7_))
                  {
                     _loc11_ = 0;
                  }
                  if(_loc8_ != 2147483647)
                  {
                     _loc11_ = 1;
                  }
                  if(_loc11_ == 0)
                  {
                     ESP = _loc2_;
                     F___error();
                     si32(84,eax);
                     _loc11_ = 1;
                     §§goto(addr388);
                  }
                  else
                  {
                     _loc9_ = _loc1_ + _loc7_;
                     _loc11_ = _loc6_ = 1;
                     if(uint(_loc9_) >= uint(_loc1_))
                     {
                        _loc11_ = 0;
                     }
                     if(uint(_loc9_) >= uint(_loc7_))
                     {
                        _loc6_ = _loc11_;
                     }
                     _loc8_ = (_loc12_ = 0 + _loc8_) + _loc6_;
                     _loc7_ = _loc9_;
                  }
                  §§goto(addr388);
               }
            }
            si32(_loc7_,_loc10_);
            si32(_loc8_,_loc10_ + 4);
            _loc11_ = 0;
         }
         else
         {
            _loc2_ -= 16;
            si32(_loc11_ = 1,_loc2_ + 12);
            si32(0,_loc2_ + 8);
            si32(0,_loc2_ + 4);
            si32(_loc1_,_loc2_);
            ESP = _loc2_;
            F__sseek();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc8_ = edx;
            if((_loc12_ = _loc7_ & _loc8_) != -1)
            {
               _loc9_ = li16(_loc1_ + 12);
               §§goto(addr143);
            }
         }
      }
      addr388:
      eax = _loc11_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
