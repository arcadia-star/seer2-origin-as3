package com.fcc
{
   import MEncrypt.*;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public function MDecrypt(param1:ByteArray, param2:int, param3:ByteArray) : void
   {
      var _loc15_:* = undefined;
      var _loc6_:* = 0;
      var _loc17_:* = 0;
      var _loc16_:int = 0;
      var _loc10_:* = 0;
      var _loc13_:int = 0;
      var _loc14_:int = 0;
      var _loc12_:int = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:*;
      _loc6_ = _loc5_ = ESP;
      ESP = _loc5_ & -16;
      var _loc4_:*;
      if((_loc4_ = int(getDefinitionByName("net.DLLLoader").size)) == 1011)
      {
         ESP = _loc5_ & -16;
         _loc17_ = param2;
         _loc5_ -= 16;
         si32(_loc17_,_loc5_);
         ESP = _loc5_;
         F_malloc();
         _loc5_ += 16;
         _loc16_ = eax;
         ESP = _loc5_ & -16;
         CModule.writeBytes(_loc16_,_loc17_,param1);
         _loc5_ -= 16;
         si32(_loc14_ = _loc17_ + -1,_loc5_);
         ESP = _loc5_;
         F_malloc();
         _loc5_ += 16;
         _loc13_ = eax;
         if(_loc14_ >= 1)
         {
            _loc12_ = _loc16_ + 1;
            _loc11_ = _loc17_ + -1;
            _loc10_ = li8(_loc16_);
            _loc9_ = _loc13_;
            do
            {
               var _loc8_:int = (_loc4_ = _loc10_ & 224) >>> 5;
               si8(_loc4_ = (_loc4_ = (_loc10_ = li8(_loc12_)) << 3) | _loc8_,_loc9_);
               _loc12_ += 1;
               _loc11_ += -1;
               _loc9_ += 1;
            }
            while(_loc11_ != 0);
            
            if(_loc14_ >= 1)
            {
               _loc12_ = _loc17_ + -1;
               _loc11_ = _loc13_;
               _loc7_ = 0;
               do
               {
                  _loc10_ = li8(_loc11_);
                  _loc9_ = 0;
                  _loc17_ = L__2E_str5;
                  if(_loc7_ != 17)
                  {
                     _loc17_ = L__2E_str5 + _loc7_;
                     _loc9_ = _loc7_ + 1;
                  }
                  si8(_loc4_ = (_loc4_ = li8(_loc17_)) ^ _loc10_,_loc11_);
                  _loc11_ += 1;
                  _loc12_ += -1;
                  _loc7_ = _loc9_;
               }
               while(_loc12_ != 0);
               
            }
         }
         if(_loc16_ != 0)
         {
            _loc5_ -= 16;
            si32(_loc16_,_loc5_);
            ESP = _loc5_;
            F_idalloc();
            _loc5_ += 16;
         }
         ESP = _loc5_ & -16;
         CModule.readBytes(_loc13_,_loc14_,param3);
         if(_loc13_ != 0)
         {
            _loc5_ -= 16;
            si32(_loc13_,_loc5_);
            ESP = _loc5_;
            F_idalloc();
            _loc5_ += 16;
         }
      }
      ESP = _loc5_ = _loc6_;
      return _loc15_;
   }
}
