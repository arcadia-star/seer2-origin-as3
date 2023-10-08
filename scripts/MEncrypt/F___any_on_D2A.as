package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   
   public function F___any_on_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc9_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc9_ = _loc1_ >> 5;
      _loc6_ = _loc7_ = li32((_loc8_ = li32(_loc3_)) + 16);
      if(_loc9_ <= _loc7_)
      {
         _loc6_ = _loc9_;
         if(_loc9_ < _loc7_)
         {
            _loc1_ &= 31;
            _loc6_ = _loc9_;
            if(_loc1_ != 0)
            {
               _loc1_ = 1;
               _loc6_ = _loc9_;
               var _loc4_:int;
               var _loc5_:*;
               if((_loc4_ = (_loc5_ = li32((_loc5_ = _loc8_ + (_loc9_ << 2)) + 20)) >>> _loc1_) << _loc1_ == _loc5_)
               {
                  addr87:
                  do
                  {
                     _loc1_ = 0;
                     if(_loc6_ <= 0)
                     {
                        break;
                     }
                     _loc6_ += -1;
                     _loc1_ = 1;
                  }
                  while(li32((_loc5_ = _loc8_ + (_loc6_ << 2)) + 16) == 0);
                  
               }
               eax = _loc1_;
               _loc2_ = _loc3_;
               ESP = _loc2_;
               return;
            }
         }
      }
      §§goto(addr87);
   }
}
