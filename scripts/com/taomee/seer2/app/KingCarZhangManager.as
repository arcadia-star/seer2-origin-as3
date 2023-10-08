package com.taomee.seer2.app
{
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class KingCarZhangManager
   {
      
      public static var go:int = 0;
      
      public static var dayState:Array = new Array();
      
      public static var CarSwap:int = 3336;
       
      
      private var mapArray:Array;
      
      private var staticString:Array;
      
      private var swapTime:Array;
      
      private var _map:MapModel;
      
      private const SWAP_ID:int = 4164;
      
      private const DAY_LIST:Array = [5178];
      
      private var _leagueFly:MovieClip;
      
      private var _boxOpenMc:MovieClip;
      
      private var _main:Sprite;
      
      private var _havePlay:Boolean = false;
      
      public function KingCarZhangManager(param1:MapModel)
      {
         this.mapArray = [90,160,230,320,470,540];
         this.staticString = ["草","水","火","沙","地","冰"];
         this.swapTime = [[0,10],[11,20],[21,30],[31,40],[41,50],[51,60]];
         super();
         this._map = param1;
         StatisticsManager.newSendNovice("2015活动","战神联盟巡游会","进入" + this.staticString[this.mapArray.indexOf(this._map.id)] + "系场景人数、人次");
         QueueLoader.load(URLUtil.getActivityAnimation("leagueCruise/leagueCruise"),LoadType.SWF,this.onResLoaded);
      }
      
      private function onResLoaded(param1:ContentInfo) : void
      {
         this.initView(param1);
         this.initEvent();
         if(this.checkInActTime() && !this._havePlay)
         {
            this._havePlay = true;
            this.playLeagueFly();
         }
      }
      
      private function initView(param1:ContentInfo) : void
      {
         this._main = param1.content;
         this._leagueFly = this._main["leagueFlyMc"];
         this._leagueFly.gotoAndStop(1);
         this._leagueFly.visible = false;
         this._boxOpenMc = this._main["boxOpenMc"];
         this._boxOpenMc.gotoAndStop(1);
         this._boxOpenMc.visible = false;
         this._map.front.addChildAt(this._boxOpenMc,this._map.front.numChildren);
         this._map.front.addChildAt(this._leagueFly,this._map.front.numChildren);
      }
      
      private function initEvent() : void
      {
         this._boxOpenMc.addEventListener(MouseEvent.CLICK,this.onBoxOpen);
         TimeManager.addEventListener(TimeManager.TIME_UPDATE,this.onUpdateTime);
      }
      
      private function onBoxOpen(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.changClickState(this._boxOpenMc,false);
         MovieClipUtil.playMc(this._boxOpenMc,1,this._boxOpenMc.totalFrames,function():void
         {
            _boxOpenMc.gotoAndStop(_boxOpenMc.totalFrames);
            _boxOpenMc.visible = false;
            SwapManager.swapItem(SWAP_ID,1,function success(param1:IDataInput):void
            {
               new SwapInfo(param1);
            });
         });
      }
      
      private function onUpdateTime(param1:Event) : void
      {
         if(this.checkInActTime() && !this._havePlay)
         {
            this._havePlay = true;
            this.playLeagueFly();
         }
      }
      
      private function playLeagueFly() : void
      {
         DayLimitListManager.getDaylimitList(this.DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            var mapIndex:int = mapArray.indexOf(_map.id);
            if(0 == BitUtil.getBit(info.getCount(DAY_LIST[0]),mapIndex))
            {
               _leagueFly.visible = true;
               MovieClipUtil.playMc(_leagueFly,1,_leagueFly.totalFrames,function():void
               {
                  _boxOpenMc.visible = true;
                  _leagueFly.visible = false;
                  changClickState(_boxOpenMc,true);
               });
            }
         });
      }
      
      private function checkInActTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.fullYear != 2015)
         {
            return false;
         }
         if(_loc1_.month != 7)
         {
            return false;
         }
         if(_loc1_.date < 29 || _loc1_.date > 30)
         {
            return false;
         }
         if(_loc1_.hours != 13)
         {
            return false;
         }
         var _loc2_:int = this.mapArray.indexOf(this._map.id);
         if(_loc1_.minutes < this.swapTime[_loc2_][0] || _loc1_.minutes > this.swapTime[_loc2_][1])
         {
            return false;
         }
         return true;
      }
      
      private function changClickState(param1:MovieClip, param2:Boolean) : void
      {
         param1.buttonMode = param2;
         param1.mouseEnabled = param1.mouseChildren = param2;
      }
      
      public function dispose() : void
      {
         if(this._leagueFly)
         {
            this._leagueFly = null;
         }
         if(this._boxOpenMc)
         {
            if(this._boxOpenMc.hasEventListener(MouseEvent.CLICK))
            {
               this._boxOpenMc.removeEventListener(MouseEvent.CLICK,this.onBoxOpen);
            }
            this._boxOpenMc = null;
         }
         if(TimeManager.hasEventListener(TimeManager.TIME_UPDATE))
         {
            TimeManager.removeEventListener(TimeManager.TIME_UPDATE,this.onUpdateTime);
         }
      }
   }
}
