package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   
   public function F_memchr() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc7_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      if((_loc7_ = li32(_loc3_ + 8)) != 0)
      {
         _loc5_ = li32(_loc3_);
         _loc4_ = li32(_loc3_ + 4) & 255;
         do
         {
            var _loc6_:* = li8(_loc5_);
            _loc1_ = _loc5_;
            if(_loc6_ == _loc4_)
            {
               break;
            }
            _loc5_ += 1;
            _loc7_ += -1;
            _loc1_ = 0;
         }
         while(_loc7_ != 0);
         
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
