package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80461 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [5091];
      
      private static const FOR_LIST:Array = [250228,250229];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3959]);
      
      private static const GAME_SET:Vector.<int> = Vector.<int>([5,20]);
      
      private static var _curSelectList:Vector.<int> = Vector.<int>([]);
       
      
      private var _clickTip:MovieClip;
      
      private var _fightTip:MovieClip;
      
      private var _timeUI:MovieClip;
      
      private var _cdTime:TextField;
      
      private var _clickItemList:Vector.<MovieClip>;
      
      private var _leftTime:int;
      
      public function MapProcessor_80461(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.kingTaoProcessActInit();
      }
      
      private function kingTaoProcessActInit() : void
      {
         this.initSet();
         this.initEvent();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this.update(true);
         }
         else
         {
            this.update();
         }
      }
      
      private function initSet() : void
      {
         this._clickTip = _map.content["clickTip"];
         this._fightTip = _map.content["fightTip"];
         this._timeUI = _map.content["timeUI"];
         this._cdTime = this._timeUI["cdTime"];
         this._clickItemList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._clickItemList.push(_map.content["clickItem" + _loc1_]);
            this._clickItemList[_loc1_].buttonMode = true;
            this._clickItemList[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._clickItemList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickItem);
         }
      }
      
      private function onClickItem(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         index = this._clickItemList.indexOf(evt.currentTarget);
         this.setItemMouseEnable(false);
         SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
         {
            _curSelectList.push(index);
            new SwapInfo(param1);
            update(true);
         },function(param1:uint):void
         {
            setItemMouseEnable(true);
         });
      }
      
      private function setFuncDisable() : void
      {
         this.setItemMouseEnable(false);
      }
      
      private function setItemMouseEnable(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._clickItemList)
         {
            _loc2_.mouseEnabled = _loc2_.mouseChildren = param1;
         }
      }
      
      private function setItemVisible(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._clickItemList)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function update(param1:Boolean = false) : void
      {
         var isTip:Boolean = param1;
         this.setFuncDisable();
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var _loc2_:int = 0;
               var _loc3_:int = 0;
               Tick.instance.removeRender(onTimeUpdate);
               if(info.getCount(DAY_LIST[0]) >= GAME_SET[1])
               {
                  if(isTip)
                  {
                     ServerMessager.addMessage("今天已获得所有的铁甲片,明天再来吧！");
                  }
                  setItemVisible(false);
                  _timeUI.visible = _clickTip.visible = _fightTip.visible = false;
                  return;
               }
               if(TimeManager.getPrecisionServerTime() >= param1.infoVec[0])
               {
                  _leftTime = 0;
                  _timeUI.visible = false;
                  _loc2_ = GAME_SET[0] - param1.infoVec[1];
               }
               else
               {
                  _loc2_ = 0;
                  _leftTime = param1.infoVec[0] - TimeManager.getPrecisionServerTime();
                  _cdTime.text = DateUtil.getMS(_leftTime);
                  _timeUI.visible = true;
                  Tick.instance.addRender(onTimeUpdate,1000);
               }
               if(_loc2_ > 0)
               {
                  _clickTip.visible = true;
                  _loc3_ = 0;
                  while(_loc3_ < GAME_SET[0])
                  {
                     if(_curSelectList.indexOf(_loc3_) == -1)
                     {
                        _clickItemList[_loc3_].visible = true;
                     }
                     else
                     {
                        _clickItemList[_loc3_].visible = false;
                     }
                     _loc3_++;
                  }
               }
               else
               {
                  _curSelectList = Vector.<int>([]);
                  _clickTip.visible = false;
                  _loc3_ = 0;
                  while(_loc3_ < GAME_SET[0])
                  {
                     _clickItemList[_loc3_].visible = false;
                     _loc3_++;
                  }
               }
               setItemMouseEnable(true);
            });
         });
      }
      
      private function onTimeUpdate(param1:int) : void
      {
         --this._leftTime;
         this._cdTime.text = DateUtil.getMS(this._leftTime);
         if(this._leftTime <= 0)
         {
            Tick.instance.removeRender(this.onTimeUpdate);
            this.update();
         }
      }
      
      private function kingTaoProcessActDispose() : void
      {
         var _loc1_:MovieClip = null;
         Tick.instance.removeRender(this.onTimeUpdate);
         if(this._clickItemList)
         {
            for each(_loc1_ in this._clickItemList)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickItem);
            }
            this._clickItemList = null;
         }
         this._clickTip = null;
         this._fightTip = null;
         this._timeUI = null;
         this._cdTime = null;
      }
      
      override public function dispose() : void
      {
         this.kingTaoProcessActDispose();
         super.dispose();
      }
   }
}
