package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._exp2ft;
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18._twom10061;
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_exp2f() : void
   {
      var _loc6_:int = 0;
      var _loc1_:* = NaN;
      var _loc5_:* = 0;
      var _loc20_:* = 0;
      var _loc7_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 24;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc20_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 1124073472)
      {
         if(uint(_loc20_) >= 2139095040)
         {
            var _loc16_:*;
            if((_loc16_ = _loc5_ & 8388607) == 0)
            {
               _loc3_ = 0;
               if(_loc5_ >= 0)
               {
               }
               §§goto(addr299);
            }
            var _loc9_:* = _loc1_;
            _loc3_ = _loc9_ += _loc9_;
         }
         else
         {
            _loc3_ = inf;
            _loc7_ = _loc1_;
            if(_loc7_ < 128)
            {
               _loc9_ = -150;
               if(!(_loc7_ > _loc9_ | _loc7_ != _loc7_ | _loc9_ != _loc9_))
               {
                  _loc3_ = _loc9_ = lf32(_twom10061) * lf32(_twom10061);
               }
               else
               {
                  addr133:
                  _loc9_ = _loc1_;
                  var _loc17_:Number;
                  var _loc14_:* = _loc17_ = 786432;
                  var _loc19_:*;
                  sf32(_loc19_ = _loc14_ = _loc9_ + _loc14_,_loc6_ - 20);
                  var _loc13_:* = (_loc13_ = _loc6_ - 16) | 4;
                  var _loc8_:*;
                  var _loc12_:*;
                  si32(_loc8_ = (_loc8_ = (_loc8_ = (_loc12_ = (_loc12_ = li32(_loc6_ - 20)) + 8) << 16) + 1072693248) & -1048576,_loc13_);
                  si32(0,_loc6_ - 16);
                  _loc13_ = (_loc13_ = _loc12_ & 15) << 3;
                  _loc14_ = lf64(_loc13_ = _exp2ft + _loc13_);
                  var _loc11_:* = _loc19_;
                  var _loc10_:Number;
                  var _loc18_:* = _loc10_ = -786432;
                  _loc11_ = _loc19_ = _loc11_ += _loc18_;
                  var _loc2_:* = _loc9_ -= _loc11_;
                  _loc18_ = _loc2_;
                  _loc9_ = _loc14_ * _loc18_;
                  _loc11_ = (_loc11_ = _loc18_ * _loc18_) * _loc9_;
                  var _loc15_:Number = (_loc15_ = _loc18_ * 0.009618354961276054) + 0.055505409836769104;
                  _loc11_ *= _loc15_;
                  _loc9_ = (_loc9_ = (_loc9_ = (_loc18_ = (_loc18_ *= 0.24022650718688965) + 0.6931471824645996) * _loc9_) + _loc14_) + _loc11_;
                  _loc14_ = lf64(_loc6_ - 16);
                  _loc3_ = _loc9_ *= _loc14_;
               }
            }
         }
         §§goto(addr299);
      }
      else
      {
         if(uint(_loc20_) <= 855638016)
         {
            _loc3_ = _loc9_ = _loc1_ + (_loc17_ = 1);
         }
         else
         {
            §§goto(addr133);
         }
         addr299:
         st0 = _loc3_;
         ESP = _loc4_ = _loc6_;
         return;
      }
      §§goto(addr133);
   }
}
