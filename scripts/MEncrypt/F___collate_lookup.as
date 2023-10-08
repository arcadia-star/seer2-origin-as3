package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F___collate_lookup() : void
   {
      var _loc5_:* = 0;
      var _loc15_:* = 0;
      var _loc4_:* = 0;
      var _loc16_:* = 0;
      var _loc17_:* = 0;
      var _loc14_:int = 0;
      var _loc2_:int = 0;
      var _loc13_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:int = 0;
      var _loc8_:int = 0;
      var _loc1_:* = 0;
      var _loc10_:int = 0;
      var _loc12_:* = 0;
      var _loc3_:* = ESP;
      _loc4_ = li32((_loc5_ = _loc3_) + 4);
      si32(1,_loc4_);
      _loc17_ = li32(_loc5_ + 12);
      si32(0,_loc17_);
      _loc16_ = li32(_loc5_ + 8);
      si32(0,_loc16_);
      _loc14_ = (_loc15_ = li32(_loc5_)) + 1;
      _loc13_ = li32(___collate_chain_pri_table);
      loop0:
      while(true)
      {
         if((_loc11_ = li8(_loc13_)) == 0)
         {
            var _loc7_:*;
            si32(_loc7_ = li32(_loc7_ = (_loc7_ = li32(___collate_char_pri_table_ptr)) + ((_loc7_ = li8(_loc15_)) << 3)),_loc16_);
            var _loc6_:*;
            _loc13_ = (_loc7_ = (_loc6_ = li32(___collate_char_pri_table_ptr)) + ((_loc7_ = li8(_loc15_)) << 3)) + 4;
            break;
         }
         if((_loc12_ = li8(_loc15_)) != _loc11_)
         {
            continue;
         }
         _loc10_ = _loc13_ + 1;
         _loc1_ = _loc13_ & -4;
         if((_loc7_ = (_loc6_ = (_loc6_ &= -2139062144) ^ -2139062144) & (_loc6_ = li32(_loc1_)) + -16843009) != 0)
         {
            _loc8_ = _loc1_ + 4;
            _loc9_ = 0;
            while(true)
            {
               _loc2_ = _loc13_ + _loc9_;
               if(uint(_loc2_) < uint(_loc8_))
               {
                  continue;
               }
            }
            addr260:
            if(_loc9_ != 0)
            {
               _loc8_ = _loc9_ + -1;
               _loc1_ = _loc14_;
               while(true)
               {
                  _loc7_ = _loc11_ & 255;
                  if((_loc11_ = _loc12_ & 255) == _loc7_)
                  {
                     if(_loc11_ == 0)
                     {
                        break;
                     }
                     continue;
                  }
                  continue loop0;
               }
            }
            si32(_loc9_,_loc4_);
            si32(_loc7_ = li32(_loc13_ + 12),_loc16_);
            _loc13_ += 16;
            break;
         }
         _loc9_ = _loc1_ + 4;
         while(true)
         {
            _loc1_ = li32(_loc9_);
            _loc7_ = _loc1_ + -16843009;
            if((_loc7_ = (_loc6_ = (_loc6_ = _loc1_ & -2139062144) ^ -2139062144) & _loc7_) == 0)
            {
               continue;
            }
            if((_loc7_ = _loc1_ & 255) == 0)
            {
               _loc9_ -= _loc13_;
            }
            else if((_loc7_ = li8(_loc9_ + 1)) == 0)
            {
               _loc9_ = (_loc7_ = 1 - _loc13_) + _loc9_;
            }
            else if((_loc7_ = li8(_loc9_ + 2)) == 0)
            {
               _loc9_ = (_loc7_ = 2 - _loc13_) + _loc9_;
            }
            else
            {
               if((_loc7_ = li8(_loc9_ + 3)) != 0)
               {
                  continue;
               }
               _loc9_ = (_loc7_ = 3 - _loc13_) + _loc9_;
            }
            §§goto(addr260);
         }
      }
      si32(_loc7_ = li32(_loc13_),_loc17_);
      _loc3_ = _loc5_;
      ESP = _loc3_;
   }
}
