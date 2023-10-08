package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___sfvwrite;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_grouping_print() : void
   {
      var _loc6_:* = 0;
      var _loc16_:* = 0;
      var _loc13_:* = 0;
      var _loc4_:* = 0;
      var _loc15_:* = 0;
      var _loc9_:* = 0;
      var _loc17_:int = 0;
      var _loc14_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = 0;
      var _loc5_:* = 0;
      var _loc10_:* = 0;
      var _loc18_:* = 0;
      var _loc8_:int = 0;
      var _loc3_:* = ESP;
      _loc4_ = li32((_loc6_ = _loc3_) + 8);
      _loc17_ = (_loc18_ = li32(_loc6_ + 12)) - _loc4_;
      _loc14_ = _loc15_ = li32((_loc16_ = li32(_loc6_)) + 12);
      if(_loc17_ <= _loc15_)
      {
         _loc14_ = _loc17_;
      }
      _loc13_ = li32(_loc6_ + 4);
      if(_loc14_ <= 0)
      {
         _loc17_ = _loc13_ + 12;
         _loc14_ = 0;
      }
      else
      {
         var _loc11_:* = (_loc11_ = li32(_loc13_ + 8)) << 3;
         si32(_loc4_,_loc13_ + 16 + _loc11_);
         si32(_loc14_,_loc13_ + 16 + ((_loc11_ = li32(_loc13_ + 8)) << 3) + 4);
         var _loc12_:*;
         si32(_loc7_ = (_loc12_ = li32(_loc13_ + 12)) + _loc14_,_loc13_ + 12);
         si32(_loc12_ = _loc11_ + 1,_loc13_ + 8);
         _loc17_ = _loc13_ + 12;
         if(_loc12_ >= 8)
         {
            if(_loc7_ == 0)
            {
               si32(0,_loc13_ + 8);
               addr212:
               _loc7_ = _loc15_ - _loc14_;
               _loc15_ = _loc13_ + 4;
               loop0:
               while(true)
               {
                  if(_loc7_ > 0)
                  {
                     _loc9_ = _loc13_ + 16;
                     si32(_zeroes,_loc9_ + ((_loc12_ = li32(_loc13_ + 8)) << 3));
                     _loc14_ = 16;
                     if(_loc7_ <= _loc14_)
                     {
                        _loc14_ = _loc7_;
                     }
                     _loc11_ = (_loc12_ = li32(_loc13_ + 8)) << 3;
                     _loc11_ = _loc9_ + _loc11_;
                     si32(_loc14_,_loc11_ + 4);
                     si32(_loc9_ = (_loc11_ = li32(_loc17_)) + _loc14_,_loc17_);
                     si32(_loc12_ += 1,_loc13_ + 8);
                     if(_loc12_ >= 8)
                     {
                        if(_loc9_ == 0)
                        {
                           si32(0,_loc13_ + 8);
                        }
                        else
                        {
                           _loc3_ -= 16;
                           si32(_loc15_,_loc3_ + 4);
                           si32(li32(_loc13_),_loc3_);
                           ESP = _loc3_;
                           F___sfvwrite();
                           _loc3_ += 16;
                           si32(0,_loc17_);
                           si32(0,_loc13_ + 8);
                           _loc8_ = -1;
                           if(eax != 0)
                           {
                              break;
                           }
                        }
                     }
                     continue;
                  }
                  _loc14_ = _loc4_ + li32(_loc16_ + 12);
                  while(true)
                  {
                     _loc9_ = li32(_loc16_ + 20);
                     if((_loc7_ = li32(_loc16_ + 16)) > 0)
                     {
                        if(_loc9_ >= 1)
                        {
                           addr372:
                           si32(_loc12_ = _loc9_ + -1,_loc16_ + 20);
                        }
                        else
                        {
                           si32(_loc12_ = (_loc12_ = li32(_loc16_ + 8)) + -1,_loc16_ + 8);
                           si32(_loc12_ = _loc7_ + -1,_loc16_ + 16);
                        }
                        _loc7_ = _loc13_ + 16;
                        _loc12_ = (_loc12_ = li32(_loc13_ + 8)) << 3;
                        _loc11_ = _loc7_ + _loc12_;
                        _loc12_ = li32(_loc16_ + 4);
                        var _loc1_:* = li32(_loc16_);
                        si32(_loc1_,_loc11_);
                        _loc1_ = (_loc11_ = li32(_loc13_ + 8)) << 3;
                        _loc1_ = _loc7_ + _loc1_;
                        si32(_loc12_,_loc1_ + 4);
                        _loc1_ = li32(_loc17_);
                        si32(_loc8_ = _loc1_ + _loc12_,_loc17_);
                        si32(_loc9_ = _loc11_ + 1,_loc13_ + 8);
                        if(_loc9_ >= 8)
                        {
                           if(_loc8_ != 0)
                           {
                              _loc3_ -= 16;
                              si32(_loc15_,_loc3_ + 4);
                              si32(li32(_loc13_),_loc3_);
                              ESP = _loc3_;
                              F___sfvwrite();
                              _loc3_ += 16;
                              si32(_loc9_ = 0,_loc17_);
                              si32(_loc9_,_loc13_ + 8);
                              _loc8_ = -1;
                              if(eax == 0)
                              {
                              }
                              break loop0;
                           }
                           si32(_loc9_ = 0,_loc13_ + 8);
                        }
                        _loc8_ = _loc18_ - _loc14_;
                        _loc2_ = _loc10_ = si8(li8(_loc12_ = li32(_loc16_ + 8)));
                        if(_loc8_ <= _loc10_)
                        {
                           _loc2_ = _loc8_;
                        }
                        _loc5_ = 0;
                        if(_loc2_ >= 1)
                        {
                           si32(_loc14_,_loc7_ + (_loc9_ << 3));
                           si32(_loc2_,_loc7_ + ((_loc12_ = li32(_loc13_ + 8)) << 3) + 4);
                           si32(_loc8_ = (_loc11_ = li32(_loc17_)) + _loc2_,_loc17_);
                           si32(_loc9_ = _loc12_ + 1,_loc13_ + 8);
                           _loc5_ = _loc2_;
                           if(_loc9_ >= 8)
                           {
                              if(_loc8_ != 0)
                              {
                                 _loc3_ -= 16;
                                 si32(_loc15_,_loc3_ + 4);
                                 si32(li32(_loc13_),_loc3_);
                                 ESP = _loc3_;
                                 F___sfvwrite();
                                 _loc3_ += 16;
                                 si32(_loc9_ = 0,_loc17_);
                                 si32(_loc9_,_loc13_ + 8);
                                 _loc8_ = -1;
                                 _loc5_ = _loc2_;
                                 if(eax == 0)
                                 {
                                 }
                                 break loop0;
                              }
                              si32(_loc9_ = 0,_loc13_ + 8);
                              _loc5_ = _loc2_;
                           }
                        }
                        _loc2_ = _loc10_ - _loc5_;
                        while(_loc2_ > 0)
                        {
                           si32(_zeroes,_loc7_ + (_loc9_ << 3));
                           _loc10_ = 16;
                           if(_loc2_ <= _loc10_)
                           {
                              _loc10_ = _loc2_;
                           }
                           _loc11_ = (_loc12_ = li32(_loc13_ + 8)) << 3;
                           _loc11_ = _loc7_ + _loc11_;
                           si32(_loc10_,_loc11_ + 4);
                           si32(_loc8_ = (_loc11_ = li32(_loc17_)) + _loc10_,_loc17_);
                           si32(_loc9_ = _loc12_ + 1,_loc13_ + 8);
                           if(_loc9_ >= 8)
                           {
                              if(_loc8_ == 0)
                              {
                                 si32(_loc9_ = 0,_loc13_ + 8);
                              }
                              else
                              {
                                 _loc3_ -= 16;
                                 si32(_loc15_,_loc3_ + 4);
                                 si32(li32(_loc13_),_loc3_);
                                 ESP = _loc3_;
                                 F___sfvwrite();
                                 _loc3_ += 16;
                                 si32(_loc9_ = 0,_loc17_);
                                 si32(_loc9_,_loc13_ + 8);
                                 _loc8_ = -1;
                                 if(eax != 0)
                                 {
                                    break loop0;
                                 }
                              }
                           }
                           _loc2_ -= _loc10_;
                        }
                        continue;
                     }
                     if(_loc9_ <= 0)
                     {
                        if(uint(_loc14_) <= uint(_loc18_))
                        {
                           _loc18_ = _loc14_;
                        }
                        _loc8_ = _loc18_ - _loc4_;
                        break loop0;
                     }
                     §§goto(addr372);
                  }
               }
            }
            else
            {
               _loc3_ -= 16;
               si32(_loc11_ = _loc13_ + 4,_loc3_ + 4);
               si32(li32(_loc13_),_loc3_);
               ESP = _loc3_;
               F___sfvwrite();
               _loc3_ += 16;
               si32(0,_loc13_ + 12);
               si32(0,_loc13_ + 8);
               _loc8_ = -1;
               if(eax == 0)
               {
                  §§goto(addr212);
               }
            }
            eax = _loc8_;
            _loc3_ = _loc6_;
            ESP = _loc3_;
            return;
         }
      }
      §§goto(addr212);
   }
}
