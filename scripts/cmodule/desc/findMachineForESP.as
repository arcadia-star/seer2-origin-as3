package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   internal function findMachineForESP(param1:int) : Machine
   {
      var _loc2_:Object = null;
      for(_loc2_ in gsetjmpMachine2ESPMap)
      {
         if(gsetjmpMachine2ESPMap[_loc2_] == param1)
         {
            return Machine(_loc2_);
         }
      }
      return null;
   }
}
