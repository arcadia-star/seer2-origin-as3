package com.taomee.seer2.app.activity.onlineReward
{
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.DisplayUtil;
   
   public class DoubleRewardVipPanel
   {
       
      
      private var _buy4:SimpleButton;
      
      private var _count000:MovieClip;
      
      private var _creatvip:MovieClip;
      
      private var _timer:Timer;
      
      private var _coins:uint;
      
      private var _itemID:uint;
      
      private var _currConis:uint;
      
      private var _doubleRewardVipPanel:MovieClip;
      
      private var _fun:Function;
      
      public function DoubleRewardVipPanel(param1:MovieClip)
      {
         super();
         this._doubleRewardVipPanel = param1;
         this._count000 = this._doubleRewardVipPanel["count000"];
         this._count000.gotoAndStop(1);
         this._buy4 = this._doubleRewardVipPanel["buy4"];
         this._creatvip = this._doubleRewardVipPanel["creatvip"];
         this.initEvent();
      }
      
      private function initEvent() : void
      {
         this._buy4.addEventListener(MouseEvent.CLICK,this.onGetRewardVip);
      }
      
      private function onGetRewardVip(param1:MouseEvent) : void
      {
         this._buy4.mouseEnabled = false;
         ColorFilter.setGrayscale(this._buy4);
         SwapManager.swapItem(3177,1,this.onGetRewardSuccess);
      }
      
      private function onGetRewardSuccess(param1:IDataInput) : void
      {
         var data:IDataInput = param1;
         var swapInfo:SwapInfo = new SwapInfo(data,false);
         this._itemID = swapInfo.itemID;
         this._currConis = 0;
         this._count000.gotoAndPlay(1);
         DayLimitManager.getDoCount(1334,function(param1:uint):void
         {
            _coins = param1;
            _timer = new Timer(1000);
            _timer.addEventListener(TimerEvent.TIMER,onTimer);
            _timer.start();
         });
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(this._timer.currentCount == 2)
         {
            this._count000.gotoAndStop(this._coins + 1);
         }
         if(this._timer.currentCount == 3)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._fun();
         }
      }
      
      public function show(param1:Function = null) : void
      {
         this._fun = param1;
         this._buy4.mouseEnabled = true;
         this._buy4.filters = [];
         this._buy4.addEventListener(MouseEvent.CLICK,this.onGetRewardVip);
         this._count000.gotoAndStop(1);
         LayerManager.topLayer.addChild(this._doubleRewardVipPanel);
         DisplayUtil.align(this._doubleRewardVipPanel);
      }
      
      public function dispose() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
         this._timer = null;
         LayerManager.topLayer.removeChild(this._doubleRewardVipPanel);
      }
   }
}
