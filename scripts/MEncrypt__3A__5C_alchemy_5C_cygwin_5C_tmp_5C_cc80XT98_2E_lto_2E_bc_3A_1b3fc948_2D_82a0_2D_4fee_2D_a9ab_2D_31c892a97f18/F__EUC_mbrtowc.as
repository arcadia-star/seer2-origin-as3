package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.__CurrentRuneLocale;
   import MEncrypt.___mb_cur_max;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F__EUC_mbrtowc() : void
   {
      var _loc4_:* = 0;
      var _loc3_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc15_:* = 0;
      var _loc5_:* = 0;
      var _loc11_:* = 0;
      var _loc1_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = li32((_loc4_ = _loc2_) + 12);
      if((_loc15_ = li32(_loc3_ + 8)) >= 0)
      {
         if(_loc15_ <= li32(___mb_cur_max))
         {
            if((uint(_loc13_ = li32(_loc3_ + 4))) >= 4)
            {
               addr60:
               ESP = _loc2_;
               F___error();
               var _loc14_:* = eax;
               si32(22,_loc14_);
               _loc12_ = -1;
            }
            else
            {
               _loc11_ = li32(_loc4_ + 4);
               _loc10_ = 1;
               if(_loc11_ != 0)
               {
                  _loc10_ = li32(_loc4_ + 8);
               }
               _loc9_ = 0;
               if(_loc11_ != 0)
               {
                  _loc9_ = li32(_loc4_);
               }
               _loc8_ = L__2E_str414;
               if(_loc11_ != 0)
               {
                  _loc8_ = _loc11_;
               }
               _loc12_ = -2;
               if(_loc10_ != 0)
               {
                  if(_loc15_ == 0)
                  {
                     _loc12_ = li32((_loc14_ = li32(__CurrentRuneLocale)) + 3148);
                     _loc1_ = si8(li8(_loc8_));
                     _loc13_ = 0;
                     if((_loc1_ & 128) != 0)
                     {
                        _loc11_ = _loc1_ & 255;
                        _loc13_ = 2;
                        if(_loc11_ != 142)
                        {
                           _loc13_ = 1;
                           if(_loc11_ == 143)
                           {
                              _loc13_ = 3;
                              addr178:
                              _loc14_ = _loc13_ << 2;
                              _loc12_ = (_loc14_ = li32(_loc14_ = _loc12_ + _loc14_)) + -1;
                              if((_loc10_ += -1) == 0)
                              {
                                 si32(_loc13_,_loc3_ + 4);
                                 si32(_loc12_,_loc3_ + 8);
                                 si32(0,_loc3_);
                                 _loc12_ = -2;
                              }
                              else
                              {
                                 _loc1_ = li8(_loc8_ + 1);
                                 _loc11_ = _loc8_ + 1;
                                 if(_loc1_ == 0)
                                 {
                                    ESP = _loc2_;
                                    F___error();
                                    si32(86,eax);
                                    _loc12_ = -1;
                                 }
                              }
                              §§goto(addr425);
                           }
                           else
                           {
                              addr162:
                              _loc14_ = _loc13_ << 2;
                              _loc12_ = li32(_loc14_ = _loc12_ + _loc14_);
                              _loc11_ = _loc8_;
                           }
                           _loc11_ += 1;
                           _loc1_ &= 255;
                           §§goto(addr271);
                        }
                        §§goto(addr178);
                     }
                     §§goto(addr162);
                  }
                  else
                  {
                     _loc1_ = li32(_loc3_);
                     _loc12_ = _loc15_;
                     _loc11_ = _loc8_;
                  }
                  addr271:
                  _loc5_ = 1;
                  if(_loc15_ != 0)
                  {
                     _loc5_ = 0;
                  }
                  if(uint(_loc10_) > uint(_loc12_))
                  {
                     _loc10_ = _loc12_;
                  }
                  _loc5_ &= 1;
                  while(true)
                  {
                     if(uint(_loc5_) >= uint(_loc10_))
                     {
                        if(_loc5_ < _loc12_)
                        {
                           si32(_loc13_,_loc3_ + 4);
                           si32(_loc14_ = _loc12_ - _loc5_,_loc3_ + 8);
                           si32(_loc1_,_loc3_);
                           _loc12_ = -2;
                           break;
                        }
                        var _loc6_:*;
                        _loc13_ = _loc1_ & ((_loc14_ = li32((_loc6_ = li32((_loc14_ = li32(__CurrentRuneLocale)) + 3148)) + 32)) ^ -1) | li32((_loc6_ += _loc13_ << 2) + 16);
                        if(_loc9_ != 0)
                        {
                           si32(_loc13_,_loc9_);
                        }
                        si32(_loc12_ = 0,_loc3_ + 8);
                        if(_loc13_ != 0)
                        {
                           _loc12_ = _loc11_ - _loc8_;
                           break;
                        }
                        break;
                     }
                     if((_loc15_ = li8(_loc11_)) == 0)
                     {
                        ESP = _loc2_;
                        F___error();
                        si32(86,eax);
                        _loc12_ = -1;
                        break;
                     }
                     _loc1_ = _loc15_ | _loc1_ << 8;
                     _loc5_ += 1;
                     _loc11_ += 1;
                  }
                  §§goto(addr425);
               }
            }
            addr425:
            eax = _loc12_;
            _loc2_ = _loc4_;
            ESP = _loc2_;
            return;
         }
      }
      §§goto(addr60);
   }
}
