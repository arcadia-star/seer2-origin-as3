package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F___ULtod_D2A() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc7_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 12);
      _loc9_ = _loc1_ & 7;
      _loc8_ = li32(_loc3_ + 8);
      _loc7_ = li32(_loc3_ + 4);
      _loc6_ = li32(_loc3_);
      if(_loc9_ <= 2)
      {
         if(_loc9_ != 0)
         {
            if(_loc9_ != 1)
            {
               if(_loc9_ == 2)
               {
                  var _loc5_:*;
                  si32(_loc5_ = li32(_loc7_),_loc6_);
                  si32(_loc5_ = li32(_loc7_ + 4),_loc6_ + 4);
               }
            }
            else
            {
               addr108:
               si32(_loc5_ = li32(_loc7_),_loc6_);
               _loc5_ = (_loc5_ = _loc8_ << 20) + 1127219200;
               var _loc4_:*;
               si32(_loc5_ = (_loc4_ = (_loc4_ = li32(_loc7_ + 4)) & -1048577) | _loc5_,_loc6_ + 4);
            }
         }
         else
         {
            addr80:
            si32(0,_loc6_ + 4);
            si32(0,_loc6_);
         }
         §§goto(addr162);
      }
      else
      {
         if(_loc9_ <= 4)
         {
            if(_loc9_ != 3)
            {
               if(_loc9_ == 4)
               {
                  si32(0,_loc6_);
                  si32(2146959360,_loc6_ + 4);
               }
            }
            else
            {
               si32(2146435072,_loc6_ + 4);
               si32(0,_loc6_);
            }
         }
         else if(_loc9_ != 5)
         {
            if(_loc9_ == 6)
            {
               §§goto(addr80);
            }
         }
         else
         {
            §§goto(addr108);
         }
         addr162:
         if((_loc5_ = _loc1_ & 8) != 0)
         {
            si32(_loc5_ = (_loc5_ = li32(_loc6_ + 4)) | -2147483648,_loc6_ + 4);
         }
         _loc2_ = _loc3_;
         ESP = _loc2_;
         return;
      }
      §§goto(addr108);
   }
}
