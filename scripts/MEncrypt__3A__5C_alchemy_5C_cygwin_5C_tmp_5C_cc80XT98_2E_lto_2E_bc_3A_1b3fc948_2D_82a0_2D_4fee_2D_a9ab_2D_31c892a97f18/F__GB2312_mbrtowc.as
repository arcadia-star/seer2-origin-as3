package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F___error;
   import MEncrypt.Fmemcpy;
   import MEncrypt.___mb_cur_max;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F__GB2312_mbrtowc() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc6_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      if((uint(_loc11_ = li32(_loc1_))) >= 3)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc9_ = -1;
      }
      else
      {
         _loc9_ = li32(_loc3_ + 4);
         _loc8_ = L__2E_str461;
         _loc7_ = 0;
         if(_loc9_ != _loc7_)
         {
            _loc8_ = _loc9_;
         }
         _loc6_ = li32(___mb_cur_max);
         _loc2_ -= 16;
         si32(_loc8_,_loc2_ + 4);
         var _loc10_:*;
         si32(_loc10_ = (_loc10_ = _loc1_ + _loc11_) + 4,_loc2_);
         _loc8_ = 1;
         if(_loc9_ != _loc7_)
         {
            _loc8_ = li32(_loc3_ + 8);
         }
         if(uint(_loc6_) > uint(_loc8_))
         {
            _loc6_ = _loc8_;
         }
         if((uint(_loc11_ = 2 - _loc11_)) > uint(_loc6_))
         {
            _loc11_ = _loc6_;
         }
         si32(_loc11_,_loc2_ + 8);
         ESP = _loc2_;
         Fmemcpy();
         _loc2_ += 16;
         _loc6_ = li32(_loc1_);
         si32(_loc11_ += _loc6_,_loc1_);
         if(_loc9_ != _loc7_)
         {
            _loc7_ = li32(_loc3_);
         }
         _loc9_ = -2;
         if(_loc11_ != 0)
         {
            if((uint(_loc10_ = (_loc10_ = (_loc9_ = li8(_loc1_ + 4)) + 95) & 255)) <= 93)
            {
               _loc9_ = -2;
               if(uint(_loc11_) >= 2)
               {
                  _loc9_ = -1;
                  if((uint((_loc10_ = (_loc10_ = li8(_loc1_ + 5)) + 95) & 255)) <= 93)
                  {
                     _loc9_ = 2;
                  }
               }
               §§goto(addr302);
            }
            else
            {
               _loc9_ = -1;
               if((_loc10_ = _loc9_ << 24) >> 24 >= 0)
               {
                  _loc9_ = 1;
               }
            }
            if(_loc9_ >= 0)
            {
               _loc11_ = 0;
               if(_loc9_ >= 1)
               {
                  _loc5_ = _loc1_ + 4;
                  _loc11_ = 0;
                  _loc8_ = _loc9_;
                  do
                  {
                     _loc10_ = _loc11_ << 8;
                     var _loc4_:*;
                     _loc11_ = (_loc4_ = li8(_loc5_)) | _loc10_;
                     _loc5_ += 1;
                  }
                  while((_loc8_ += -1) != 0);
                  
               }
               if(_loc7_ != 0)
               {
                  si32(_loc11_,_loc7_);
               }
               si32(_loc7_ = 0,_loc1_);
               if(_loc11_ != _loc7_)
               {
                  _loc7_ = _loc9_ - _loc6_;
               }
               _loc9_ = _loc7_;
            }
         }
      }
      addr302:
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
