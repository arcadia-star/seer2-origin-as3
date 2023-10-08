package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   
   public function F_strcmp() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc6_ = li32(_loc3_);
      do
      {
         _loc5_ = li8(_loc1_);
         if((_loc4_ = li8(_loc6_)) != _loc5_)
         {
            _loc5_ = _loc4_ - _loc5_;
            break;
         }
         _loc6_ += 1;
         _loc1_ += 1;
         _loc5_ = 0;
      }
      while(_loc4_ != 0);
      
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
