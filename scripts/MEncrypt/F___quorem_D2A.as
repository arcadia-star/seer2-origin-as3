package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___quorem_D2A() : void
   {
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc22_:* = 0;
      var _loc9_:* = 0;
      var _loc23_:* = 0;
      var _loc24_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:int = 0;
      var _loc15_:* = 0;
      var _loc4_:* = 0;
      var _loc17_:* = 0;
      var _loc13_:* = 0;
      var _loc2_:int = 0;
      var _loc11_:int = 0;
      var _loc3_:int = 0;
      var _loc8_:int = 0;
      var _loc7_:int = 0;
      var _loc1_:* = 0;
      var _loc20_:* = 0;
      var _loc21_:int = 0;
      var _loc5_:*;
      _loc24_ = li32((_loc6_ = li32(_loc10_ = _loc5_ = ESP)) + 16);
      _loc22_ = li32((_loc23_ = li32(_loc10_ + 4)) + 16);
      _loc21_ = 0;
      if(_loc24_ >= _loc22_)
      {
         var _loc19_:* = (_loc20_ = _loc22_ + -1) << 2;
         var _loc16_:* = (_loc16_ = li32((_loc19_ = _loc23_ + _loc19_) + 20)) + 1;
         var _loc18_:*;
         _loc21_ = uint(li32((_loc18_ = _loc6_ + _loc19_) + 20)) / uint(_loc16_);
         _loc1_ = _loc19_ + 20;
         if(_loc21_ != 0)
         {
            _loc11_ = _loc6_ + 20;
            _loc24_ = _loc23_ + 20;
            _loc12_ = 0;
            _loc14_ = 0;
            _loc15_ = 0;
            _loc4_ = 0;
            do
            {
               _loc5_ -= 16;
               si32(_loc21_,_loc5_ + 8);
               si32(0,_loc5_ + 4);
               si32(0,_loc5_ + 12);
               si32(_loc18_ = li32(_loc24_),_loc5_);
               ESP = _loc5_;
               F___muldi3();
               _loc5_ += 16;
               _loc18_ = eax;
               _loc7_ = edx;
               _loc8_ = _loc18_ + _loc15_;
               _loc3_ = (_loc9_ = li32(_loc11_)) - _loc8_;
               si32(_loc19_ = _loc3_ - _loc12_,_loc11_);
               _loc2_ = 1;
               _loc17_ = _loc2_;
               if(uint(_loc8_) >= uint(_loc18_))
               {
                  _loc17_ = 0;
               }
               _loc13_ = _loc2_;
               if(uint(_loc8_) >= uint(_loc15_))
               {
                  _loc13_ = _loc17_;
               }
               _loc17_ = _loc2_;
               if(uint(_loc3_) >= uint(_loc12_))
               {
                  _loc17_ = 0;
               }
               if(uint(_loc9_) >= uint(_loc8_))
               {
                  _loc2_ = 0;
               }
               _loc15_ = (_loc18_ = _loc7_ + _loc4_) + _loc13_;
               _loc12_ = (_loc18_ = (_loc18_ = (_loc18_ = 0 - _loc2_) - _loc14_) - _loc17_) & 1;
               _loc11_ += 4;
               _loc24_ += 4;
               _loc14_ = 0;
               _loc4_ = 0;
            }
            while(uint(_loc24_) <= uint(_loc1_));
            
            _loc24_ = _loc22_ << 2;
            if((_loc18_ = li32((_loc18_ = _loc6_ + _loc24_) + 16)) != 0)
            {
               _loc24_ = li32(_loc6_ + 16);
            }
            else
            {
               _loc20_ = _loc6_ + 20;
               _loc11_ = (_loc18_ = _loc24_ + _loc6_) + 12;
               _loc24_ = _loc22_ + -1;
               while(uint(_loc11_) > uint(_loc20_))
               {
                  if((_loc18_ = li32(_loc11_)) != 0)
                  {
                     break;
                  }
                  _loc24_ += -1;
                  _loc11_ += -4;
               }
               si32(_loc24_,_loc6_ + 16);
               _loc20_ = _loc24_;
            }
         }
         _loc22_ = li32(_loc23_ + 16);
         if(_loc24_ != _loc22_)
         {
            _loc11_ = _loc24_ - _loc22_;
            §§goto(addr458);
         }
         else
         {
            _loc3_ = (_loc18_ = (_loc19_ = _loc22_ << 2) + _loc6_) + 20;
            _loc11_ = (_loc18_ = _loc19_ + _loc23_) + 16;
            _loc9_ = _loc6_ + 20;
            while(true)
            {
               _loc24_ = li32(_loc11_);
               if((_loc22_ = li32(_loc3_ - 4)) == _loc24_)
               {
                  _loc3_ += -4;
                  _loc11_ += -4;
                  if(uint(_loc3_) <= uint(_loc9_))
                  {
                     break;
                  }
                  continue;
               }
               _loc11_ = -1;
               if(uint(_loc22_) >= uint(_loc24_))
               {
                  _loc11_ = 1;
               }
               §§goto(addr458);
            }
         }
         _loc22_ = _loc6_ + 20;
         _loc3_ = _loc23_ + 20;
         _loc4_ = 0;
         _loc9_ = 0;
         _loc8_ = 0;
         _loc7_ = 0;
         do
         {
            _loc23_ = (_loc19_ = li32(_loc3_)) + _loc8_;
            si32(_loc18_ = (_loc11_ = (_loc24_ = li32(_loc22_)) - _loc23_) - _loc4_,_loc22_);
            _loc2_ = 1;
            _loc15_ = _loc2_;
            if(uint(_loc23_) >= uint(_loc19_))
            {
               _loc15_ = 0;
            }
            _loc12_ = _loc2_;
            if(uint(_loc23_) >= uint(_loc8_))
            {
               _loc12_ = _loc15_;
            }
            _loc15_ = _loc2_;
            if(uint(_loc11_) >= uint(_loc4_))
            {
               _loc15_ = 0;
            }
            if(uint(_loc24_) >= uint(_loc23_))
            {
               _loc2_ = 0;
            }
            _loc8_ = _loc7_ + _loc12_;
            _loc4_ = (_loc18_ = (_loc18_ = (_loc18_ = 0 - _loc2_) - _loc9_) - _loc15_) & 1;
            _loc22_ += 4;
            _loc3_ += 4;
            _loc9_ = 0;
            _loc7_ = 0;
         }
         while(uint(_loc3_) <= uint(_loc1_));
         
         _loc1_ = _loc20_ << 2;
         _loc21_ += 1;
         if(li32(_loc18_ = (_loc23_ = _loc6_ + 20) + _loc1_) == 0)
         {
            _loc22_ = _loc6_ + 16;
            while((uint(_loc18_ = _loc22_ + _loc1_)) > uint(_loc23_))
            {
               if((_loc18_ = li32(_loc18_ = _loc22_ + (_loc20_ << 2))) != 0)
               {
                  break;
               }
               _loc1_ += -4;
               _loc20_ += -1;
            }
            si32(_loc20_,_loc6_ + 16);
         }
      }
      addr458:
      if(_loc11_ >= 0)
      {
      }
      eax = _loc21_;
      ESP = _loc5_ = _loc10_;
   }
}
