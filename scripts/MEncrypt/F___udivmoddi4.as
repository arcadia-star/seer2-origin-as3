package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___udivmoddi4() : void
   {
      var _loc10_:* = 0;
      var _loc22_:* = 0;
      var _loc19_:* = 0;
      var _loc9_:int = 0;
      var _loc3_:int = 0;
      var _loc2_:int = 0;
      var _loc1_:* = 0;
      var _loc20_:* = 0;
      var _loc11_:* = 0;
      var _loc21_:* = 0;
      var _loc17_:* = 0;
      var _loc4_:int = 0;
      var _loc8_:int = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc5_:*;
      _loc6_ = li32((_loc10_ = _loc5_ = ESP) + 12);
      _loc22_ = li32(_loc10_ + 8);
      _loc21_ = li32(_loc10_ + 4);
      _loc20_ = li32(_loc10_);
      _loc19_ = li32(_loc10_ + 16);
      if(_loc21_ == 0)
      {
         if(_loc6_ == 0)
         {
            if(_loc19_ != 0)
            {
               si32(0,_loc19_ + 4);
               var _loc18_:*;
               si32(_loc18_ = uint(_loc20_) % uint(_loc22_),_loc19_);
            }
            _loc6_ = uint(_loc20_) / uint(_loc22_);
            _loc17_ = 0;
         }
         else
         {
            _loc17_ = _loc6_ = 0;
            if(_loc19_ != 0)
            {
               si32(_loc6_ = 0,_loc19_ + 4);
               si32(_loc20_,_loc19_);
               _loc17_ = _loc6_;
            }
         }
      }
      else
      {
         if(_loc22_ == 0)
         {
            if(_loc6_ == 0)
            {
               if(_loc19_ != 0)
               {
                  si32(0,_loc19_ + 4);
                  si32(_loc18_ = uint(_loc21_) % uint(_loc22_),_loc19_);
               }
               _loc6_ = uint(_loc21_) / uint(_loc22_);
               _loc17_ = 0;
            }
            else if(_loc20_ == 0)
            {
               if(_loc19_ != 0)
               {
                  si32(0,_loc19_);
                  si32(_loc18_ = uint(_loc21_) % uint(_loc6_),_loc19_ + 4);
               }
               _loc6_ = uint(_loc21_) / uint(_loc6_);
               _loc17_ = 0;
            }
            else if((_loc18_ = (_loc17_ = _loc6_ + -1) & _loc6_) == 0)
            {
               if(_loc19_ != 0)
               {
                  si32(_loc20_,_loc19_);
                  si32(_loc18_ = _loc17_ & _loc21_,_loc19_ + 4);
               }
               _loc18_ = _loc6_ + -1;
               var _loc16_:* = (_loc16_ = (_loc18_ = (_loc16_ = _loc6_ ^ -1) & _loc18_) >>> 1) & 1431655765;
               _loc18_ = (_loc16_ = _loc18_ - _loc16_) & 858993459;
               _loc16_ = (_loc16_ >>>= 2) & 858993459;
               _loc18_ = (_loc16_ = _loc18_ + _loc16_) >>> 4;
               _loc18_ = (_loc18_ = (_loc18_ = (_loc18_ = _loc16_ + _loc18_) & 252645135) * 16843009) >>> 24;
               _loc6_ = _loc21_ >>> _loc18_;
               _loc17_ = 0;
            }
            else
            {
               var _loc15_:*;
               _loc1_ = ((_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc16_ = _loc18_ - ((_loc16_ = (_loc18_ = (_loc18_ = _loc16_ | (_loc16_ |= (_loc16_ |= (_loc16_ |= (_loc16_ = _loc6_ | _loc6_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc16_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) - ((_loc16_ = (_loc16_ = (_loc16_ += (_loc16_ = ((_loc15_ = _loc16_ - ((_loc15_ = (_loc16_ = (_loc16_ |= (_loc16_ = _loc15_ | (_loc15_ = _loc16_ | (_loc16_ |= (_loc16_ = _loc21_ | _loc21_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc15_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24);
               if(uint(_loc1_) >= 31)
               {
                  _loc17_ = _loc6_ = 0;
                  if(_loc19_ != 0)
                  {
                     si32(_loc20_,_loc19_);
                     si32(_loc21_,_loc19_ + 4);
                     _loc17_ = _loc6_ = 0;
                  }
                  §§goto(addr1498);
               }
               else
               {
                  _loc17_ = _loc1_ + 1;
                  _loc16_ = 31 - _loc1_;
                  _loc1_ = (_loc15_ = _loc21_ << _loc16_) | _loc20_ >>> _loc17_;
                  _loc21_ >>>= _loc17_;
                  _loc11_ = _loc20_ << _loc16_;
                  _loc20_ = 0;
               }
            }
         }
         else if(_loc6_ == 0)
         {
            _loc1_ = _loc22_ + -1;
            if((_loc18_ = _loc1_ & _loc22_) == 0)
            {
               if(_loc19_ != 0)
               {
                  si32(0,_loc19_ + 4);
                  si32(_loc18_ = _loc1_ & _loc20_,_loc19_);
               }
               _loc6_ = _loc20_;
               _loc17_ = _loc21_;
               if(_loc22_ != 1)
               {
                  _loc16_ = ((_loc16_ = _loc18_ - ((_loc16_ = (_loc18_ = (_loc18_ = _loc22_ ^ -1) & _loc1_) >>> 1) & 1431655765)) & 858993459) + ((_loc16_ >>>= 2) & 858993459);
                  _loc16_ = (_loc18_ = (_loc18_ = (_loc18_ = _loc16_ + (_loc16_ >>> 4)) & 252645135) * 16843009) >>> 24;
                  _loc6_ = (_loc15_ = _loc21_ << 32 - _loc16_) | _loc20_ >>> _loc16_;
                  _loc17_ = _loc21_ >>> _loc16_;
               }
               §§goto(addr1498);
            }
            else
            {
               var _loc12_:* = (_loc16_ = ((_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc16_ = _loc18_ - ((_loc16_ = (_loc18_ = (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ |= (_loc18_ = _loc22_ | _loc22_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc16_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) - ((_loc16_ = (_loc16_ = (_loc16_ += (_loc16_ = ((_loc15_ = _loc16_ - ((_loc15_ = (_loc16_ = (_loc16_ |= (_loc16_ |= (_loc16_ |= (_loc16_ |= (_loc16_ = _loc21_ | _loc21_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc15_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24)) + 1;
               _loc15_ = _loc16_ ^ -1;
               _loc17_ = _loc16_ + 33;
               var _loc14_:*;
               _loc1_ = (_loc14_ = ((_loc18_ = _loc20_ >>> _loc17_) | _loc21_ << _loc15_) & (_loc18_ = _loc12_ >> 31)) | _loc21_ >>> _loc12_ & (_loc15_ = -2 - _loc16_) >> 31;
               _loc16_ = 31 - _loc16_;
               _loc11_ = (_loc12_ = ((_loc14_ = _loc21_ << _loc16_) | _loc20_ >>> _loc12_) & (_loc15_ >>= 31)) | _loc20_ << _loc15_ & _loc16_ >> 31;
               _loc21_ = (_loc12_ = _loc21_ >>> _loc17_) & _loc18_;
               _loc20_ = (_loc18_ = _loc20_ << _loc16_) & _loc15_;
            }
         }
         else
         {
            _loc1_ = (_loc16_ = (_loc16_ = (_loc16_ = (_loc16_ += (_loc16_ = ((_loc15_ = _loc16_ - ((_loc15_ = (_loc16_ = (_loc16_ |= (_loc16_ |= (_loc16_ |= (_loc16_ = _loc15_ | (_loc15_ = _loc6_ | _loc6_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc15_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24) - ((_loc18_ = (_loc18_ = (_loc18_ += (_loc18_ = ((_loc16_ = _loc18_ - ((_loc16_ = (_loc18_ = (_loc18_ = _loc16_ | (_loc16_ = _loc18_ | (_loc18_ |= (_loc18_ |= (_loc18_ = _loc21_ | _loc21_ >>> 1) >>> 2) >>> 4) >>> 8) >>> 16) ^ -1) >>> 1) & 1431655765)) & 858993459) + ((_loc16_ >>>= 2) & 858993459)) >>> 4) & 252645135) * 16843009) >>> 24);
            if(uint(_loc1_) >= 32)
            {
               _loc17_ = _loc6_ = 0;
               if(_loc19_ != 0)
               {
                  si32(_loc20_,_loc19_);
                  si32(_loc21_,_loc19_ + 4);
                  _loc17_ = _loc6_ = 0;
               }
               §§goto(addr1498);
            }
            else
            {
               _loc18_ = 31 - _loc1_;
               _loc17_ = _loc1_ + 1;
               _loc1_ = (_loc12_ = _loc20_ >>> _loc17_ & (_loc15_ = (_loc15_ = _loc1_ + -31) >> 31)) | _loc21_ << _loc18_;
               _loc11_ = _loc20_ << _loc18_;
               _loc21_ = (_loc18_ = _loc21_ >>> _loc17_) & _loc15_;
               _loc20_ = 0;
            }
         }
         §§goto(addr1498);
         _loc16_ = _loc20_ >>> 31;
         _loc17_ = (_loc18_ = (_loc18_ = _loc11_ << 1) | _loc16_) | _loc7_;
         if(_loc19_ != 0)
         {
            si32(_loc1_,_loc19_);
            si32(_loc21_,_loc19_ + 4);
         }
      }
      addr1498:
      eax = _loc6_;
      edx = _loc17_;
      ESP = _loc5_ = _loc10_;
   }
}
