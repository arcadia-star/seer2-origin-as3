package com.taomee.seer2.app.info
{
   public class BuyPropInfo
   {
       
      
      public var itemId:uint;
      
      public var iconId:uint;
      
      public var canBatch:Boolean = true;
      
      public var buyType:String = "mi";
      
      public var islimitNum:Boolean = false;
      
      public var price:uint;
      
      public var buyNum:uint = 1;
      
      public var buyComplete:Function;
      
      public var cancelFunc:Function;
      
      public var noVip:Number = 0;
      
      public function BuyPropInfo()
      {
         super();
      }
   }
}
