package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___ucmpdi2() : void
   {
      var _loc3_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc4_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      _loc5_ = li32(_loc3_ + 4);
      _loc4_ = 0;
      if(uint(_loc5_) >= uint(_loc1_))
      {
         _loc4_ = 2;
         if(uint(_loc5_) <= uint(_loc1_))
         {
            _loc1_ = li32(_loc3_ + 8);
            _loc5_ = li32(_loc3_);
            _loc4_ = 0;
            if(uint(_loc5_) >= uint(_loc1_))
            {
               _loc4_ = 2;
               if(uint(_loc5_) <= uint(_loc1_))
               {
                  _loc4_ = 1;
               }
            }
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
