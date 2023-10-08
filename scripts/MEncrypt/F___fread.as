package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___fread() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc10_:int = 0;
      var _loc4_:* = 0;
      var _loc7_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 4);
      _loc10_ = (_loc11_ = li32(_loc3_ + 8)) * _loc1_;
      _loc9_ = 0;
      if(_loc10_ != 0)
      {
         var _loc8_:*;
         if((_loc8_ = li32((_loc9_ = li32(_loc3_ + 12)) + 100)) == 0)
         {
            si32(-1,_loc9_ + 100);
         }
         if((_loc7_ = li32(_loc9_ + 4)) <= -1)
         {
            si32(_loc7_ = 0,_loc9_ + 4);
         }
         _loc6_ = li32(_loc3_);
         _loc5_ = _loc10_;
         while(true)
         {
            _loc4_ = li32(_loc9_);
            if(uint(_loc7_) >= uint(_loc5_))
            {
               _loc2_ -= 16;
               si32(_loc4_,_loc2_ + 4);
               si32(_loc6_,_loc2_);
               si32(_loc5_,_loc2_ + 8);
               ESP = _loc2_;
               Fmemcpy();
               _loc2_ += 16;
               si32(_loc8_ = (_loc8_ = li32(_loc9_ + 4)) - _loc5_,_loc9_ + 4);
               si32(_loc8_ = (_loc8_ = li32(_loc9_)) + _loc5_,_loc9_);
               _loc9_ = _loc11_;
               break;
            }
            _loc2_ -= 16;
            si32(_loc4_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            si32(_loc7_,_loc2_ + 8);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            si32(_loc8_ = (_loc8_ = li32(_loc9_)) + _loc7_,_loc9_);
            _loc2_ -= 16;
            si32(_loc9_,_loc2_);
            _loc5_ -= _loc7_;
            ESP = _loc2_;
            F___srefill();
            _loc2_ += 16;
            if((_loc8_ = eax) != 0)
            {
               _loc9_ = (uint(_loc8_ = _loc10_ - _loc5_)) / uint(_loc1_);
               break;
            }
            _loc6_ += _loc7_;
            _loc7_ = li32(_loc9_ + 4);
         }
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
