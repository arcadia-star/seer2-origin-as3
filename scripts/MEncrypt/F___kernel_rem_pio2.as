package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._PIo2;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._init_jk;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._ipio2;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___kernel_rem_pio2() : void
   {
      var _loc13_:int = 0;
      var _loc37_:* = 0;
      var _loc45_:* = 0;
      var _loc28_:* = 0;
      var _loc43_:* = 0;
      var _loc39_:int = 0;
      var _loc34_:int = 0;
      var _loc26_:int = 0;
      var _loc17_:int = 0;
      var _loc1_:Number = NaN;
      var _loc18_:* = 0;
      var _loc16_:int = 0;
      var _loc40_:* = 0;
      var _loc41_:* = 0;
      var _loc12_:* = 0;
      var _loc44_:* = 0;
      var _loc25_:* = 0;
      var _loc38_:* = 0;
      var _loc20_:Number = NaN;
      var _loc31_:int = 0;
      var _loc32_:* = 0;
      var _loc27_:* = 0;
      var _loc30_:int = 0;
      var _loc21_:* = NaN;
      var _loc11_:* = 0;
      var _loc8_:int = 0;
      var _loc10_:* = 0;
      var _loc7_:* = 0;
      var _loc24_:* = NaN;
      var _loc35_:* = 0;
      var _loc33_:* = 0;
      var _loc3_:Number = NaN;
      var _loc4_:Number = NaN;
      var _loc36_:* = 0;
      var _loc6_:Number = NaN;
      var _loc5_:* = NaN;
      var _loc9_:* = (_loc13_ = ESP) - 560;
      _loc45_ = (_loc28_ = li32(_loc13_ + 8)) + -3;
      _loc44_ = 0;
      if(_loc45_ >= -23)
      {
         _loc44_ = _loc45_ / 24;
      }
      var _loc42_:* = (_loc43_ = li32(_loc13_ + 16)) << 2;
      _loc41_ = li32(_loc42_ = _init_jk + _loc42_);
      _loc39_ = (_loc40_ = li32(_loc13_ + 12)) + -1;
      if((_loc42_ = _loc41_ + _loc39_) >= 0)
      {
         _loc38_ = _loc41_ + _loc40_;
         _loc45_ = (_loc42_ = _loc44_ + 1) - _loc40_;
         _loc25_ = _loc13_ - 240;
         do
         {
            _loc20_ = 0;
            if(_loc45_ >= 0)
            {
               _loc20_ = _loc42_ = li32(_loc42_ = _ipio2 + (_loc45_ << 2));
            }
            sf64(_loc20_,_loc25_);
            _loc45_ += 1;
            _loc25_ += 8;
         }
         while((_loc38_ += -1) != 0);
         
      }
      _loc34_ = (_loc33_ = _loc44_ * 24) + 24;
      _loc35_ = _loc28_ - _loc34_;
      _loc45_ = li32(_loc13_ + 4);
      _loc37_ = li32(_loc13_);
      if(_loc39_ >= 0)
      {
         _loc30_ = (_loc42_ = (_loc40_ << 3) + (_loc13_ - 240)) + -8;
         _loc38_ = _loc41_ + 1;
         _loc25_ = _loc13_ - 560;
         do
         {
            _loc20_ = 0;
            _loc31_ = 0;
            _loc32_ = _loc37_;
            _loc27_ = _loc40_;
            do
            {
               _loc42_ = _loc31_ << 3;
               var _loc19_:* = lf64(_loc42_ = _loc30_ + _loc42_);
               var _loc22_:*;
               _loc20_ = (_loc22_ = (_loc22_ = lf64(_loc32_)) * _loc19_) + _loc20_;
               _loc31_ += -1;
               _loc32_ += 8;
            }
            while((_loc27_ += -1) != 0);
            
            sf64(_loc20_,_loc25_);
            _loc38_ += -1;
            _loc25_ += 8;
            _loc30_ += 8;
         }
         while(_loc38_ != 0);
         
      }
      else
      {
         _loc9_ -= 16;
         si32(0,_loc9_ + 4);
         si32(_loc42_ = _loc13_ - 560,_loc9_);
         si32(_loc42_ = (_loc42_ = _loc41_ << 3) + 8,_loc9_ + 8);
         ESP = _loc9_;
         Fmemset();
         _loc9_ += 16;
      }
      _loc42_ = _loc44_ << 2;
      _loc32_ = _ipio2 + _loc42_;
      var _loc29_:* = _loc40_ << 3;
      _loc26_ = (_loc42_ = _loc13_ - 240) + _loc29_;
      _loc18_ = _loc41_ << 2;
      _loc16_ = _loc13_ - 80;
      _loc17_ = (_loc42_ = _loc18_ + _loc16_) + -8;
      _loc30_ = 23 - _loc35_;
      _loc31_ = 24 - _loc35_;
      _loc20_ = 0;
      _loc25_ = _loc41_;
      loop3:
      while(true)
      {
         _loc42_ = (_loc44_ = _loc25_) << 3;
         _loc21_ = lf64(_loc42_ = (_loc27_ = _loc13_ - 560) + _loc42_);
         _loc38_ = _loc16_;
         _loc25_ = _loc44_;
         if(_loc44_ >= 1)
         {
            do
            {
               si32(_loc29_ = _loc19_ = (_loc19_ = (_loc22_ = _loc42_ = _loc22_ = _loc21_ * 5.9604644775390625e-8) * -16777216) + _loc21_,_loc38_);
               _loc29_ = _loc25_ << 3;
               _loc21_ = (_loc19_ = lf64((_loc29_ = _loc27_ + _loc29_) - 8)) + _loc22_;
               _loc38_ += 4;
            }
            while((_loc25_ += -1) != 0);
            
         }
         _loc9_ -= 16;
         si32(_loc35_,_loc9_ + 8);
         sf64(_loc21_,_loc9_);
         ESP = _loc9_;
         F_scalbn();
         _loc9_ += 16;
         _loc22_ = st0;
         _loc9_ -= 16;
         sf64(_loc19_ = _loc22_ * 0.125,_loc9_);
         ESP = _loc9_;
         F_floor();
         _loc9_ += 16;
         _loc22_ = _loc25_ = _loc19_ = (_loc19_ = (_loc19_ = st0) * -8) + _loc22_;
         _loc21_ = _loc19_ - _loc22_;
         if(_loc35_ >= 1)
         {
            _loc29_ = (_loc44_ << 2) + (_loc13_ - 80);
            var _loc14_:*;
            si32(_loc14_ -= (_loc42_ = (_loc14_ = li32(_loc29_ - 4)) >> _loc31_) << _loc31_,_loc29_ - 4);
            _loc11_ = _loc14_ >> _loc30_;
            _loc25_ = _loc42_ + _loc25_;
            addr689:
            _loc38_ = _loc11_;
            if(_loc11_ >= 1)
            {
               addr695:
               _loc38_ = _loc11_;
               _loc12_ = 0;
               _loc8_ = _loc13_ - 80;
               _loc10_ = _loc44_;
               if(_loc44_ >= 1)
               {
                  do
                  {
                     _loc11_ = li32(_loc8_);
                     if(_loc12_ == 0)
                     {
                        _loc12_ = 0;
                        if(_loc11_ != 0)
                        {
                           si32(_loc42_ = 16777216 - _loc11_,_loc8_);
                           _loc12_ = 1;
                        }
                     }
                     else
                     {
                        si32(_loc42_ = 16777215 - _loc11_,_loc8_);
                     }
                     _loc8_ += 4;
                  }
                  while((_loc10_ += -1) != 0);
                  
               }
               if(_loc35_ >= 1)
               {
                  if(_loc35_ != 2)
                  {
                     if(_loc35_ == 1)
                     {
                        _loc42_ = (_loc44_ << 2) + (_loc13_ - 80);
                        si32(_loc29_ = (_loc29_ = li32(_loc42_ - 4)) & 8388607,_loc42_ - 4);
                     }
                  }
                  else
                  {
                     _loc42_ = (_loc44_ << 2) + (_loc13_ - 80);
                     si32(_loc29_ = (_loc29_ = li32(_loc42_ - 4)) & 4194303,_loc42_ - 4);
                  }
               }
               _loc25_ += 1;
               if(_loc38_ == 2)
               {
                  _loc21_ = 1 - _loc21_;
                  _loc38_ = 2;
                  if(_loc12_ != 0)
                  {
                     _loc9_ -= 16;
                     si32(1072693248,_loc9_ + 4);
                     si32(0,_loc9_);
                     si32(_loc35_,_loc9_ + 8);
                     ESP = _loc9_;
                     F_scalbn();
                     _loc9_ += 16;
                     _loc21_ -= st0;
                     _loc38_ = 2;
                  }
               }
            }
         }
         else if(_loc34_ == _loc28_)
         {
            _loc11_ = (_loc42_ = li32((_loc42_ = (_loc44_ << 2) + (_loc13_ - 80)) - 4)) >> 23;
            §§goto(addr689);
         }
         else
         {
            _loc11_ = 2;
            _loc38_ = 0;
            if(!(_loc21_ < 0.5 | _loc21_ != _loc21_ | false))
            {
               §§goto(addr695);
            }
         }
         if(!(_loc21_ != _loc20_ | _loc21_ != _loc21_ | _loc20_ != _loc20_))
         {
            if((_loc11_ = _loc44_ + -1) >= _loc41_)
            {
               _loc12_ = 0;
               do
               {
                  _loc42_ = _loc11_ << 2;
                  _loc12_ = (_loc42_ = li32(_loc42_ = (_loc10_ = _loc13_ - 80) + _loc42_)) | _loc12_;
               }
               while((_loc11_ += -1) >= _loc41_);
               
               if(_loc12_ != 0)
               {
                  if(!(_loc21_ != 0 | _loc21_ != _loc21_ | false))
                  {
                     _loc35_ = (_loc42_ = _loc28_ + -24) - _loc33_;
                     addr1191:
                     _loc42_ = _loc44_ << 2;
                     _loc42_ = li32((_loc42_ = _loc10_ + _loc42_) - 4);
                     _loc44_ += -1;
                     _loc35_ += -24;
                     if(_loc42_ == 0)
                     {
                        §§goto(addr1191);
                     }
                     §§goto(addr1338);
                  }
                  break;
               }
            }
            _loc42_ = li32((_loc42_ = (_loc42_ = _loc13_ - 80) + _loc18_) - 4);
            _loc38_ = 1;
            _loc25_ = _loc17_;
            if(_loc42_ == 0)
            {
               do
               {
                  _loc29_ = _loc25_ + -4;
                  _loc38_ += 1;
                  _loc42_ = li32(_loc25_);
                  _loc25_ = _loc29_;
               }
               while(_loc42_ == 0);
               
            }
            _loc25_ = _loc38_ + _loc44_;
            _loc38_ = _loc44_ + 1;
            if(_loc25_ < _loc38_)
            {
               continue;
            }
            if(_loc39_ < 0)
            {
               _loc44_ += 1;
               do
               {
                  _loc29_ = _loc44_ << 3;
                  _loc42_ = _loc26_ + _loc29_;
                  _loc14_ = _loc44_ << 2;
                  var _loc23_:*;
                  sf64(_loc23_ = _loc14_ = li32(_loc14_ = _loc32_ + _loc14_),_loc42_ - 8);
                  _loc42_ = (_loc29_ = _loc27_ + _loc29_) | 4;
                  si32(0,_loc42_);
                  si32(0,_loc29_);
                  _loc44_ += 1;
               }
               while(_loc25_ >= _loc44_);
               
               continue;
            }
            while(true)
            {
               _loc12_ = _loc38_ << 3;
               _loc42_ = _loc26_ + _loc12_;
               _loc29_ = _loc38_ << 2;
               sf64(_loc19_ = _loc29_ = li32(_loc29_ = _loc32_ + _loc29_),_loc42_ - 8);
               _loc24_ = 0;
               _loc10_ = 0;
               _loc7_ = _loc37_;
               _loc11_ = _loc40_;
               do
               {
                  _loc19_ = lf64((_loc42_ = (_loc42_ = _loc26_ + _loc10_) + _loc12_) - 8);
                  _loc24_ = (_loc22_ = (_loc22_ = lf64(_loc7_)) * _loc19_) + _loc24_;
                  _loc10_ += -8;
                  _loc7_ += 8;
               }
               while((_loc11_ += -1) != 0);
               
               sf64(_loc24_,_loc27_ + _loc12_);
               _loc38_ += 1;
               if(_loc25_ >= _loc38_)
               {
                  continue;
               }
               continue loop3;
            }
         }
         break;
      }
      _loc9_ -= 16;
      sf64(_loc21_,_loc9_);
      si32(_loc42_ = 0 - _loc35_,_loc9_ + 8);
      ESP = _loc9_;
      F_scalbn();
      _loc9_ += 16;
      _loc1_ = st0;
      if(!(_loc1_ < 16777216 | _loc1_ != _loc1_ | false))
      {
         var _loc15_:int;
         si32(_loc15_ = (_loc29_ = _loc19_ = _loc1_ * 5.9604644775390625e-8) * -16777216 + _loc1_,(_loc42_ = _loc13_ - 80) + (_loc44_ << 2));
         si32(_loc29_,_loc42_ + ((_loc44_ += 1) << 2));
         _loc35_ += 24;
      }
      else
      {
         si32(_loc29_ = _loc1_,(_loc29_ = _loc13_ - 80) + (_loc44_ << 2));
      }
      addr1338:
      if(_loc44_ >= 0)
      {
         _loc9_ -= 16;
         si32(1072693248,_loc9_ + 4);
         si32(_loc28_ = 0,_loc9_);
         si32(_loc35_,_loc9_ + 8);
         if((_loc33_ = _loc44_ ^ -1) <= -1)
         {
            _loc33_ = -1;
         }
         _loc40_ = _loc44_ << 3;
         _loc39_ = _loc27_ + _loc40_;
         _loc42_ = _loc44_ << 2;
         _loc35_ = (_loc29_ = _loc13_ - 80) + _loc42_;
         _loc34_ = (_loc42_ = _loc44_ + _loc33_) + 2;
         ESP = _loc9_;
         F_scalbn();
         _loc9_ += 16;
         _loc3_ = st0;
         do
         {
            sf64(_loc22_ = (_loc22_ = _loc42_ = li32(_loc35_)) * _loc3_,_loc39_);
            _loc39_ += -8;
            _loc35_ += -4;
            _loc34_ += -1;
            _loc3_ *= 5.9604644775390625e-8;
         }
         while(_loc34_ != 0);
         
         if(_loc44_ >= 0)
         {
            _loc35_ = _loc44_ ^ -1;
            _loc39_ = -1;
            if(_loc35_ <= _loc39_)
            {
               _loc35_ = _loc39_;
            }
            _loc40_ = _loc27_ + _loc40_;
            _loc35_ = (_loc42_ = _loc44_ + _loc35_) + 2;
            _loc41_ ^= -1;
            do
            {
               _loc27_ = _loc39_;
               if(uint(_loc39_) <= uint(_loc41_))
               {
                  _loc27_ = _loc41_;
               }
               _loc27_ = 0 - _loc27_;
               _loc34_ = _PIo2;
               _loc4_ = 0;
               _loc33_ = _loc40_;
               if(_loc28_ >= 0)
               {
                  do
                  {
                     _loc22_ = lf64(_loc33_);
                     _loc4_ = (_loc22_ = (_loc19_ = lf64(_loc34_)) * _loc22_) + _loc4_;
                     _loc33_ += 8;
                     _loc34_ += 8;
                  }
                  while((_loc27_ += -1) != 0);
                  
               }
               _loc42_ = _loc28_ << 3;
               _loc42_ = (_loc29_ = _loc13_ - 400) + _loc42_;
               sf64(_loc4_,_loc42_);
               _loc40_ += -8;
               _loc39_ += -1;
               _loc28_ += 1;
            }
            while(_loc35_ != _loc28_);
            
         }
      }
      if(_loc43_ != 3)
      {
         if((uint(_loc42_ = _loc43_ + -1)) >= 2)
         {
            if(_loc43_ == 0)
            {
               if(_loc44_ >= 0)
               {
                  if((_loc41_ = _loc44_ ^ -1) <= -1)
                  {
                     _loc41_ = -1;
                  }
                  _loc29_ = _loc44_ << 3;
                  _loc43_ = (_loc42_ = _loc13_ - 400) + _loc29_;
                  _loc44_ = (_loc42_ = _loc44_ + _loc41_) + 2;
                  _loc20_ = 0;
                  do
                  {
                     _loc20_ = (_loc22_ = lf64(_loc43_)) + _loc20_;
                     _loc43_ += -8;
                  }
                  while((_loc44_ += -1) != 0);
                  
               }
               if(_loc38_ != 0)
               {
                  _loc20_ = -_loc20_;
               }
               sf64(_loc20_,_loc45_);
            }
         }
         else
         {
            _loc6_ = 0;
            if(_loc44_ >= 0)
            {
               if((_loc43_ = _loc44_ ^ -1) <= -1)
               {
                  _loc43_ = -1;
               }
               _loc42_ = _loc44_ << 3;
               _loc41_ = (_loc29_ = _loc13_ - 400) + _loc42_;
               _loc36_ = (_loc42_ = _loc44_ + _loc43_) + 2;
               _loc6_ = 0;
               do
               {
                  _loc6_ = (_loc22_ = lf64(_loc41_)) + _loc6_;
                  _loc41_ += -8;
               }
               while((_loc36_ += -1) != 0);
               
            }
            _loc5_ = _loc6_;
            if(_loc38_ != 0)
            {
               _loc5_ = -_loc6_;
            }
            sf64(_loc5_,_loc45_);
            _loc5_ = (_loc22_ = lf64(_loc13_ - 400)) - _loc6_;
            if(_loc44_ >= 1)
            {
               _loc5_ = (_loc22_ = lf64(_loc13_ - 392)) + _loc5_;
               if(_loc44_ != 1)
               {
                  _loc43_ = (_loc42_ = _loc13_ - 400) + 16;
                  _loc44_ += -1;
                  do
                  {
                     _loc5_ = (_loc22_ = lf64(_loc43_)) + _loc5_;
                     _loc43_ += 8;
                  }
                  while((_loc44_ += -1) != 0);
                  
               }
            }
            if(_loc38_ != 0)
            {
               _loc5_ = -_loc5_;
            }
            sf64(_loc5_,_loc45_ + 8);
         }
      }
      else
      {
         _loc6_ = 0;
         _loc36_ = _loc44_;
         if(_loc44_ > 0)
         {
            do
            {
               _loc42_ = _loc36_ << 3;
               _loc23_ = lf64(_loc42_ = (_loc41_ = _loc13_ - 400) + _loc42_);
               var _loc2_:* = lf64(_loc42_ - 8);
               _loc19_ = _loc2_ + _loc23_;
               _loc2_ -= _loc19_;
               sf64(_loc23_ += _loc2_,_loc42_);
               sf64(_loc19_,_loc42_ - 8);
            }
            while((_loc36_ += -1) != 0);
            
            _loc6_ = 0;
            _loc36_ = _loc44_;
            if(_loc44_ >= 2)
            {
               do
               {
                  _loc42_ = _loc36_ << 3;
                  _loc23_ = lf64(_loc42_ = _loc41_ + _loc42_);
                  _loc2_ = lf64(_loc42_ - 8);
                  _loc19_ = _loc2_ + _loc23_;
                  _loc2_ -= _loc19_;
                  sf64(_loc23_ += _loc2_,_loc42_);
                  sf64(_loc19_,_loc42_ - 8);
               }
               while((_loc36_ += -1) != 1);
               
               _loc6_ = 0;
               if(_loc44_ >= 2)
               {
                  do
                  {
                     _loc42_ = _loc44_ << 3;
                     _loc6_ = (_loc22_ = lf64(_loc42_ = _loc41_ + _loc42_)) + _loc6_;
                  }
                  while((_loc44_ += -1) != 1);
                  
               }
            }
         }
         _loc24_ = lf64(_loc13_ - 400);
         if(_loc38_ == 0)
         {
            sf64(_loc24_,_loc45_);
            sf64(_loc22_ = lf64(_loc13_ - 392),_loc45_ + 8);
            sf64(_loc6_,_loc45_ + 16);
         }
         else
         {
            sf64(_loc22_ = -_loc24_,_loc45_);
            sf64(_loc22_ = -(_loc22_ = lf64(_loc13_ - 392)),_loc45_ + 8);
            sf64(_loc22_ = -_loc6_,_loc45_ + 16);
         }
      }
      eax = _loc42_ = _loc25_ & 7;
      ESP = _loc9_ = _loc13_;
   }
}
