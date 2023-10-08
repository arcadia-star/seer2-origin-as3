package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.L__2E_str78;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public function F_sysctl() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc6_ = li32(_loc1_);
      _loc5_ = li32(_loc3_ + 12);
      _loc4_ = li32(_loc3_ + 8);
      if(_loc6_ != 8)
      {
         _loc2_ -= 32;
         si32(_loc4_,_loc2_ + 20);
         si32(_loc4_,_loc2_ + 16);
         si32(_loc5_,_loc2_ + 12);
         si32(_loc4_,_loc2_ + 8);
         si32(_loc4_,_loc2_ + 4);
         si32(_loc1_,_loc2_);
         ESP = _loc2_;
         F___sysctl();
         _loc2_ += 32;
         _loc1_ = eax;
      }
      else if((_loc6_ = li32(_loc3_ + 16)) != 0)
      {
         ESP = _loc2_;
         F___error();
         si32(1,eax);
         _loc1_ = -1;
      }
      else if((_loc6_ = li32(_loc3_ + 4)) != 2)
      {
         ESP = _loc2_;
         F___error();
         si32(22,eax);
         _loc1_ = -1;
      }
      else if((_loc6_ = li32(_loc1_ + 4)) == 1)
      {
         if(_loc4_ == 0)
         {
            si32(31,_loc5_);
            _loc1_ = 0;
         }
         else if((uint(_loc6_ = li32(_loc5_))) <= 30)
         {
            ESP = _loc2_;
            F___error();
            si32(12,eax);
            _loc1_ = -1;
         }
         else
         {
            si32(31,_loc5_);
            _loc2_ -= 16;
            si32(31,_loc2_ + 8);
            si32(L__2E_str78,_loc2_ + 4);
            si32(_loc4_,_loc2_);
            ESP = _loc2_;
            Fmemcpy();
            _loc2_ += 16;
            _loc1_ = 0;
         }
      }
      else if(_loc4_ == 0)
      {
         si32(4,_loc5_);
         _loc1_ = 0;
      }
      else if((uint(_loc6_ = li32(_loc5_))) <= 3)
      {
         ESP = _loc2_;
         F___error();
         si32(12,eax);
         _loc1_ = -1;
      }
      else
      {
         si32(4,_loc5_);
         _loc1_ = li32(_loc1_ + 4);
         if(_loc1_ <= 10)
         {
            if(_loc1_ <= 5)
            {
               if(_loc1_ <= 3)
               {
                  if(_loc1_ != 2)
                  {
                     if(_loc1_ != 3)
                     {
                        addr509:
                        ESP = _loc2_;
                        F___error();
                        _loc6_ = eax;
                        si32(22,_loc6_);
                        _loc1_ = -1;
                     }
                     else
                     {
                        si32(2048,_loc4_);
                        _loc1_ = 0;
                     }
                  }
                  else
                  {
                     si32(99,_loc4_);
                     _loc1_ = 0;
                  }
               }
               else if(_loc1_ != 4)
               {
                  if(_loc1_ != 5)
                  {
                     §§goto(addr509);
                  }
                  else
                  {
                     si32(1000,_loc4_);
                     _loc1_ = 0;
                  }
               }
               else
               {
                  si32(99,_loc4_);
                  _loc1_ = 0;
               }
            }
            else if(_loc1_ <= 7)
            {
               if(_loc1_ != 6)
               {
                  if(_loc1_ != 7)
                  {
                     §§goto(addr509);
                  }
                  else
                  {
                     si32(32,_loc4_);
                     _loc1_ = 0;
                  }
               }
               else
               {
                  _loc1_ = 0;
                  si32(_loc1_,_loc4_);
               }
            }
            else if(_loc1_ != 8)
            {
               if(_loc1_ != 9)
               {
                  if(_loc1_ != 10)
                  {
                     §§goto(addr509);
                  }
                  else
                  {
                     si32(199212,_loc4_);
                     _loc1_ = 0;
                  }
               }
               else
               {
                  si32(255,_loc4_);
                  _loc1_ = 0;
               }
            }
            else
            {
               si32(2048,_loc4_);
               _loc1_ = 0;
            }
         }
         else if(_loc1_ <= 15)
         {
            if(_loc1_ <= 12)
            {
               if(_loc1_ != 11)
               {
                  if(_loc1_ != 12)
                  {
                     §§goto(addr509);
                  }
                  else
                  {
                     _loc1_ = 0;
                     si32(_loc1_,_loc4_);
                  }
               }
               else
               {
                  _loc1_ = 0;
                  si32(_loc1_,_loc4_);
               }
            }
            else if(_loc1_ != 13)
            {
               if(_loc1_ != 14)
               {
                  if(_loc1_ != 15)
                  {
                     §§goto(addr509);
                  }
                  else
                  {
                     _loc1_ = 0;
                     si32(_loc1_,_loc4_);
                  }
               }
               else
               {
                  _loc1_ = 0;
                  si32(_loc1_,_loc4_);
               }
            }
            else
            {
               _loc1_ = 0;
               si32(_loc1_,_loc4_);
            }
         }
         else if(_loc1_ <= 17)
         {
            if(_loc1_ != 16)
            {
               if(_loc1_ != 17)
               {
                  §§goto(addr509);
               }
               else
               {
                  _loc1_ = 0;
                  si32(_loc1_,_loc4_);
               }
            }
            else
            {
               _loc1_ = 0;
               si32(_loc1_,_loc4_);
            }
         }
         else if(_loc1_ != 18)
         {
            if(_loc1_ != 19)
            {
               if(_loc1_ != 20)
               {
                  §§goto(addr509);
               }
               else
               {
                  si32(255,_loc4_);
                  _loc1_ = 0;
               }
            }
            else
            {
               si32(20,_loc4_);
               _loc1_ = 0;
            }
         }
         else
         {
            _loc1_ = 0;
            si32(_loc1_,_loc4_);
         }
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
