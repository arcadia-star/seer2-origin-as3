package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_modff() : void
   {
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:int = 0;
      var _loc2_:* = NaN;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = lf32(_loc4_);
      sf32(_loc2_,_loc4_ - 4);
      _loc1_ = li32(_loc4_ - 4);
      var _loc9_:*;
      _loc8_ = (_loc9_ = (_loc9_ = _loc1_ >>> 23) & 255) + -127;
      _loc7_ = li32(_loc4_ + 4);
      if(_loc8_ <= 22)
      {
         if(_loc8_ <= -1)
         {
            si32(_loc9_ = _loc1_ & -2147483648,_loc7_);
         }
         else if((_loc9_ = (_loc8_ = 8388607 >>> _loc8_) & _loc1_) == 0)
         {
            sf32(_loc2_,_loc7_);
            si32(_loc9_ = _loc1_ & -2147483648,_loc4_ - 16);
            _loc2_ = lf32(_loc4_ - 16);
         }
         else
         {
            si32(_loc9_ = _loc1_ & (_loc8_ ^ -1),_loc7_);
            si32(_loc9_,_loc4_ - 12);
            var _loc6_:*;
            _loc2_ = _loc6_ = _loc2_ - lf32(_loc4_ - 12);
         }
      }
      else
      {
         sf32(_loc2_,_loc7_);
         _loc6_ = _loc2_;
         if(!(_loc6_ != _loc6_ | _loc6_ != _loc6_))
         {
            si32(_loc9_ = _loc1_ & -2147483648,_loc4_ - 8);
            _loc2_ = lf32(_loc4_ - 8);
         }
      }
      st0 = _loc2_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
