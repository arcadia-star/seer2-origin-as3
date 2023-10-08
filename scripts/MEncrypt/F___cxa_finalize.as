package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___cxa_finalize() : void
   {
      var _loc3_:* = 0;
      var _loc11_:* = 0;
      var _loc10_:* = 0;
      var _loc8_:int = 0;
      var _loc9_:int = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:* = 0;
      var _loc12_:* = 0;
      var _loc7_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_atexit_mutex,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_lock();
         _loc2_ += 16;
      }
      if((_loc12_ = li32(___atexit)) != 0)
      {
         _loc11_ = li32(_loc3_);
         do
         {
            if((_loc10_ = li32(_loc12_ + 4)) >= 1)
            {
               _loc9_ = _loc12_ + (_loc10_ << 4);
               _loc8_ = 0 - _loc10_;
               _loc7_ = 0;
               do
               {
                  _loc1_ = _loc7_ << 4;
                  _loc1_ = _loc9_ + _loc1_;
                  if((_loc6_ = li32(_loc1_ - 8)) != 0)
                  {
                     _loc5_ = _loc7_ << 2;
                     if(_loc11_ != 0)
                     {
                        if(li32(_loc9_ + (_loc5_ << 2) + 4) != _loc11_)
                        {
                           continue;
                        }
                     }
                     _loc1_ = _loc5_ << 2;
                     _loc1_ = _loc9_ + _loc1_;
                     _loc4_ = li32(_loc1_);
                     _loc1_ = _loc5_ << 2;
                     _loc1_ = _loc9_ + _loc1_;
                     _loc10_ = li32(_loc1_ - 4);
                     _loc1_ = _loc5_ << 2;
                     _loc1_ = _loc9_ + _loc1_;
                     si32(0,_loc1_ - 8);
                     _loc1_ = li32(___isthreaded);
                     if(_loc1_ != 0)
                     {
                        _loc2_ -= 16;
                        si32(_atexit_mutex,_loc2_);
                        ESP = _loc2_;
                        F__pthread_mutex_unlock();
                        _loc2_ += 16;
                     }
                     if(_loc6_ != 1)
                     {
                        if(_loc6_ == 2)
                        {
                           _loc2_ -= 16;
                           si32(_loc4_,_loc2_);
                           ESP = _loc2_;
                           ptr2fun[_loc10_]();
                           _loc2_ += 16;
                        }
                     }
                     else
                     {
                        ESP = _loc2_;
                        ptr2fun[_loc10_]();
                     }
                     _loc1_ = li32(___isthreaded);
                     if(_loc1_ != 0)
                     {
                        _loc2_ -= 16;
                        si32(_atexit_mutex,_loc2_);
                        ESP = _loc2_;
                        F__pthread_mutex_lock();
                        _loc2_ += 16;
                     }
                  }
               }
               while(_loc7_ += -1, _loc8_ != _loc7_);
               
            }
         }
         while((_loc12_ = li32(_loc12_)) != 0);
         
      }
      _loc1_ = li32(___isthreaded);
      if(_loc1_ != 0)
      {
         _loc2_ -= 16;
         si32(_atexit_mutex,_loc2_);
         ESP = _loc2_;
         F__pthread_mutex_unlock();
         _loc2_ += 16;
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
