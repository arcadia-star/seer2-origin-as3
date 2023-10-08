package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   public function memmove(param1:int, param2:int, param3:int) : int
   {
      var _loc4_:int = 0;
      if(param2 > param1 || param2 + param3 < param1)
      {
         memcpy(param1,param2,param3);
      }
      else
      {
         _loc4_ = param1 + param3;
         param2 += param3;
         while(param3--)
         {
            var _loc5_:*;
            gstate.ds[_loc5_ = --_loc4_] = gstate.ds[--param2];
         }
      }
      return param1;
   }
}
