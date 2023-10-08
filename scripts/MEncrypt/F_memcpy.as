package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import flash.utils.ByteArray;
   
   public function F_memcpy() : void
   {
      var _loc3_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_ + 8);
      _loc6_ = li32(_loc3_);
      if(_loc1_ != 0)
      {
         var _loc5_:* = li32(_loc3_ + 4);
         var _loc4_:ByteArray;
         (_loc4_ = ram).position = _loc6_;
         _loc4_.writeBytes(_loc4_,_loc5_,_loc1_);
      }
      eax = _loc6_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
