package com.taomee.seer2.app.config.info
{
   public class PaintGuessSwapInfo
   {
       
      
      public var type:String;
      
      public var sort:uint;
      
      public var itemList:Vector.<PaintGuessSwapItemInfo>;
      
      public function PaintGuessSwapInfo(param1:String, param2:uint, param3:Vector.<PaintGuessSwapItemInfo>)
      {
         super();
         this.type = param1;
         this.sort = param2;
         this.itemList = param3;
      }
   }
}
