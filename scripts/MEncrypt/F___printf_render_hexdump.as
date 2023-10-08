package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str1331;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str330;
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F___printf_render_hexdump() : void
   {
      var _loc2_:* = 0;
      var _loc17_:* = 0;
      var _loc11_:* = 0;
      var _loc27_:* = 0;
      var _loc20_:int = 0;
      var _loc12_:int = 0;
      var _loc19_:int = 0;
      var _loc18_:int = 0;
      var _loc14_:* = 0;
      var _loc5_:* = 0;
      var _loc25_:* = 0;
      var _loc8_:* = 0;
      var _loc16_:* = 0;
      var _loc26_:int = 0;
      var _loc13_:int = 0;
      var _loc24_:* = 0;
      var _loc22_:* = 0;
      var _loc7_:* = 0;
      var _loc10_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc3_:int = 0;
      var _loc4_:* = 0;
      var _loc21_:int = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc1_ -= 112;
      _loc26_ = (_loc27_ = li32((_loc11_ = li32(_loc2_ + 4)) + 4)) + -1;
      _loc25_ = _loc27_;
      if(uint(_loc26_) >= 15)
      {
         _loc25_ = 16;
      }
      var _loc23_:*;
      _loc22_ = li32(_loc23_ = li32((_loc24_ = li32(_loc2_ + 8)) + 4));
      _loc21_ = 0;
      if(_loc22_ != 0)
      {
         _loc20_ = 0 - _loc27_;
         _loc8_ = _loc27_;
         if(uint(_loc20_) <= 4294967280)
         {
            _loc8_ = 16;
         }
         _loc16_ = _loc20_;
         if(uint(_loc20_) <= 4294967280)
         {
            _loc16_ = -16;
         }
         if(uint(_loc26_) <= 15)
         {
            _loc26_ = 15;
         }
         _loc17_ = li32(_loc2_);
         _loc18_ = (_loc23_ = _loc27_ + 15) - _loc26_;
         _loc19_ = _loc17_ + 16;
         _loc12_ = _loc17_ + 4;
         _loc27_ = (_loc26_ = _loc2_ - 100) + 1;
         _loc24_ = li32(_loc23_ = li32(_loc24_));
         _loc21_ = 0;
         _loc13_ = 0;
         do
         {
            _loc14_ = _loc22_;
            _loc23_ = li32(_loc11_ + 40);
            _loc22_ = _loc26_;
            if(_loc23_ != 0)
            {
               _loc1_ -= 16;
               si32(_loc13_,_loc1_ + 8);
               si32(L__2E_str330,_loc1_ + 4);
               si32(_loc23_ = _loc2_ - 100,_loc1_);
               ESP = _loc1_;
               F_sprintf();
               _loc1_ += 16;
               _loc22_ = _loc23_ + eax;
            }
            _loc10_ = 1;
            _loc9_ = 0;
            _loc7_ = _loc10_;
            if(_loc14_ == _loc9_)
            {
               _loc7_ = _loc9_;
            }
            if(_loc25_ == _loc9_)
            {
               _loc10_ = _loc9_;
            }
            if((_loc10_ = (_loc23_ = _loc10_ & _loc7_) & 1) != 0)
            {
               _loc5_ = _loc7_ = 0 - _loc14_;
               if(uint(_loc7_) <= uint(_loc20_))
               {
                  _loc5_ = _loc20_;
               }
               if((uint(_loc9_ = _loc5_ ^ -1)) <= 15)
               {
                  _loc9_ = 15;
               }
               if(uint(_loc7_) <= uint(_loc20_))
               {
                  _loc7_ = _loc20_;
               }
               _loc6_ = (_loc23_ = 15 - _loc5_) - _loc9_;
               _loc9_ = 0 - _loc7_;
               _loc5_ = _loc24_;
               do
               {
                  _loc23_ = li8(_loc5_);
                  _loc1_ -= 16;
                  si32(_loc23_,_loc1_ + 8);
                  si32(L__2E_str1331,_loc1_ + 4);
                  si32(_loc22_,_loc1_);
                  ESP = _loc1_;
                  F_sprintf();
                  _loc1_ += 16;
                  _loc23_ = eax;
                  _loc22_ += _loc23_;
                  _loc5_ += 1;
               }
               while((_loc6_ += -1) != 0);
               
               if(uint(_loc7_) <= 4294967280)
               {
                  _loc9_ = 16;
               }
            }
            if((_loc23_ = li32(_loc11_ + 28)) != 0)
            {
               if(uint(_loc9_) < uint(_loc25_))
               {
                  _loc7_ = _loc18_ - _loc9_;
                  _loc5_ = (_loc23_ = _loc9_ + _loc16_) * -3;
                  _loc9_ = _loc22_;
                  do
                  {
                     si32(2105376,_loc9_);
                     _loc9_ += 3;
                  }
                  while((_loc7_ += -1) != 0);
                  
                  _loc22_ += _loc5_;
               }
               si32(8134688,_loc22_);
               _loc7_ = _loc22_ + 3;
               _loc9_ = 0;
               if(_loc10_ != 0)
               {
                  _loc9_ = _loc10_ = 0 - _loc14_;
                  if(uint(_loc10_) <= uint(_loc20_))
                  {
                     _loc9_ = _loc20_;
                  }
                  if((uint(_loc7_ = _loc9_ ^ -1)) <= 15)
                  {
                     _loc7_ = 15;
                  }
                  if(uint(_loc10_) <= uint(_loc20_))
                  {
                     _loc10_ = _loc20_;
                  }
                  _loc7_ = (_loc23_ = 15 - _loc9_) - _loc7_;
                  _loc9_ = 0 - _loc10_;
                  _loc3_ = _loc22_ + 3;
                  _loc4_ = _loc24_;
                  do
                  {
                     _loc23_ = (_loc23_ = (_loc6_ = li8(_loc4_)) + -32) & 255;
                     _loc5_ = 46;
                     if(uint(_loc23_) <= 94)
                     {
                        _loc5_ = _loc6_;
                     }
                     si8(_loc5_,_loc3_);
                     _loc3_ += 1;
                     _loc4_ += 1;
                  }
                  while((_loc7_ += -1) != 0);
                  
                  if(uint(_loc10_) <= 4294967280)
                  {
                     _loc9_ = 16;
                  }
                  _loc7_ = (_loc23_ = _loc9_ + _loc22_) + 3;
               }
               if(uint(_loc9_) < uint(_loc25_))
               {
                  _loc1_ -= 16;
                  si32(32,_loc1_ + 4);
                  si32(_loc23_ = _loc8_ - _loc9_,_loc1_ + 8);
                  si32(_loc7_,_loc1_);
                  _loc7_ += _loc23_;
                  ESP = _loc1_;
                  Fmemset();
                  _loc1_ += 16;
               }
               si8(124,_loc7_);
               _loc22_ = _loc7_ + 1;
            }
            _loc10_ = _loc25_;
            if(uint(_loc25_) >= uint(_loc14_))
            {
               _loc10_ = _loc14_;
            }
            if(_loc14_ != _loc10_)
            {
               si8(10,_loc22_);
               _loc22_ += 1;
            }
            _loc23_ = (_loc23_ = li16((_loc23_ = li32(_loc17_)) + 12)) & 64;
            _loc9_ = 0;
            if(_loc23_ == 0)
            {
               if(_loc22_ != _loc27_)
               {
                  _loc9_ = _loc22_ - _loc27_;
                  si32(_loc27_,li32(_loc17_ + 80));
                  si32(_loc9_,li32(_loc17_ + 80) + 4);
                  si32(_loc23_ = (_loc23_ = li32(_loc17_ + 12)) + _loc9_,_loc17_ + 12);
                  si32(_loc23_ = (_loc23_ = li32(_loc17_ + 80)) + 8,_loc17_ + 80);
                  si32(_loc23_ = (_loc23_ = li32(_loc17_ + 8)) + 1,_loc17_ + 8);
                  if(_loc23_ >= 8)
                  {
                     _loc1_ -= 16;
                     si32(_loc12_,_loc1_ + 4);
                     si32(li32(_loc17_),_loc1_);
                     ESP = _loc1_;
                     F___sfvwrite();
                     _loc1_ += 16;
                     si32(_loc19_,_loc17_ + 80);
                     si32(_loc19_,_loc17_ + 4);
                     si32(0,_loc17_ + 12);
                     si32(0,_loc17_ + 8);
                  }
               }
            }
            _loc13_ = _loc10_ + _loc13_;
            _loc22_ = _loc14_ - _loc10_;
            _loc24_ += _loc10_;
            _loc23_ = li32(_loc17_);
            _loc1_ -= 16;
            si32(_loc12_,_loc1_ + 4);
            si32(_loc23_,_loc1_);
            ESP = _loc1_;
            F___sfvwrite();
            _loc1_ += 16;
            si32(_loc19_,_loc17_ + 80);
            si32(_loc19_,_loc17_ + 4);
            si32(0,_loc17_ + 12);
            si32(0,_loc17_ + 8);
            _loc21_ = _loc9_ + _loc21_;
         }
         while(_loc14_ != _loc10_);
         
      }
      eax = _loc21_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
