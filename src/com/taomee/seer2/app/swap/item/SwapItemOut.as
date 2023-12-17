package com.taomee.seer2.app.swap.item
{
   public class SwapItemOut
   {
       
      
      public var referenceId:uint;
      
      public var flag:int;
      
      public var petLevel:uint;
      
      public var count:uint;
      
      public function SwapItemOut(param1:uint, param2:int = 0, param3:uint = 0, param4:uint = 0)
      {
         super();
         this.referenceId = param1;
         this.flag = param2;
         this.petLevel = param3;
         this.count = param4;
      }
   }
}
