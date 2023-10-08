package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si8;
   
   public function F_strlcpy() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc7_ = _loc8_ = li32(_loc3_ + 4);
      if(_loc1_ != 0)
      {
         _loc6_ = li32(_loc3_);
         _loc7_ = _loc1_ + -1;
         _loc5_ = _loc8_;
         var _loc4_:*;
         do
         {
            if(_loc7_ != 0)
            {
               continue;
            }
            _loc7_ = _loc5_;
            if(_loc1_ != 0)
            {
               si8(0,_loc6_);
               _loc7_ = _loc5_;
            }
         }
         while(si8(_loc4_ = li8(_loc5_),_loc6_), _loc5_ += 1, _loc6_ += 1, _loc7_ += -1, _loc4_ != 0);
         
         §§goto(addr103);
      }
      while(true)
      {
         _loc5_ = _loc7_ + 1;
         _loc4_ = li8(_loc7_);
         _loc7_ = _loc5_;
         if(_loc4_ == 0)
         {
            addr103:
            _loc4_ = _loc8_ ^ -1;
            eax = _loc4_ = _loc5_ + _loc4_;
            _loc2_ = _loc3_;
         }
         continue;
         ESP = _loc2_;
         return;
      }
   }
}
