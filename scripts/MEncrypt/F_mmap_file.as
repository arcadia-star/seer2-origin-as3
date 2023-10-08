package MEncrypt
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_mmap_file() : void
   {
      var _loc3_:* = 0;
      var _loc4_:int = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      var _loc9_:*;
      if((_loc9_ = li32(_loc3_ + 16)) == 0)
      {
         var _loc6_:* = li32(_loc3_ + 8);
         var _loc5_:* = li32(_loc3_ + 4);
         _loc9_ = li32(_loc3_);
         _loc2_ -= 32;
         si32(li32(_loc3_ + 20),_loc2_ + 20);
         si32(-1,_loc2_ + 16);
         si32(4096,_loc2_ + 12);
         si32(_loc6_,_loc2_ + 8);
         si32(_loc5_,_loc2_ + 4);
         si32(_loc9_,_loc2_);
         si32(li32(_loc3_ + 24),_loc2_ + 24);
         ESP = _loc2_;
         F___sys_mmap();
         _loc1_ = 0;
         _loc2_ += 32;
         if((_loc4_ = eax) != 0)
         {
            si32(_loc4_,___avm2_stdin_mapping);
            _loc2_ -= 16;
            si32((_loc9_ = (_loc5_ = li32(___avm2_vgl_fb_w)) * li32(___avm2_vgl_fb_h)) << 2,_loc2_);
            ESP = _loc2_;
            F_malloc();
            _loc2_ += 16;
            si32(_loc9_ = eax,___avm2_vgl_argb_buffer);
            _loc1_ = _loc4_;
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
