package cmodule.desc
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM___qdivrem extends Machine
   {
       
      
      public function FSM___qdivrem()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 48;
         _loc1_ = mstate.ebp + -48;
         _loc2_ = li32(mstate.ebp + 24);
         _loc3_ = li32(mstate.ebp + 8);
         _loc4_ = li32(mstate.ebp + 12);
         _loc5_ = li32(mstate.ebp + 16);
         _loc6_ = li32(mstate.ebp + 20);
         _loc7_ = mstate.ebp + -32;
         _loc8_ = mstate.ebp + -16;
         if((_loc9_ = _loc5_ | _loc6_) == 0)
         {
            if(_loc2_ == 0)
            {
               _loc1_ = 0;
               _loc1_ = uint(1) / uint(_loc1_);
               _loc2_ = _loc1_;
               addr1663:
               mstate.edx = _loc2_;
            }
            else
            {
               _loc1_ = 0;
               si32(_loc3_,_loc2_);
               si32(_loc4_,_loc2_ + 4);
               _loc1_ = uint(1) / uint(_loc1_);
               addr264:
               mstate.edx = _loc1_;
            }
            §§goto(addr1667);
         }
         else
         {
            _loc9_ = uint(_loc4_) >= uint(_loc6_) ? 1 : 0;
            _loc10_ = uint(_loc3_) >= uint(_loc5_) ? 1 : 0;
            if((_loc9_ = (_loc11_ = _loc4_ == _loc6_ ? 1 : 0) != 0 ? _loc10_ : _loc9_) == 0)
            {
               if(_loc2_ == 0)
               {
                  _loc1_ = 0;
                  _loc2_ = _loc1_;
                  §§goto(addr1663);
               }
               else
               {
                  _loc1_ = 0;
                  si32(_loc3_,_loc2_);
                  si32(_loc4_,_loc2_ + 4);
                  §§goto(addr264);
               }
               mstate.esp += 4;
               mstate.esp += 4;
               return;
            }
            si16(_loc9_ = 0,mstate.ebp + -16);
            si16(_loc9_ = _loc4_ >>> 16,mstate.ebp + -14);
            si16(_loc4_,mstate.ebp + -12);
            si16(_loc10_ = _loc3_ >>> 16,mstate.ebp + -10);
            si16(_loc3_,mstate.ebp + -8);
            si16(_loc11_ = _loc6_ >>> 16,mstate.ebp + -30);
            si16(_loc6_,mstate.ebp + -28);
            _loc6_ = _loc5_ >>> 16;
            _loc12_ = mstate.ebp + -16;
            si16(_loc6_,mstate.ebp + -26);
            si16(_loc5_,mstate.ebp + -24);
            _loc5_ = _loc12_ + 8;
            _loc6_ = _loc12_ + 6;
            _loc13_ = _loc12_ + 4;
            _loc14_ = _loc12_ + 2;
            _loc15_ = mstate.ebp + -32;
            _loc16_ = _loc9_;
            if(_loc11_ != 0)
            {
               _loc3_ = 4;
               _loc4_ = _loc15_;
            }
            else
            {
               _loc11_ = 0;
               _loc7_ += 4;
               _loc15_ = _loc11_;
               while(true)
               {
                  _loc17_ = _loc7_;
                  if((_loc18_ = _loc15_ + 3) == 1)
                  {
                     _loc1_ = mstate.ebp + -32;
                     _loc1_ = (_loc7_ = _loc11_ << 1) + _loc1_;
                     _loc1_ = li16(_loc1_ + 4);
                     _loc7_ = uint(_loc9_) % uint(_loc1_);
                     _loc4_ &= 65535;
                     _loc7_ <<= 16;
                     _loc4_ |= _loc7_;
                     _loc7_ = (_loc7_ = uint(_loc4_) % uint(_loc1_)) << 16;
                     _loc7_ = _loc10_ | _loc7_;
                     _loc11_ = uint(_loc7_) % uint(_loc1_);
                     _loc3_ &= 65535;
                     _loc11_ <<= 16;
                     _loc3_ |= _loc11_;
                     _loc11_ = uint(_loc3_) / uint(_loc1_);
                     _loc7_ = uint(_loc7_) / uint(_loc1_);
                     _loc4_ = uint(_loc4_) / uint(_loc1_);
                     _loc15_ = uint(_loc9_) / uint(_loc1_);
                     if(_loc2_ != 0)
                     {
                        _loc5_ = 0;
                        _loc1_ = uint(_loc3_) % uint(_loc1_);
                        si32(_loc1_,_loc2_);
                        si32(_loc5_,_loc2_ + 4);
                     }
                     _loc1_ = _loc11_ & 65535;
                     _loc2_ = _loc7_ << 16;
                     _loc3_ = _loc4_ & 65535;
                     _loc4_ = _loc15_ << 16;
                     _loc1_ |= _loc2_;
                     _loc2_ = _loc3_ | _loc4_;
                     break;
                  }
                  _loc17_ = li16(_loc17_);
                  _loc7_ += 2;
                  _loc15_ += -1;
                  _loc11_ += 1;
                  if(_loc17_ == 0)
                  {
                     continue;
                  }
                  _loc3_ = mstate.ebp + -32;
                  _loc4_ = _loc11_ << 1;
                  _loc7_ = _loc15_ + 4;
                  _loc4_ = _loc3_ + _loc4_;
                  _loc3_ = _loc7_;
               }
               §§goto(addr1663);
            }
            _loc7_ = 4 - _loc3_;
            _loc9_ = _loc4_;
            if((_loc10_ = _loc16_ & 65535) != 0)
            {
               _loc8_ = _loc12_;
            }
            else
            {
               _loc10_ = 0;
               _loc8_ += 4;
               do
               {
                  _loc11_ = li16(_loc8_);
                  _loc8_ += 2;
                  _loc10_ += 1;
               }
               while(_loc11_ == 0);
               
               _loc8_ = mstate.ebp + -16;
               _loc11_ = _loc10_ + -1;
               _loc10_ <<= 1;
               _loc7_ -= _loc11_;
               _loc8_ += _loc10_;
               _loc7_ += -1;
            }
            _loc10_ = 3 - _loc7_;
            _loc11_ = _loc8_;
            if(_loc10_ >= 0)
            {
               _loc10_ = _loc7_ << 1;
               _loc10_ = _loc1_ - _loc10_;
               _loc12_ = 3 - _loc7_;
               _loc10_ += 6;
               do
               {
                  si16(_loc15_ = 0,_loc10_);
                  _loc10_ += -2;
               }
               while((_loc12_ += -1) >= 0);
               
            }
            _loc10_ = li16(_loc4_ + 2);
            _loc12_ = _loc4_ + 2;
            if((_loc15_ = (_loc15_ = _loc10_ << 16) >> 16) <= -1)
            {
               _loc10_ = 0;
            }
            else
            {
               _loc15_ = 0;
               do
               {
                  _loc15_ += 1;
                  _loc10_ <<= 1;
               }
               while(uint(_loc10_) < uint(32768));
               
               _loc10_ = _loc15_;
            }
            if(_loc10_ >= 1)
            {
               _loc15_ = (_loc15_ = li16(_loc8_)) << _loc10_;
               if((_loc16_ = _loc7_ + _loc3_) <= 0)
               {
                  _loc16_ = 0;
               }
               else
               {
                  _loc17_ = 0;
                  _loc18_ = 16 - _loc10_;
                  _loc19_ = _loc11_;
                  do
                  {
                     si16(_loc15_ = (_loc20_ = (_loc20_ = li16(_loc19_ + 2)) >>> _loc18_) | _loc15_,_loc19_);
                     _loc15_ = li16(_loc19_ + 2);
                     _loc17_ += 1;
                     _loc15_ <<= _loc10_;
                     _loc19_ += 2;
                  }
                  while(_loc17_ != _loc16_);
                  
               }
               _loc16_ <<= 1;
               _loc16_ = _loc8_ + _loc16_;
               si16(_loc15_,_loc16_);
               _loc15_ = (_loc15_ = li16(_loc12_)) << _loc10_;
               if((_loc16_ = _loc3_ + -1) <= 0)
               {
                  _loc16_ = 1;
               }
               else
               {
                  _loc17_ = 0;
                  _loc18_ = 16 - _loc10_;
                  _loc19_ = _loc9_;
                  do
                  {
                     si16(_loc15_ = (_loc20_ = (_loc20_ = li16(_loc19_ + 4)) >>> _loc18_) | _loc15_,_loc19_ + 2);
                     _loc15_ = li16(_loc19_ + 4);
                     _loc17_ += 1;
                     _loc15_ <<= _loc10_;
                     _loc19_ += 2;
                  }
                  while(_loc17_ != _loc16_);
                  
                  _loc16_ = _loc3_;
               }
               _loc16_ <<= 1;
               _loc16_ = _loc4_ + _loc16_;
               si16(_loc15_,_loc16_);
            }
            _loc15_ = 0;
            _loc12_ = li16(_loc12_);
            _loc4_ = li16(_loc4_ + 4);
            _loc16_ = _loc7_ << 1;
            _loc1_ -= _loc16_;
            _loc16_ = _loc12_;
            _loc17_ = _loc15_;
            while(true)
            {
               _loc19_ = li16(_loc18_ = _loc11_ + _loc17_);
               _loc20_ = li16(_loc18_ + 2);
               _loc21_ = li16(_loc18_ + 4);
               _loc22_ = _loc12_ & 65535;
               if(_loc19_ == _loc22_)
               {
                  _loc19_ = (_loc19_ = _loc20_ & 65535) + _loc16_;
                  if(uint(_loc19_) <= uint(65535))
                  {
                     _loc20_ = 65535;
                     addr1128:
                     _loc22_ = _loc12_ & 65535;
                     _loc23_ = _loc4_ & 65535;
                     _loc21_ &= 65535;
                     _loc24_ = _loc19_ << 16;
                     _loc25_ = _loc22_ << 16;
                     _loc26_ = _loc20_ * _loc23_;
                     while(true)
                     {
                        _loc27_ = _loc19_;
                        _loc19_ = _loc20_;
                        _loc20_ = _loc24_ | _loc21_;
                        if(uint(_loc26_) <= uint(_loc20_))
                        {
                           break;
                        }
                        _loc26_ -= _loc23_;
                        _loc20_ = _loc22_ + _loc27_;
                        _loc24_ = _loc25_ + _loc24_;
                        _loc27_ = _loc19_ + -1;
                        if(uint(_loc20_) > uint(65535))
                        {
                           _loc19_ = _loc27_;
                           break;
                        }
                        _loc19_ = _loc20_;
                        _loc20_ = _loc27_;
                     }
                  }
                  else
                  {
                     _loc19_ = 65535;
                  }
                  if(_loc3_ <= 0)
                  {
                     _loc20_ = 0;
                  }
                  else
                  {
                     _loc20_ = 0;
                     _loc21_ = _loc3_ << 1;
                     _loc22_ = _loc11_ + _loc17_;
                     _loc23_ = _loc3_;
                     while(true)
                     {
                        _loc24_ = li16(_loc24_ = _loc9_ + _loc21_);
                        _loc26_ = li16(_loc25_ = _loc22_ + _loc21_);
                        _loc24_ *= _loc19_;
                        _loc24_ = (_loc20_ = (_loc24_ = _loc26_ - _loc24_) - _loc20_) >>> 16;
                        _loc24_ = 65536 - _loc24_;
                        si16(_loc20_,_loc25_);
                        _loc20_ = _loc21_ + -2;
                        _loc23_ += -1;
                        _loc24_ &= 65535;
                        if(_loc23_ <= 0)
                        {
                           break;
                        }
                        _loc21_ = _loc20_;
                        _loc20_ = _loc24_;
                     }
                     _loc20_ = _loc24_;
                  }
                  si16(_loc20_ = (_loc21_ = li16(_loc18_)) - _loc20_,_loc18_);
                  if(uint(_loc20_) <= uint(65535))
                  {
                     _loc18_ = _loc19_;
                  }
                  else
                  {
                     _loc19_ += -1;
                     if(_loc3_ <= 0)
                     {
                        _loc20_ = 0;
                     }
                     else
                     {
                        _loc20_ = 0;
                        _loc21_ = _loc3_ << 1;
                        _loc22_ = _loc11_ + _loc17_;
                        _loc23_ = _loc3_;
                        do
                        {
                           _loc25_ = li16(_loc24_ = _loc22_ + _loc21_);
                           _loc26_ = li16(_loc26_ = _loc9_ + _loc21_);
                           si16(_loc20_ = (_loc20_ = _loc25_ + _loc20_) + _loc26_,_loc24_);
                           _loc21_ += -2;
                           _loc23_ += -1;
                           _loc20_ >>>= 16;
                        }
                        while(_loc23_ >= 1);
                        
                     }
                     si16(_loc20_ = (_loc21_ = li16(_loc18_)) + _loc20_,_loc18_);
                     _loc18_ = _loc19_;
                  }
                  _loc19_ = _loc1_ + _loc17_;
                  si16(_loc18_,_loc19_ + 8);
                  _loc17_ += 2;
                  if((_loc15_ += 1) > _loc7_)
                  {
                     break;
                  }
                  continue;
               }
               _loc20_ &= 65535;
               _loc19_ = (_loc19_ <<= 16) | _loc20_;
               _loc20_ = uint(_loc19_) % uint(_loc16_);
               _loc22_ = uint(_loc19_) / uint(_loc16_);
               _loc19_ = _loc20_;
               _loc20_ = _loc22_;
               §§goto(addr1128);
            }
            if(_loc2_ != 0)
            {
               if(_loc10_ != 0)
               {
                  _loc1_ = _loc3_ + _loc7_;
                  _loc4_ = _loc1_ << 1;
                  _loc4_ = _loc8_ + _loc4_;
                  if(_loc1_ <= _loc7_)
                  {
                     _loc1_ = _loc4_;
                  }
                  else
                  {
                     _loc1_ = _loc3_ + _loc7_;
                     _loc8_ = (_loc8_ = _loc1_ + -1) << 1;
                     _loc9_ = _loc1_ << 1;
                     _loc12_ = 16 - _loc10_;
                     do
                     {
                        _loc15_ = _loc9_ + _loc11_;
                        _loc4_ = li16(_loc4_);
                        _loc16_ = (_loc16_ = li16(_loc15_ + -2)) << _loc12_;
                        _loc4_ >>>= _loc10_;
                        si16(_loc4_ = _loc16_ | _loc4_,_loc15_);
                        _loc4_ = _loc8_ + _loc11_;
                        _loc11_ += -2;
                        _loc1_ += -1;
                     }
                     while(_loc1_ > _loc7_);
                     
                     _loc1_ = _loc3_ + _loc7_;
                     _loc1_ <<= 1;
                     _loc1_ += _loc11_;
                  }
                  _loc3_ = 0;
                  si16(_loc3_,_loc1_);
               }
               _loc1_ = li16(_loc14_);
               _loc3_ = li16(_loc6_);
               _loc4_ = li16(_loc13_);
               _loc5_ = li16(_loc5_);
               _loc3_ <<= 16;
               _loc1_ <<= 16;
               _loc3_ |= _loc5_;
               _loc1_ |= _loc4_;
               si32(_loc3_,_loc2_);
               si32(_loc1_,_loc2_ + 4);
            }
            _loc1_ = li16(mstate.ebp + -42);
            _loc2_ = li16(mstate.ebp + -46);
            _loc3_ = li16(mstate.ebp + -40);
            _loc4_ = li16(mstate.ebp + -44);
            _loc1_ <<= 16;
            _loc2_ <<= 16;
            _loc1_ |= _loc3_;
            _loc2_ |= _loc4_;
         }
         §§goto(addr1663);
      }
   }
}
