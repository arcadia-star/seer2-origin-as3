package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public function F___sflags() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc9_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:int = 0;
      var _loc7_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc9_ = si8(li8(_loc1_));
      _loc8_ = li32(_loc3_ + 4);
      if(_loc9_ != 97)
      {
         _loc7_ = 0;
         _loc6_ = 4;
         _loc5_ = _loc7_;
         if(_loc9_ != 114)
         {
            if(_loc9_ == 119)
            {
               _loc5_ = 1536;
               _loc7_ = 1;
               _loc6_ = 8;
               addr85:
               if((_loc9_ = li8(_loc1_ + 1)) != 43)
               {
                  if(_loc9_ == 98)
                  {
                     var _loc4_:*;
                     if((_loc4_ = li8(_loc1_ + 2)) == 43)
                     {
                        addr107:
                        _loc7_ = 2;
                        _loc6_ = 16;
                     }
                  }
                  si32(_loc4_ = _loc7_ | _loc5_,_loc8_);
                  §§goto(addr120);
               }
               §§goto(addr107);
            }
            else
            {
               ESP = _loc2_;
               F___error();
               si32(22,eax);
               _loc6_ = 0;
            }
            addr120:
            eax = _loc6_;
            _loc2_ = _loc3_;
            ESP = _loc2_;
            return;
         }
      }
      else
      {
         _loc5_ = 520;
         _loc7_ = 1;
         _loc6_ = 8;
      }
      §§goto(addr85);
   }
}
