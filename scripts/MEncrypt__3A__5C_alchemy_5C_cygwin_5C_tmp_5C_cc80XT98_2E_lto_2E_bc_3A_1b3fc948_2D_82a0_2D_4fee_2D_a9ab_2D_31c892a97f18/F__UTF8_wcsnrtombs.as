package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.Fmemcpy;
   import MEncrypt.___mb_cur_max;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F__UTF8_wcsnrtombs() : void
   {
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc14_:* = 0;
      var _loc9_:* = 0;
      var _loc4_:* = 0;
      var _loc15_:* = 0;
      var _loc13_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:int = 0;
      var _loc8_:* = 0;
      var _loc2_:int = 0;
      var _loc16_:int = 0;
      var _loc3_:* = ESP;
      _loc5_ = _loc3_;
      _loc3_ -= 16;
      var _loc17_:*;
      if((_loc17_ = li32((_loc4_ = li32(_loc5_ + 16)) + 4)) != 0)
      {
         ESP = _loc3_;
         F___error();
         si32(22,eax);
         _loc16_ = -1;
      }
      else
      {
         _loc15_ = li32(_loc5_ + 12);
         _loc14_ = li32(_loc5_ + 8);
         _loc13_ = li32(_loc5_ + 4);
         _loc12_ = li32(_loc5_);
         _loc11_ = li32(_loc13_);
         _loc16_ = 0;
         if(_loc12_ != 0)
         {
            while(_loc15_ != 0)
            {
               if(_loc14_ != 0)
               {
                  _loc1_ = li32(_loc11_);
                  if(uint(_loc1_) <= 127)
                  {
                     si8(_loc1_,_loc12_);
                     _loc10_ = 1;
                  }
                  else
                  {
                     _loc10_ = li32(_loc4_ + 4);
                     if((uint(_loc17_ = li32(___mb_cur_max))) < uint(_loc15_))
                     {
                        if(_loc10_ != 0)
                        {
                           ESP = _loc3_;
                           F___error();
                           si32(22,eax);
                           §§goto(addr437);
                        }
                        _loc10_ = 1;
                        if(_loc12_ != 0)
                        {
                           if(uint(_loc1_) <= 127)
                           {
                              si8(_loc1_,_loc12_);
                              _loc10_ = 1;
                           }
                           else
                           {
                              _loc10_ = 2;
                              _loc7_ = 192;
                              if(uint(_loc1_) >= 2048)
                              {
                                 _loc10_ = 3;
                                 _loc7_ = 224;
                                 if(uint(_loc1_) >= 65536)
                                 {
                                    _loc10_ = 4;
                                    _loc7_ = 240;
                                    if(uint(_loc1_) >= 2097152)
                                    {
                                       _loc10_ = 5;
                                       _loc7_ = 248;
                                       if(uint(_loc1_) >= 67108864)
                                       {
                                          _loc10_ = 6;
                                          _loc7_ = 252;
                                          if(_loc1_ <= -1)
                                          {
                                             ESP = _loc3_;
                                             F___error();
                                             si32(86,eax);
                                          }
                                          §§goto(addr437);
                                       }
                                    }
                                 }
                              }
                              _loc8_ = 1 - _loc10_;
                              _loc9_ = _loc1_;
                              do
                              {
                                 _loc17_ = _loc12_ - _loc8_;
                                 var _loc6_:*;
                                 si8(_loc6_ = (_loc6_ = _loc1_ & 63) | 128,_loc17_);
                                 _loc8_ += 1;
                                 _loc1_ = _loc9_ >> 6;
                                 _loc9_ = _loc1_;
                              }
                              while(_loc8_ != 0);
                              
                              si8(_loc17_ = _loc1_ | _loc7_,_loc12_);
                           }
                        }
                     }
                     else if(_loc10_ != 0)
                     {
                        ESP = _loc3_;
                        F___error();
                        si32(22,eax);
                        §§goto(addr567);
                     }
                     else
                     {
                        _loc10_ = 2;
                        _loc2_ = 192;
                        if(uint(_loc1_) >= 2048)
                        {
                           _loc10_ = 3;
                           _loc2_ = 224;
                           if(uint(_loc1_) >= 65536)
                           {
                              _loc10_ = 4;
                              _loc2_ = 240;
                              if(uint(_loc1_) >= 2097152)
                              {
                                 _loc10_ = 5;
                                 _loc2_ = 248;
                                 if(uint(_loc1_) >= 67108864)
                                 {
                                    _loc10_ = 6;
                                    _loc2_ = 252;
                                    if(_loc1_ <= -1)
                                    {
                                       ESP = _loc3_;
                                       F___error();
                                       si32(86,eax);
                                       addr567:
                                       si32(_loc11_,_loc13_);
                                       _loc16_ = -1;
                                    }
                                    §§goto(addr437);
                                 }
                              }
                           }
                        }
                        _loc7_ = 1 - _loc10_;
                        _loc8_ = _loc1_;
                        do
                        {
                           _loc17_ = (_loc9_ = _loc5_ - 6) - _loc7_;
                           si8(_loc6_ = (_loc6_ = _loc1_ & 63) | 128,_loc17_);
                           _loc7_ += 1;
                           _loc1_ = _loc8_ >> 6;
                           _loc8_ = _loc1_;
                        }
                        while(_loc7_ != 0);
                        
                        si8(_loc17_ = _loc1_ | _loc2_,_loc5_ - 6);
                        if(uint(_loc10_) > uint(_loc15_))
                        {
                           break;
                        }
                        _loc3_ -= 16;
                        si32(_loc10_,_loc3_ + 8);
                        si32(_loc9_,_loc3_ + 4);
                        si32(_loc12_,_loc3_);
                        ESP = _loc3_;
                        Fmemcpy();
                        _loc3_ += 16;
                     }
                     §§goto(addr437);
                  }
                  if((_loc17_ = li32(_loc11_)) != 0)
                  {
                     _loc16_ = _loc10_ + _loc16_;
                     _loc15_ -= _loc10_;
                     _loc12_ += _loc10_;
                     _loc11_ += 4;
                     _loc14_ += -1;
                     continue;
                  }
                  si32(0,_loc13_);
                  _loc16_ = (_loc17_ = _loc16_ + _loc10_) + -1;
                  §§goto(addr437);
               }
               break;
            }
            si32(_loc11_,_loc13_);
         }
         else
         {
            while(_loc14_ != 0)
            {
               _loc10_ = li32(_loc11_);
               _loc15_ = 1;
               if(uint(_loc10_) >= 128)
               {
                  _loc15_ = 2;
                  _loc4_ = 192;
                  if(uint(_loc10_) >= 2048)
                  {
                     _loc15_ = 3;
                     _loc4_ = 224;
                     if(uint(_loc10_) >= 65536)
                     {
                        _loc15_ = 4;
                        _loc4_ = 240;
                        if(uint(_loc10_) >= 2097152)
                        {
                           _loc15_ = 5;
                           _loc4_ = 248;
                           if(uint(_loc10_) >= 67108864)
                           {
                              _loc15_ = 6;
                              _loc4_ = 252;
                              if(_loc10_ <= -1)
                              {
                                 ESP = _loc3_;
                                 F___error();
                                 si32(86,eax);
                                 _loc16_ = -1;
                                 break;
                              }
                           }
                        }
                     }
                  }
                  _loc13_ = 1 - _loc15_;
                  _loc1_ = _loc10_;
                  _loc12_ = _loc10_;
                  do
                  {
                     _loc17_ = (_loc17_ = _loc5_ - 6) - _loc13_;
                     si8(_loc6_ = (_loc6_ = _loc1_ & 63) | 128,_loc17_);
                     _loc13_ += 1;
                     _loc1_ = _loc12_ >> 6;
                     _loc12_ = _loc1_;
                  }
                  while(_loc13_ != 0);
                  
                  si8(_loc17_ = _loc1_ | _loc4_,_loc5_ - 6);
               }
               if(_loc10_ == 0)
               {
                  _loc16_ = (_loc17_ = _loc16_ + _loc15_) + -1;
                  break;
               }
               _loc16_ = _loc15_ + _loc16_;
               _loc11_ += 4;
               _loc14_ += -1;
            }
         }
      }
      addr437:
      si32(_loc11_,_loc13_);
      _loc16_ = -1;
      eax = _loc16_;
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
