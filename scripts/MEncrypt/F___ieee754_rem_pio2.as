package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___ieee754_rem_pio2() : void
   {
      var _loc4_:* = 0;
      var _loc9_:* = NaN;
      var _loc12_:* = 0;
      var _loc3_:* = 0;
      var _loc16_:* = 0;
      var _loc14_:* = 0;
      var _loc11_:Number = NaN;
      var _loc1_:Number = NaN;
      var _loc8_:int = 0;
      var _loc5_:int = 0;
      var _loc15_:Number = NaN;
      var _loc17_:* = NaN;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 80;
      sf64(_loc9_ = lf64(_loc4_),_loc4_ - 48);
      _loc3_ = _loc4_ - 48;
      _loc3_ |= 4;
      _loc14_ = (_loc16_ = li32(_loc3_)) & 2147483647;
      _loc12_ = li32(_loc4_ + 8);
      if(uint(_loc14_) <= 1074752122)
      {
         if((_loc16_ & 1048575) != 598523)
         {
            if(uint(_loc14_) <= 1073928572)
            {
               if(_loc16_ >= 1)
               {
                  var _loc13_:Number;
                  var _loc7_:*;
                  sf64(_loc13_ = (_loc7_ = _loc9_ + -1.5707963267341256) + -6.077100506506192e-11,_loc12_);
                  sf64(_loc7_ = (_loc7_ -= _loc13_) + -6.077100506506192e-11,_loc12_ + 8);
                  _loc14_ = 1;
               }
               else
               {
                  sf64(_loc7_ = (_loc13_ = _loc9_ + 1.5707963267341256) + 6.077100506506192e-11,_loc12_);
                  sf64(_loc7_ = (_loc7_ = _loc13_ - _loc7_) + 6.077100506506192e-11,_loc12_ + 8);
                  _loc14_ = -1;
               }
            }
            else if(_loc16_ >= 1)
            {
               sf64(_loc13_ = (_loc7_ = _loc9_ + -3.1415926534682512) + -1.2154201013012384e-10,_loc12_);
               sf64(_loc7_ = (_loc7_ -= _loc13_) + -1.2154201013012384e-10,_loc12_ + 8);
               _loc14_ = 2;
            }
            else
            {
               sf64(_loc13_ = (_loc7_ = _loc9_ + 3.1415926534682512) + 1.2154201013012384e-10,_loc12_);
               sf64(_loc7_ = (_loc7_ -= _loc13_) + 1.2154201013012384e-10,_loc12_ + 8);
               _loc14_ = -2;
            }
         }
         else
         {
            addr377:
            _loc17_ = (_loc7_ = (_loc11_ = (_loc7_ = (_loc7_ = _loc9_ * 0.6366197723675814) + 6755399441055744) + -6755399441055744) * -1.5707963267341256) + _loc9_;
            _loc9_ = _loc11_ * 6.077100506506192e-11;
            sf64(_loc15_ = _loc17_ - _loc9_,_loc12_);
            sf64(_loc15_,_loc4_ - 64);
            _loc14_ >>>= 20;
            _loc3_ = _loc4_ - 64;
            _loc3_ |= 4;
            _loc3_ = li32(_loc3_);
            _loc3_ >>>= 20;
            _loc3_ &= 2047;
            _loc3_ = _loc14_ - _loc3_;
            if(_loc3_ >= 17)
            {
               _loc13_ = _loc11_ * 6.077100506303966e-11;
               _loc1_ = _loc17_ - _loc13_;
               _loc9_ = (_loc7_ = _loc11_ * 2.0222662487959506e-21) - ((_loc7_ = _loc17_ - _loc1_) - _loc13_);
               sf64(_loc15_ = _loc1_ - _loc9_,_loc12_);
               sf64(_loc15_,_loc4_ - 72);
               _loc17_ = _loc1_;
               if(_loc14_ - (li32(_loc4_ - 72 | 4) >>> 20 & 2047) >= 50)
               {
                  _loc13_ = _loc11_ * 2.0222662487111665e-21;
                  _loc17_ = _loc1_ - _loc13_;
                  _loc9_ = (_loc7_ = _loc11_ * 8.4784276603689e-32) - ((_loc7_ = _loc1_ - _loc17_) - _loc13_);
                  sf64(_loc15_ = _loc17_ - _loc9_,_loc12_);
               }
            }
            _loc14_ = _loc11_;
            sf64(_loc7_ = (_loc7_ = _loc17_ - _loc15_) - _loc9_,_loc12_ + 8);
         }
         §§goto(addr811);
      }
      else if(uint(_loc14_) <= 1075594811)
      {
         if(uint(_loc14_) <= 1075183036)
         {
            if(_loc14_ != 1074977148)
            {
               if(_loc16_ >= 1)
               {
                  sf64(_loc13_ = (_loc7_ = _loc9_ + -4.712388980202377) + -1.8231301519518578e-10,_loc12_);
                  sf64(_loc7_ = (_loc7_ -= _loc13_) + -1.8231301519518578e-10,_loc12_ + 8);
                  _loc14_ = 3;
               }
               else
               {
                  sf64(_loc13_ = (_loc7_ = _loc9_ + 4.712388980202377) + 1.8231301519518578e-10,_loc12_);
                  sf64(_loc7_ = (_loc7_ -= _loc13_) + 1.8231301519518578e-10,_loc12_ + 8);
                  _loc14_ = -3;
               }
            }
            else
            {
               §§goto(addr377);
            }
         }
         else if(_loc14_ != 1075388923)
         {
            if(_loc16_ >= 1)
            {
               sf64(_loc7_ = (_loc13_ = _loc9_ + -6.2831853069365025) + -2.430840202602477e-10,_loc12_);
               sf64(_loc7_ = (_loc7_ = _loc13_ - _loc7_) + -2.430840202602477e-10,_loc12_ + 8);
               _loc14_ = 4;
            }
            else
            {
               sf64(_loc7_ = (_loc13_ = _loc9_ + 6.2831853069365025) + 2.430840202602477e-10,_loc12_);
               sf64(_loc7_ = (_loc7_ = _loc13_ - _loc7_) + 2.430840202602477e-10,_loc12_ + 8);
               _loc14_ = -4;
            }
         }
         else
         {
            §§goto(addr377);
         }
         §§goto(addr811);
      }
      else
      {
         if(uint(_loc14_) <= 1094263290)
         {
            §§goto(addr377);
         }
         else if(uint(_loc14_) >= 2146435072)
         {
            sf64(_loc7_ = _loc9_ - _loc9_,_loc12_ + 8);
            sf64(_loc7_,_loc12_);
            _loc14_ = 0;
         }
         else
         {
            var _loc6_:int;
            var _loc10_:int;
            si32(_loc14_ - ((_loc8_ = (_loc10_ = _loc14_ >>> 20) + -1046) << 20),(_loc6_ = _loc4_ - 56) | 4);
            si32(li32(_loc4_ - 48),_loc4_ - 56);
            sf64(_loc13_ = _loc10_ = _loc7_ = lf64(_loc4_ - 56),_loc4_ - 24);
            sf64(_loc13_ = _loc10_ = _loc7_ = (_loc7_ -= _loc13_) * 16777216,_loc4_ - 16);
            sf64(_loc7_ = (_loc7_ -= _loc13_) * 16777216,_loc4_ - 8);
            _loc14_ = 4;
            do
            {
               _loc3_ = _loc14_ << 3;
               _loc3_ = (_loc5_ = _loc4_ - 24) + _loc3_;
               _loc7_ = lf64(_loc3_ - 16);
               _loc14_ += -1;
            }
            while(_loc7_ == 0);
            
            _loc2_ -= 32;
            si32(1,_loc2_ + 16);
            si32(_loc14_,_loc2_ + 12);
            si32(_loc8_,_loc2_ + 8);
            si32(_loc4_ - 40,_loc2_ + 4);
            si32(_loc5_,_loc2_);
            ESP = _loc2_;
            F___kernel_rem_pio2();
            _loc2_ += 32;
            _loc14_ = eax;
            _loc9_ = lf64(_loc4_ - 40);
            if(_loc16_ <= -1)
            {
               sf64(_loc7_ = -_loc9_,_loc12_);
               sf64(_loc7_ = -(_loc7_ = lf64(_loc4_ - 32)),_loc12_ + 8);
               _loc14_ = 0 - _loc14_;
            }
            else
            {
               sf64(_loc9_,_loc12_);
               sf64(_loc7_ = lf64(_loc4_ - 32),_loc12_ + 8);
            }
         }
         addr811:
         eax = _loc14_;
         _loc2_ = _loc4_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr377);
   }
}
