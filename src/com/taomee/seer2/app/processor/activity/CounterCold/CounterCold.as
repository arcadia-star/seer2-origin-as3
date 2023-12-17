package com.taomee.seer2.app.processor.activity.CounterCold
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class CounterCold
   {
      
      private static const SUERVER_BUFF_POS:int = 1;
      
      private static const TIME_SYN_DELAY:Array = [1,2,2,2,3,5,10];
      
      private static const LEAVE_TIME:Array = [10,30,180,300,900,1800,3600];
      
      private static const COUNTER_CLICK_SWAP:Array = [863,864,865,866,867,868,869,870];
      
      private static const DAY_LIMIT:Array = [584,583];
       
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _counter:MovieClip;
      
      private var _coldBottle:MovieClip;
      
      private var _scenMc:MovieClip;
      
      private var _scen1Mc:MovieClip;
      
      private var _mouseHint:Sprite;
      
      private var _handItemMc:MovieClip;
      
      private var _mouseHandItem:MovieClip;
      
      private var _timeMc:MovieClip;
      
      private var _mouseState:int;
      
      private var _counterState:int;
      
      private var _hasJoinGame:Boolean;
      
      private var _curCount:int;
      
      private var _curStartTime:int;
      
      private var _curLeaveTime:int;
      
      public function CounterCold(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.getURL();
      }
      
      private function init() : void
      {
         DayLimitManager.getDoCount(DAY_LIMIT[0],function(param1:int):void
         {
            _curCount = param1;
            ServerBufferManager.getServerBuffer(ServerBufferType.COUNTER_COLD_FIRST,onGetServer,false);
         });
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var _loc2_:int = param1.readDataAtPostion(1);
         if(_loc2_ == 0)
         {
            this._hasJoinGame = false;
         }
         else
         {
            this._hasJoinGame = true;
         }
         this.initHandle();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("counterCold/CounterCold"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function onTipClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         MovieClipUtil.playNpcTalkNew(URLUtil.getActivityNpcTalk("CounterCold"),4,[[1,0]],function():void
         {
         });
      }
      
      private function initHandle() : void
      {
         this._counter = this.getMovie("counter");
         this._counter.x = 710;
         this._counter.y = 295;
         this._counter.gotoAndStop(1);
         this._coldBottle = this.getMovie("bottle");
         this._coldBottle.buttonMode = true;
         this._coldBottle.x = 837;
         this._coldBottle.y = 267;
         this._mapModel.content.addChild(this._coldBottle);
         this._handItemMc = this.getMovie("handItem");
         this._handItemMc.x = 847;
         this._handItemMc.y = 461;
         this._handItemMc.gotoAndStop(1);
         this._mapModel.content.addChild(this._handItemMc);
         if(this._hasJoinGame == false)
         {
            this._counter.gotoAndStop(2);
            this._counterState = 1;
            this._handItemMc.buttonMode = true;
            this._scenMc = this.getMovie("scene_1");
            this._scenMc.x = 547;
            this._scenMc.y = 303;
            this._mapModel.front.addChild(this._scenMc);
            MovieClipUtil.playMc(this._scenMc,2,this._scenMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scenMc);
               _scen1Mc = getMovie("scene_2");
               _mapModel.content.addChild(_counter);
               _mapModel.front.addChild(_scen1Mc);
               MovieClipUtil.playMc(_scen1Mc,2,_scen1Mc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scen1Mc);
                  showMouseHint(_handItemMc);
               },true);
            },true);
         }
         else
         {
            this.counterStateHandle();
            this._mapModel.content.addChild(this._counter);
         }
         this._coldBottle.addEventListener(MouseEvent.CLICK,this.onBottleClick);
         this._handItemMc.addEventListener(MouseEvent.CLICK,this.onHandItemClick);
      }
      
      private function onBottleClick(param1:MouseEvent) : void
      {
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
         }
         this._mouseHint = null;
         ModuleManager.showModule(URLUtil.getAppModule("CounterColdPanel"),"正在打开病毒收集面板...");
      }
      
      private function counterStateHandle(param1:IDataInput = null) : void
      {
         var swapInfo:SwapInfo = null;
         var data:IDataInput = param1;
         if(data)
         {
            swapInfo = new SwapInfo(data);
         }
         if(!this._hasJoinGame)
         {
            this._hasJoinGame = true;
            ServerBufferManager.updateServerBuffer(ServerBufferType.COUNTER_COLD_FIRST,1,1);
            if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
            {
               DisplayUtil.removeForParent(this._mouseHint);
            }
            this._mouseHint = null;
            this.showMouseHint(this._coldBottle);
         }
         this.removeCounterMouseEvent();
         DayLimitManager.getDoCount(DAY_LIMIT[0],function(param1:int):void
         {
            var num:int = param1;
            _curCount = num;
            if(num == 0)
            {
               addCounterMouseEvent();
               _counter.gotoAndStop(2);
               _counterState = 1;
               _handItemMc.buttonMode = true;
               return;
            }
            if(num == 8)
            {
               _counter.gotoAndStop(1);
               _counterState = 0;
               _handItemMc.buttonMode = true;
               _counter.addEventListener(MouseEvent.CLICK,onFinishClick);
               return;
            }
            DayLimitManager.getDoCount(DAY_LIMIT[1],function(param1:int):void
            {
               _curStartTime = param1;
               if(TimeManager.getServerTime() - _curStartTime >= LEAVE_TIME[_curCount - 1] + TIME_SYN_DELAY[_curCount - 1])
               {
                  addCounterMouseEvent();
                  _counter.gotoAndStop(2);
                  _counterState = 1;
                  _handItemMc.buttonMode = true;
                  if(Boolean(_timeMc) && Boolean(_timeMc.parent))
                  {
                     DisplayUtil.removeForParent(_timeMc);
                     _timeMc = null;
                  }
               }
               else
               {
                  _counter.gotoAndStop(1);
                  _counterState = 0;
                  _handItemMc.buttonMode = false;
                  _curLeaveTime = LEAVE_TIME[_curCount - 1] + TIME_SYN_DELAY[_curCount - 1] - (TimeManager.getServerTime() - _curStartTime);
                  if(_curLeaveTime <= LEAVE_TIME[_curCount - 1])
                  {
                     addTimePanel();
                     (_timeMc["time"] as TextField).text = styleChange(_curLeaveTime);
                  }
                  Tick.instance.addRender(changeCounterColdValidate,1000);
               }
            });
         });
      }
      
      private function onFinishClick(param1:MouseEvent) : void
      {
         AlertManager.showAlert("你已经完成了今天的任务，明天再来吧");
      }
      
      private function addTimePanel() : void
      {
         if(Boolean(this._timeMc) && Boolean(this._timeMc.parent))
         {
            DisplayUtil.removeForParent(this._timeMc);
            this._timeMc = null;
         }
         this._timeMc = this.getMovie("timePanel");
         this._timeMc.x = 589;
         this._timeMc.y = 251;
         this._mapModel.front.addChild(this._timeMc);
      }
      
      private function changeCounterColdValidate(param1:int) : void
      {
         if(this._curLeaveTime <= 0)
         {
            this._curLeaveTime = 0;
            Tick.instance.removeRender(this.changeCounterColdValidate);
            if(Boolean(this._timeMc) && Boolean(this._timeMc.parent))
            {
               DisplayUtil.removeForParent(this._timeMc);
               this._timeMc = null;
            }
            this.addCounterMouseEvent();
            this._counter.gotoAndStop(2);
            this._handItemMc.buttonMode = true;
            return;
         }
         --this._curLeaveTime;
         if(this._curLeaveTime == LEAVE_TIME[this._curCount - 1])
         {
            this.addTimePanel();
         }
         if(this._curLeaveTime <= LEAVE_TIME[this._curCount - 1])
         {
            (this._timeMc["time"] as TextField).text = this.styleChange(this._curLeaveTime);
         }
         if(this._curLeaveTime == 0)
         {
            Tick.instance.removeRender(this.changeCounterColdValidate);
            if(Boolean(this._timeMc) && Boolean(this._timeMc.parent))
            {
               DisplayUtil.removeForParent(this._timeMc);
               this._timeMc = null;
            }
            this.addCounterMouseEvent();
            this._counter.gotoAndStop(2);
            this._handItemMc.buttonMode = true;
            this._counterState = 1;
         }
      }
      
      public function styleChange(param1:int) : String
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc2_:int = param1 / 3600;
         var _loc4_:int = (param1 - _loc2_ * 3600) / 60;
         var _loc6_:int = param1 - _loc2_ * 3600 - 60 * _loc4_;
         if(_loc2_ <= 9)
         {
            _loc3_ = "0" + String(_loc2_);
         }
         else
         {
            _loc3_ = String(_loc2_);
         }
         if(_loc4_ <= 9)
         {
            _loc5_ = "0" + String(_loc4_);
         }
         else
         {
            _loc5_ = String(_loc4_);
         }
         if(_loc6_ <= 9)
         {
            _loc7_ = "0" + String(_loc6_);
         }
         else
         {
            _loc7_ = String(_loc6_);
         }
         return _loc3_ + ":" + _loc5_ + ":" + _loc7_;
      }
      
      private function addCounterMouseEvent() : void
      {
         if(Boolean(this._counter) && Boolean(this._counter.parent))
         {
            this._counter.buttonMode = true;
            this._counter.addEventListener(MouseEvent.CLICK,this.onCounterClick);
            this._counter.addEventListener(MouseEvent.ROLL_OVER,this.onCounterOver);
            this._counter.addEventListener(MouseEvent.ROLL_OUT,this.onCounterOut);
         }
      }
      
      private function removeCounterMouseEvent() : void
      {
         if(Boolean(this._counter) && Boolean(this._counter.parent))
         {
            this._counter.buttonMode = false;
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterClick);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterOver);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterOut);
         }
      }
      
      private function onHandItemClick(param1:MouseEvent) : void
      {
         if(this._counterState == 0)
         {
            return;
         }
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
         }
         this._mouseHint = null;
         if(!this._hasJoinGame)
         {
            this.showMouseHint(this._counter);
         }
         this.handleStateHandle();
      }
      
      private function onCounterOver(param1:MouseEvent) : void
      {
         if(this._mouseState == 0 || this._counterState == 0)
         {
            this._counter.buttonMode = false;
            return;
         }
         this._counter.buttonMode = true;
         if(Boolean(this._mouseHandItem) && Boolean(this._mouseHandItem.parent))
         {
            this._mouseHandItem.gotoAndStop(2);
         }
      }
      
      private function onCounterOut(param1:MouseEvent) : void
      {
         if(Boolean(this._mouseHandItem) && Boolean(this._mouseHandItem.parent))
         {
            this._mouseHandItem.gotoAndStop(1);
         }
      }
      
      private function onCounterClick(param1:MouseEvent) : void
      {
         if(this._mouseState == 0 || this._counterState == 0)
         {
            return;
         }
         this.removeCounterMouseEvent();
         this.normalHandle();
         if(!this._hasJoinGame)
         {
            SwapManager.swapItem(COUNTER_CLICK_SWAP[0],1,this.counterStateHandle);
         }
         else
         {
            SwapManager.swapItem(COUNTER_CLICK_SWAP[this._curCount],1,this.counterStateHandle);
         }
      }
      
      private function handleStateHandle() : void
      {
         if(Boolean(this._mouseHandItem) && Boolean(this._mouseHandItem.parent))
         {
            DisplayUtil.removeForParent(this._mouseHandItem);
            this._mouseHandItem.stopDrag();
            this._mouseHandItem = null;
         }
         this._mouseHandItem = this.getMovie("handItem");
         this._mouseHandItem.gotoAndStop(1);
         this._mouseHandItem.x = LayerManager.stage.mouseX;
         this._mouseHandItem.y = LayerManager.stage.mouseY;
         this._mapModel.front.addChild(this._mouseHandItem);
         this._mouseHandItem.startDrag(true);
         Mouse.hide();
         this._mouseHandItem.mouseEnabled = this._mouseHandItem.mouseChildren = false;
         this._mouseState = 1;
         this.addCounterMouseEvent();
      }
      
      private function normalHandle() : void
      {
         if(Boolean(this._mouseHandItem) && Boolean(this._mouseHandItem.parent))
         {
            DisplayUtil.removeForParent(this._mouseHandItem);
            this._mouseHandItem.stopDrag();
            this._mouseHandItem = null;
         }
         this._mouseState = 0;
         Mouse.show();
      }
      
      public function showMouseHint(param1:MovieClip) : void
      {
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
         }
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -this._mouseHint.height + 40;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 10;
         param1.addChild(this._mouseHint);
      }
      
      public function dispose() : void
      {
         this._resLib = null;
         this._mapModel = null;
         if(Boolean(this._counter) && Boolean(this._counter.parent))
         {
            DisplayUtil.removeForParent(this._counter);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterClick);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterOver);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onCounterOut);
            this._counter.removeEventListener(MouseEvent.CLICK,this.onFinishClick);
         }
         this._counter = null;
         if(Boolean(this._coldBottle) && Boolean(this._coldBottle.parent))
         {
            this._coldBottle.removeEventListener(MouseEvent.CLICK,this.onBottleClick);
            DisplayUtil.removeForParent(this._coldBottle);
         }
         this._coldBottle = null;
         if(Boolean(this._scenMc) && Boolean(this._scenMc.parent))
         {
            DisplayUtil.removeForParent(this._scenMc);
         }
         this._scenMc = null;
         if(Boolean(this._scen1Mc) && Boolean(this._scen1Mc.parent))
         {
            DisplayUtil.removeForParent(this._scen1Mc);
         }
         this._scen1Mc = null;
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
         }
         this._mouseHint = null;
         if(Boolean(this._handItemMc) && Boolean(this._handItemMc.parent))
         {
            this._handItemMc.removeEventListener(MouseEvent.CLICK,this.onHandItemClick);
            DisplayUtil.removeForParent(this._handItemMc);
         }
         this._handItemMc = null;
         if(Boolean(this._mouseHandItem) && Boolean(this._mouseHandItem.parent))
         {
            DisplayUtil.removeForParent(this._mouseHandItem);
         }
         this._mouseHandItem = null;
         if(Boolean(this._timeMc) && Boolean(this._timeMc.parent))
         {
            DisplayUtil.removeForParent(this._timeMc);
         }
         this._timeMc = null;
         Tick.instance.removeRender(this.changeCounterColdValidate);
         this.removeCounterMouseEvent();
      }
   }
}
