package com.taomee.seer2.app.swap.process
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.event.SwapEventDispatcher;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.item.SwapItem;
   import com.taomee.seer2.app.swap.item.SwapItemOut;
   import com.taomee.seer2.app.swap.sharedObject.SwapSharedObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   
   public class StartSwapProcess extends EventDispatcher
   {
       
      
      private var _swapItem:SwapItem;
      
      private var _endSwapProcess:com.taomee.seer2.app.swap.process.EndSwapProcess;
      
      public function StartSwapProcess(param1:SwapItem)
      {
         super();
         this._swapItem = param1;
         this.start();
      }
      
      private function start() : void
      {
         if(this.checkSharedObject() && this.isItemNumberLimited() == false)
         {
            this.requestSwap();
         }
         else
         {
            this.sendNumberLimit();
         }
      }
      
      private function isItemNumberLimited() : Boolean
      {
         var _loc1_:SwapItemOut = null;
         for each(_loc1_ in this._swapItem.itemOutList)
         {
            if(_loc1_.referenceId >= 100000)
            {
               if(ItemManager.getItemQuantityByReferenceId(_loc1_.referenceId) >= ItemConfig.getItemDefinition(_loc1_.referenceId).quantityLimit)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function checkSharedObject() : Boolean
      {
         return SwapSharedObject.instance.startCheck(this._swapItem);
      }
      
      private function requestSwap() : void
      {
         SwapManager.swapItem(this._swapItem.swapId,1,this.onRequestSwap,this.onSwapError);
      }
      
      private function onSwapError(param1:int) : void
      {
         if(param1 == 66)
         {
            SwapSharedObject.instance.setRewardNum();
            if(this._swapItem.isShowAlert == 0)
            {
               AlertManager.showAlert("兑换已经到达上限");
            }
         }
      }
      
      private function onRequestSwap(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         this._endSwapProcess = new com.taomee.seer2.app.swap.process.EndSwapProcess();
      }
      
      private function sendNumberLimit() : void
      {
         SwapEventDispatcher.dispatchEvent(new Event(SwapEventDispatcher.NUMBER_LIMIT));
      }
      
      public function dispose() : void
      {
         if(this._swapItem)
         {
            this._swapItem = null;
         }
         if(this._endSwapProcess)
         {
            this._endSwapProcess = null;
         }
      }
   }
}
