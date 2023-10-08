package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public function F_strsep() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc8_:* = 0;
      var _loc10_:* = 0;
      var _loc7_:int = 0;
      var _loc6_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc10_ = li32(_loc1_);
      _loc9_ = 0;
      if(_loc10_ != 0)
      {
         _loc8_ = li32(_loc3_ + 4);
         _loc7_ = _loc10_ + 1;
         loop0:
         while(true)
         {
            _loc6_ = li8(_loc7_ - 1);
            _loc5_ = _loc8_;
            while(true)
            {
               _loc4_ = li8(_loc5_);
               _loc9_ = _loc6_ & 255;
               if(_loc4_ == _loc9_)
               {
                  break;
               }
               _loc5_ += 1;
               if(_loc4_ != 0)
               {
                  continue;
               }
               continue loop0;
            }
            _loc8_ = 0;
            if(_loc9_ != 0)
            {
               si8(0,_loc7_ - 1);
               _loc8_ = _loc7_;
            }
            si32(_loc8_,_loc1_);
            _loc9_ = _loc10_;
         }
      }
      eax = _loc9_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
