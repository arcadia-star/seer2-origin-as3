package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si8;
   
   public function F_strcpy() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc6_ = li8(_loc1_);
      _loc5_ = li32(_loc3_);
      si8(_loc6_,_loc5_);
      if(_loc6_ != 0)
      {
         _loc1_ += 1;
         _loc4_ = _loc5_ + 1;
         do
         {
            si8(_loc6_ = li8(_loc1_),_loc4_);
            _loc1_ += 1;
            _loc4_ += 1;
         }
         while(_loc6_ != 0);
         
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
