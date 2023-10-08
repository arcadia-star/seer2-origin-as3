package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___hexnan_D2A() : void
   {
      var _loc8_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc14_:* = 0;
      var _loc1_:int = 0;
      var _loc12_:* = 0;
      var _loc2_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc16_:* = 0;
      var _loc5_:* = 0;
      var _loc19_:* = 0;
      var _loc18_:* = 0;
      var _loc17_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc20_:* = 0;
      var _loc3_:* = ESP;
      _loc8_ = _loc3_;
      var _loc4_:*;
      if((_loc4_ = li8(___hexdig_D2A + 48)) == 0)
      {
         si8(16,___hexdig_D2A + 48);
         si8(17,___hexdig_D2A + 49);
         si8(18,___hexdig_D2A + 50);
         si8(19,___hexdig_D2A + 51);
         si8(20,___hexdig_D2A + 52);
         si8(21,___hexdig_D2A + 53);
         si8(22,___hexdig_D2A + 54);
         si8(23,___hexdig_D2A + 55);
         si8(24,___hexdig_D2A + 56);
         si8(25,___hexdig_D2A + 57);
         si8(26,___hexdig_D2A + 97);
         si8(27,___hexdig_D2A + 98);
         si8(28,___hexdig_D2A + 99);
         si8(29,___hexdig_D2A + 100);
         si8(30,___hexdig_D2A + 101);
         si8(31,___hexdig_D2A + 102);
         si8(26,___hexdig_D2A + 65);
         si8(27,___hexdig_D2A + 66);
         si8(28,___hexdig_D2A + 67);
         si8(29,___hexdig_D2A + 68);
         si8(30,___hexdig_D2A + 69);
         si8(31,___hexdig_D2A + 70);
      }
      _loc19_ = (_loc20_ = li32(_loc4_ = li32(_loc8_ + 4))) & 31;
      _loc18_ = 1;
      _loc17_ = 0;
      if(_loc19_ == _loc17_)
      {
         _loc18_ = _loc17_;
      }
      _loc16_ = li32(_loc8_ + 8);
      _loc15_ = li32(_loc8_);
      _loc14_ = _loc18_ & 1;
      _loc4_ = (_loc4_ = (_loc4_ = (_loc13_ = _loc20_ >> 5) + _loc14_) << 2) + _loc16_;
      si32(_loc17_,_loc4_ - 4);
      _loc1_ = _loc4_ + -4;
      _loc4_ = li8((_loc18_ = li32(_loc15_)) + 1);
      _loc9_ = _loc1_;
      _loc10_ = _loc17_;
      _loc11_ = _loc17_;
      if(_loc4_ == 48)
      {
         _loc17_ = 0;
         _loc9_ = _loc1_;
         _loc10_ = _loc17_;
         _loc11_ = _loc17_;
         if(((_loc4_ = (_loc4_ = li8(_loc18_ + 2)) | 32) & 255) == 120)
         {
            _loc18_ += 2;
            _loc17_ = 0;
            _loc9_ = _loc1_;
            _loc10_ = _loc17_;
            _loc11_ = _loc17_;
         }
      }
      loop0:
      while(true)
      {
         if(uint(_loc9_) <= uint(_loc16_))
         {
            _loc20_ = _loc18_ + 1;
            _loc6_ = 0;
            while(true)
            {
               _loc12_ = li8(_loc4_ = _loc20_ + _loc6_);
               _loc5_ = 0;
               if(_loc12_ == 0)
               {
                  break;
               }
               _loc2_ = li8(_loc4_ = ___hexdig_D2A + _loc12_);
               _loc5_ = _loc12_;
               if(_loc2_ == 0)
               {
                  break;
               }
               _loc6_ += 1;
               if((_loc5_ = _loc11_ + _loc6_) <= 8)
               {
                  _loc10_ += _loc6_;
                  _loc18_ += _loc6_;
                  _loc11_ = _loc5_;
                  continue loop0;
               }
            }
            _loc20_ = (_loc4_ = _loc18_ + _loc6_) + 1;
            break;
         }
         _loc12_ = li8(_loc18_ + 1);
         _loc20_ = _loc18_ + 1;
         _loc6_ = _loc5_ = 0;
         if(_loc12_ == 0)
         {
            break;
         }
         _loc2_ = li8(_loc4_ = ___hexdig_D2A + _loc12_);
         _loc6_ = 0;
         _loc5_ = _loc12_;
         if(_loc2_ == 0)
         {
            break;
         }
         _loc10_ += 1;
         _loc11_ += 1;
         _loc18_ = _loc20_;
         if(_loc11_ > 8)
         {
            si32(_loc17_ = 0,_loc9_ - 4);
            _loc9_ += -4;
            _loc11_ = 1;
            _loc18_ = _loc20_;
         }
      }
      _loc2_ = _loc6_ + _loc10_;
      if(_loc2_ != 0)
      {
         if(uint(_loc9_) < uint(_loc1_))
         {
            if((_loc11_ = _loc6_ + _loc11_) <= 7)
            {
               _loc10_ = (_loc4_ = 8 - _loc11_) << 2;
               _loc11_ = 32 - _loc10_;
               _loc12_ = _loc9_;
               do
               {
                  var _loc7_:*;
                  si32(_loc7_ = (_loc7_ = (_loc4_ = li32(_loc12_ + 4)) << _loc11_) | _loc17_,_loc12_);
                  si32(_loc17_ = _loc4_ >>> _loc10_,_loc12_ + 4);
               }
               while((uint(_loc12_ += 4)) < uint(_loc1_));
               
            }
         }
      }
      _loc11_ = -1;
      _loc17_ = 1;
      _loc10_ = _loc16_;
      if(uint(_loc9_) > uint(_loc16_))
      {
         do
         {
            si32(_loc4_ = li32(_loc9_),_loc10_);
            _loc10_ += 4;
            _loc9_ += 4;
            _loc17_ += 1;
            _loc11_ += 1;
         }
         while(uint(_loc9_) <= uint(_loc1_));
         
         _loc3_ -= 16;
         si32(0,_loc3_ + 4);
         si32(_loc10_,_loc3_);
         _loc19_ = _loc14_ + _loc13_;
         if(_loc17_ <= _loc19_)
         {
            _loc17_ = _loc19_;
         }
         _loc4_ = _loc11_ ^ -1;
         si32(_loc4_ = (_loc4_ = _loc17_ + _loc4_) << 2,_loc3_ + 8);
         ESP = _loc3_;
         Fmemset();
         _loc3_ += 16;
      }
      else if(_loc19_ != 0)
      {
         si32(_loc4_ = (_loc7_ = li32(_loc1_)) & -1 >>> 32 - _loc19_,_loc1_);
      }
      if(_loc2_ != 0)
      {
         _loc4_ = (_loc4_ = _loc14_ + _loc13_) << 2;
         _loc19_ = 4 - _loc4_;
         _loc16_ = (_loc4_ += _loc16_) + -4;
         while((_loc4_ = li32(_loc16_)) == 0)
         {
            if(_loc19_ == 0)
            {
               si32(1,_loc16_);
               break;
            }
            _loc19_ += 4;
            _loc16_ += -4;
         }
      }
      if(_loc5_ != 0)
      {
         if(_loc5_ != 41)
         {
            _loc20_ = (_loc4_ = _loc6_ + _loc18_) + 2;
            _loc16_ = li32(__CurrentRuneLocale);
            _loc18_ = li32(___mb_sb_limit);
            while((_loc5_ = li8(_loc20_)) != 0)
            {
               if(_loc5_ == 41)
               {
                  break;
               }
               _loc6_ = 1;
               if(_loc18_ > _loc5_)
               {
                  _loc6_ = 1;
                  if(((_loc4_ = li8((_loc4_ = _loc16_ + (_loc5_ << 2)) + 53)) & 5) != 0)
                  {
                     _loc6_ = 0;
                  }
               }
               _loc20_ += 1;
               if((_loc4_ = _loc6_ & 1) != 0)
               {
                  if(_loc5_ != 95)
                  {
                     §§goto(addr799);
                  }
               }
            }
         }
         si32(_loc4_ = _loc20_ + 1,_loc15_);
      }
      addr799:
      eax = 5;
      _loc3_ = _loc8_;
      ESP = _loc3_;
   }
}
