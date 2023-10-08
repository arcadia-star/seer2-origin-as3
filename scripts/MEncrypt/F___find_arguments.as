package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_build_arg_table;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.F_idalloc;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   import flash.utils.ByteArray;
   
   public function F___find_arguments() : void
   {
      var _loc8_:int = 0;
      var _loc18_:* = 0;
      var _loc19_:* = 0;
      var _loc20_:* = 0;
      var _loc5_:int = 0;
      var _loc16_:* = 0;
      var _loc13_:* = 0;
      var _loc15_:* = 0;
      var _loc2_:* = 0;
      var _loc9_:* = 0;
      var _loc12_:* = 0;
      var _loc3_:int = 0;
      var _loc17_:* = 0;
      var _loc11_:int = 0;
      var _loc14_:* = 0;
      var _loc4_:* = (_loc8_ = ESP) - 48;
      si32(_loc20_ = (_loc5_ = _loc8_ - 48) | 4,_loc8_ - 48);
      si32(8,_loc8_ - 12);
      si32(0,_loc8_ - 8);
      si32(1,_loc8_ - 4);
      si32(0,_loc20_ + 24);
      si32(0,_loc20_ + 20);
      si32(0,_loc20_ + 16);
      si32(0,_loc20_ + 12);
      si32(0,_loc20_ + 8);
      si32(0,_loc20_ + 4);
      si32(0,_loc20_);
      si32(0,_loc8_ - 16);
      _loc19_ = li32(_loc8_ + 8);
      _loc18_ = li32(_loc8_ + 4);
      _loc17_ = li32(_loc8_);
      _loc16_ = 1;
      loop0:
      while((_loc15_ = li8(_loc17_)) != 0)
      {
         if(_loc15_ == 37)
         {
            _loc17_ += 1;
            _loc14_ = 0;
            loop1:
            while(true)
            {
               _loc13_ = _loc17_ + 1;
               _loc15_ = si8(li8(_loc17_));
               while(true)
               {
                  _loc17_ = _loc13_;
                  if(_loc15_ <= 87)
                  {
                     if(_loc15_ <= 64)
                     {
                        if(_loc15_ > 42)
                        {
                           _loc2_ = _loc15_ + -43;
                           if(uint(_loc2_) <= 14)
                           {
                              _loc9_ = 0;
                              var _loc10_:*;
                              if((_loc10_ = (_loc13_ = 1 << _loc2_) & 32704) != 0)
                              {
                                 do
                                 {
                                    _loc10_ = _loc9_ * 10;
                                    _loc9_ = (_loc10_ = _loc15_ + _loc10_) + -48;
                                    _loc13_ = _loc17_ + 1;
                                    _loc10_ = (_loc15_ = si8(li8(_loc17_))) + -48;
                                    _loc17_ = _loc13_;
                                 }
                                 while(uint(_loc10_) < 10);
                                 
                                 if((_loc10_ = _loc15_ & 255) == 36)
                                 {
                                    si32(_loc9_,_loc8_ - 4);
                                    _loc16_ = _loc9_;
                                    _loc17_ = _loc13_;
                                    continue loop1;
                                 }
                                 continue;
                              }
                              if((_loc10_ = _loc13_ & 37) != 0)
                              {
                                 continue loop1;
                              }
                              if(_loc2_ != 3)
                              {
                                 break loop1;
                              }
                              _loc13_ = _loc17_ + 1;
                              if((_loc15_ = li8(_loc17_)) != 42)
                              {
                                 if((uint(_loc10_ = (_loc15_ = (_loc10_ = _loc15_ << 24) >> 24) + -48)) <= 9)
                                 {
                                    _loc17_ += 1;
                                    do
                                    {
                                       _loc13_ = _loc17_ + 1;
                                       _loc10_ = (_loc15_ = si8(li8(_loc17_))) + -48;
                                       _loc17_ = _loc13_;
                                    }
                                    while(uint(_loc10_) < 10);
                                    
                                 }
                                 continue;
                              }
                              _loc2_ = si8(li8(_loc13_));
                              _loc12_ = _loc2_ + -48;
                              _loc15_ = 0;
                              _loc9_ = _loc13_;
                              if(uint(_loc12_) <= 9)
                              {
                                 do
                                 {
                                    _loc15_ = (_loc10_ = _loc15_ * 10) + _loc12_;
                                    _loc9_ = _loc17_ + 1;
                                    _loc2_ = si8(li8(_loc17_ + 2));
                                    _loc12_ = _loc2_ + -48;
                                    _loc17_ = _loc9_;
                                 }
                                 while(uint(_loc12_) < 10);
                                 
                                 _loc9_ += 1;
                              }
                              if((_loc10_ = _loc2_ & 255) == 36)
                              {
                                 si32(_loc15_,_loc8_ - 4);
                                 _loc13_ = li32(_loc8_ - 12);
                                 if(_loc15_ >= _loc13_)
                                 {
                                    _loc17_ = _loc13_ << 1;
                                    _loc2_ = _loc11_ = _loc15_ + 1;
                                    if(_loc11_ <= _loc17_)
                                    {
                                       _loc2_ = _loc17_;
                                    }
                                    _loc15_ = _loc2_ << 2;
                                    _loc12_ = li32(_loc8_ - 48);
                                    if(_loc13_ == 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_);
                                       ESP = _loc4_;
                                       F_malloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       _loc3_ = eax;
                                       if(_loc3_ != 0)
                                       {
                                          _loc10_ = _loc13_ << 2;
                                          var _loc1_:ByteArray = ram;
                                          _loc1_.position = _loc3_;
                                          _loc1_.writeBytes(_loc1_,_loc12_,_loc10_);
                                          addr1154:
                                          if(_loc13_ < _loc2_)
                                          {
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 4);
                                             si32(_loc10_ = _loc3_ + (_loc13_ << 2),_loc4_);
                                             if(_loc17_ <= _loc11_)
                                             {
                                                _loc17_ = _loc11_;
                                             }
                                             si32(_loc10_ = (_loc10_ = _loc17_ - _loc13_) << 2,_loc4_ + 8);
                                             ESP = _loc4_;
                                             Fmemset();
                                             _loc4_ += 16;
                                          }
                                          si32(_loc3_,_loc8_ - 48);
                                          si32(_loc2_,_loc8_ - 12);
                                          _loc15_ = li32(_loc8_ - 4);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    else
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_ + 4);
                                       si32(_loc12_,_loc4_);
                                       ESP = _loc4_;
                                       F_realloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       _loc3_ = eax;
                                       if(_loc3_ != 0)
                                       {
                                          §§goto(addr1154);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    §§goto(addr5817);
                                 }
                                 _loc10_ = li32(_loc8_ - 8);
                                 if(_loc15_ > _loc10_)
                                 {
                                    si32(_loc15_,_loc8_ - 8);
                                 }
                                 var _loc6_:* = _loc15_ << 2;
                                 _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                                 si32(2,_loc10_);
                                 si32(_loc16_,_loc8_ - 4);
                                 _loc17_ = _loc9_ + 1;
                              }
                              else
                              {
                                 _loc9_ = li32(_loc8_ - 12);
                                 if(_loc16_ >= _loc9_)
                                 {
                                    _loc17_ = _loc9_ << 1;
                                    _loc2_ = _loc16_ + 1;
                                    _loc12_ = _loc2_;
                                    if(_loc2_ <= _loc17_)
                                    {
                                       _loc12_ = _loc17_;
                                    }
                                    _loc15_ = _loc12_ << 2;
                                    _loc16_ = li32(_loc8_ - 48);
                                    if(_loc9_ == 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_);
                                       ESP = _loc4_;
                                       F_malloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc11_ = eax) != 0)
                                       {
                                          _loc10_ = _loc9_ << 2;
                                          _loc1_ = ram;
                                          _loc1_.position = _loc11_;
                                          _loc1_.writeBytes(_loc1_,_loc16_,_loc10_);
                                          addr1388:
                                          if(_loc9_ < _loc12_)
                                          {
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 4);
                                             si32(_loc10_ = _loc11_ + (_loc9_ << 2),_loc4_);
                                             if(_loc17_ <= _loc2_)
                                             {
                                                _loc17_ = _loc2_;
                                             }
                                             si32(_loc10_ = (_loc10_ = _loc17_ - _loc9_) << 2,_loc4_ + 8);
                                             ESP = _loc4_;
                                             Fmemset();
                                             _loc4_ += 16;
                                          }
                                          si32(_loc11_,_loc8_ - 48);
                                          si32(_loc12_,_loc8_ - 12);
                                          _loc16_ = li32(_loc8_ - 4);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    else
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_ + 4);
                                       si32(_loc16_,_loc4_);
                                       ESP = _loc4_;
                                       F_realloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc11_ = eax) != 0)
                                       {
                                          §§goto(addr1388);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    §§goto(addr5817);
                                 }
                                 _loc10_ = li32(_loc8_ - 8);
                                 if(_loc16_ > _loc10_)
                                 {
                                    si32(_loc16_,_loc8_ - 8);
                                 }
                                 _loc6_ = _loc16_ << 2;
                                 _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                                 si32(2,_loc10_);
                                 si32(_loc16_ += 1,_loc8_ - 4);
                                 _loc17_ = _loc13_;
                              }
                              continue loop1;
                              §§goto(addr5817);
                           }
                           break loop1;
                        }
                        if(_loc15_ <= 38)
                        {
                           if(_loc15_ != 32)
                           {
                              if(_loc15_ != 35)
                              {
                                 break loop1;
                              }
                           }
                        }
                        else if(_loc15_ != 39)
                        {
                           if(_loc15_ != 42)
                           {
                              break loop1;
                           }
                           _loc2_ = (_loc9_ = si8(li8(_loc17_))) + -48;
                           _loc15_ = 0;
                           _loc13_ = _loc17_;
                           if(uint(_loc2_) <= 9)
                           {
                              do
                              {
                                 _loc15_ = (_loc10_ = _loc15_ * 10) + _loc2_;
                                 _loc10_ = _loc13_ + 1;
                                 _loc2_ = (_loc9_ = si8(li8(_loc13_ + 1))) + -48;
                                 _loc13_ = _loc10_;
                              }
                              while(uint(_loc2_) < 10);
                              
                           }
                           if((_loc10_ = _loc9_ & 255) == 36)
                           {
                              si32(_loc15_,_loc8_ - 4);
                              _loc9_ = li32(_loc8_ - 12);
                              if(_loc15_ >= _loc9_)
                              {
                                 _loc17_ = _loc9_ << 1;
                                 _loc12_ = _loc11_ = _loc15_ + 1;
                                 if(_loc11_ <= _loc17_)
                                 {
                                    _loc12_ = _loc17_;
                                 }
                                 _loc15_ = _loc12_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc9_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    _loc3_ = eax;
                                    if(_loc3_ != 0)
                                    {
                                       _loc10_ = _loc9_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc3_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr579:
                                       if(_loc9_ < _loc12_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc3_ + (_loc9_ << 2),_loc4_);
                                          if(_loc17_ <= _loc11_)
                                          {
                                             _loc17_ = _loc11_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc17_ - _loc9_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc3_,_loc8_ - 48);
                                       si32(_loc12_,_loc8_ - 12);
                                       _loc15_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    _loc3_ = eax;
                                    if(_loc3_ != 0)
                                    {
                                       §§goto(addr579);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc15_ > _loc10_)
                              {
                                 si32(_loc15_,_loc8_ - 8);
                              }
                              _loc10_ = _loc15_ << 2;
                              _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                              si32(2,_loc10_);
                              si32(_loc16_,_loc8_ - 4);
                              _loc17_ = _loc13_ + 1;
                           }
                           else
                           {
                              _loc9_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc9_)
                              {
                                 _loc13_ = _loc9_ << 1;
                                 _loc12_ = _loc16_ += 1;
                                 if(_loc16_ <= _loc13_)
                                 {
                                    _loc12_ = _loc13_;
                                 }
                                 _loc15_ = _loc12_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc9_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       _loc10_ = _loc9_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc11_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr813:
                                       if(_loc9_ < _loc12_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc11_ + (_loc9_ << 2),_loc4_);
                                          if(_loc13_ <= _loc16_)
                                          {
                                             _loc13_ = _loc16_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc13_ - _loc9_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc11_,_loc8_ - 48);
                                       si32(_loc12_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       §§goto(addr813);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc6_ = _loc16_ << 2;
                              _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                              si32(2,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                        }
                        continue loop1;
                     }
                     if(_loc15_ <= 70)
                     {
                        if(_loc15_ <= 67)
                        {
                           if(_loc15_ != 65)
                           {
                              if(_loc15_ != 67)
                              {
                                 break loop1;
                              }
                              _loc14_ |= 16;
                              addr1667:
                              _loc10_ = _loc14_ & 16;
                              _loc13_ = 2;
                              if(_loc10_ != 0)
                              {
                                 _loc13_ = 24;
                              }
                              _loc9_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc9_)
                              {
                                 _loc14_ = _loc9_ << 1;
                                 _loc2_ = _loc16_ + 1;
                                 _loc12_ = _loc2_;
                                 if(_loc2_ <= _loc14_)
                                 {
                                    _loc12_ = _loc14_;
                                 }
                                 _loc15_ = _loc12_ << 2;
                                 _loc16_ = li32(_loc8_ - 48);
                                 if(_loc9_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       _loc10_ = _loc9_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc11_;
                                       _loc1_.writeBytes(_loc1_,_loc16_,_loc10_);
                                       addr1796:
                                       if(_loc9_ < _loc12_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc11_ + (_loc9_ << 2),_loc4_);
                                          if(_loc14_ <= _loc2_)
                                          {
                                             _loc14_ = _loc2_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc9_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc11_,_loc8_ - 48);
                                       si32(_loc12_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc16_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       §§goto(addr1796);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc6_ = _loc16_ << 2;
                              _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                              si32(_loc13_,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else
                           {
                              addr2318:
                              _loc9_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc9_)
                              {
                                 _loc13_ = _loc9_ << 1;
                                 _loc16_ = _loc12_ = _loc16_ + 1;
                                 if(_loc12_ <= _loc13_)
                                 {
                                    _loc16_ = _loc13_;
                                 }
                                 _loc15_ = _loc16_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc9_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       _loc10_ = _loc9_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc11_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr2435:
                                       if(_loc9_ < _loc16_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc11_ + (_loc9_ << 2),_loc4_);
                                          if(_loc13_ <= _loc12_)
                                          {
                                             _loc13_ = _loc12_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc13_ - _loc9_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc11_,_loc8_ - 48);
                                       si32(_loc16_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       §§goto(addr2435);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc10_ = (_loc10_ = (_loc10_ = _loc14_ >>> 3) & 1) | 22;
                              var _loc7_:* = _loc16_ << 2;
                              _loc6_ = (_loc6_ = li32(_loc8_ - 48)) + _loc7_;
                              si32(_loc10_,_loc6_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           continue loop0;
                        }
                        if(_loc15_ == 68)
                        {
                           _loc14_ |= 16;
                           addr1918:
                           _loc13_ = li32(_loc8_ - 12);
                           if(_loc16_ >= _loc13_)
                           {
                              _loc9_ = _loc13_ << 1;
                              _loc2_ = _loc16_ + 1;
                              _loc16_ = _loc2_;
                              if(_loc2_ <= _loc9_)
                              {
                                 _loc16_ = _loc9_;
                              }
                              _loc15_ = _loc16_ << 2;
                              _loc12_ = li32(_loc8_ - 48);
                              if(_loc13_ == 8)
                              {
                                 _loc4_ -= 16;
                                 si32(_loc15_,_loc4_);
                                 ESP = _loc4_;
                                 F_malloc();
                                 _loc15_ = -1;
                                 _loc4_ += 16;
                                 if((_loc11_ = eax) != 0)
                                 {
                                    _loc10_ = _loc13_ << 2;
                                    _loc1_ = ram;
                                    _loc1_.position = _loc11_;
                                    _loc1_.writeBytes(_loc1_,_loc12_,_loc10_);
                                    addr2035:
                                    if(_loc13_ < _loc16_)
                                    {
                                       _loc4_ -= 16;
                                       si32(0,_loc4_ + 4);
                                       si32(_loc10_ = _loc11_ + (_loc13_ << 2),_loc4_);
                                       if(_loc9_ <= _loc2_)
                                       {
                                          _loc9_ = _loc2_;
                                       }
                                       si32(_loc10_ = (_loc10_ = _loc9_ - _loc13_) << 2,_loc4_ + 8);
                                       ESP = _loc4_;
                                       Fmemset();
                                       _loc4_ += 16;
                                    }
                                    si32(_loc11_,_loc8_ - 48);
                                    si32(_loc16_,_loc8_ - 12);
                                    _loc16_ = li32(_loc8_ - 4);
                                 }
                                 else
                                 {
                                    §§goto(addr5817);
                                 }
                              }
                              else
                              {
                                 _loc4_ -= 16;
                                 si32(_loc15_,_loc4_ + 4);
                                 si32(_loc12_,_loc4_);
                                 ESP = _loc4_;
                                 F_realloc();
                                 _loc15_ = -1;
                                 _loc4_ += 16;
                                 if((_loc11_ = eax) != 0)
                                 {
                                    §§goto(addr2035);
                                 }
                                 else
                                 {
                                    §§goto(addr5817);
                                 }
                              }
                              §§goto(addr5817);
                           }
                           _loc10_ = li32(_loc8_ - 8);
                           if(_loc16_ > _loc10_)
                           {
                              si32(_loc16_,_loc8_ - 8);
                           }
                           if((_loc10_ = _loc14_ & 4096) != 0)
                           {
                              si32(16,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 1024) != 0)
                           {
                              si32(13,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 2048) != 0)
                           {
                              si32(11,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 32) != 0)
                           {
                              si32(8,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else
                           {
                              _loc15_ = li32(_loc8_ - 48);
                              if((_loc14_ & 16) != 0)
                              {
                                 si32(5,_loc15_ + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else
                              {
                                 si32(2,_loc15_ + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                           }
                           continue loop0;
                        }
                        if(_loc15_ != 69)
                        {
                           break loop1;
                        }
                     }
                     else
                     {
                        if(_loc15_ > 78)
                        {
                           if(_loc15_ != 79)
                           {
                              if(_loc15_ != 83)
                              {
                                 if(_loc15_ != 85)
                                 {
                                    break loop1;
                                 }
                                 _loc14_ |= 16;
                                 break;
                              }
                              _loc14_ |= 16;
                              addr5130:
                              _loc10_ = _loc14_ & 16;
                              _loc9_ = 20;
                              if(_loc10_ != 0)
                              {
                                 _loc9_ = 25;
                              }
                              _loc14_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc14_)
                              {
                                 _loc13_ = _loc14_ << 1;
                                 _loc16_ = _loc12_ = _loc16_ + 1;
                                 if(_loc12_ <= _loc13_)
                                 {
                                    _loc16_ = _loc13_;
                                 }
                                 _loc15_ = _loc16_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc14_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       _loc10_ = _loc14_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc11_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr5259:
                                       if(_loc14_ < _loc16_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc11_ + (_loc14_ << 2),_loc4_);
                                          if(_loc13_ <= _loc12_)
                                          {
                                             _loc13_ = _loc12_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc13_ - _loc14_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc11_,_loc8_ - 48);
                                       si32(_loc16_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       §§goto(addr5259);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc10_ = _loc16_ << 2;
                              _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                              si32(_loc9_,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else
                           {
                              _loc14_ |= 16;
                              addr4491:
                              _loc9_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc9_)
                              {
                                 _loc13_ = _loc9_ << 1;
                                 _loc16_ = _loc12_ = _loc16_ + 1;
                                 if(_loc12_ <= _loc13_)
                                 {
                                    _loc16_ = _loc13_;
                                 }
                                 _loc15_ = _loc16_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc9_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       _loc10_ = _loc9_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc11_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr4608:
                                       if(_loc9_ < _loc16_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc11_ + (_loc9_ << 2),_loc4_);
                                          if(_loc13_ <= _loc12_)
                                          {
                                             _loc13_ = _loc12_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc13_ - _loc9_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc11_,_loc8_ - 48);
                                       si32(_loc16_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc11_ = eax) != 0)
                                    {
                                       §§goto(addr4608);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              if((_loc10_ = _loc14_ & 4096) != 0)
                              {
                                 si32(17,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else if((_loc10_ = _loc14_ & 1024) != 0)
                              {
                                 si32(14,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else if((_loc10_ = _loc14_ & 2048) != 0)
                              {
                                 si32(14,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else if((_loc10_ = _loc14_ & 32) != 0)
                              {
                                 si32(9,(_loc6_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else
                              {
                                 _loc15_ = li32(_loc8_ - 48);
                                 if((_loc14_ & 16) != 0)
                                 {
                                    si32(6,_loc15_ + (_loc16_ << 2));
                                    si32(_loc16_ += 1,_loc8_ - 4);
                                 }
                                 else
                                 {
                                    si32(3,_loc15_ + (_loc16_ << 2));
                                    si32(_loc16_ += 1,_loc8_ - 4);
                                 }
                              }
                           }
                           continue loop0;
                        }
                        if(_loc15_ != 71)
                        {
                           if(_loc15_ != 76)
                           {
                              break loop1;
                           }
                           _loc14_ |= 8;
                           continue loop1;
                        }
                     }
                     §§goto(addr2318);
                  }
                  else
                  {
                     if(_loc15_ <= 109)
                     {
                        if(_loc15_ <= 100)
                        {
                           if(_loc15_ <= 98)
                           {
                              if(_loc15_ == 88)
                              {
                                 break;
                              }
                              if(_loc15_ != 97)
                              {
                                 break loop1;
                              }
                              §§goto(addr2318);
                           }
                           else
                           {
                              if(_loc15_ != 99)
                              {
                                 if(_loc15_ != 100)
                                 {
                                    break loop1;
                                 }
                              }
                              else
                              {
                                 §§goto(addr1667);
                              }
                              §§goto(addr5817);
                           }
                        }
                        else
                        {
                           if(_loc15_ <= 104)
                           {
                              if((uint(_loc10_ = _loc15_ + -101)) >= 3)
                              {
                                 if(_loc15_ != 104)
                                 {
                                    break loop1;
                                 }
                                 if((_loc10_ = _loc14_ & 64) != 0)
                                 {
                                    _loc14_ = (_loc10_ = _loc14_ & -8257) | 8192;
                                 }
                                 else
                                 {
                                    _loc14_ |= 64;
                                 }
                                 continue loop1;
                              }
                              §§goto(addr2318);
                           }
                           else if(_loc15_ != 105)
                           {
                              if(_loc15_ != 106)
                              {
                                 if(_loc15_ != 108)
                                 {
                                    break loop1;
                                 }
                                 if((_loc10_ = _loc14_ & 16) != 0)
                                 {
                                    _loc14_ = (_loc10_ = _loc14_ & -49) | 32;
                                 }
                                 else
                                 {
                                    _loc14_ |= 16;
                                 }
                              }
                              else
                              {
                                 _loc14_ |= 4096;
                              }
                              continue loop1;
                           }
                           §§goto(addr5817);
                        }
                        §§goto(addr1918);
                     }
                     else if(_loc15_ <= 114)
                     {
                        if(_loc15_ > 111)
                        {
                           if(_loc15_ != 112)
                           {
                              if(_loc15_ != 113)
                              {
                                 break loop1;
                              }
                              _loc14_ |= 32;
                              continue loop1;
                           }
                           _loc13_ = li32(_loc8_ - 12);
                           if(_loc16_ >= _loc13_)
                           {
                              _loc14_ = _loc13_ << 1;
                              _loc2_ = _loc16_ + 1;
                              _loc16_ = _loc2_;
                              if(_loc2_ <= _loc14_)
                              {
                                 _loc16_ = _loc14_;
                              }
                              _loc15_ = _loc16_ << 2;
                              _loc9_ = li32(_loc8_ - 48);
                              if(_loc13_ == 8)
                              {
                                 _loc4_ -= 16;
                                 si32(_loc15_,_loc4_);
                                 ESP = _loc4_;
                                 F_malloc();
                                 _loc15_ = -1;
                                 _loc4_ += 16;
                                 if((_loc12_ = eax) != 0)
                                 {
                                    _loc10_ = _loc13_ << 2;
                                    _loc1_ = ram;
                                    _loc1_.position = _loc12_;
                                    _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                    addr5008:
                                    if(_loc13_ < _loc16_)
                                    {
                                       _loc4_ -= 16;
                                       si32(0,_loc4_ + 4);
                                       si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                       if(_loc14_ <= _loc2_)
                                       {
                                          _loc14_ = _loc2_;
                                       }
                                       si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                       ESP = _loc4_;
                                       Fmemset();
                                       _loc4_ += 16;
                                    }
                                    si32(_loc12_,_loc8_ - 48);
                                    si32(_loc16_,_loc8_ - 12);
                                    _loc16_ = li32(_loc8_ - 4);
                                 }
                                 else
                                 {
                                    §§goto(addr5817);
                                 }
                              }
                              else
                              {
                                 _loc4_ -= 16;
                                 si32(_loc15_,_loc4_ + 4);
                                 si32(_loc9_,_loc4_);
                                 ESP = _loc4_;
                                 F_realloc();
                                 _loc15_ = -1;
                                 _loc4_ += 16;
                                 if((_loc12_ = eax) != 0)
                                 {
                                    §§goto(addr5008);
                                 }
                                 else
                                 {
                                    §§goto(addr5817);
                                 }
                              }
                              §§goto(addr5817);
                           }
                           _loc10_ = li32(_loc8_ - 8);
                           if(_loc16_ > _loc10_)
                           {
                              si32(_loc16_,_loc8_ - 8);
                           }
                           _loc10_ = _loc16_ << 2;
                           _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                           si32(19,_loc10_);
                           si32(_loc16_ += 1,_loc8_ - 4);
                           continue loop0;
                        }
                        if(_loc15_ == 110)
                        {
                           if((_loc10_ = _loc14_ & 4096) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc2_ = _loc16_ + 1;
                                 _loc16_ = _loc2_;
                                 if(_loc2_ <= _loc14_)
                                 {
                                    _loc16_ = _loc14_;
                                 }
                                 _loc15_ = _loc16_ << 2;
                                 _loc9_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                       addr2690:
                                       if(_loc13_ < _loc16_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc2_)
                                          {
                                             _loc14_ = _loc2_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc16_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc9_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr2690);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc10_ = _loc16_ << 2;
                              _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                              si32(18,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 2048) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc16_ = _loc9_ = _loc16_ + 1;
                                 if(_loc9_ <= _loc14_)
                                 {
                                    _loc16_ = _loc14_;
                                 }
                                 _loc15_ = _loc16_ << 2;
                                 _loc2_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                                       addr2932:
                                       if(_loc13_ < _loc16_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc9_)
                                          {
                                             _loc14_ = _loc9_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc16_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc2_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr2932);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc6_ = _loc16_ << 2;
                              _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                              si32(12,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 1024) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc2_ = _loc16_ += 1;
                                 if(_loc16_ <= _loc14_)
                                 {
                                    _loc2_ = _loc14_;
                                 }
                                 _loc15_ = _loc2_ << 2;
                                 _loc9_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                       addr3174:
                                       if(_loc13_ < _loc2_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc16_)
                                          {
                                             _loc14_ = _loc16_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc2_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc9_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr3174);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc10_ = _loc16_ << 2;
                              _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                              si32(15,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 32) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc2_ = _loc16_ += 1;
                                 if(_loc16_ <= _loc14_)
                                 {
                                    _loc2_ = _loc14_;
                                 }
                                 _loc15_ = _loc2_ << 2;
                                 _loc9_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                       addr3416:
                                       if(_loc13_ < _loc2_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc16_)
                                          {
                                             _loc14_ = _loc16_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc2_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc9_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr3416);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc6_ = _loc16_ << 2;
                              _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                              si32(10,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 16) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc2_ = _loc16_ += 1;
                                 if(_loc16_ <= _loc14_)
                                 {
                                    _loc2_ = _loc14_;
                                 }
                                 _loc15_ = _loc2_ << 2;
                                 _loc9_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                       addr3658:
                                       if(_loc13_ < _loc2_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc16_)
                                          {
                                             _loc14_ = _loc16_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc2_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc9_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr3658);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc10_ = _loc16_ << 2;
                              _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                              si32(7,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else if((_loc10_ = _loc14_ & 64) != 0)
                           {
                              _loc13_ = li32(_loc8_ - 12);
                              if(_loc16_ >= _loc13_)
                              {
                                 _loc14_ = _loc13_ << 1;
                                 _loc2_ = _loc9_ = _loc16_ + 1;
                                 if(_loc9_ <= _loc14_)
                                 {
                                    _loc2_ = _loc14_;
                                 }
                                 _loc15_ = _loc2_ << 2;
                                 _loc16_ = li32(_loc8_ - 48);
                                 if(_loc13_ == 8)
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_);
                                    ESP = _loc4_;
                                    F_malloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       _loc10_ = _loc13_ << 2;
                                       _loc1_ = ram;
                                       _loc1_.position = _loc12_;
                                       _loc1_.writeBytes(_loc1_,_loc16_,_loc10_);
                                       addr3900:
                                       if(_loc13_ < _loc2_)
                                       {
                                          _loc4_ -= 16;
                                          si32(0,_loc4_ + 4);
                                          si32(_loc10_ = _loc12_ + (_loc13_ << 2),_loc4_);
                                          if(_loc14_ <= _loc9_)
                                          {
                                             _loc14_ = _loc9_;
                                          }
                                          si32(_loc10_ = (_loc10_ = _loc14_ - _loc13_) << 2,_loc4_ + 8);
                                          ESP = _loc4_;
                                          Fmemset();
                                          _loc4_ += 16;
                                       }
                                       si32(_loc12_,_loc8_ - 48);
                                       si32(_loc2_,_loc8_ - 12);
                                       _loc16_ = li32(_loc8_ - 4);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ -= 16;
                                    si32(_loc15_,_loc4_ + 4);
                                    si32(_loc16_,_loc4_);
                                    ESP = _loc4_;
                                    F_realloc();
                                    _loc15_ = -1;
                                    _loc4_ += 16;
                                    if((_loc12_ = eax) != 0)
                                    {
                                       §§goto(addr3900);
                                    }
                                    else
                                    {
                                       §§goto(addr5817);
                                    }
                                 }
                                 §§goto(addr5817);
                              }
                              _loc10_ = li32(_loc8_ - 8);
                              if(_loc16_ > _loc10_)
                              {
                                 si32(_loc16_,_loc8_ - 8);
                              }
                              _loc6_ = _loc16_ << 2;
                              _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                              si32(1,_loc10_);
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else
                           {
                              _loc14_ = li32(_loc8_ - 12);
                              if((_loc14_ & 8192) != 0)
                              {
                                 if(_loc16_ >= _loc14_)
                                 {
                                    _loc13_ = _loc14_ << 1;
                                    _loc2_ = _loc16_ + 1;
                                    _loc16_ = _loc2_;
                                    if(_loc2_ <= _loc13_)
                                    {
                                       _loc16_ = _loc13_;
                                    }
                                    _loc15_ = _loc16_ << 2;
                                    _loc9_ = li32(_loc8_ - 48);
                                    if(_loc14_ == 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_);
                                       ESP = _loc4_;
                                       F_malloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc12_ = eax) != 0)
                                       {
                                          _loc10_ = _loc14_ << 2;
                                          _loc1_ = ram;
                                          _loc1_.position = _loc12_;
                                          _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                          addr4140:
                                          if(_loc14_ < _loc16_)
                                          {
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 4);
                                             si32(_loc10_ = _loc12_ + (_loc14_ << 2),_loc4_);
                                             if(_loc13_ <= _loc2_)
                                             {
                                                _loc13_ = _loc2_;
                                             }
                                             si32(_loc10_ = (_loc10_ = _loc13_ - _loc14_) << 2,_loc4_ + 8);
                                             ESP = _loc4_;
                                             Fmemset();
                                             _loc4_ += 16;
                                          }
                                          si32(_loc12_,_loc8_ - 48);
                                          si32(_loc16_,_loc8_ - 12);
                                          _loc16_ = li32(_loc8_ - 4);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    else
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_ + 4);
                                       si32(_loc9_,_loc4_);
                                       ESP = _loc4_;
                                       F_realloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc12_ = eax) != 0)
                                       {
                                          §§goto(addr4140);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    §§goto(addr5817);
                                 }
                                 _loc10_ = li32(_loc8_ - 8);
                                 if(_loc16_ > _loc10_)
                                 {
                                    si32(_loc16_,_loc8_ - 8);
                                 }
                                 _loc6_ = _loc16_ << 2;
                                 _loc10_ = (_loc10_ = li32(_loc8_ - 48)) + _loc6_;
                                 si32(21,_loc10_);
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                              else
                              {
                                 if(_loc16_ >= _loc14_)
                                 {
                                    _loc13_ = _loc14_ << 1;
                                    _loc2_ = _loc16_ + 1;
                                    _loc16_ = _loc2_;
                                    if(_loc2_ <= _loc13_)
                                    {
                                       _loc16_ = _loc13_;
                                    }
                                    _loc15_ = _loc16_ << 2;
                                    _loc9_ = li32(_loc8_ - 48);
                                    if(_loc14_ == 8)
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_);
                                       ESP = _loc4_;
                                       F_malloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc12_ = eax) != 0)
                                       {
                                          _loc10_ = _loc14_ << 2;
                                          _loc1_ = ram;
                                          _loc1_.position = _loc12_;
                                          _loc1_.writeBytes(_loc1_,_loc9_,_loc10_);
                                          addr4369:
                                          if(_loc14_ < _loc16_)
                                          {
                                             _loc4_ -= 16;
                                             si32(0,_loc4_ + 4);
                                             si32(_loc10_ = _loc12_ + (_loc14_ << 2),_loc4_);
                                             if(_loc13_ <= _loc2_)
                                             {
                                                _loc13_ = _loc2_;
                                             }
                                             si32(_loc10_ = (_loc10_ = _loc13_ - _loc14_) << 2,_loc4_ + 8);
                                             ESP = _loc4_;
                                             Fmemset();
                                             _loc4_ += 16;
                                          }
                                          si32(_loc12_,_loc8_ - 48);
                                          si32(_loc16_,_loc8_ - 12);
                                          _loc16_ = li32(_loc8_ - 4);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    else
                                    {
                                       _loc4_ -= 16;
                                       si32(_loc15_,_loc4_ + 4);
                                       si32(_loc9_,_loc4_);
                                       ESP = _loc4_;
                                       F_realloc();
                                       _loc15_ = -1;
                                       _loc4_ += 16;
                                       if((_loc12_ = eax) != 0)
                                       {
                                          §§goto(addr4369);
                                       }
                                       else
                                       {
                                          §§goto(addr5817);
                                       }
                                    }
                                    §§goto(addr5817);
                                 }
                                 _loc10_ = li32(_loc8_ - 8);
                                 if(_loc16_ > _loc10_)
                                 {
                                    si32(_loc16_,_loc8_ - 8);
                                 }
                                 _loc10_ = _loc16_ << 2;
                                 _loc10_ = (_loc6_ = li32(_loc8_ - 48)) + _loc10_;
                                 si32(4,_loc10_);
                                 si32(_loc16_ += 1,_loc8_ - 4);
                              }
                           }
                           continue loop0;
                        }
                        if(_loc15_ != 111)
                        {
                           break loop1;
                        }
                        §§goto(addr4491);
                     }
                     else
                     {
                        if(_loc15_ > 116)
                        {
                           if(_loc15_ == 117)
                           {
                              break;
                           }
                           if(_loc15_ == 120)
                           {
                              break;
                           }
                           if(_loc15_ != 122)
                           {
                              break loop1;
                           }
                           _loc14_ |= 1024;
                           continue loop1;
                        }
                        if(_loc15_ != 115)
                        {
                           if(_loc15_ != 116)
                           {
                              break loop1;
                           }
                           _loc14_ |= 2048;
                           continue loop1;
                        }
                        §§goto(addr5130);
                     }
                     §§goto(addr5817);
                  }
               }
               _loc13_ = li32(_loc8_ - 12);
               if(_loc16_ >= _loc13_)
               {
                  _loc9_ = _loc13_ << 1;
                  _loc16_ = _loc12_ = _loc16_ + 1;
                  if(_loc12_ <= _loc9_)
                  {
                     _loc16_ = _loc9_;
                  }
                  _loc15_ = _loc16_ << 2;
                  _loc2_ = li32(_loc8_ - 48);
                  if(_loc13_ == 8)
                  {
                     _loc4_ -= 16;
                     si32(_loc15_,_loc4_);
                     ESP = _loc4_;
                     F_malloc();
                     _loc15_ = -1;
                     _loc4_ += 16;
                     if((_loc11_ = eax) != 0)
                     {
                        _loc10_ = _loc13_ << 2;
                        _loc1_ = ram;
                        _loc1_.position = _loc11_;
                        _loc1_.writeBytes(_loc1_,_loc2_,_loc10_);
                        addr5498:
                        if(_loc13_ < _loc16_)
                        {
                           _loc4_ -= 16;
                           si32(0,_loc4_ + 4);
                           si32(_loc10_ = _loc11_ + (_loc13_ << 2),_loc4_);
                           if(_loc9_ <= _loc12_)
                           {
                              _loc9_ = _loc12_;
                           }
                           si32(_loc10_ = (_loc10_ = _loc9_ - _loc13_) << 2,_loc4_ + 8);
                           ESP = _loc4_;
                           Fmemset();
                           _loc4_ += 16;
                        }
                        si32(_loc11_,_loc8_ - 48);
                        si32(_loc16_,_loc8_ - 12);
                        _loc16_ = li32(_loc8_ - 4);
                        addr5571:
                        _loc10_ = li32(_loc8_ - 8);
                        if(_loc16_ > _loc10_)
                        {
                           si32(_loc16_,_loc8_ - 8);
                        }
                        if((_loc10_ = _loc14_ & 4096) != 0)
                        {
                           si32(17,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                           si32(_loc16_ += 1,_loc8_ - 4);
                        }
                        else if((_loc10_ = _loc14_ & 1024) != 0)
                        {
                           si32(14,(_loc10_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                           si32(_loc16_ += 1,_loc8_ - 4);
                        }
                        else if((_loc10_ = _loc14_ & 2048) != 0)
                        {
                           si32(14,(_loc6_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                           si32(_loc16_ += 1,_loc8_ - 4);
                        }
                        else if((_loc10_ = _loc14_ & 32) != 0)
                        {
                           si32(9,(_loc6_ = li32(_loc8_ - 48)) + (_loc16_ << 2));
                           si32(_loc16_ += 1,_loc8_ - 4);
                        }
                        else
                        {
                           _loc15_ = li32(_loc8_ - 48);
                           if((_loc14_ & 16) != 0)
                           {
                              si32(6,_loc15_ + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                           else
                           {
                              si32(3,_loc15_ + (_loc16_ << 2));
                              si32(_loc16_ += 1,_loc8_ - 4);
                           }
                        }
                        continue loop0;
                     }
                  }
                  else
                  {
                     _loc4_ -= 16;
                     si32(_loc15_,_loc4_ + 4);
                     si32(_loc2_,_loc4_);
                     ESP = _loc4_;
                     F_realloc();
                     _loc15_ = -1;
                     _loc4_ += 16;
                     if((_loc11_ = eax) != 0)
                     {
                        §§goto(addr5498);
                     }
                  }
                  §§goto(addr5817);
               }
               §§goto(addr5571);
            }
            if(_loc15_ == 0)
            {
               break;
            }
         }
         else
         {
            _loc17_ += 1;
         }
      }
      _loc4_ -= 16;
      si32(_loc19_,_loc4_ + 8);
      si32(_loc18_,_loc4_ + 4);
      si32(_loc5_,_loc4_);
      ESP = _loc4_;
      F_build_arg_table();
      _loc4_ += 16;
      _loc15_ = 0;
      addr5817:
      if((_loc18_ = li32(_loc8_ - 48)) != _loc20_)
      {
         if(_loc18_ != 0)
         {
            _loc4_ -= 16;
            si32(_loc18_,_loc4_);
            ESP = _loc4_;
            F_idalloc();
            _loc4_ += 16;
         }
      }
      _loc20_ = 1;
      if(_loc15_ == 0)
      {
         _loc20_ = 1;
         if(li32(_loc19_) != 0)
         {
            _loc20_ = 0;
         }
      }
      eax = _loc20_;
      ESP = _loc4_ = _loc8_;
   }
}
