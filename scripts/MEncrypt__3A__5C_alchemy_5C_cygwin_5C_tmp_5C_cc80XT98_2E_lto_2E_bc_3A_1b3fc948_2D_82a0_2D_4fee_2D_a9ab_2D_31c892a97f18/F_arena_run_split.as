package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.Fmemset;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public function F_arena_run_split() : void
   {
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc9_:* = 0;
      var _loc15_:* = 0;
      var _loc17_:* = 0;
      var _loc11_:* = 0;
      var _loc8_:int = 0;
      var _loc7_:int = 0;
      var _loc13_:int = 0;
      var _loc12_:* = 0;
      var _loc4_:* = 0;
      var _loc18_:* = 0;
      var _loc10_:int = 0;
      var _loc14_:int = 0;
      var _loc16_:int = 0;
      var _loc3_:* = ESP;
      _loc6_ = _loc3_;
      _loc4_ = (_loc4_ = li32(_chunksize_mask)) ^ -1;
      _loc17_ = (_loc18_ = li32(_loc6_ + 4)) & _loc4_;
      _loc14_ = (_loc15_ = (_loc16_ = _loc18_ - _loc17_) >>> 12) * 12;
      _loc12_ = li32((_loc13_ = _loc17_ + _loc14_) + 24);
      _loc4_ = _loc13_ + 16;
      _loc11_ = li32(_loc17_ + 12);
      _loc3_ -= 16;
      si32(_loc4_,_loc3_ + 4);
      _loc1_ = li32(_loc6_);
      si32(_loc7_ = _loc1_ + 44,_loc3_);
      _loc8_ = _loc12_ >>> 12;
      ESP = _loc3_;
      F_arena_avail_tree_remove();
      _loc3_ += 16;
      _loc10_ = (_loc9_ = li32(_loc6_ + 8)) >>> 12;
      if(_loc8_ != _loc10_)
      {
         _loc4_ = (_loc4_ = _loc8_ - _loc10_) << 12;
         var _loc2_:int = _loc17_ + 16;
         _loc12_ = _loc2_ + (_loc12_ = _loc15_ + _loc10_) * 12;
         var _loc5_:*;
         si32(_loc5_ = (_loc5_ = (_loc5_ = li32(_loc12_ + 8)) & 4095) | _loc4_,_loc12_ + 8);
         _loc2_ = (_loc5_ = (_loc5_ = _loc15_ + _loc8_) * 12) + _loc2_;
         si32(_loc4_ = (_loc5_ = (_loc5_ = li32(_loc2_ - 4)) & 4095) | _loc4_,_loc2_ - 4);
         _loc3_ -= 16;
         si32(_loc12_,_loc3_ + 4);
         si32(_loc7_,_loc3_);
         ESP = _loc3_;
         F_arena_avail_tree_insert();
         _loc3_ += 16;
      }
      _loc15_ = li32(_loc6_ + 12);
      if(_loc10_ == 0)
      {
         if(_loc15_ != 0)
         {
            addr484:
            si32(_loc4_ = (_loc4_ = li32(_loc13_ + 24)) | _loc9_,_loc13_ + 24);
         }
      }
      else
      {
         _loc18_ |= 1;
         if(_loc15_ != 0)
         {
            _loc18_ = 3;
         }
         if((_loc4_ = li32(_loc6_ + 16)) == 0)
         {
            _loc14_ = (_loc4_ = _loc14_ + _loc17_) + 24;
            _loc10_ = _loc9_ >>> 12;
            while(true)
            {
               if((_loc4_ = (_loc4_ = li8(_loc14_)) & 8) != 0)
               {
                  si32(_loc4_ = (_loc4_ = li32(_loc17_ + 12)) + -1,_loc17_ + 12);
                  si32(_loc4_ = (_loc4_ = li32(_loc1_ + 40)) + -1,_loc1_ + 40);
               }
               si32(_loc18_,_loc14_);
               _loc10_ += -1;
               _loc14_ += 12;
               if(_loc10_ != 0)
               {
                  continue;
               }
            }
         }
         else
         {
            _loc16_ = (_loc4_ = _loc16_ & -4096) + _loc17_;
            _loc14_ = (_loc4_ = _loc14_ + _loc17_) + 24;
            do
            {
               if((_loc4_ = (_loc4_ = li8(_loc14_)) & 4) == 0)
               {
                  _loc3_ -= 16;
                  si32(4096,_loc3_ + 8);
                  si32(0,_loc3_ + 4);
                  si32(_loc16_,_loc3_);
                  ESP = _loc3_;
                  Fmemset();
                  _loc3_ += 16;
               }
               if((_loc4_ = (_loc4_ = li8(_loc14_)) & 8) != 0)
               {
                  si32(_loc4_ = (_loc4_ = li32(_loc17_ + 12)) + -1,_loc17_ + 12);
                  si32(_loc4_ = (_loc4_ = li32(_loc1_ + 40)) + -1,_loc1_ + 40);
               }
               si32(_loc18_,_loc14_);
               _loc16_ += 4096;
               _loc14_ += 12;
            }
            while((_loc10_ += -1) != 0);
            
         }
         if(_loc15_ != 0)
         {
            §§goto(addr484);
         }
      }
      if((_loc4_ = li32(_loc17_ + 12)) == 0)
      {
         if(_loc11_ != 0)
         {
            _loc3_ -= 16;
            si32(_loc17_,_loc3_ + 4);
            si32(_loc4_ = _loc1_ + 4,_loc3_);
            ESP = _loc3_;
            F_arena_chunk_tree_dirty_remove();
            _loc3_ += 16;
         }
      }
      _loc3_ = _loc6_;
      ESP = _loc3_;
   }
}
