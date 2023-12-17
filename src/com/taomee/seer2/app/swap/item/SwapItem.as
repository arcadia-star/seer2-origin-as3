package com.taomee.seer2.app.swap.item
{
   public class SwapItem
   {
       
      
      public var swapId:uint;
      
      public var timeLimit:int;
      
      public var dayMaxNum:int;
      
      public var onlyFlagIndex:int;
      
      public var isShowAlert:int;
      
      public var itemInList:Vector.<SwapItemIn>;
      
      public var itemOutList:Vector.<SwapItemOut>;
      
      public function SwapItem(param1:uint, param2:int = 1, param3:int = 1, param4:int = 0, param5:int = 0)
      {
         super();
         this.swapId = param1;
         this.timeLimit = param2;
         this.dayMaxNum = param3;
         this.onlyFlagIndex = param4;
         this.isShowAlert = param5;
      }
   }
}
