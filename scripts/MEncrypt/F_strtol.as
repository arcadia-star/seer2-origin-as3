package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_strtol() : void
   {
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc9_:* = 0;
      var _loc15_:* = 0;
      var _loc1_:* = 0;
      var _loc16_:int = 0;
      var _loc10_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc3_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32(_loc4_ = _loc2_);
      _loc16_ = _loc3_ + 1;
      _loc15_ = _loc3_ + 2;
      _loc14_ = li32(__CurrentRuneLocale);
      _loc13_ = li32(___mb_sb_limit);
      _loc12_ = li32(_loc4_ + 8);
      _loc11_ = li32(_loc4_ + 4);
      var _loc5_:*;
      do
      {
         _loc10_ = _loc16_;
         _loc1_ = li8((_loc9_ = _loc15_) - 2);
         if(_loc13_ <= _loc1_)
         {
            break;
         }
         _loc16_ = _loc10_ + 1;
         _loc15_ = _loc9_ + 1;
      }
      while(((_loc5_ = li8((_loc5_ = _loc14_ + (_loc1_ << 2)) + 53)) & 64) != 0);
      
      if(_loc1_ != 43)
      {
         _loc16_ = 0;
         if(_loc1_ == 45)
         {
            _loc1_ = li8(_loc10_);
            _loc16_ = 1;
            _loc10_ = _loc9_;
         }
      }
      else
      {
         _loc1_ = li8(_loc10_);
         _loc16_ = 0;
         _loc10_ = _loc9_;
      }
      if((_loc5_ = _loc12_ | 16) == 16)
      {
         if((_loc9_ = _loc1_ & 255) == 48)
         {
            if((_loc5_ = (_loc5_ = (_loc5_ = li8(_loc10_)) | 32) & 255) == 120)
            {
               if((uint(_loc5_ = (_loc5_ = (_loc15_ = li8(_loc10_ + 1)) + -48) & 255)) >= 10)
               {
                  if((uint(_loc5_ = (_loc5_ = _loc15_ + -65) & 255)) >= 6)
                  {
                     if((uint(_loc5_ = (_loc5_ = _loc15_ + -97) & 255)) <= 5)
                     {
                        addr213:
                        _loc10_ += 2;
                        _loc12_ = 16;
                        _loc1_ = _loc15_;
                        §§goto(addr249);
                     }
                     else
                     {
                        addr224:
                        if(_loc12_ == 0)
                        {
                           _loc12_ = 8;
                           if(_loc9_ != 48)
                           {
                              _loc12_ = 10;
                           }
                           addr237:
                           _loc5_ = _loc12_ + -2;
                           _loc6_ = 0;
                           if(uint(_loc5_) <= 34)
                           {
                              addr249:
                              _loc7_ = 2147483647;
                              _loc6_ = 0;
                              if(_loc16_ != _loc6_)
                              {
                                 _loc7_ = -2147483648;
                              }
                              _loc9_ = uint(_loc7_) / uint(_loc12_);
                              _loc13_ = uint(_loc7_) % uint(_loc12_);
                              _loc8_ = _loc6_;
                              while(true)
                              {
                                 _loc15_ = _loc10_;
                                 _loc14_ = _loc8_;
                                 if((uint(_loc5_ = (_loc10_ = _loc1_ + -48) & 255)) >= 10)
                                 {
                                    if((uint(_loc5_ = (_loc5_ = _loc1_ + -65) & 255)) > 25)
                                    {
                                       if((uint(_loc5_ = (_loc5_ = _loc1_ + -97) & 255)) > 25)
                                       {
                                          break;
                                       }
                                       _loc10_ = _loc1_ + -87;
                                       addr335:
                                       _loc1_ = (_loc5_ = _loc10_ << 24) >> 24;
                                       if(_loc1_ >= _loc12_)
                                       {
                                          break;
                                       }
                                       _loc8_ = -1;
                                       if(_loc14_ >= 0)
                                       {
                                          if(uint(_loc6_) <= uint(_loc9_))
                                          {
                                             if(_loc6_ == _loc9_)
                                             {
                                                _loc8_ = -1;
                                                if(_loc1_ > _loc13_)
                                                {
                                                   continue;
                                                }
                                             }
                                             _loc5_ = _loc6_ * _loc12_;
                                             _loc6_ = _loc1_ + _loc5_;
                                             _loc8_ = 1;
                                          }
                                       }
                                       continue;
                                    }
                                    _loc10_ = _loc1_ + -55;
                                 }
                                 §§goto(addr335);
                              }
                              if(_loc14_ <= -1)
                              {
                                 ESP = _loc2_;
                                 F___error();
                                 si32(34,eax);
                                 _loc6_ = _loc7_;
                                 _loc10_ = _loc15_;
                              }
                              else
                              {
                                 _loc10_ = _loc15_;
                                 if(_loc14_ == 0)
                                 {
                                    addr421:
                                    ESP = _loc2_;
                                    F___error();
                                    _loc5_ = eax;
                                    si32(22,_loc5_);
                                    _loc14_ = 0;
                                 }
                                 else
                                 {
                                    if(_loc16_ != 0)
                                    {
                                       _loc6_ = 0 - _loc6_;
                                    }
                                    _loc10_ = _loc15_;
                                 }
                              }
                              if(_loc11_ != 0)
                              {
                                 if(_loc14_ != 0)
                                 {
                                    _loc3_ = _loc10_ + -1;
                                 }
                                 si32(_loc3_,_loc11_);
                              }
                              eax = _loc6_;
                              _loc2_ = _loc4_;
                              ESP = _loc2_;
                              return;
                           }
                        }
                        §§goto(addr237);
                     }
                  }
               }
               §§goto(addr213);
            }
         }
         §§goto(addr224);
      }
      §§goto(addr237);
   }
}
