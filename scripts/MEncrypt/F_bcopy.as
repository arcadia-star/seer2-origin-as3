package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import flash.utils.ByteArray;
   
   public function F_bcopy() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      if(_loc1_ != 0)
      {
         var _loc5_:* = li32(_loc3_);
         var _loc4_:ByteArray;
         (_loc4_ = ram).position = li32(_loc3_ + 4);
         _loc4_.writeBytes(_loc4_,_loc5_,_loc1_);
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
