package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F___kernel_tan() : void
   {
      var _loc4_:* = 0;
      var _loc11_:* = 0;
      var _loc14_:* = 0;
      var _loc12_:* = 0;
      var _loc1_:Number = NaN;
      var _loc3_:* = 0;
      var _loc5_:* = NaN;
      var _loc7_:* = NaN;
      var _loc2_:* = ESP;
      _loc4_ = _loc2_;
      _loc2_ -= 40;
      sf64(_loc7_ = lf64(_loc4_),_loc4_ - 8);
      _loc3_ = _loc4_ - 8;
      _loc3_ |= 4;
      _loc12_ = (_loc14_ = li32(_loc3_)) & 2147483640;
      _loc5_ = lf64(_loc4_ + 8);
      if(uint(_loc12_) >= 1072010280)
      {
         if(_loc14_ <= -1)
         {
            _loc5_ = -_loc5_;
            _loc7_ = -_loc7_;
         }
         var _loc10_:* = 3.061616997868383e-17 - _loc5_;
         var _loc9_:Number;
         _loc7_ = (_loc9_ = 0.7853981633974483 - _loc7_) + _loc10_;
         _loc5_ = 0;
      }
      _loc11_ = li32(_loc4_ + 16);
      _loc9_ = _loc7_ * _loc7_;
      var _loc15_:Number = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc15_ = (_loc10_ = _loc9_ * _loc9_) * 0.00002590730518636337) + 0.00007140724913826082) * _loc10_) + 0.0002464631348184699) * _loc10_) + 0.0014562094543252903) * _loc10_) + 0.0088632398235993) * _loc10_) + 0.05396825397622605) * _loc9_;
      var _loc13_:*;
      _loc15_ = (_loc10_ = (_loc10_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = (_loc13_ = _loc10_ * -0.000018558637485527546) + 0.00007817944429395571) * _loc10_) + 0.0005880412408202641) * _loc10_) + 0.0035920791075913124) * _loc10_) + 0.021869488294859542) * _loc10_) + 0.13333333333320124) + _loc15_;
      _loc10_ = _loc9_ * _loc7_;
      _loc9_ = (_loc9_ = (_loc15_ = (_loc15_ *= _loc10_) + _loc5_) * _loc9_) + _loc5_;
      _loc1_ = (_loc10_ *= 0.3333333333333341) + _loc9_;
      _loc5_ = _loc7_ + _loc1_;
      if(uint(_loc12_) >= 1072010280)
      {
         _loc9_ = _loc11_;
         var _loc8_:*;
         _loc5_ = (_loc10_ = _loc8_ = 1 - ((_loc8_ = _loc14_ >>> 30) & 2)) * ((_loc10_ = (_loc10_ = _loc7_ - ((_loc10_ = (_loc10_ = _loc5_ * _loc5_) / (_loc5_ + _loc9_)) - _loc1_)) * -2) + _loc9_);
      }
      else if(_loc11_ != 1)
      {
         sf64(_loc5_,_loc4_ - 16);
         si32(_loc8_ = li32(_loc8_ = (_loc8_ = _loc4_ - 16) | 4),_loc4_ - 24 | 4);
         sf64(_loc9_ = -1 / _loc5_,_loc4_ - 32);
         var _loc6_:*;
         si32(_loc6_ = li32(_loc6_ = (_loc6_ = _loc4_ - 32) | 4),(_loc8_ = _loc4_ - 40) | 4);
         si32(0,_loc4_ - 24);
         si32(0,_loc4_ - 40);
         _loc5_ = (_loc9_ = (_loc15_ = (_loc10_ = lf64(_loc4_ - 40)) * (_loc1_ - ((_loc13_ = lf64(_loc4_ - 24)) - _loc7_)) + ((_loc13_ = _loc10_ * _loc13_) + 1)) * _loc9_) + _loc10_;
      }
      st0 = _loc5_;
      _loc2_ = _loc4_;
      ESP = _loc2_;
   }
}
