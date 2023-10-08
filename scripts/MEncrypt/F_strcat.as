package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si8;
   
   public function F_strcat() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc4_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:int = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc7_ = li8(_loc1_);
      _loc6_ = li32(_loc3_ + 4);
      _loc5_ = _loc1_;
      _loc4_ = _loc1_;
      if(_loc7_ != 0)
      {
         do
         {
            _loc4_ = _loc5_ + 1;
            _loc7_ = li8(_loc5_ + 1);
            _loc5_ = _loc4_;
         }
         while(_loc7_ != 0);
         
      }
      do
      {
         si8(_loc7_ = li8(_loc6_),_loc4_);
         _loc4_ += 1;
         _loc6_ += 1;
      }
      while(_loc7_ != 0);
      
      eax = _loc1_;
      ESP = _loc3_;
   }
}
