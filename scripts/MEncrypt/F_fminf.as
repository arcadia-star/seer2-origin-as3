package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   
   public function F_fminf() : void
   {
      var _loc6_:* = 0;
      var _loc2_:* = NaN;
      var _loc5_:* = NaN;
      var _loc12_:* = 0;
      var _loc1_:int = 0;
      var _loc11_:* = 0;
      var _loc13_:* = 0;
      var _loc8_:* = NaN;
      var _loc9_:* = 0;
      var _loc10_:int = 0;
      var _loc7_:* = NaN;
      var _loc4_:* = NaN;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc3_ -= 16;
      _loc2_ = lf32(_loc6_);
      sf32(_loc2_,_loc6_ - 8);
      _loc1_ = _loc6_ - 8;
      _loc13_ = _loc1_ | 4;
      sf32(_loc5_ = lf32(_loc6_ + 4),_loc13_);
      sf32(_loc2_,_loc6_ - 12);
      sf32(_loc5_,_loc6_ - 16);
      _loc13_ = (_loc13_ = (_loc12_ = li32(_loc6_ - 12)) >>> 23) & 255;
      _loc11_ = li32(_loc6_ - 16);
      if(_loc13_ == 255)
      {
         _loc4_ = _loc5_;
         if((_loc12_ & 8388607) == 0)
         {
            addr103:
            if((_loc13_ = (_loc13_ = _loc11_ >>> 23) & 255) == 255)
            {
               _loc4_ = _loc2_;
               if((_loc11_ & 8388607) == 0)
               {
               }
               §§goto(addr182);
            }
            _loc9_ = _loc10_ = 1;
            if(_loc11_ >= 0)
            {
               _loc9_ = 0;
            }
            if(_loc12_ >= 0)
            {
               _loc10_ = 0;
            }
            if((_loc13_ = (_loc13_ = _loc10_ ^ _loc9_) & 1) != 0)
            {
               _loc4_ = lf32(_loc13_ = _loc1_ | (_loc13_ = _loc11_ & -2147483648) >>> 29);
            }
            else
            {
               _loc8_ = _loc5_;
               if((_loc7_ = _loc2_) >= _loc8_)
               {
                  _loc7_ = _loc8_;
               }
               _loc4_ = _loc7_;
            }
         }
         addr182:
         st0 = _loc4_;
         _loc3_ = _loc6_;
         ESP = _loc3_;
         return;
      }
      §§goto(addr103);
   }
}
