package cmodule.desc
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_localeconv extends Machine
   {
       
      
      public function FSM_localeconv()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li8(___mlocale_changed_2E_b);
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
            si8(_loc1_,___mlocale_changed_2E_b);
         }
         _loc1_ = li8(___nlocale_changed_2E_b);
         if(_loc1_ == 0)
         {
            _loc1_ = __2E_str20157;
            si32(_loc1_,_ret_2E_993_2E_0);
            _loc1_ = __2E_str58;
            si32(_loc1_,_ret_2E_993_2E_1);
            _loc1_ = _numempty22;
            si32(_loc1_,_ret_2E_993_2E_2);
            _loc1_ = 1;
            si8(_loc1_,___nlocale_changed_2E_b);
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
