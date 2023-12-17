package com.taomee.seer2.app.swap
{
   import com.taomee.seer2.app.config.SwapConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.swap.event.SwapEventDispatcher;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.item.SwapItem;
   import com.taomee.seer2.app.swap.item.SwapItemIn;
   import com.taomee.seer2.app.swap.process.StartSwapProcess;
   import com.taomee.seer2.app.swap.sharedObject.SwapSharedObject;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.events.Event;
   import flash.utils.IDataInput;
   
   public class SwapManager
   {
      
      private static var _swapID:uint;
      
      private static var _swapItem:SwapItem;
      
      private static var _startSwapProcess:StartSwapProcess;
      
      private static var _successHandler:Function;
      
      private static var _failHandler:Function;
       
      
      public function SwapManager()
      {
         super();
      }
      
      public static function swapItem(param1:int, param2:uint = 1, param3:Function = null, param4:Function = null, param5:SpecialInfo = null) : void
      {
         _successHandler = param3;
         _failHandler = param4;
         if(param5 == null)
         {
            param5 = new SpecialInfo(0);
         }
         Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,onGetReward);
         Connection.addErrorHandler(CommandSet.ITEM_EXCHANGE_1055,onGetError);
         Connection.send(CommandSet.ITEM_EXCHANGE_1055,param1,param2,param5.data);
         MapPanelProtocolPanel.instance().swapID = param1;
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.SWAP_ID,"\n交换协议： " + CommandSet.ITEM_EXCHANGE_1055.toString() + "  swapID:" + param1 + param5.toSring());
      }
      
      private static function onGetReward(param1:MessageEvent) : void
      {
         var _loc3_:Function = null;
         var _loc4_:SwapInfo = null;
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,onGetReward);
         Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055,onGetError);
         var _loc2_:IDataInput = param1.message.getRawData();
         if(_successHandler != null)
         {
            _loc3_ = _successHandler;
            _successHandler = null;
            _loc3_(_loc2_);
         }
         else
         {
            _loc4_ = new SwapInfo(_loc2_);
         }
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.SWAP_ID,"\n交换协议： swapID=" + MapPanelProtocolPanel.instance().swapID + "  成功回包");
      }
      
      private static function onGetError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,onGetReward);
         Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055,onGetError);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.SWAP_ID,"\n交换协议： swapID=" + MapPanelProtocolPanel.instance().swapID + "  回包异常 【" + ErrorMap.findErrorMessage(param1.message.statusCode) + "】");
         if(_failHandler != null)
         {
            _failHandler(param1.message.statusCode);
            _failHandler = null;
            return;
         }
         ErrorMap.parseStatusCode(param1.message.statusCode);
      }
      
      public static function entrySwap(param1:uint) : void
      {
         _swapID = param1;
         _swapItem = SwapConfig.getSwapItem(_swapID);
         initEventListener();
         startSwap();
      }
      
      private static function initEventListener() : void
      {
         SwapEventDispatcher.addEventListener(SwapEventDispatcher.NUMBER_LIMIT,onNumberLimit);
         SwapEventDispatcher.addEventListener(SwapEventDispatcher.SWAP_END,onSwapEnd);
      }
      
      private static function onNumberLimit(param1:Event) : void
      {
         showUnavaliableMessage();
      }
      
      private static function onSwapEnd(param1:Event) : void
      {
         dispose();
      }
      
      private static function startSwap() : void
      {
         _startSwapProcess = new StartSwapProcess(_swapItem);
      }
      
      private static function showUnavaliableMessage() : void
      {
         ServerMessager.addMessage("兑换已经到达上限");
      }
      
      public static function isSwapNumberMax(param1:uint) : Boolean
      {
         var _loc2_:SwapItem = SwapConfig.getSwapItem(param1);
         return SwapSharedObject.instance.startCheck(_loc2_);
      }
      
      public static function get swapID() : uint
      {
         return _swapID;
      }
      
      public static function isSureSwap(param1:uint) : Boolean
      {
         var _loc4_:SwapItemIn = null;
         var _loc2_:SwapItem = SwapConfig.getSwapItem(param1);
         var _loc3_:Vector.<SwapItemIn> = _loc2_.itemInList;
         for each(_loc4_ in _loc3_)
         {
            if(ItemManager.getItemQuantityByReferenceId(_loc4_.referenceId) < _loc4_.count)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isEquipSureSwap(param1:uint) : Boolean
      {
         var _loc4_:SwapItemIn = null;
         var _loc2_:SwapItem = SwapConfig.getSwapItem(param1);
         var _loc3_:Vector.<SwapItemIn> = _loc2_.itemInList;
         for each(_loc4_ in _loc3_)
         {
            if(ItemManager.getItemByReferenceId(_loc2_.itemOutList[0].referenceId) != null)
            {
               return false;
            }
         }
         return true;
      }
      
      private static function disposeEventListener() : void
      {
         SwapEventDispatcher.removeEventListener(SwapEventDispatcher.NUMBER_LIMIT,onNumberLimit);
         SwapEventDispatcher.removeEventListener(SwapEventDispatcher.SWAP_END,onSwapEnd);
      }
      
      public static function dispose() : void
      {
         disposeEventListener();
         if(_swapItem)
         {
            _swapItem = null;
         }
         if(_startSwapProcess)
         {
            _startSwapProcess.dispose();
            _startSwapProcess = null;
         }
      }
   }
}
