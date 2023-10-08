package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import avm2.intrinsics.memory.sxi8;
   
   public function F_strvisx() : void
   {
      var _loc3_:* = 0;
      var _loc9_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:int = 0;
      var _loc11_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc6_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      _loc11_ = li32(_loc3_ + 8);
      _loc10_ = li32(_loc3_ + 4);
      _loc9_ = li32(_loc3_);
      if(uint(_loc11_) >= 2)
      {
         _loc8_ = _loc10_ + 1;
         _loc11_ = _loc7_ = _loc11_ + -1;
         _loc6_ = _loc9_;
         do
         {
            var _loc5_:* = si8(li8(_loc8_ - 1));
            var _loc4_:* = si8(li8(_loc8_));
            _loc2_ -= 16;
            si32(_loc4_,_loc2_ + 12);
            si32(_loc1_,_loc2_ + 8);
            si32(_loc5_,_loc2_ + 4);
            si32(_loc6_,_loc2_);
            ESP = _loc2_;
            F_vis();
            _loc11_ += -1;
            _loc8_ += 1;
            _loc2_ += 16;
            _loc6_ = eax;
         }
         while(_loc11_ != 0);
         
         _loc10_ += _loc7_;
         addr137:
         _loc5_ = si8(li8(_loc10_));
         _loc2_ -= 16;
         si32(0,_loc2_ + 12);
         si32(_loc1_,_loc2_ + 8);
         si32(_loc5_,_loc2_ + 4);
         si32(_loc6_,_loc2_);
         ESP = _loc2_;
         F_vis();
         _loc2_ += 16;
         _loc8_ = eax;
      }
      else
      {
         _loc6_ = _loc9_;
         _loc8_ = _loc9_;
         if(_loc11_ != 0)
         {
            §§goto(addr137);
         }
      }
      si8(0,_loc8_);
      eax = _loc5_ = _loc8_ - _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
