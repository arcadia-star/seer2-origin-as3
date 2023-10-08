package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_hypot() : void
   {
      var _loc6_:int = 0;
      var _loc8_:* = NaN;
      var _loc14_:* = 0;
      var _loc12_:* = 0;
      var _loc11_:* = NaN;
      var _loc9_:* = NaN;
      var _loc16_:Number = NaN;
      var _loc7_:* = NaN;
      var _loc15_:* = 0;
      var _loc4_:* = (_loc6_ = ESP) - 136;
      sf64(_loc8_ = lf64(_loc6_),_loc6_ - 8);
      sf64(_loc7_ = lf64(_loc6_ + 8),_loc6_ - 16);
      var _loc5_:*;
      _loc15_ = (_loc5_ = li32(_loc5_ = (_loc5_ = _loc6_ - 8) | 4)) & 2147483647;
      _loc14_ = (_loc5_ = li32(_loc5_ = (_loc5_ = _loc6_ - 16) | 4)) & 2147483647;
      _loc11_ = _loc7_;
      if(uint(_loc14_) <= uint(_loc15_))
      {
         _loc11_ = _loc8_;
      }
      _loc9_ = _loc8_;
      if(uint(_loc14_) <= uint(_loc15_))
      {
         _loc9_ = _loc7_;
      }
      _loc12_ = _loc15_;
      if(uint(_loc14_) <= uint(_loc15_))
      {
         _loc12_ = _loc14_;
      }
      if(uint(_loc14_) <= uint(_loc15_))
      {
         _loc14_ = _loc15_;
      }
      if(!(_loc11_ >= 0 | _loc11_ != _loc11_ | false))
      {
         _loc11_ = -_loc11_;
      }
      if(!(_loc9_ >= 0 | _loc9_ != _loc9_ | false))
      {
         _loc9_ = -_loc9_;
      }
      if((_loc5_ = _loc14_ - _loc12_) >= 62914561)
      {
         _loc9_ = _loc11_ + _loc9_;
      }
      else
      {
         _loc15_ = 0;
         if(uint(_loc14_) >= 1596981249)
         {
            if(uint(_loc14_) >= 2146435072)
            {
               if(!((_loc16_ = _loc8_ + 0) >= 0 | _loc16_ != _loc16_ | false))
               {
                  _loc16_ = -_loc16_;
               }
               if(!((_loc7_ += 0) >= 0 | _loc7_ != _loc7_ | false))
               {
                  _loc7_ = -_loc7_;
               }
               sf64(_loc11_,_loc6_ - 128);
               _loc5_ = _loc14_ & 1048575;
               var _loc10_:*;
               if((_loc5_ = (_loc10_ = li32(_loc6_ - 128)) | _loc5_) != 0)
               {
                  _loc11_ = _loc16_ - _loc7_;
               }
               sf64(_loc9_,_loc6_ - 136);
               _loc5_ = _loc12_ ^ 2146435072;
               if((_loc5_ = (_loc10_ = li32(_loc6_ - 136)) | _loc5_) != 0)
               {
                  _loc9_ = _loc11_;
               }
               §§goto(addr682);
            }
            else
            {
               _loc12_ += -629145600;
               si32(_loc12_,(_loc5_ = _loc6_ - 48) | 4);
               _loc14_ += -629145600;
               si32(_loc14_,(_loc5_ = _loc6_ - 32) | 4);
               sf64(_loc9_,_loc6_ - 40);
               sf64(_loc11_,_loc6_ - 24);
               si32(_loc5_ = li32(_loc6_ - 40),_loc6_ - 48);
               si32(_loc5_ = li32(_loc6_ - 24),_loc6_ - 32);
               _loc15_ = 600;
               _loc9_ = lf64(_loc6_ - 48);
               _loc11_ = lf64(_loc6_ - 32);
            }
            §§goto(addr682);
         }
         _loc7_ = _loc9_;
         if(_loc12_ <= 548405247)
         {
            if(_loc12_ <= 1048575)
            {
               sf64(_loc7_,_loc6_ - 88);
               _loc9_ = _loc11_;
               if((_loc12_ | li32(_loc6_ - 88)) != 0)
               {
                  _loc15_ |= -1022;
                  _loc11_ *= 4.49423283715579e+307;
                  _loc7_ *= 4.49423283715579e+307;
               }
               §§goto(addr682);
            }
            else
            {
               _loc12_ += 629145600;
               si32(_loc12_,(_loc5_ = _loc6_ - 80) | 4);
               _loc14_ += 629145600;
               si32(_loc14_,(_loc5_ = _loc6_ - 64) | 4);
               sf64(_loc7_,_loc6_ - 72);
               sf64(_loc11_,_loc6_ - 56);
               si32(_loc5_ = li32(_loc6_ - 72),_loc6_ - 80);
               si32(_loc5_ = li32(_loc6_ - 56),_loc6_ - 64);
               _loc15_ += -600;
               _loc7_ = lf64(_loc6_ - 80);
               _loc11_ = lf64(_loc6_ - 64);
            }
         }
         if(!((_loc9_ = _loc11_ - _loc7_) <= _loc7_ | _loc9_ != _loc9_ | _loc7_ != _loc7_))
         {
            si32(_loc14_,(_loc5_ = _loc6_ - 112) | 4);
            si32(0,_loc6_ - 112);
            var _loc13_:* = lf64(_loc6_ - 112);
            _loc9_ = Math.sqrt((_loc13_ *= _loc13_) - (_loc7_ * -_loc7_ - (_loc11_ + _loc13_) * (_loc11_ - _loc13_)));
         }
         else
         {
            si32(_loc14_ + 1048576,(_loc10_ = _loc6_ - 104) | 4);
            si32(_loc12_,(_loc5_ = _loc6_ - 96) | 4);
            si32(0,_loc6_ - 104);
            si32(0,_loc6_ - 96);
            var _loc1_:* = lf64(_loc6_ - 96);
            _loc9_ = Math.sqrt((_loc13_ *= _loc1_) - (_loc9_ * -_loc9_ - (_loc13_ * (_loc7_ - _loc1_) + (_loc11_ + _loc11_ - (_loc13_ = lf64(_loc6_ - 104))) * _loc7_)));
         }
         if(_loc15_ != 0)
         {
            si32(_loc10_ = (_loc10_ = _loc15_ << 20) + 1072693248,(_loc5_ = _loc6_ - 120) | 4);
            si32(0,_loc6_ - 120);
            _loc9_ = (_loc13_ = lf64(_loc6_ - 120)) * _loc9_;
         }
      }
      addr682:
      st0 = _loc9_;
      ESP = _loc4_ = _loc6_;
   }
}
