package cmodule.desc
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM__UTF8_wcsnrtombs extends Machine
   {
       
      
      public function FSM__UTF8_wcsnrtombs()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 16;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = li32(mstate.ebp + 16);
         _loc4_ = li32(mstate.ebp + 20);
         if((_loc6_ = li32((_loc5_ = li32(mstate.ebp + 24)) + 4)) != 0)
         {
            _loc1_ = 22;
            si32(_loc1_,_val_2E_939);
            _loc1_ = -1;
         }
         else
         {
            _loc6_ = li32(_loc2_);
            if(_loc1_ != 0)
            {
               _loc7_ = 0;
               _loc8_ = mstate.ebp + -16;
               _loc9_ = _loc7_;
               _loc10_ = _loc7_;
               while(true)
               {
                  _loc12_ = _loc7_;
                  _loc11_ = _loc1_ + _loc12_;
                  _loc7_ = _loc6_;
                  if(_loc4_ != 0)
                  {
                     if(_loc9_ == _loc3_)
                     {
                        break;
                     }
                     _loc13_ = li32(_loc7_);
                     if(uint(_loc13_) <= uint(127))
                     {
                        si8(_loc13_,_loc11_);
                        if((_loc7_ = li32(_loc7_)) != 0)
                        {
                           _loc7_ = 1;
                           continue;
                        }
                        _loc6_ = 1;
                     }
                     else
                     {
                        _loc14_ = (_loc14_ = li8(___mb_cur_max_2E_b)) != 0 ? 6 : 0;
                        if(uint(_loc14_) < uint(_loc4_))
                        {
                           mstate.esp -= 12;
                           si32(_loc11_,mstate.esp);
                           si32(_loc13_,mstate.esp + 4);
                           si32(_loc5_,mstate.esp + 8);
                           mstate.esp -= 4;
                           FSM__UTF8_wcrtomb.start();
                           _loc11_ = int(mstate.eax);
                           mstate.esp += 12;
                           if(_loc11_ != -1)
                           {
                              addr583:
                              if((_loc7_ = li32(_loc7_)) != 0)
                              {
                                 _loc7_ = _loc11_;
                                 continue;
                              }
                              addr289:
                              _loc6_ = _loc11_;
                              addr598:
                              _loc7_ = 0;
                              _loc6_ = _loc10_ + _loc6_;
                              si32(_loc7_,_loc2_);
                              _loc6_ += -1;
                           }
                           else
                           {
                              addr555:
                              _loc6_ = -1;
                              si32(_loc7_,_loc2_);
                           }
                           §§goto(addr296);
                        }
                        mstate.esp -= 12;
                        si32(_loc8_,mstate.esp);
                        si32(_loc13_,mstate.esp + 4);
                        si32(_loc5_,mstate.esp + 8);
                        mstate.esp -= 4;
                        FSM__UTF8_wcrtomb.start();
                        _loc13_ = int(mstate.eax);
                        mstate.esp += 12;
                        if(_loc13_ == -1)
                        {
                           §§goto(addr555);
                        }
                        else
                        {
                           if(uint(_loc13_) > uint(_loc4_))
                           {
                              break;
                           }
                           _loc14_ = _loc8_;
                           _loc15_ = _loc13_;
                           memcpy(_loc11_,_loc14_,_loc15_);
                           _loc11_ = _loc13_;
                           §§goto(addr583);
                        }
                        mstate.esp += 4;
                        mstate.esp += 4;
                        return;
                        §§goto(addr583);
                     }
                     §§goto(addr598);
                  }
                  break;
               }
               si32(_loc7_,_loc2_);
               mstate.eax = _loc10_;
            }
            else
            {
               if(_loc3_ == 0)
               {
                  _loc6_ = 0;
               }
               else
               {
                  _loc4_ = 0;
                  _loc1_ = _loc3_ + -1;
                  _loc3_ = -1;
                  _loc2_ = mstate.ebp + -16;
                  while(true)
                  {
                     _loc7_ = li32(_loc6_);
                     _loc8_ = _loc6_;
                     if(uint(_loc7_) <= uint(127))
                     {
                        _loc7_ = 1;
                     }
                     else
                     {
                        mstate.esp -= 12;
                        si32(_loc2_,mstate.esp);
                        si32(_loc7_,mstate.esp + 4);
                        si32(_loc5_,mstate.esp + 8);
                        mstate.esp -= 4;
                        FSM__UTF8_wcrtomb.start();
                        _loc7_ = int(mstate.eax);
                        mstate.esp += 12;
                        if(_loc7_ == -1)
                        {
                           _loc6_ = -1;
                           break;
                        }
                     }
                     if((_loc8_ = li32(_loc8_)) != 0)
                     {
                        _loc6_ += 4;
                        _loc3_ += 1;
                        _loc4_ = _loc7_ + _loc4_;
                        if(_loc1_ == _loc3_)
                        {
                           _loc6_ = _loc4_;
                           break;
                        }
                        continue;
                     }
                     _loc6_ = _loc4_ + _loc7_;
                     §§goto(addr289);
                  }
               }
               _loc1_ = _loc6_;
               addr615:
               mstate.eax = _loc1_;
            }
            §§goto(addr296);
         }
         §§goto(addr615);
      }
   }
}
