package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_malloc_print_stats() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:* = 0;
      var _loc12_:* = 0;
      var _loc14_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc13_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 32;
      _loc1_ = li8(_opt_print_stats_2E_b);
      if(_loc1_ == 1)
      {
         _loc1_ = li32(__malloc_message);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str242,_loc2_ + 4);
         si32(L__2E_str141,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
         _loc1_ = li32(__malloc_message);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(L__2E_str444,_loc2_ + 4);
         si32(L__2E_str343,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
         _loc14_ = li32(__malloc_message);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         _loc13_ = L__2E_str646;
         if(li8(_opt_abort_2E_b) == 0)
         {
            _loc13_ = L__2E_str747;
         }
         si32(_loc13_,_loc2_ + 4);
         si32(L__2E_str848,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc14_]();
         _loc2_ += 16;
         _loc13_ = li32(__malloc_message);
         _loc1_ = li8(_opt_dss_2E_b);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str242,_loc2_ + 4);
         _loc14_ = L__2E_str1050;
         if(_loc1_ == 0)
         {
            _loc14_ = L__2E_str949;
         }
         si32(_loc14_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc13_]();
         _loc2_ += 16;
         _loc13_ = li32(__malloc_message);
         _loc1_ = li8(_opt_junk_2E_b);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str242,_loc2_ + 4);
         _loc14_ = L__2E_str1151;
         if(_loc1_ == 0)
         {
            _loc14_ = L__2E_str12;
         }
         si32(_loc14_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc13_]();
         _loc2_ += 16;
         _loc13_ = li32(__malloc_message);
         _loc1_ = li8(_opt_mmap_2E_b);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str242,_loc2_ + 4);
         _loc14_ = L__2E_str14;
         if(_loc1_ == 0)
         {
            _loc14_ = L__2E_str13;
         }
         si32(_loc14_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc13_]();
         _loc2_ += 16;
         _loc12_ = L__2E_str21;
         _loc1_ = li8(_opt_zero_2E_b);
         if(_loc1_ == 0)
         {
            _loc12_ = L__2E_str22;
         }
         _loc14_ = li32(__malloc_message);
         _loc13_ = li8(_opt_utrace_2E_b);
         _loc11_ = li8(_opt_sysv_2E_b);
         _loc1_ = li8(_opt_xmalloc_2E_b);
         _loc2_ -= 16;
         si32(_loc12_,_loc2_ + 12);
         _loc12_ = L__2E_str19;
         if(_loc1_ == 0)
         {
            _loc12_ = L__2E_str20;
         }
         si32(_loc12_,_loc2_ + 8);
         _loc12_ = L__2E_str17;
         if(_loc11_ == 0)
         {
            _loc12_ = L__2E_str1852;
         }
         si32(_loc12_,_loc2_ + 4);
         _loc11_ = L__2E_str15;
         if(_loc13_ == 0)
         {
            _loc11_ = L__2E_str16;
         }
         si32(_loc11_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc14_]();
         _loc2_ += 16;
         _loc10_ = li32(_ncpus);
         _loc9_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc14_ = (_loc13_ = _loc3_ - 21) + 20;
         _loc8_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc10_,_loc2_);
            si32(_loc8_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc6_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc8_,_loc2_ + 4);
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc14_ - 1);
            _loc11_ = _loc12_ = 1;
            if(uint(_loc10_) <= 9)
            {
               _loc11_ = 0;
            }
            if(_loc8_ == 0)
            {
               _loc12_ = 0;
            }
            if(_loc8_ != 0)
            {
               _loc11_ = _loc12_;
            }
            _loc14_ += -1;
            _loc10_ = _loc7_;
            _loc8_ = _loc6_;
         }
         while(_loc11_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(_loc14_,_loc2_ + 4);
         si32(L__2E_str23,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc9_]();
         _loc2_ += 16;
         _loc8_ = li32(_narenas);
         _loc9_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = _loc13_ + 20;
         _loc12_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc8_,_loc2_);
            si32(_loc12_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc6_ = eax;
            _loc7_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc10_ - 1);
            _loc14_ = _loc11_ = 1;
            if(uint(_loc8_) <= 9)
            {
               _loc14_ = 0;
            }
            if(_loc12_ == 0)
            {
               _loc11_ = 0;
            }
            if(_loc12_ != 0)
            {
               _loc14_ = _loc11_;
            }
            _loc10_ += -1;
            _loc8_ = _loc6_;
            _loc12_ = _loc7_;
         }
         while(_loc14_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(_loc10_,_loc2_ + 4);
         si32(L__2E_str24,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc9_]();
         _loc2_ += 16;
         _loc1_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(52,_loc3_ - 2);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         var _loc4_:*;
         si32(_loc4_ = _loc13_ + 19,_loc2_ + 4);
         si32(L__2E_str25,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
         var _loc5_:* = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(54,_loc3_ - 2);
         si8(49,_loc3_ - 3);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(_loc13_ + 18,_loc2_ + 4);
         si32(L__2E_str2653,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc5_]();
         _loc2_ += 16;
         _loc5_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(52,_loc3_ - 2);
         si8(54,_loc3_ - 3);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(_loc13_ + 18,_loc2_ + 4);
         si32(L__2E_str27,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc5_]();
         _loc2_ += 16;
         _loc5_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(50,_loc3_ - 2);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str29,_loc2_ + 8);
         si32(_loc4_,_loc2_ + 4);
         si32(L__2E_str28,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc5_]();
         _loc2_ += 16;
         _loc5_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(56,_loc3_ - 2);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str30,_loc2_ + 4);
         si32(_loc4_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc5_]();
         _loc2_ += 16;
         _loc4_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         si8(54,_loc3_ - 2);
         si8(49,_loc3_ - 3);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str29,_loc2_ + 8);
         si32(_loc13_ + 18,_loc2_ + 4);
         si32(L__2E_str31,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc4_]();
         _loc2_ += 16;
         _loc8_ = li32(_qspace_max);
         _loc6_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = _loc13_ + 20;
         _loc12_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc8_,_loc2_);
            si32(_loc12_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc9_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc10_ - 1);
            _loc14_ = _loc11_ = 1;
            if(uint(_loc8_) <= 9)
            {
               _loc14_ = 0;
            }
            if(_loc12_ == 0)
            {
               _loc11_ = 0;
            }
            if(_loc12_ != 0)
            {
               _loc14_ = _loc11_;
            }
            _loc10_ += -1;
            _loc8_ = _loc7_;
            _loc12_ = _loc9_;
         }
         while(_loc14_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str30,_loc2_ + 4);
         si32(_loc10_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc6_]();
         _loc2_ += 16;
         _loc12_ = li32(_cspace_min);
         _loc6_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc8_ = _loc13_ + 20;
         _loc14_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc12_,_loc2_);
            si32(_loc14_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc9_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc14_,_loc2_ + 4);
            si32(_loc12_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc8_ - 1);
            _loc10_ = _loc11_ = 1;
            if(uint(_loc12_) <= 9)
            {
               _loc10_ = 0;
            }
            if(_loc14_ == 0)
            {
               _loc11_ = 0;
            }
            if(_loc14_ != 0)
            {
               _loc10_ = _loc11_;
            }
            _loc8_ += -1;
            _loc12_ = _loc7_;
            _loc14_ = _loc9_;
         }
         while(_loc10_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str29,_loc2_ + 8);
         si32(_loc8_,_loc2_ + 4);
         si32(L__2E_str32,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc6_]();
         _loc2_ += 16;
         _loc8_ = li32(_cspace_max);
         _loc6_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = _loc13_ + 20;
         _loc12_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc8_,_loc2_);
            si32(_loc12_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc9_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc10_ - 1);
            _loc14_ = _loc11_ = 1;
            if(uint(_loc8_) <= 9)
            {
               _loc14_ = 0;
            }
            if(_loc12_ == 0)
            {
               _loc11_ = 0;
            }
            if(_loc12_ != 0)
            {
               _loc14_ = _loc11_;
            }
            _loc10_ += -1;
            _loc8_ = _loc7_;
            _loc12_ = _loc9_;
         }
         while(_loc14_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str30,_loc2_ + 4);
         si32(_loc10_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc6_]();
         _loc2_ += 16;
         _loc8_ = li32(_sspace_min);
         _loc6_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = _loc13_ + 20;
         _loc12_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc8_,_loc2_);
            si32(_loc12_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc9_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc12_,_loc2_ + 4);
            si32(_loc8_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc10_ - 1);
            _loc14_ = _loc11_ = 1;
            if(uint(_loc8_) <= 9)
            {
               _loc14_ = 0;
            }
            if(_loc12_ == 0)
            {
               _loc11_ = 0;
            }
            if(_loc12_ != 0)
            {
               _loc14_ = _loc11_;
            }
            _loc10_ += -1;
            _loc8_ = _loc7_;
            _loc12_ = _loc9_;
         }
         while(_loc14_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str29,_loc2_ + 8);
         si32(_loc10_,_loc2_ + 4);
         si32(L__2E_str33,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc6_]();
         _loc2_ += 16;
         _loc7_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = 3840;
         if(li8(_sspace_max_2E_b) == 0)
         {
            _loc10_ = 0;
         }
         _loc6_ = _loc13_ + 20;
         _loc14_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc10_,_loc2_);
            si32(_loc14_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc9_ = eax;
            _loc8_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc14_,_loc2_ + 4);
            si32(_loc10_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc6_ - 1);
            _loc11_ = _loc12_ = 1;
            if(uint(_loc10_) <= 9)
            {
               _loc11_ = 0;
            }
            if(_loc14_ == 0)
            {
               _loc12_ = 0;
            }
            if(_loc14_ != 0)
            {
               _loc11_ = _loc12_;
            }
            _loc6_ += -1;
            _loc10_ = _loc9_;
            _loc14_ = _loc8_;
         }
         while(_loc11_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str30,_loc2_ + 4);
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc7_]();
         _loc2_ += 16;
         _loc7_ = li32(_opt_dirty_max);
         _loc14_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc9_ = _loc13_ + 20;
         _loc6_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc7_,_loc2_);
            si32(_loc6_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc12_ = eax;
            _loc11_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc6_,_loc2_ + 4);
            si32(_loc7_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc9_ - 1);
            _loc8_ = _loc10_ = 1;
            if(uint(_loc7_) <= 9)
            {
               _loc8_ = 0;
            }
            if(_loc6_ == 0)
            {
               _loc10_ = 0;
            }
            if(_loc6_ != 0)
            {
               _loc8_ = _loc10_;
            }
            _loc9_ += -1;
            _loc7_ = _loc12_;
            _loc6_ = _loc11_;
         }
         while(_loc8_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str545,_loc2_ + 8);
         si32(_loc9_,_loc2_ + 4);
         si32(L__2E_str34,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc14_]();
         _loc2_ += 16;
         _loc6_ = li32(_chunksize);
         _loc12_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc7_ = _loc13_ + 20;
         _loc10_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc6_,_loc2_);
            si32(_loc10_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc11_ = eax;
            _loc14_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc10_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc7_ - 1);
            _loc9_ = _loc8_ = 1;
            if(uint(_loc6_) <= 9)
            {
               _loc9_ = 0;
            }
            if(_loc10_ == 0)
            {
               _loc8_ = 0;
            }
            if(_loc10_ != 0)
            {
               _loc9_ = _loc8_;
            }
            _loc7_ += -1;
            _loc6_ = _loc11_;
            _loc10_ = _loc14_;
         }
         while(_loc9_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(_loc7_,_loc2_ + 4);
         si32(L__2E_str35,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc12_]();
         _loc2_ += 16;
         _loc11_ = li32(_opt_chunk_2pow);
         _loc14_ = li32(__malloc_message);
         si8(0,_loc3_ - 1);
         _loc10_ = _loc13_ + 20;
         _loc13_ = 0;
         do
         {
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc11_,_loc2_);
            si32(_loc13_,_loc2_ + 4);
            ESP = _loc2_;
            F___udivdi3();
            _loc2_ += 16;
            _loc7_ = eax;
            _loc6_ = edx;
            _loc2_ -= 16;
            si32(0,_loc2_ + 12);
            si32(10,_loc2_ + 8);
            si32(_loc13_,_loc2_ + 4);
            si32(_loc11_,_loc2_);
            ESP = _loc2_;
            F___umoddi3();
            _loc2_ += 16;
            _loc1_ = eax;
            _loc1_ = L__2E_str71 + _loc1_;
            _loc1_ = li8(_loc1_);
            si8(_loc1_,_loc10_ - 1);
            _loc8_ = _loc12_ = 1;
            if(uint(_loc11_) <= 9)
            {
               _loc8_ = 0;
            }
            if(_loc13_ == 0)
            {
               _loc12_ = 0;
            }
            if(_loc13_ != 0)
            {
               _loc8_ = _loc12_;
            }
            _loc10_ += -1;
            _loc11_ = _loc7_;
            _loc13_ = _loc6_;
         }
         while(_loc8_ != 0);
         
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str37,_loc2_ + 8);
         si32(_loc10_,_loc2_ + 4);
         si32(L__2E_str36,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc14_]();
         _loc2_ += 16;
         _loc1_ = li32(__malloc_message);
         _loc2_ -= 16;
         si32(L__2E_str242,_loc2_ + 12);
         si32(L__2E_str242,_loc2_ + 8);
         si32(L__2E_str242,_loc2_ + 4);
         si32(L__2E_str38,_loc2_);
         ESP = _loc2_;
         ptr2fun[_loc1_]();
         _loc2_ += 16;
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
