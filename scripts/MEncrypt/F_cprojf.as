package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public function F_cprojf() : void
   {
      var _loc4_:* = 0;
      var _loc2_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = NaN;
      var _loc5_:* = 0;
      var _loc3_:* = ESP;
      _loc4_ = _loc3_;
      _loc3_ -= 8;
      _loc2_ = li32(_loc4_);
      _loc6_ = (_loc6_ = _loc2_ >>> 23) & 255;
      _loc5_ = li32(_loc4_ + 4);
      if(_loc6_ == 255)
      {
         if((_loc6_ = _loc2_ & 8388607) != 0)
         {
            §§goto(addr52);
         }
         §§goto(addr83);
      }
      addr52:
      si32(_loc2_,_loc4_ - 4);
      _loc6_ = (_loc6_ = _loc5_ >>> 23) & 255;
      _loc1_ = lf32(_loc4_ - 4);
      if(_loc6_ == 255)
      {
         if((_loc6_ = _loc5_ & 8388607) == 0)
         {
            addr83:
            _loc1_ = inf;
            _loc5_ &= -2147483648;
         }
      }
      sf32(_loc1_,_loc4_ - 8);
      eax = _loc6_ = li32(_loc4_ - 8);
      edx = _loc5_;
      _loc3_ = _loc4_;
      ESP = _loc3_;
   }
}
