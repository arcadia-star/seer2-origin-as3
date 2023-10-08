package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_log10f() : void
   {
      var _loc6_:int = 0;
      var _loc5_:int = 0;
      var _loc18_:* = 0;
      var _loc1_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 16;
      _loc1_ = lf32(_loc6_);
      sf32(_loc1_,_loc6_ - 4);
      _loc5_ = -127;
      if((_loc18_ = li32(_loc6_ - 4)) <= 8388607)
      {
         _loc3_ = -inf;
         var _loc15_:*;
         if((_loc15_ = _loc18_ & 2147483647) != 0)
         {
            if(_loc18_ <= -1)
            {
               var _loc7_:* = _loc1_;
               var _loc9_:*;
               var _loc16_:*;
               _loc3_ = _loc9_ = (_loc7_ = _loc16_ = _loc7_ -= _loc7_) / 0;
            }
            else
            {
               _loc1_ = _loc9_ = _loc1_ * (_loc16_ = 33554432);
               sf32(_loc1_,_loc6_ - 8);
               _loc5_ = -152;
               _loc18_ = li32(_loc6_ - 8);
               addr101:
               if(_loc18_ >= 2139095040)
               {
                  _loc9_ = _loc1_;
                  _loc3_ = _loc9_ += _loc9_;
               }
               else
               {
                  var _loc14_:int;
                  _loc15_ = (_loc14_ = (_loc15_ = _loc18_ >> 23) + _loc5_) >>> 31;
                  var _loc12_:int;
                  si32((_loc12_ = 127 - _loc15_) << 23 | _loc18_ & 8388607,_loc4_ -= 16);
                  _loc9_ = 0.3010292053222656;
                  _loc9_ = _loc9_ = (_loc15_ += _loc14_) * _loc9_;
                  ESP = _loc4_;
                  F_logf();
                  _loc4_ += 16;
                  var _loc17_:*;
                  var _loc13_:Number;
                  var _loc10_:*;
                  var _loc11_:Number;
                  _loc3_ = _loc9_ += _loc16_ = _loc7_ = (_loc16_ = _loc7_ = (_loc15_ += _loc14_) * (_loc17_ = 7.903415166765626e-7)) + (_loc17_ = _loc13_ = (_loc10_ = _loc11_ = st0) * (_loc17_ = 0.4342944920063019));
               }
            }
         }
         st0 = _loc3_;
         ESP = _loc4_ = _loc6_;
         return;
      }
      §§goto(addr101);
   }
}
