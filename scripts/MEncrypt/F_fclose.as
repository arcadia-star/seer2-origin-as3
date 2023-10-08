package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F_fclose() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc6_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      if((_loc9_ = li16(_loc1_ + 12)) == 0)
      {
         ESP = _loc2_;
         F___error();
         si32(9,eax);
         _loc7_ = -1;
      }
      else
      {
         var _loc8_:*;
         if((_loc8_ = li32(___isthreaded)) != 0)
         {
            ESP = _loc2_;
            F__pthread_self();
            _loc7_ = eax;
            if((_loc8_ = li32(_loc1_ + 92)) == _loc7_)
            {
               si32(_loc8_ = (_loc8_ = li32(_loc1_ + 96)) + 1,_loc1_ + 96);
            }
            else
            {
               _loc2_ -= 16;
               si32(_loc8_ = _loc1_ + 88,_loc2_);
               ESP = _loc2_;
               F__pthread_mutex_lock();
               _loc2_ += 16;
               si32(_loc7_,_loc1_ + 92);
               si32(1,_loc1_ + 96);
            }
            _loc9_ = li16(_loc1_ + 12);
         }
         _loc8_ = _loc9_ & 8;
         _loc7_ = 0;
         if(_loc8_ != 0)
         {
            _loc7_ = 0;
            if(((_loc6_ = (_loc8_ = _loc9_ << 16) >> 16) & 8) != 0)
            {
               _loc9_ = li32(_loc1_ + 16);
               _loc7_ = 0;
               if(_loc9_ != 0)
               {
                  _loc7_ = li32(_loc1_);
                  si32(_loc9_,_loc1_);
                  _loc5_ = 0;
                  if((_loc6_ & 3) == 0)
                  {
                     _loc5_ = li32(_loc1_ + 20);
                  }
                  _loc6_ = _loc7_ - _loc9_;
                  si32(_loc5_,_loc1_ + 8);
                  while(true)
                  {
                     _loc7_ = 0;
                     if(_loc6_ <= 0)
                     {
                        break;
                     }
                     _loc2_ -= 16;
                     si32(_loc6_,_loc2_ + 8);
                     si32(_loc9_,_loc2_ + 4);
                     si32(_loc1_,_loc2_);
                     ESP = _loc2_;
                     F__swrite();
                     _loc2_ += 16;
                     if((_loc7_ = eax) <= 0)
                     {
                        si16(_loc8_ = (_loc8_ = li16(_loc1_ + 12)) | 64,_loc1_ + 12);
                        _loc7_ = -1;
                        break;
                     }
                     _loc9_ += _loc7_;
                     _loc6_ -= _loc7_;
                  }
               }
            }
         }
         if((_loc9_ = li32(_loc1_ + 32)) != 0)
         {
            _loc2_ -= 16;
            si32(li32(_loc1_ + 28),_loc2_);
            ESP = _loc2_;
            ptr2fun[_loc9_]();
            _loc2_ += 16;
            if((_loc8_ = eax) <= -1)
            {
               _loc7_ = -1;
            }
         }
         if((_loc8_ = (_loc8_ = li8(_loc1_ + 12)) & 128) != 0)
         {
            if((_loc9_ = li32(_loc1_ + 16)) != 0)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F_idalloc();
               _loc2_ += 16;
            }
         }
         if((_loc9_ = li32(_loc1_ + 48)) != 0)
         {
            if(_loc9_ != _loc1_ + 64)
            {
               _loc2_ -= 16;
               si32(_loc9_,_loc2_);
               ESP = _loc2_;
               F_idalloc();
               _loc2_ += 16;
            }
            si32(0,_loc1_ + 48);
         }
         if((_loc9_ = li32(_loc1_ + 68)) != 0)
         {
            _loc2_ -= 16;
            si32(_loc9_,_loc2_);
            ESP = _loc2_;
            F_idalloc();
            _loc2_ += 16;
            si32(0,_loc1_ + 68);
         }
         si16(-1,_loc1_ + 14);
         si32(0,_loc1_ + 8);
         si32(0,_loc1_ + 4);
         si16(0,_loc1_ + 12);
         if((_loc8_ = li32(___isthreaded)) != 0)
         {
            ESP = _loc2_;
            F__pthread_self();
            var _loc4_:*;
            if((_loc4_ = li32(_loc1_ + 92)) == eax)
            {
               if((_loc9_ = li32(_loc1_ + 96)) >= 2)
               {
                  si32(_loc8_ = _loc9_ + -1,_loc1_ + 96);
               }
               else
               {
                  si32(0,_loc1_ + 96);
                  si32(0,_loc1_ + 92);
                  _loc2_ -= 16;
                  si32(_loc8_ = _loc1_ + 88,_loc2_);
                  ESP = _loc2_;
                  F__pthread_mutex_unlock();
                  _loc2_ += 16;
               }
            }
         }
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
