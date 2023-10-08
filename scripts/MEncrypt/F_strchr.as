package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   
   public function F_strchr() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc4_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc7_ = li32(_loc3_);
      _loc6_ = _loc1_ & 255;
      while(true)
      {
         _loc5_ = li8(_loc7_);
         _loc4_ = _loc7_;
         if(_loc5_ == _loc6_)
         {
            break;
         }
         _loc4_ = 0;
         if(_loc5_ == 0)
         {
            break;
         }
         _loc7_ += 1;
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
