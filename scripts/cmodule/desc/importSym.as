package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public function importSym(param1:String) : int
   {
      var s:String = param1;
      var res:int = int(gstate.syms[s]);
      if(!res)
      {
         log(3,"Undefined sym: " + s);
         return exportSym(s,regFunc(function():*
         {
            throw "Undefined sym: " + s;
         }));
      }
      return res;
   }
}
