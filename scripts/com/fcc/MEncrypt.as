package com.fcc
{
   import MEncrypt.*;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public function MEncrypt(param1:ByteArray, param2:int, param3:ByteArray) : void
   {
      var _loc5_:* = undefined;
      var _loc8_:* = 0;
      var _loc19_:* = 0;
      var _loc18_:int = 0;
      var _loc4_:* = 0;
      var _loc16_:int = 0;
      var _loc17_:int = 0;
      var _loc15_:* = 0;
      var _loc14_:* = 0;
      var _loc13_:* = 0;
      var _loc12_:* = 0;
      var _loc10_:int = 0;
      var _loc9_:int = 0;
      var _loc6_:*;
      _loc8_ = _loc6_ = ESP;
      ESP = _loc6_ & -16;
      var _loc7_:*;
      if((_loc7_ = int(getDefinitionByName("net.DLLLoader").size)) == 1011)
      {
         ESP = _loc6_ & -16;
         _loc19_ = param2;
         _loc6_ -= 16;
         si32(_loc19_,_loc6_);
         ESP = _loc6_;
         F_malloc();
         _loc6_ += 16;
         _loc18_ = eax;
         ESP = _loc6_ & -16;
         CModule.writeBytes(_loc18_,_loc19_,param1);
         _loc6_ -= 16;
         si32(_loc17_ = _loc19_ + 1,_loc6_);
         ESP = _loc6_;
         F_malloc();
         _loc6_ += 16;
         _loc16_ = eax;
         _loc15_ = _loc18_;
         _loc14_ = _loc16_;
         _loc13_ = _loc19_;
         _loc12_ = 0;
         if(_loc19_ >= 1)
         {
            do
            {
               _loc4_ = li8(_loc15_);
               _loc9_ = L__2E_str5;
               _loc10_ = 0;
               if(_loc12_ != 17)
               {
                  _loc9_ = L__2E_str5 + _loc12_;
                  _loc10_ = _loc12_ + 1;
               }
               si8(_loc7_ = (_loc7_ = li8(_loc9_)) ^ _loc4_,_loc14_);
               _loc15_ += 1;
               _loc14_ += 1;
               _loc13_ += -1;
               _loc12_ = _loc10_;
            }
            while(_loc13_ != 0);
            
         }
         _loc4_ = _loc16_ + _loc19_;
         si8(0,_loc4_);
         if((_loc7_ = _loc19_ + -1) >= 0)
         {
            if((_loc13_ = 0 - _loc19_) <= -1)
            {
               _loc13_ = -1;
            }
            _loc19_ = (_loc7_ = _loc19_ + _loc13_) + 1;
            do
            {
               _loc7_ = li8(_loc4_);
               var _loc11_:*;
               si8(_loc7_ = (_loc11_ = (_loc11_ = li8(_loc4_ - 1)) >>> 3) | _loc7_,_loc4_);
               si8(_loc7_ = (_loc7_ = li8(_loc4_ - 1)) << 5,_loc4_ - 1);
               _loc4_ += -1;
            }
            while((_loc19_ += -1) != 0);
            
         }
         si8(_loc7_ = (_loc7_ = li8(_loc16_)) | 3,_loc16_);
         if(_loc18_ != 0)
         {
            _loc6_ -= 16;
            si32(_loc18_,_loc6_);
            ESP = _loc6_;
            F_idalloc();
            _loc6_ += 16;
         }
         ESP = _loc6_ & -16;
         CModule.readBytes(_loc16_,_loc17_,param3);
         if(_loc16_ != 0)
         {
            _loc6_ -= 16;
            si32(_loc16_,_loc6_);
            ESP = _loc6_;
            F_idalloc();
            _loc6_ += 16;
         }
      }
      ESP = _loc6_ = _loc8_;
      return _loc5_;
   }
}
