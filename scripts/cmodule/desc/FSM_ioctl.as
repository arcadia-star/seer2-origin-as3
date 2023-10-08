package cmodule.desc
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM_ioctl extends Machine
   {
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public function FSM_ioctl()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_ioctl = null;
         _loc1_ = new FSM_ioctl();
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
               mstate.esp -= 8;
               this.i2 = mstate.ebp + 16;
               si32(this.i2,mstate.ebp + -8);
               this.i0 = mstate.ebp + -8;
               this.i0 = li32(mstate.ebp + 8);
               this.i1 = li32(mstate.ebp + 12);
               if(this.i0 == 0)
               {
                  si32(this.i2,mstate.ebp + -4);
                  if(this.i1 <= 1074029312)
                  {
                     if(this.i1 == -1072405750)
                     {
                        this.i0 = ___sF;
                        mstate.esp -= 16;
                        this.i1 = __2E_str2393;
                        this.i0 += 176;
                        this.i2 = 14;
                        this.i3 = 1;
                        si32(this.i1,mstate.esp);
                        si32(this.i3,mstate.esp + 4);
                        si32(this.i2,mstate.esp + 8);
                        si32(this.i0,mstate.esp + 12);
                        state = 3;
                        mstate.esp -= 4;
                        FSM_fwrite.start();
                        return;
                     }
                     if(this.i1 == -1062968474)
                     {
                        this.i0 = li32(mstate.ebp + -4);
                        this.i1 = this.i0 + 4;
                        si32(this.i1,mstate.ebp + -4);
                        this.i0 = li32(this.i0);
                        this.i1 = li32(this.i0);
                        this.i2 = this.i0;
                        if(uint(this.i1) <= uint(8))
                        {
                           this.i3 = _smodes;
                           this.i1 *= 164;
                           this.i4 = this.i2;
                           this.i1 = this.i3 + this.i1;
                           this.i3 = 164;
                           memcpy(this.i4,this.i1,this.i3);
                           this.i1 = li32(this.i2 + 12);
                           this.i2 = li32(this.i2 + 8);
                           this.i0 = li32(this.i0);
                           this.i3 = ___sF;
                           mstate.esp -= 20;
                           this.i4 = __2E_str1392;
                           this.i3 += 176;
                           si32(this.i3,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           si32(this.i0,mstate.esp + 8);
                           si32(this.i2,mstate.esp + 12);
                           si32(this.i1,mstate.esp + 16);
                           state = 1;
                           mstate.esp -= 4;
                           FSM_fprintf.start();
                           return;
                        }
                        this.i0 = 0;
                        this.i1 = this.i2;
                        this.i2 = this.i0;
                        this.i3 = 164;
                        memset(this.i1,this.i2,this.i3);
                        break;
                     }
                  }
                  else
                  {
                     if(this.i1 == 1074029313)
                     {
                        this.i0 = 0;
                        this.i1 = li32(mstate.ebp + -4);
                        this.i2 = this.i1 + 4;
                        si32(this.i2,mstate.ebp + -4);
                        this.i1 = li32(this.i1);
                        si32(this.i0,this.i1);
                        break;
                     }
                     if(this.i1 != 1074296323)
                     {
                        if(this.i1 == 1241672454)
                        {
                           this.i0 = ___sF;
                           this.i1 = li32(mstate.ebp + -4);
                           this.i2 = this.i1 + 4;
                           si32(this.i2,mstate.ebp + -4);
                           this.i1 = li32(this.i1);
                           mstate.esp -= 16;
                           this.i2 = __2E_str391;
                           this.i0 += 176;
                           this.i3 = 11;
                           this.i4 = 1;
                           si32(this.i2,mstate.esp);
                           si32(this.i4,mstate.esp + 4);
                           si32(this.i3,mstate.esp + 8);
                           si32(this.i0,mstate.esp + 12);
                           state = 2;
                           mstate.esp -= 4;
                           FSM_fwrite.start();
                           return;
                        }
                     }
                     else
                     {
                        §§goto(addr663);
                     }
                  }
                  this.i0 = ___sF;
                  mstate.esp -= 12;
                  this.i2 = __2E_str4397;
                  this.i0 += 176;
                  si32(this.i0,mstate.esp);
                  si32(this.i2,mstate.esp + 4);
                  si32(this.i1,mstate.esp + 8);
                  state = 5;
                  mstate.esp -= 4;
                  FSM_fprintf.start();
                  return;
               }
               state = 6;
            case 6:
               this.i0 = mstate.system.ioctl(this.i0,this.i1,this.i2);
               break;
            case 1:
               mstate.esp += 20;
               this.i0 = 0;
               break;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = 0;
               this.i2 = this.i0;
               this.i3 = 2562;
               memset(this.i1,this.i2,this.i3);
               this.i2 = 256;
               si16(this.i2,this.i1);
               this.i1 += 2;
               this.i2 = this.i0;
               do
               {
                  si8(this.i2,this.i1);
                  this.i2 += 1;
                  this.i1 += 10;
                  this.i0 += 1;
               }
               while(this.i0 != 256);
               
               this.i0 = 0;
               break;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = li32(mstate.ebp + -4);
               this.i1 = this.i0 + 4;
               si32(this.i1,mstate.ebp + -4);
               this.i1 = li32(this.i0);
               this.i0 = li32(this.i1);
               if(this.i0 == 5)
               {
                  this.i2 = 0;
                  this.i0 = vgl_mouse_x();
                  this.i3 = this.i0;
                  this.i0 = vgl_mouse_y();
                  this.i4 = this.i0;
                  this.i0 = vgl_mouse_buttons();
                  si32(this.i0,this.i1 + 16);
                  si32(this.i3,this.i1 + 4);
                  si32(this.i4,this.i1 + 8);
                  this.i0 = this.i2;
                  break;
               }
               addr663:
               this.i0 = ___sF;
               this.i1 = li32(mstate.ebp + -4);
               this.i2 = this.i1 + 4;
               si32(this.i2,mstate.ebp + -4);
               this.i1 = li32(this.i1);
               mstate.esp -= 16;
               this.i2 = __2E_str3396;
               this.i0 += 176;
               this.i3 = 11;
               this.i4 = 1;
               si32(this.i2,mstate.esp);
               si32(this.i4,mstate.esp + 4);
               si32(this.i3,mstate.esp + 8);
               si32(this.i0,mstate.esp + 12);
               state = 4;
               mstate.esp -= 4;
               FSM_fwrite.start();
               return;
               break;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 16;
               this.i0 = 0;
               si16(this.i0,this.i1);
               si16(this.i0,this.i1 + 2);
               si16(this.i0,this.i1 + 4);
               si16(this.i0,this.i1 + 6);
               break;
            case 5:
               mstate.esp += 12;
               this.i0 = -1;
               break;
            default:
               throw "Invalid state in _ioctl";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
