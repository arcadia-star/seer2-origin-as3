package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public function exportSym(param1:String, param2:int) : int
   {
      gstate.syms[param1] = param2;
      return param2;
   }
}
