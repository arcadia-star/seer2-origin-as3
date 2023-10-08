package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si8;
   
   public function Fmemset() : void
   {
      var _loc1_:int = ESP;
      var _loc4_:* = li32(_loc1_);
      var _loc2_:* = li32(_loc1_ + 4);
      var _loc3_:* = li32(_loc1_ + 8);
      if(!_loc2_)
      {
         while(_loc3_ >= 8)
         {
            sf64(0,_loc4_);
            _loc4_ += 8;
            _loc3_ -= 8;
         }
      }
      while(_loc3_)
      {
         si8(_loc2_,_loc4_);
         _loc4_++;
         _loc3_--;
      }
   }
}
