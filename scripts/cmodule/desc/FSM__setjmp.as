package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class FSM__setjmp extends Machine
   {
       
      
      public function FSM__setjmp()
      {
         super();
      }
      
      public static function start() : void
      {
         gstate.gworker = new FSM__setjmp();
         throw new AlchemyDispatch();
      }
      
      override public function work() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Machine = null;
         mstate.pop();
         _loc1_ = _mr32(mstate.esp);
         _mw32(_loc1_ + 0,667788);
         _mw32(_loc1_ + 4,caller.state);
         _mw32(_loc1_ + 8,mstate.esp);
         _mw32(_loc1_ + 12,mstate.ebp);
         _mw32(_loc1_ + 16,887766);
         log(4,"setjmp: " + _loc1_);
         _loc2_ = findMachineForESP(mstate.esp);
         if(_loc2_)
         {
            delete gsetjmpMachine2ESPMap[_loc2_];
         }
         gsetjmpMachine2ESPMap[caller] = mstate.esp;
         mstate.gworker = caller;
         mstate.eax = 0;
      }
   }
}
