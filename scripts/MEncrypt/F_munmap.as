package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_munmap() : void
   {
      var _loc9_:* = 0;
      var _loc19_:int = 0;
      var _loc16_:int = 0;
      var _loc11_:* = 0;
      var _loc12_:* = 0;
      var _loc13_:* = 0;
      var _loc3_:* = 0;
      var _loc6_:int = 0;
      var _loc5_:* = 0;
      var _loc18_:* = 0;
      var _loc15_:* = 0;
      var _loc14_:* = 0;
      var _loc1_:int = 0;
      var _loc10_:int = 0;
      var _loc7_:* = 0;
      var _loc2_:* = 0;
      var _loc8_:int = 0;
      var _loc4_:*;
      _loc9_ = _loc4_ = ESP;
      if((_loc5_ = li32(_avm2_haveWorkers_2E_4273)) == -1)
      {
         si32(_loc5_ = int(Boolean(workerClass)),_avm2_haveWorkers_2E_4273);
      }
      if(_loc5_ != 0)
      {
         _loc4_ -= 16;
         var _loc21_:*;
         si32(_loc21_ = int(threadId) + 8,_loc4_ + 4);
         si32(_smmapMtx,_loc4_);
         ESP = _loc4_;
         F_avm2_lock_id();
         _loc4_ += 16;
      }
      var _loc20_:* = li32(_loc9_ + 4);
      _loc19_ = (_loc20_ = (_loc20_ = (_loc21_ = li32(_loc9_)) + _loc20_) + 4095) >>> 12;
      _loc20_ = (_loc20_ = _loc21_ >> 31) >>> 20;
      _loc18_ = (_loc21_ += _loc20_) >> 12;
      if(_loc19_ != _loc18_)
      {
         do
         {
            _loc21_ = _loc18_ & 31;
            _loc21_ = (_loc21_ = 1 << _loc21_) ^ -1;
            _loc20_ = (_loc20_ = _loc18_ & -32) >>> 3;
            _loc20_ = _mmapBlockAllocBitSet + _loc20_;
            var _loc17_:*;
            si32(_loc21_ = (_loc17_ = li32(_loc20_)) & _loc21_,_loc20_);
            _loc18_ += 1;
         }
         while(_loc19_ != _loc18_);
         
      }
      ESP = _loc4_ & -16;
      _loc16_ = (ram.length + 4095) / 4096;
      _loc15_ = li32(_mmapBlockCount);
      if(_loc16_ > _loc15_)
      {
         do
         {
            _loc21_ = _loc15_ & 31;
            _loc21_ = 1 << _loc21_;
            _loc20_ = (_loc20_ = _loc15_ & -32) >>> 3;
            _loc17_ = li32(_loc20_ = _mmapBlockAllocBitSet + _loc20_);
            si32(_loc21_ |= _loc17_,_loc20_);
            _loc15_ += 1;
         }
         while(_loc16_ != _loc15_);
         
      }
      si32(_loc16_,_mmapBlockCount);
      _loc14_ = _loc16_ << 12;
      _loc1_ = _loc16_ + -1;
      _loc10_ = -1;
      do
      {
         _loc11_ = _loc14_;
         _loc12_ = _loc1_;
         _loc13_ = _loc10_;
         if(_loc12_ == -1)
         {
            break;
         }
         _loc14_ = _loc11_ + -4096;
         _loc1_ = _loc12_ + -1;
         _loc10_ = _loc13_ + -1;
      }
      while(((_loc20_ = li32(_loc20_ = _mmapBlockAllocBitSet + ((_loc20_ = _loc12_ & -32) >>> 3))) & 1 << (_loc12_ & 31)) == 0);
      
      if((_loc21_ = _loc13_ ^ -1) >= 256)
      {
         _loc4_ -= 16;
         si32(_loc11_,_loc4_ + 4);
         _loc3_ = _loc16_ << 12;
         si32(_loc3_,_loc4_);
         ESP = _loc4_;
         F_avm2_casRamLength();
         _loc4_ += 16;
         if((_loc6_ = eax) == -1)
         {
            if((_loc7_ = li32(_avm2_haveWorkers_2E_4273)) == -1)
            {
               si32(_loc7_ = int(Boolean(workerClass)),_avm2_haveWorkers_2E_4273);
            }
            if(_loc7_ != 0)
            {
               _loc4_ -= 16;
               si32(_smmapMtx,_loc4_);
               ESP = _loc4_;
               F_avm2_unlock();
               _loc4_ += 16;
            }
            ESP = _loc4_;
            F___error();
            _loc21_ = eax;
            si32(22,_loc21_);
            _loc8_ = -1;
         }
         else
         {
            if(_loc6_ == _loc3_)
            {
               si32(_loc21_ = _loc12_ + 1,_mmapBlockCount);
               addr426:
               _loc2_ = li32(_avm2_haveWorkers_2E_4273);
               if(_loc2_ == -1)
               {
                  _loc2_ = int(Boolean(workerClass));
                  si32(_loc2_,_avm2_haveWorkers_2E_4273);
               }
               _loc8_ = 0;
               if(_loc2_ != 0)
               {
                  _loc4_ -= 16;
                  si32(_smmapMtx,_loc4_);
                  ESP = _loc4_;
                  F_avm2_unlock();
                  _loc4_ += 16;
                  _loc8_ = 0;
               }
            }
            §§goto(addr426);
         }
         eax = _loc8_;
         ESP = _loc4_ = _loc9_;
         return;
      }
      §§goto(addr426);
   }
}
