package com.taomee.seer2.app.shopManager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.MatchingConfig;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.net.parser.Parser_1223;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShopManager
   {
      
      public static const CAN_NOT_BUY_IDS:Array = [203559];
      
      private static var _successCallBack:Function;
      
      private static var _errorCallBack:Function;
      
      private static var _buySuccessCallBack:Function;
      
      private static var _buyErrorCallBack:Function;
      
      private static var _waitList:Array;
      
      private static var _isRequesting:Boolean = false;
      
      private static var _isBuyRequesting:Boolean = false;
      
      private static var _tryId:uint = 0;
      
      private static var _count:uint;
      
      private static var _obj:Object;
      
      private static var _buyWaitList:Array;
      
      private static var _byte:ByteArray;
      
      private static var _buyInfo:BuyPropInfo = new BuyPropInfo();
      
      {
         initialize();
      }
      
      public function ShopManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _waitList = new Array();
         _buyWaitList = new Array();
      }
      
      public static function buyShopItem(param1:uint, param2:uint, param3:ByteArray, param4:Function, param5:Function = null) : void
      {
         if(param1)
         {
            _buyWaitList.push({
               "id":param1,
               "count":param2,
               "by":param3,
               "success":param4,
               "error":param5
            });
         }
         processNextBuyRequest();
      }
      
      private static function processNextBuyRequest() : void
      {
         var _loc1_:Object = null;
         var _loc2_:uint = 0;
         if(Boolean(_buyWaitList.length) && _isBuyRequesting == false)
         {
            _isBuyRequesting = true;
            _loc1_ = _buyWaitList.shift();
            _obj = _loc1_;
            _buySuccessCallBack = _loc1_.success;
            _buyErrorCallBack = _loc1_.error;
            _tryId = MatchingConfig.getOldId(_loc1_.id);
            _count = _loc1_.count;
            Connection.addErrorHandler(CommandSet.MI_BUY_ITEM_1224,onGerBuyRewardError);
            Connection.addCommandListener(CommandSet.MI_BUY_ITEM_1224,onGetBuyRewardSuccess);
            Connection.send(CommandSet.MI_BUY_ITEM_1224,_loc1_.id,_loc1_.count,_loc1_.by);
            _loc2_ = MatchingConfig.getOldId(_loc1_.id);
            MapPanelProtocolPanel.instance().buyID = _loc2_;
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"\n购买协议：" + CommandSet.MI_BUY_ITEM_1224 + "\n\t newID=" + _loc2_ + " oldID=" + _loc1_.id + " num=" + _loc1_.count + " price=" + ShopPanelConfig.getItemPrice(_loc2_) * _loc1_.count + "星钻");
         }
      }
      
      private static function onGetBuyRewardSuccess(param1:MessageEvent) : void
      {
         var parser:Parser_1224;
         var event:MessageEvent = param1;
         Connection.removeErrorHandler(CommandSet.MI_BUY_ITEM_1224,onGerBuyRewardError);
         Connection.removeCommandListener(CommandSet.MI_BUY_ITEM_1224,onGetBuyRewardSuccess);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"\n购买协议： 购买成功  newID=" + MapPanelProtocolPanel.instance().buyID);
         OnlyFlagManager.RequestFlag(function():void
         {
            if(OnlyFlagManager.getFlag(710) == 0)
            {
               OnlyFlagManager.updataFlag(710,1);
               SwapManager.swapItem(1210,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
               });
            }
         });
         parser = new Parser_1224(event.message.getRawData(),_obj.id,_count,_tryId);
         _buySuccessCallBack(parser);
         _buySuccessCallBack = null;
         _isBuyRequesting = false;
         _tryId = 0;
         _count = 0;
         processNextBuyRequest();
      }
      
      private static function onGerBuyRewardError(param1:MessageEvent) : void
      {
         var event:MessageEvent = param1;
         var nextRequest:Function = function():void
         {
            if(_buyErrorCallBack != null)
            {
               _buyErrorCallBack(event.message.statusCode);
               _buyErrorCallBack = null;
            }
            _isBuyRequesting = false;
            _tryId = 0;
            _count = 0;
            processNextRequest();
         };
         Connection.removeErrorHandler(CommandSet.MI_BUY_ITEM_1224,onGerBuyRewardError);
         Connection.removeCommandListener(CommandSet.MI_BUY_ITEM_1224,onGetBuyRewardSuccess);
         if(event.message.statusCode == 100105)
         {
            AlertManager.showAlert("星钻余额不足，请充值后再购买!",function():void
            {
               AlertManager.showMoney(function():void
               {
                  LayerManager.resetOperation();
                  nextRequest();
               },function():void
               {
                  LayerManager.resetOperation();
                  nextRequest();
               });
            });
         }
         else
         {
            nextRequest();
         }
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MIBUY_ID,"\n购买协议： 购买失败  newID=" + MapPanelProtocolPanel.instance().buyID + "\n\t" + ErrorMap.findErrorMessage(event.message.statusCode));
      }
      
      public static function requestShop(param1:uint, param2:Function, param3:Function = null) : void
      {
         if(param1)
         {
            _waitList.push({
               "id":param1,
               "success":param2,
               "error":param3
            });
         }
         processNextRequest();
      }
      
      private static function processNextRequest() : void
      {
         var _loc1_:Object = null;
         if(Boolean(_waitList.length) && _isRequesting == false)
         {
            _isRequesting = true;
            _loc1_ = _waitList.shift();
            _successCallBack = _loc1_.success;
            _errorCallBack = _loc1_.error;
            if(_loc1_.id == 510109)
            {
            }
            Connection.addErrorHandler(CommandSet.GET_SHOP_INFO_1223,onGerRewardError);
            Connection.addCommandListener(CommandSet.GET_SHOP_INFO_1223,onGetRewardSuccess);
            Connection.send(CommandSet.GET_SHOP_INFO_1223,_loc1_.id);
         }
      }
      
      private static function onGetRewardSuccess(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.GET_SHOP_INFO_1223,onGerRewardError);
         Connection.removeCommandListener(CommandSet.GET_SHOP_INFO_1223,onGetRewardSuccess);
         var _loc2_:Parser_1223 = new Parser_1223(param1.message.getRawData());
         _successCallBack(_loc2_);
         _successCallBack = null;
         _isRequesting = false;
         processNextRequest();
      }
      
      private static function onGerRewardError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.GET_SHOP_INFO_1223,onGerRewardError);
         Connection.removeCommandListener(CommandSet.GET_SHOP_INFO_1223,onGetRewardSuccess);
         if(_errorCallBack != null)
         {
            _errorCallBack(param1.message.statusCode);
            _errorCallBack = null;
         }
         _isRequesting = false;
         processNextRequest();
      }
      
      public static function buyBagItem(param1:BuyPropInfo) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"),"",param1);
      }
      
      public static function buyVirtualItem(param1:BuyPropInfo) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("BuyItemVirtualPanel"),"",param1);
      }
      
      public static function buyItemForId(param1:uint, param2:Function = null) : void
      {
         _buyInfo.itemId = param1;
         _buyInfo.buyComplete = param2;
         if(CAN_NOT_BUY_IDS.indexOf(param1) != -1)
         {
            return;
         }
         if(param1 > 800000)
         {
            buyBagItem(_buyInfo);
            return;
         }
         if(param1 <= 500500)
         {
            buyBagItem(_buyInfo);
         }
         else
         {
            buyVirtualItem(_buyInfo);
         }
      }
      
      public static function checkReally(param1:Number, param2:Function) : void
      {
         if(ActorManager.actorInfo.moneyCount >= param1 * 10)
         {
            param2(true);
         }
         else
         {
            param2(false);
         }
      }
      
      public static function getReallyCount(param1:Function) : void
      {
         param1(ActorManager.actorInfo.moneyCount);
      }
      
      public static function getReallyName() : String
      {
         return "星钻";
      }
      
      public static function getReallyNum(param1:Number) : Number
      {
         return param1 * 10;
      }
   }
}
