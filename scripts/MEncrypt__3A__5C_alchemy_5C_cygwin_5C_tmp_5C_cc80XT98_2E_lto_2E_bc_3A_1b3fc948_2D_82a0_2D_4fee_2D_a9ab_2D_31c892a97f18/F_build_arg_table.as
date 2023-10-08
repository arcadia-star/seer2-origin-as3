package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.ESP;
   import MEncrypt.F_malloc;
   import MEncrypt.eax;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public function F_build_arg_table() : void
   {
      var _loc3_:* = 0;
      var _loc1_:* = 0;
      var _loc10_:* = 0;
      var _loc11_:* = 0;
      var _loc5_:* = 0;
      var _loc9_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc11_ = li32(_loc1_ + 40);
      _loc10_ = li32(_loc3_ + 8);
      _loc9_ = li32(_loc3_ + 4);
      if(_loc11_ <= 7)
      {
         _loc11_ = li32(_loc10_);
         addr85:
         si32(0,_loc11_);
         var _loc8_:*;
         if((_loc8_ = li32(_loc1_ + 40)) >= 1)
         {
            _loc11_ = 1;
            do
            {
               _loc8_ = _loc11_ << 2;
               var _loc7_:*;
               if((_loc5_ = li32(_loc8_ = (_loc7_ = li32(_loc1_)) + _loc8_)) <= 12)
               {
                  if(_loc5_ <= 5)
                  {
                     if(_loc5_ <= 2)
                     {
                        if(_loc5_ != 0)
                        {
                           if(_loc5_ != 1)
                           {
                              if(_loc5_ == 2)
                              {
                                 si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                                 _loc9_ += 4;
                              }
                           }
                           else
                           {
                              si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                              _loc9_ += 4;
                           }
                        }
                        else
                        {
                           si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else if(_loc5_ != 3)
                     {
                        if(_loc5_ != 4)
                        {
                           if(_loc5_ == 5)
                           {
                              si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                              _loc9_ += 4;
                           }
                        }
                        else
                        {
                           si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 4;
                     }
                  }
                  else if(_loc5_ <= 8)
                  {
                     if(_loc5_ != 6)
                     {
                        if(_loc5_ != 7)
                        {
                           if(_loc5_ == 8)
                           {
                              _loc8_ = (_loc8_ = li32(_loc10_)) + (_loc11_ << 3);
                              var _loc4_:*;
                              si32(_loc4_ = li32(_loc9_ + 4),_loc8_ + 4);
                              si32(li32(_loc9_),_loc8_);
                              _loc9_ += 8;
                           }
                        }
                        else
                        {
                           si32(_loc7_ = li32(_loc9_),(_loc7_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 4;
                     }
                  }
                  else if(_loc5_ <= 10)
                  {
                     if(_loc5_ != 9)
                     {
                        if(_loc5_ == 10)
                        {
                           si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        _loc7_ = (_loc8_ = li32(_loc10_)) + (_loc11_ << 3);
                        si32(_loc4_ = li32(_loc9_ + 4),_loc7_ + 4);
                        si32(li32(_loc9_),_loc7_);
                        _loc9_ += 8;
                     }
                  }
                  else if(_loc5_ != 11)
                  {
                     if(_loc5_ == 12)
                     {
                        si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 4;
                     }
                  }
                  else
                  {
                     si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                     _loc9_ += 4;
                  }
               }
               else if(_loc5_ <= 18)
               {
                  if(_loc5_ <= 15)
                  {
                     if(_loc5_ != 13)
                     {
                        if(_loc5_ != 14)
                        {
                           if(_loc5_ == 15)
                           {
                              si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                              _loc9_ += 4;
                           }
                        }
                        else
                        {
                           si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 4;
                     }
                  }
                  else if(_loc5_ != 16)
                  {
                     if(_loc5_ != 17)
                     {
                        if(_loc5_ == 18)
                        {
                           si32(_loc7_ = li32(_loc9_),(_loc7_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        _loc4_ = (_loc7_ = li32(_loc10_)) + (_loc11_ << 3);
                        si32(_loc7_ = li32(_loc9_ + 4),_loc4_ + 4);
                        si32(li32(_loc9_),_loc4_);
                        _loc9_ += 8;
                     }
                  }
                  else
                  {
                     _loc8_ = (_loc7_ = li32(_loc10_)) + (_loc11_ << 3);
                     si32(_loc4_ = li32(_loc9_ + 4),_loc8_ + 4);
                     si32(li32(_loc9_),_loc8_);
                     _loc9_ += 8;
                  }
               }
               else if(_loc5_ <= 21)
               {
                  if(_loc5_ != 19)
                  {
                     if(_loc5_ != 20)
                     {
                        if(_loc5_ == 21)
                        {
                           si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                           _loc9_ += 4;
                        }
                     }
                     else
                     {
                        si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 4;
                     }
                  }
                  else
                  {
                     si32(_loc7_ = li32(_loc9_),(_loc7_ = li32(_loc10_)) + (_loc11_ << 3));
                     _loc9_ += 4;
                  }
               }
               else if(_loc5_ <= 23)
               {
                  if(_loc5_ != 22)
                  {
                     if(_loc5_ == 23)
                     {
                        var _loc6_:*;
                        sf64(_loc6_ = lf64(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                        _loc9_ += 8;
                     }
                  }
                  else
                  {
                     sf64(_loc6_ = lf64(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                     _loc9_ += 8;
                  }
               }
               else if(_loc5_ != 24)
               {
                  if(_loc5_ == 25)
                  {
                     si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                     _loc9_ += 4;
                  }
               }
               else
               {
                  si32(_loc8_ = li32(_loc9_),(_loc8_ = li32(_loc10_)) + (_loc11_ << 3));
                  _loc9_ += 4;
               }
               _loc11_ += 1;
            }
            while((_loc8_ = li32(_loc1_ + 40)) >= _loc11_);
            
         }
      }
      else
      {
         _loc2_ -= 16;
         si32(_loc8_ = (_loc8_ = _loc11_ << 3) + 8,_loc2_);
         ESP = _loc2_;
         F_malloc();
         _loc2_ += 16;
         si32(_loc11_ = eax,_loc10_);
         if(_loc11_ != 0)
         {
            §§goto(addr85);
         }
      }
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
