package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___sys_mmap() : void
   {
      var _loc2_:* = 0;
      var _loc25_:* = 0;
      var _loc26_:* = 0;
      var _loc19_:* = 0;
      var _loc10_:* = 0;
      var _loc20_:int = 0;
      var _loc16_:int = 0;
      var _loc17_:int = 0;
      var _loc13_:* = 0;
      var _loc8_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:* = 0;
      var _loc18_:* = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc9_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc15_:int = 0;
      var _loc14_:* = 0;
      var _loc3_:* = 0;
      var _loc24_:* = 0;
      var _loc1_:* = ESP;
      _loc2_ = _loc1_;
      _loc10_ = li32(_loc2_ + 16);
      _loc26_ = li32(_loc2_ + 8);
      _loc25_ = li32(_loc2_ + 4);
      if(_loc10_ >= 0)
      {
         _loc24_ = 0;
         if(_loc10_ == 0)
         {
            var _loc21_:* = li32(_loc2_);
            _loc1_ -= 32;
            si32(li32(_loc2_ + 20),_loc1_ + 20);
            si32(-1,_loc1_ + 16);
            si32(4096,_loc1_ + 12);
            si32(_loc26_,_loc1_ + 8);
            si32(_loc25_,_loc1_ + 4);
            si32(_loc21_,_loc1_);
            si32(li32(_loc2_ + 24),_loc1_ + 24);
            ESP = _loc1_;
            F___sys_mmap();
            _loc24_ = 0;
            _loc1_ += 32;
            if((_loc20_ = eax) != 0)
            {
               si32(_loc20_,___avm2_stdin_mapping);
               _loc1_ -= 16;
               var _loc23_:*;
               si32((_loc23_ = (_loc23_ = li32(___avm2_vgl_fb_w)) * li32(___avm2_vgl_fb_h)) << 2,_loc1_);
               ESP = _loc1_;
               F_malloc();
               _loc1_ += 16;
               si32(_loc23_ = eax,___avm2_vgl_argb_buffer);
               _loc24_ = _loc20_;
            }
         }
      }
      else
      {
         if((_loc19_ = li32(_loc2_ + 12)) != 0)
         {
            if((_loc23_ = _loc19_ & 4096) == 0)
            {
               ESP = _loc1_;
               F___error();
               si32(22,eax);
               _loc24_ = -1;
            }
            §§goto(addr769);
         }
         if((_loc23_ = _loc26_ & 4) != 0)
         {
            ESP = _loc1_;
            F___error();
            si32(22,eax);
            _loc24_ = -1;
         }
         else
         {
            if((_loc7_ = li32(_avm2_haveWorkers_2E_4273)) == -1)
            {
               si32(_loc7_ = int(Boolean(workerClass)),_avm2_haveWorkers_2E_4273);
            }
            if(_loc7_ != 0)
            {
               _loc1_ -= 16;
               si32(_loc23_ = int(threadId) + 8,_loc1_ + 4);
               si32(_smmapMtx,_loc1_);
               ESP = _loc1_;
               F_avm2_lock_id();
               _loc1_ += 16;
            }
            _loc15_ = (_loc23_ = _loc25_ + 4095) >>> 12;
            _loc16_ = 0 - _loc15_;
            loop0:
            while(true)
            {
               if((_loc17_ = ram.length) <= -1)
               {
                  ESP = _loc1_ & -16;
                  _loc18_ = (ram.length + 4095) / 4096;
               }
               else
               {
                  var _loc22_:*;
                  _loc18_ = (_loc23_ += (_loc22_ = (_loc23_ = _loc17_ + 4095) >> 31) >>> 20) >> 12;
               }
               _loc11_ = li32(_mmapBlockCount);
               if(_loc18_ > _loc11_)
               {
                  do
                  {
                     _loc23_ = _loc11_ & 31;
                     _loc23_ = 1 << _loc23_;
                     _loc22_ = (_loc22_ = _loc11_ & -32) >>> 3;
                     _loc21_ = li32(_loc22_ = _mmapBlockAllocBitSet + _loc22_);
                     si32(_loc23_ |= _loc21_,_loc22_);
                     _loc11_ += 1;
                  }
                  while(_loc18_ != _loc11_);
                  
               }
               si32(_loc18_,_mmapBlockCount);
               _loc12_ = _loc18_;
               loop2:
               while((_loc13_ = _loc12_) >= _loc15_)
               {
                  _loc12_ = _loc16_ + _loc13_;
                  _loc14_ = _loc13_ - _loc15_;
                  while(true)
                  {
                     if(_loc12_ >= _loc13_)
                     {
                        if(_loc14_ >= 0)
                        {
                           _loc9_ = _loc16_;
                           if(_loc15_ != 0)
                           {
                              do
                              {
                                 _loc23_ = (_loc22_ = _loc13_ + _loc9_) & 31;
                                 _loc23_ = 1 << _loc23_;
                                 _loc22_ = (_loc22_ &= -32) >>> 3;
                                 _loc21_ = li32(_loc22_ = _mmapBlockAllocBitSet + _loc22_);
                                 si32(_loc23_ |= _loc21_,_loc22_);
                              }
                              while((_loc9_ += 1) != 0);
                              
                           }
                        }
                        if(_loc14_ <= -1)
                        {
                           break loop2;
                        }
                        addr696:
                        _loc3_ = li32(_avm2_haveWorkers_2E_4273);
                        if(_loc3_ == -1)
                        {
                           _loc3_ = int(Boolean(workerClass));
                           si32(_loc3_,_avm2_haveWorkers_2E_4273);
                        }
                        if(_loc3_ != 0)
                        {
                           _loc1_ -= 16;
                           si32(_smmapMtx,_loc1_);
                           ESP = _loc1_;
                           F_avm2_unlock();
                           _loc1_ += 16;
                        }
                        _loc24_ = _loc14_ << 12;
                        _loc1_ -= 16;
                        si32(_loc25_,_loc1_ + 8);
                        si32(0,_loc1_ + 4);
                        si32(_loc24_,_loc1_);
                        ESP = _loc1_;
                        Fmemset();
                        _loc1_ += 16;
                        break loop0;
                     }
                     if((_loc23_ = (_loc22_ = li32(_loc22_ = _mmapBlockAllocBitSet + ((_loc22_ = _loc12_ & -32) >>> 3))) & 1 << (_loc12_ & 31)) != 0)
                     {
                        break;
                     }
                     _loc12_ += 1;
                  }
               }
               _loc1_ -= 16;
               si32(_loc17_,_loc1_);
               si32(_loc23_ = (_loc8_ = _loc18_ + _loc15_) << 12,_loc1_ + 4);
               ESP = _loc1_;
               F_avm2_casRamLength();
               _loc1_ += 16;
               if((_loc6_ = eax) == -1)
               {
                  if((_loc4_ = li32(_avm2_haveWorkers_2E_4273)) == -1)
                  {
                     si32(_loc4_ = int(Boolean(workerClass)),_avm2_haveWorkers_2E_4273);
                  }
                  if(_loc4_ != 0)
                  {
                     _loc1_ -= 16;
                     si32(_smmapMtx,_loc1_);
                     ESP = _loc1_;
                     F_avm2_unlock();
                     _loc1_ += 16;
                  }
                  ESP = _loc1_;
                  F___error();
                  _loc23_ = eax;
                  si32(12,_loc23_);
                  _loc24_ = -1;
                  break;
               }
               if(_loc6_ != _loc17_)
               {
                  continue;
               }
               if(_loc15_ != 0)
               {
                  _loc5_ = li32(_mmapBlockCount);
                  do
                  {
                     _loc23_ = _loc5_ & 31;
                     _loc23_ = 1 << _loc23_;
                     _loc22_ = (_loc22_ = _loc5_ & -32) >>> 3;
                     _loc21_ = li32(_loc22_ = _mmapBlockAllocBitSet + _loc22_);
                     si32(_loc23_ |= _loc21_,_loc22_);
                     _loc5_ += 1;
                  }
                  while((_loc15_ += -1) != 0);
                  
               }
               si32(_loc8_,_mmapBlockCount);
               _loc14_ = _loc18_;
               §§goto(addr696);
            }
         }
      }
      addr769:
      eax = _loc24_;
      _loc1_ = _loc2_;
      ESP = _loc1_;
   }
}
