package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class MapProcessor_80233 extends MapProcessor
   {
      
      private static const floor_forever_limit:int = 204496;
      
      private static const next_floor_open_time_limit:int = 204497;
       
      
      private var oneEnter:SimpleButton;
      
      private var timeMc:MovieClip;
      
      private var timeTxt:TextField;
      
      private var timer:Timer;
      
      private var leftTime:int = 0;
      
      private var openPanel:MovieClip;
      
      private var butIDarr:Array;
      
      private var currentCompleteFloor:int = 0;
      
      private var nextOpenTime:int = 0;
      
      private var shi:int;
      
      private var fen:int;
      
      private var miao:int;
      
      private var str:String = "";
      
      public function MapProcessor_80233(param1:MapModel)
      {
         this.butIDarr = [604041,604041,604042,604043,604044,604045];
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMc();
      }
      
      private function initMc() : void
      {
         this.timeMc = _map.content["timeMc"];
         this.timeTxt = this.timeMc["timeTxt"];
         this.oneEnter = this.timeMc["oneKeyEnter"];
         this.timeMc.visible = false;
         this.openPanel = _map.content["openPanel"];
         this.openPanel.buttonMode = true;
         this.openPanel.addEventListener(MouseEvent.CLICK,this.onopenPanel);
         this.oneEnter.addEventListener(MouseEvent.CLICK,this.onOneEnter);
         this.checkOpenPanel();
      }
      
      private function onOneEnter(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = new BuyPropInfo();
         _loc2_.itemId = this.butIDarr[this.currentCompleteFloor];
         _loc2_.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(_loc2_);
      }
      
      private function checkOpenPanel() : void
      {
         ActiveCountManager.requestActiveCountList([floor_forever_limit,next_floor_open_time_limit],function(param1:Parser_1142):void
         {
            currentCompleteFloor = param1.infoVec[0];
            nextOpenTime = param1.infoVec[1];
            if(currentCompleteFloor == 6)
            {
               ModuleManager.showAppModule("DaoMengKongJianPanel");
               return;
            }
            checkDisplay();
         });
      }
      
      private function checkDisplay() : void
      {
         if(this.currentCompleteFloor == 6)
         {
            ModuleManager.showModule(URLUtil.getAppModule("DaoMengKongJianPanel"),"");
            this.timeMc.visible = false;
            return;
         }
         this.leftTime = this.nextOpenTime - TimeManager.getPrecisionServerTime();
         if(this.leftTime > 0)
         {
            this.showCountDown();
         }
         else
         {
            this.timeMc.visible = false;
         }
      }
      
      private function showCountDown() : void
      {
         this.timeMc.visible = true;
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer.start();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         --this.leftTime;
         if(this.leftTime <= 0)
         {
            this.timeMc.visible = false;
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this.timer = null;
         }
         else
         {
            this.shi = int(this.leftTime / 3600);
            this.fen = int((this.leftTime - this.shi * 3600) / 60);
            this.miao = this.leftTime - 60 * this.fen - 3600 * this.shi;
            this.str = "";
            if(this.shi < 10)
            {
               this.str += "0" + this.shi.toString() + ":";
            }
            else
            {
               this.str += this.shi.toString() + ":";
            }
            if(this.fen < 10)
            {
               this.str += "0" + this.fen.toString() + ":";
            }
            else
            {
               this.str += this.fen.toString() + ":";
            }
            if(this.miao < 10)
            {
               this.str += "0" + this.miao.toString();
            }
            else
            {
               this.str += this.miao.toString();
            }
            this.timeTxt.text = this.str;
            this.timeTxt.width = this.timeTxt.textWidth + 5;
         }
      }
      
      private function onopenPanel(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("DaoMengKongJianPanel"),"");
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         this.checkOpenPanel();
      }
      
      override public function dispose() : void
      {
         this.openPanel.removeEventListener(MouseEvent.CLICK,this.onopenPanel);
         if(this.timer)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this.timer = null;
         }
         super.dispose();
      }
   }
}
