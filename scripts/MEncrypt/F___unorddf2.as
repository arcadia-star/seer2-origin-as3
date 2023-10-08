package MEncrypt
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   
   public function F___unorddf2() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc2_ -= 8;
      _loc1_ = _loc3_;
      _loc1_ |= 4;
      _loc1_ = li32(_loc1_);
      _loc8_ = _loc1_ & 2147483647;
      _loc6_ = _loc7_ = 1;
      if(uint(_loc8_) <= 2146435072)
      {
         _loc6_ = 0;
      }
      _loc1_ = li32(_loc3_);
      _loc5_ = _loc7_;
      if(_loc1_ == 0)
      {
         _loc5_ = 0;
      }
      if(_loc8_ != 2146435072)
      {
         _loc5_ = _loc6_;
      }
      if(_loc5_ == 0)
      {
         var _loc4_:*;
         sf64(_loc4_ = lf64(_loc3_ + 8),_loc3_ - 8);
         _loc6_ = li32(_loc3_ - 8 | 4) & 2147483647;
         _loc5_ = _loc7_ = 1;
         if(uint(_loc6_) <= 2146435072)
         {
            _loc5_ = 0;
         }
         _loc1_ = li32(_loc3_ - 8);
         _loc8_ = _loc7_;
         if(_loc1_ == 0)
         {
            _loc8_ = 0;
         }
         if(_loc6_ != 2146435072)
         {
            _loc8_ = _loc5_;
         }
         if(_loc8_ == 0)
         {
            _loc7_ = 0;
         }
      }
      eax = _loc7_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
