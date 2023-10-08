package cmodule.desc
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public final class FSM__Z4DescPvP8_AS3_Val extends Machine
   {
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public function FSM__Z4DescPvP8_AS3_Val()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM__Z4DescPvP8_AS3_Val = null;
         _loc1_ = new FSM__Z4DescPvP8_AS3_Val();
         gstate.gworker = _loc1_;
      }
      
      final override public function work() : void
      {
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 12;
               this.i0 = 0;
               si32(this.i0,mstate.ebp + -4);
               si32(this.i0,mstate.ebp + -8);
               si32(this.i0,mstate.ebp + -12);
               mstate.esp -= 20;
               this.i0 = li32(mstate.ebp + 12);
               this.i1 = __2E_str212;
               this.i2 = mstate.ebp + -12;
               this.i3 = mstate.ebp + -8;
               this.i4 = mstate.ebp + -4;
               si32(this.i0,mstate.esp);
               si32(this.i1,mstate.esp + 4);
               si32(this.i4,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i2,mstate.esp + 16);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_ArrayValue]();
               return;
            case 1:
               mstate.esp += 20;
               this.i0 = li32(mstate.ebp + -8);
               this.i1 = li32(mstate.ebp + -12);
               this.i2 = li32(mstate.ebp + -4);
               this.i3 = this.i0 / 21;
               this.i3 *= 21;
               this.i4 = this.i2 / 13;
               this.i5 = this.i1 + 147;
               this.i1 /= 7;
               this.i4 *= 13;
               this.i0 -= this.i3;
               this.i1 = this.i5 - this.i1;
               this.i2 -= this.i4;
               this.i0 = this.i1 + this.i0;
               mstate.esp -= 4;
               this.i0 += this.i2;
               si32(this.i0,mstate.esp);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Int]();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in __Z4DescPvP8_AS3_Val";
         }
      }
   }
}
