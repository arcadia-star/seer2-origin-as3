package cmodule.desc
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getenv extends Machine
   {
       
      
      public function FSM_getenv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = _loc1_;
         if(_loc1_ != 0)
         {
            _loc3_ = li32(_environ);
            _loc4_ = _loc3_;
            if(_loc3_ != 0)
            {
               if((_loc5_ = li8(_loc1_)) != 0)
               {
                  if((_loc5_ &= 255) != 61)
                  {
                     _loc1_ = _loc2_;
                     while(true)
                     {
                        _loc5_ = li8(_loc1_ + 1);
                        _loc1_ += 1;
                        _loc6_ = _loc1_;
                        if(_loc5_ == 0)
                        {
                           break;
                        }
                        if((_loc5_ &= 255) == 61)
                        {
                           break;
                        }
                        _loc1_ = _loc6_;
                     }
                  }
                  else
                  {
                     addr136:
                  }
                  if((_loc4_ = li32(_loc4_)) != 0)
                  {
                     _loc3_ += 4;
                     _loc1_ -= _loc2_;
                     loop1:
                     while(true)
                     {
                        _loc5_ = 0;
                        _loc6_ = _loc3_;
                        while(true)
                        {
                           _loc8_ = _loc2_ + _loc5_;
                           _loc7_ = _loc4_ + _loc5_;
                           if(_loc1_ == _loc5_)
                           {
                              _loc4_ += _loc5_;
                              break;
                           }
                           if((_loc7_ = li8(_loc7_)) != 0)
                           {
                              _loc8_ = li8(_loc8_);
                              _loc9_ = _loc5_ + 1;
                              if((_loc7_ &= 255) != _loc8_)
                              {
                                 _loc4_ += _loc9_;
                                 break;
                              }
                              _loc5_ = _loc9_;
                              continue;
                           }
                           addr249:
                           _loc4_ += _loc5_;
                           if(_loc1_ == _loc5_)
                           {
                              _loc5_ = li8(_loc4_);
                              _loc4_ += 1;
                              if(_loc5_ == 61)
                              {
                                 _loc1_ = _loc4_;
                                 §§goto(addr73);
                              }
                           }
                           _loc4_ = li32(_loc6_);
                           _loc3_ += 4;
                           if(_loc4_ == 0)
                           {
                              break loop1;
                           }
                           continue loop1;
                        }
                        §§goto(addr249);
                     }
                     addr68:
                     _loc1_ = 0;
                     addr67:
                     addr73:
                     mstate.eax = _loc1_;
                     mstate.esp = mstate.ebp;
                     mstate.ebp = li32(mstate.esp);
                     mstate.esp += 4;
                     mstate.esp += 4;
                     return;
                     addr67:
                  }
                  §§goto(addr67);
               }
               §§goto(addr136);
            }
            §§goto(addr67);
         }
         §§goto(addr68);
      }
   }
}
